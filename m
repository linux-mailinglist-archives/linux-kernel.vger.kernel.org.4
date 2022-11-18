Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86662E9F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiKRABQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKRABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:01:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFCC70A3D;
        Thu, 17 Nov 2022 16:01:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3131B8221D;
        Fri, 18 Nov 2022 00:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EE3C433D6;
        Fri, 18 Nov 2022 00:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668729670;
        bh=ov1dwfKlY10jlyvvrILEMTGZym5hMBZuKYP5HTVbbNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUV6xj2ZuGt6gS++XzvZWg0g4N5kX3l4CCDn+/3k2C9z8oqImtI0RiS453F7mzV7s
         /i8YeU0Zk/s8iJXQZvkZ6VIwOVUccL/fB18s6uWeB5TNua5NHVLUQcG5c7g3lwD14I
         8Jqpt6YpzqDz7axweXGMZ0ccO8JOc2xAcPv93xP/E/hb/dTFiKsoQ4w++pKZjAtYEK
         elqG3Gz2r/BxmLl/PYwBnq6HveJstEV2yXkKHe9rQMIiGcSH/mM6UsBKQvXKyw0b+4
         lUDo3Np0l8usOfpNZ6bY7az78OiFW1/7dNoUFwg0kK1zJKH9f5UD7Xjq08EDHn3Vgp
         D4no7ZB6I5rHQ==
Date:   Thu, 17 Nov 2022 17:01:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>, llvm@lists.linux.dev
Subject: Re: linux-next: manual merge of the drm-misc tree with the origin
 tree
Message-ID: <Y3bLRLDCrd7KYqom@dev-arch.thelio-3990X>
References: <20221116105702.746ce3cf@canb.auug.org.au>
 <Y3ZvffZiR+SgtY6h@dev-arch.thelio-3990X>
 <20221118090636.00bfc293@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118090636.00bfc293@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 09:06:36AM +1100, Stephen Rothwell wrote:
> Hi Nathan,
> 
> On Thu, 17 Nov 2022 10:29:33 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > This resolution is not quite right, as pointed out by clang:
> > 
> >     drivers/gpu/drm/vc4/vc4_hdmi.c:351:14: error: variable 'vc4_hdmi' is uninitialized when used here [-Werror,-Wuninitialized]
> >             mutex_lock(&vc4_hdmi->mutex);
> >                         ^~~~~~~~
> >     ./include/linux/mutex.h:187:44: note: expanded from macro 'mutex_lock'
> >     #define mutex_lock(lock) mutex_lock_nested(lock, 0)
> >                                                ^~~~
> >     drivers/gpu/drm/vc4/vc4_hdmi.c:322:27: note: initialize the variable 'vc4_hdmi' to silence this warning
> >             struct vc4_hdmi *vc4_hdmi;
> >                                      ^
> >                                       = NULL
> >     1 error generated.
> > 
> > Obviously, the assignment of vc4_hdmi should be before mutex_lock().
> 
> Thanks for pointing that out (silly me :-) ).  I have fixed up the
> resolution for today.

Great, thank you so much! One less warning to worry about :)

Cheers,
Nathan
