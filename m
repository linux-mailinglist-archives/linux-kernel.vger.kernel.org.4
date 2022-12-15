Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31964E015
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLOR4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLOR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:56:39 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CFA18B17
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:56:38 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4NY0KV01Dxz9sRY;
        Thu, 15 Dec 2022 18:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1671126990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyLdt1rVAKkbPEI7ivqCP0WIdY2UD4VMPyCeWW/EvYk=;
        b=r/NepjnpXjqktIh6HNyIhAeGnqMWPzTa+Ds9yWF/5beGfqjBMiU7Y+06VUOh5EN3+gstYD
        ot4rKrNVk5lG66A2BNDFTVzguAE5G58XVDr/ZQfiwfJHENhnPer8Zf1AVkVy748INqkk1s
        wHfH67UwywqOa+HDFmbNOf1K5yI4NCypdthVqtBv9EiBzfOL0/acvk3PCmuVfTCrcyzk5X
        MBSSVkuzUvfKcXXDUGiJ5GMmF6jzvN6W4pqucSPRN+BmKvutEjvYFZarvCYykQomatTAiB
        DCXNq6idjYi52K5ch7E3ZpJCsPUtKs27UTCpHl9cpFKPusJOPDDQAyt8tI3PBA==
Message-ID: <dc11c746-7d06-4b9f-ddc4-9b8e72297e3f@mailbox.org>
Date:   Thu, 15 Dec 2022 18:56:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: fix dp_retrieve_lttpr_cap return code
Content-Language: en-CA
To:     Arnd Bergmann <arnd@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Alan Liu <HaoPing.Liu@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        George Shen <george.shen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20221215163743.452648-1-arnd@kernel.org>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20221215163743.452648-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 59atcha917f3kexjnj5ac5hq9p55gycs
X-MBO-RS-ID: 443935055b5c08e25a9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 17:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The dp_retrieve_lttpr_cap() return type changed from 'bool'
> to 'enum dc_status', so now the early 'return' uses the wrong
> type:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function 'dp_retrieve_lttpr_cap':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:5075:24: error: implicit conversion from 'enum <anonymous>' to 'enum dc_status' [-Werror=enum-conversion]
>  5075 |                 return false;
>       |                        ^~~~~
> 
> Convert it to return 'DC_OK', which is the same value as 'false'.
> 
> Fixes: b473bd5fc333 ("drm/amd/display: refine wake up aux in retrieve link caps")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> No idea if DC_OK is the intended return code, but it leaves the behavior
> unchanged and fixes the warning.
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index af9411ee3c74..95dbfa4e996a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -5095,7 +5095,7 @@ enum dc_status dp_retrieve_lttpr_cap(struct dc_link *link)
>  	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
>  
>  	if (!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support)
> -		return false;
> +		return DC_OK;

		return status;

seems more appropriate. (Otherwise the status = DC_ERROR_UNEXPECTED initialization has no effect)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

