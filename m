Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3161F004
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKGKLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiKGKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:11:25 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6373D18B12
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:11:23 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A75cAPq015477;
        Mon, 7 Nov 2022 04:10:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=W+CLnYPyUu0FQxpvhbNOyp8OvpfWBZPtCzOY3DXt5S0=;
 b=IFHKftRT5f4U5aIzBHn7DWcUpZ1U5L1skecCIwns7A9Fq3Y7y4dXxRV2xhuI9wy9dzQY
 4ecqkg4qxOq3tqbuPrEVG1LSc2s0YMD9IrX/wCh1MgJ/koTm5IEm/s/jTzq0h3DVnREl
 F+sZRLA/3Mn+zfvRv3rLEn2OfDXOeIx4h3W+j5F4M5zDdhRamMnWmT+WuUGnIazi4wN3
 xe7kh2/+w452X95wDabk5EYqfmCGJ2FNHNQ5Pj6688vvpi2Az6ccKrSHO+mF8LWabJTp
 YAzMuAzwa5D/pkueqcBOwgZT9KAcNXCIsRuvA9gw/9xNKh90U583FRzTUBJioeuS4mwu qQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3knn81j2mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 04:10:13 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Mon, 7 Nov
 2022 04:10:11 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Mon, 7 Nov 2022 04:10:11 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F0A55468;
        Mon,  7 Nov 2022 10:10:10 +0000 (UTC)
Date:   Mon, 7 Nov 2022 10:10:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Chancel Liu <chancel.liu@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <luca.ceresoli@bootlin.com>, <ojeda@kernel.org>,
        <cmo@melexis.com>, <u.kleine-koenig@pengutronix.de>,
        <xiaolei.wang@windriver.com>, <steve@sk2.org>,
        <chi.minghao@zte.com.cn>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: wm8962: Wait for updated value of WM8962_CLOCKING1
 register
Message-ID: <20221107101010.GD10437@ediswmail.ad.cirrus.com>
References: <20221107063818.2468193-1-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221107063818.2468193-1-chancel.liu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: pBotZGE4lalnutjQ3nXDuy48PLdn9Riu
X-Proofpoint-GUID: pBotZGE4lalnutjQ3nXDuy48PLdn9Riu
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:38:18PM +0800, Chancel Liu wrote:
> DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
> correct frequency of LRCLK and BCLK. Sometimes the read-only value
> can't be updated timely after enabling SYSCLK. This results in wrong
> calculation values. Delay is introduced here to wait for newest value
> from register. The time of the delay should be at least 500~1000us
> according to test.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  sound/soc/codecs/wm8962.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index b4b4355c6728..563843565f68 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2503,6 +2503,14 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
>  		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
>  				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
>  
> +	/* DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
> +	 * correct frequency of LRCLK and BCLK. Sometimes the read-only value
> +	 * can't be updated timely after enabling SYSCLK. This results in wrong
> +	 * calculation values. Delay is introduced here to wait for newest
> +	 * value from register. The time of the delay should be at least
> +	 * 500~1000us according to test.
> +	 */
> +	msleep(1);

This looks reasonable but for a 1ms delay we should really be
using usleep_range rather than msleep.

Thanks,
Charles
