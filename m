Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F7362EC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiKRDd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiKRDdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:33:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11911152
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:33:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59FC5622BC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D65C433D6;
        Fri, 18 Nov 2022 03:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668742402;
        bh=jlllhPzg40ifiNFyohWJbGJ7eLQfPAOOWX/cKetkVSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=He0onnLI5ceGUfoNFs6PDMjn4ByvRhL34/rt/I+kw/KZu1cNWCuZJbLbMuB3CRbZF
         T2C+kTUKW2g5fgQMrNcWbUtIJeSYgaXWrKYUS2bAptJYMLsYxoFVPjx/qdJEF31VoC
         hQqB+6Q+6166k0TOiP3FRMDT9jL2B7IiiwEGSC5gKkqJPey6nUBNvjROLRUTNHgfSo
         p/dMNNOrDuBnzgsn1MrEFt4WsCbpVcksDyJDormqmlCSIWd2OW4D+36W85ttElsGA/
         EDOLlbLXeRp/C2pY3o5kY48AQou/+fMCASuzkqyJIS6w/Shp4dB0nfrJo/4k2ZhvW5
         uMpL/BoTgsL9w==
Date:   Thu, 17 Nov 2022 19:33:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: KMSAN broken with lockdep again?
Message-ID: <Y3b9AAEKp2Vr3e6O@sol.localdomain>
References: <Y3VEL0P0M3uSCxdk@sol.localdomain>
 <CAG_fn=XwRo71wqyo-zvZxzE021tY52KKE0j_GmYUjpZeAZa7dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XwRo71wqyo-zvZxzE021tY52KKE0j_GmYUjpZeAZa7dA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 02:46:29PM +0100, Alexander Potapenko wrote:
> On Wed, Nov 16, 2022 at 9:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Hi,
> >
> > I'm trying v6.1-rc5 with CONFIG_KMSAN, but the kernel continuously spams
> > "BUG: KMSAN: uninit-value in __init_waitqueue_head".
> >
> > I tracked it down to lockdep (CONFIG_PROVE_LOCKING=y).  The problem goes away if
> > I disable that.
> >
> > I don't see any obvious use of uninitialized memory in __init_waitqueue_head().
> >
> > The compiler I'm using is tip-of-tree clang (LLVM commit 4155be339ba80fef).
> >
> > Is this a known issue?
> >
> > - Eric
> 
> Thanks for flagging this!
> 
> The reason behind that is that under lockdep we're accessing the
> contents of wq_head->lock->dep_map, which KMSAN considers
> uninitialized.
> The initialization of dep_map happens inside kernel/locking/lockdep.c,
> for which KMSAN is deliberately disabled, because lockep used to
> deadlock in the past.
> 
> As far as I can tell, removing `KMSAN_SANITIZE_lockdep.o := n` does
> not actually break anything now (although the kernel becomes quite
> slow with both lockdep and KMSAN). Let me experiment a bit and send a
> patch.
> If this won't work out, we'll need an explicit call to
> kmsan_unpoison_memory() somewhere in lockdep_init_map_type() to
> suppress these reports.

Thanks.

I tried just disabling CONFIG_PROVE_LOCKING, but now KMSAN warnings are being
spammed from check_stack_object() in mm/usercopy.c.

Commenting out the call to arch_within_stack_frames() makes it go away.

- Eric
