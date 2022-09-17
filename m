Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64D5BB877
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIQNZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIQNZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:25:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05232F022
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD882B80D6B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3DBC433D6;
        Sat, 17 Sep 2022 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663421145;
        bh=BkuuQ2aQAT4iZBNGS/uQLareFfaWSgUXjZ+EFt14Ok8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNYS6WPr2T+KbWWIkKYcUPvhDweJlIRrmD64B4yzXRLWwdXHl9n3M9u6W6yVF3/91
         kksDNxCP17ew0/I17OpL9c1arKFmpoHuCYN4q5SSI8uFQM7mJ+W/K9ZADu53iF3PPp
         16M6WJgIWxnGizOIPXogMzM4SDMPlGjwtGsvNdvSe73/bcrUwYwXJYPTaVxspROxZq
         FwewGng2c4u/vpVpwUFewx9ILrspZY48vxdF2BRNxEv4bu8LvjjmfVx6nkGM3S91iA
         uabaq+pz5IlC0pk20aJjdV9ZddiQOrh2BD3pz5t6XZcr1Xhl84IzisA2PZiQ2iVvix
         DeZKfPkmAXqmw==
Date:   Sat, 17 Sep 2022 06:25:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: mainline build failure (new) for x86_64 allmodconfig with clang
Message-ID: <YyXK1rJYEc04Sobt@dev-arch.thelio-3990X>
References: <YyWniVAqJclcbSqN@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyWniVAqJclcbSqN@debian>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On Sat, Sep 17, 2022 at 11:55:05AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build for x86_64 allmodconfig
> with clang. The errors are:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:4020:6: error: stack frame size (2184) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
> void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>      ^
> 1 error generated.
> 
> 
> Note: This is a new error seen on top on a335366bad13 ("Merge tag 'gpio-fixes-for-v6.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux").
> Previous reported clang build error is now fixed, thanks to Nathan.
> 
> And, it appears Nathan has already sent a fix for this:
> https://github.com/intel-lab-lkp/linux/commit/4ecc45d7585ae2e05d622879ad97e13a7d8c595b
> https://github.com/intel-lab-lkp/linux/commit/819976a950b497d7f10cd9a198a94c26a9005b30

I did not realize this was a mainline issue too :( it seems that
commit af2f2a256e04 ("drm/amd/display: Enable dlg and vba compilation
for dcn314") is needed to see this and it was only in -next for three
releases (20220914 to 20220916), which I missed checking as closely as I
normally do due to Plumbers wrapping up and traveling.

The series is on the mailing lists at
https://lore.kernel.org/20220916210658.3412450-1-nathan@kernel.org/,
which is basically just 's/31/314/g' on the dml31 fixes because the code
is identical. Hopefully those two patches can be picked up in the same
manner as the other ones so that x86_64 allmodconfig does not ship
broken in 6.0 and thank you to the AMD folks for moving on those
already!

Cheers,
Nathan
