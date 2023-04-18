Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D068E6E6C15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjDRS3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjDRS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9B9007;
        Tue, 18 Apr 2023 11:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A368D637F3;
        Tue, 18 Apr 2023 18:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A74FC433D2;
        Tue, 18 Apr 2023 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681842581;
        bh=8EF/b6rFEqY18fb5qJviLJjMaViEY5I0RMFUi25++jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6Ua9lozDUX+VtIi5y1RT1zzlKZd5EN9A+VUZna09GR6kyCpeZOJ7PxApwwBCdlLq
         YJmVFOjM7+dx2foTIuJm+Ymm+jln1k+s7SnRHzRrqW4JDNLGjgyI4NCMTHt34N7Ug1
         A66IY3AY3mwEWc1l55FV7O2pbDamDBO4Xi+aAxB2sn+eJeWJYtThYJWzbRjqUdQ1SS
         NCLj6PkUPPTyla8S/0j1jyUJtYIgKxfGFbWkdzUtt/j/ludJE1VTvo8pcNZowd0YST
         mM9nge6LlHx6LvWqVgkcuyTnWio2jd0V7d2CwkkpJqqnJi5ek7qEenrbFop2tOQL6Q
         bEjRAMUpdK1Yg==
Date:   Tue, 18 Apr 2023 11:29:38 -0700
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
Message-ID: <20230418182938.GA2066635@dev-arch.thelio-3990X>
References: <20230412112213.59365041@canb.auug.org.au>
 <20230413184725.GA3183133@dev-arch.thelio-3990X>
 <2d69ba0a-b12f-4bd1-83c5-d7c01ceec4e8@sirena.org.uk>
 <20230418182145.GA1392657@dev-arch.thelio-3990X>
 <57051c9d-aba4-4c47-bdaf-f7230dbab69a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57051c9d-aba4-4c47-bdaf-f7230dbab69a@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:25:00PM +0100, Mark Brown wrote:
> On Tue, Apr 18, 2023 at 11:21:45AM -0700, Nathan Chancellor wrote:
> > On Fri, Apr 14, 2023 at 05:55:10PM +0100, Mark Brown wrote:
> 
> > > Done.
> 
> > Thanks a lot, sorry for not saying it sooner! It looks like this
> > regressed in next-20230417 and next-20230418 though.
> 
> Someone sent a mail saying they thought they'd fixed the DRM tree - is
> that not the case?

Does not seem like it:

$ git show -s --format='%h ("%s")'
67d5d9f013d6 ("Add linux-next specific files for 20230418")

$ git grep DRM_AMD_DC_DCN
drivers/gpu/drm/amd/display/Kconfig:    select DRM_AMD_DC_DCN if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))

Cheers,
Nathan
