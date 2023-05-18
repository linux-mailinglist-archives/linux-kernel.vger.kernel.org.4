Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3D707A44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjERG2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:28:54 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569731FD8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:28:53 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id zX84p3FGUcjUozX84pkvOF; Thu, 18 May 2023 08:28:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684391331;
        bh=GuYEVTBxE+8PbYpT/Gdg20EMlld5z1py8d9Sy66GhE8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fqHLxmVSiyRUfvzOrJMMPEJGxWKg5I3QNzUb+SFMHW7CsNCmFK0jbtQKNZYg7ozq0
         chr6qxVdZpmTDN6SYnfqUQ606uLADAVxyfmKSbxainBwQVq4aKRGcx794p18hWSYST
         oth/kqNpC1HbdBJyl76RnM6ah++tkl77AI7e3JPXviHXt9pYzp213L1gBLkdJ/s5FC
         gAEvFmn8JKvSsaGU6hg7QZqWwaH6L2qpOt1guAkwgycgVaJVhNnRNCV75ohvHhQH2T
         emUG2COZimMSGsQCZZxTWozaHA/9OG2gewyUjUvCHDiHTvcqiNpANYYmmmfEqtweHt
         5Froh97aulA4g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 18 May 2023 08:28:51 +0200
X-ME-IP: 86.243.2.178
Message-ID: <6f9fb8e9-0d6b-c6bb-619a-50cabc610421@wanadoo.fr>
Date:   Thu, 18 May 2023 08:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/amd/display: drop redundant memset() in
 get_available_dsc_slices()
Content-Language: fr
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Stylon Wang <stylon.wang@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Leon Huang <Leon.Huang1@amd.com>,
        Mike Hsieh <Mike.Hsieh@amd.com>,
        Cruise Hung <Cruise.Hung@amd.com>,
        Nasir Osman <nasir.osman@amd.com>,
        pengfuyuan <pengfuyuan@kylinos.cn>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230517183350.314082-1-hamza.mahfooz@amd.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230517183350.314082-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 17/05/2023 à 20:33, Hamza Mahfooz a écrit :
> get_available_dsc_slices() returns the number of indices set, and all of
> the users of get_available_dsc_slices() don't cross the returned bound
> when iterating over available_slices[]. So, the memset() in
> get_available_dsc_slices() is redundant and can be dropped.
>
> Fixes: 97bda0322b8a ("drm/amd/display: Add DSC support for Navi (v2)")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> index b9a05bb025db..58dd62cce4bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -645,8 +645,6 @@ static int get_available_dsc_slices(union dsc_enc_slice_caps slice_caps, int *av
>   {
>   	int idx = 0;
>   
> -	memset(available_slices, -1, MIN_AVAILABLE_SLICES_SIZE);
> -
>   	if (slice_caps.bits.NUM_SLICES_1)
>   		available_slices[idx++] = 1;
>   

Thanks for it, it went off my radar.


FWIW:

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>





