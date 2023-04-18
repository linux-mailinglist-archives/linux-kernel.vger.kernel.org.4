Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1736E6C02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjDRSVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjDRSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ACDB464;
        Tue, 18 Apr 2023 11:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5889F637DB;
        Tue, 18 Apr 2023 18:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27916C433D2;
        Tue, 18 Apr 2023 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681842107;
        bh=fMVjHMGHdpVVTqAnb5vzPaJx9vDQalTucSaWG0SBO9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eC6qMqdwtVcKihRXLrTBp7pb5nBEwR95sbutowsfBcTGq858TqLYX+G81H6OmVhFJ
         eGeF16z1nV5TlFf7Z0ihVovLmnRU+LfNcLkrjupfE1fAZKExjS4yUbfBkHE09mBZmb
         1Qt4BosAvscnQPLKsdH8+4Jjb//CEwDv8zpx4gbFYHUGJC02Olo1roUwR0+7NvzSXv
         uSeqtwk0OY4ViKcMfZbDPQblFwA7AWWOu2bULXCBcDZ5p0evafPCFI7BC5BHEZPgHQ
         qLCITRmBmR1CobAeAUCKMZ4fEVPesa1yanHa/FB4YzXYThssgcHDGK6PxDUqG2xVxQ
         rYfYc9dKgkKCg==
Date:   Tue, 18 Apr 2023 11:21:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the powerpc tree
Message-ID: <20230418182145.GA1392657@dev-arch.thelio-3990X>
References: <20230412112213.59365041@canb.auug.org.au>
 <20230413184725.GA3183133@dev-arch.thelio-3990X>
 <2d69ba0a-b12f-4bd1-83c5-d7c01ceec4e8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d69ba0a-b12f-4bd1-83c5-d7c01ceec4e8@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 05:55:10PM +0100, Mark Brown wrote:
> On Thu, Apr 13, 2023 at 11:47:25AM -0700, Nathan Chancellor wrote:
> > On Wed, Apr 12, 2023 at 11:22:13AM +1000, Stephen Rothwell wrote:
> 
> >  	select SND_HDA_COMPONENT if SND_HDA_CORE
> >  	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
> > -	select DRM_AMD_DC_DCN if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
> > +	select DRM_AMD_DC_FP if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
> >  	help
> >  	  Choose this option if you want to use the new display engine
> >  	  support for AMDGPU. This adds required support for Vega and
> 
> > Please consider resolving this in a future -next update, I was rather
> > surprised that my AMD test machine's graphical output was not working
> > until I noticed the configuration difference :)
> 
> Done.

Thanks a lot, sorry for not saying it sooner! It looks like this
regressed in next-20230417 and next-20230418 though.

Cheers,
Nathan
