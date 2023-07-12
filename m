Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3574FECD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGLFnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGLFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506091734;
        Tue, 11 Jul 2023 22:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D99E6616C9;
        Wed, 12 Jul 2023 05:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1C4C433C8;
        Wed, 12 Jul 2023 05:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689140584;
        bh=X5WCLxSc/gFxq+FunItuY2//SgfAsofnt1zHjwb5AiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ah+DjOaiwgYFyKRzwtpHxRRyFxOm3D21AlLj9JHruB50mtI6ugoYM4kLSTM4YxY+9
         K/GIirYqpCorv2/f+20sFu1k2vOOM1FCVLBuJ1QNdDfyuspH3P2T/dIENIFqCYg6y/
         DBKqynmKpVqL3sNzGlxDLJDJO1za8OEAANcYU9dzGhTWHtNBoiT7kETY5FJn8a/7UC
         bIxEMbB5vsfsTGwtWHiwoLNDQmgDeuB0gSP3p2epeR4eq5d1FLbm442bytUXisBD16
         lN7m3txhCunJL2iT/aBJDDuk3qMFad3D9uyjhuFOBfD1ai8zk8CxkycsXyXKLKTwAV
         U8WqB7wUPsl2w==
Date:   Wed, 12 Jul 2023 07:42:58 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, amd-gfx@lists.freedesktop.org,
        corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: scripts/kernel-doc does not handle duplicate struct & function
 names (e.g., in amdgpu)
Message-ID: <20230712074258.3602b6e8@coco.lan>
In-Reply-To: <58cafdc0-0209-cfdd-c8e0-2dd25d73a184@infradead.org>
References: <b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org>
        <0475d177-4c01-0988-0b34-3099dd703498@gmail.com>
        <58cafdc0-0209-cfdd-c8e0-2dd25d73a184@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 Jul 2023 20:45:18 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 7/11/23 20:32, Akira Yokosawa wrote:
> > Hi Randy,
> >   
> >> [just documenting this for posterity or in case someone wants to fix it.]
> >>
> >> In drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c, one can find both
> >>
> >> struct amdgpu_vm_tlb_seq_cb {...};
> >>
> >> and
> >> static void amdgpu_vm_tlb_seq_cb(...)
> >>
> >> Of course C has no problem with this, but kernel-doc reports:
> >>
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:833: WARNING: Duplicate C declaration, also defined at gpu/amdgpu/driver-core:115.
> >>
> >> And of course, if the name of one of them is changed, kernel-doc is all happy...
> >> not that I am suggesting that one of them should be changed.
> >>
> >> I just want to make people aware of this. (or maybe people are already aware of this?)  
> > 
> > The duplicate warning is emitted from Sphinx, not kernel-doc.
> > 
> > This is a bug of Sphinx >=3.1, first reported by Mauro back in September 2020 at:
> > 
> >     https://github.com/sphinx-doc/sphinx/issues/8241
> > 
> > It was closed when a local fix was presented.  Unfortunately, it was not
> > merged at the time and a subsequent pull request was opened at:
> > 
> >     https://github.com/sphinx-doc/sphinx/pull/8313
> > 
> > It is not merged yet and carries a milestone of Sphinx 7.x.
> > 
> > Looks like we need to wait patiently.
> > 
> >         Thanks, Akira  
> 
> Ooooh, thanks for your assistance.  Waiting.... :)

Yeah, we've been waiting this since Sphinx version 3.x times :-(

It seems that applying the fix would break an extension
(intersphinx). We don't use at the Kernel, so it won't affect
us, but it seems to be a popular extension, as it allows one
web server to have cross-references to Sphinx docs produced
elsewhere. Btw, such extension could be interesting on partial
doc builds (e. g. make SPHNXDIRS="foo_dir" htmldocs), as the
non-existing cross-references would be pointing, for instance,
to the docs stored at kernel.doc latest docs.

Btw, I'm still using version 2.4.4 when building the docs
to avoid the wrong duplicate warnings with 3.1+ due to this bug.

Thanks,
Mauro
