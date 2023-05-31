Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE42717FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjEaMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjEaMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:24:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9088AE4A
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:23:56 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8vGVY012865;
        Wed, 31 May 2023 14:23:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=f/4V+3ywcAJTl9+Rz8L8N43LFhDVxFDBScrS7zYm3+Q=;
 b=ceITOanTGnl+bZkJBzk11F9bDED2a1fxEu8JFfvAl1LOwv7hfrGUo320mMVy5Ve5MYtL
 2z5joZhGREfc1euWlM6p+YvltXDxpk/o4Wto8YKabpD6wtiz1qDo9/XFZcewQhS67HLF
 vXnT3A3uCEb/GukNToMye2aewsnlAth+w7KgAbNdcMB1OkSAxB3365zpAaI7k92VL2kz
 gxzdbvOhsho21YR6IWiuP59dqPNNYlxxKC7dmgTIzqPiUEQrnNFM1mih4si7G7Zcoh5O
 yP+g9tXSnd0ehULbcMgKnq83QBQkYl80uBCy05HQwB6Fw6EqXlMrqFOBmhcc1KsI7VPN iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qx3671dth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 14:23:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BACE010002A;
        Wed, 31 May 2023 14:23:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A65E0233C8E;
        Wed, 31 May 2023 14:23:03 +0200 (CEST)
Received: from [10.129.178.187] (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 31 May
 2023 14:23:03 +0200
Message-ID: <421ecc95-413d-71c3-36e3-abc8da9db316@foss.st.com>
Date:   Wed, 31 May 2023 14:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/stm: ltdc: check memory returned by devm_kzalloc()
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <yannick.fertre@foss.st.com>, <philippe.cornu@foss.st.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230531072854.142629-1-claudiu.beznea@microchip.com>
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20230531072854.142629-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/31/23 09:28, Claudiu Beznea wrote:
> devm_kzalloc() can fail and return NULL pointer. Check its return status.
> Identified with Coccinelle (kmerr.cocci script).
>
> Fixes: 484e72d3146b ("drm/stm: ltdc: add support of ycbcr pixel formats")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>
> Hi,
Hi Claudiu
>
> This has been addressed using kmerr.cocci script proposed for update
> at [1].
>
> Thank you,
> Claudiu Beznea
>
> [1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/
>
>  drivers/gpu/drm/stm/ltdc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 03c6becda795..9f3ac54d4cb3 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -1579,6 +1579,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>  			       ARRAY_SIZE(ltdc_drm_fmt_ycbcr_sp) +
>  			       ARRAY_SIZE(ltdc_drm_fmt_ycbcr_fp)) *
>  			       sizeof(*formats), GFP_KERNEL);
> +	if (!formats)
> +		return NULL;
>  
>  	for (i = 0; i < ldev->caps.pix_fmt_nb; i++) {
>  		drm_fmt = ldev->caps.pix_fmt_drm[i];


Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thanks for your patch.

Cheers,
Raphaël G.-P.

