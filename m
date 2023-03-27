Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533826C9E18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjC0Iis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjC0IiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:38:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76D7AB0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:32:37 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7BCOu028059;
        Mon, 27 Mar 2023 03:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Po+ae3aSw2GW2FFY1Ex0+XnVhUK7QaDVZZPLKHJDiEc=;
 b=WOlzgGSovcspp7tuNrc+OGO3VEvtxPOZG4YX9o5+BSIQRtczlT71+R2WVLhtM76qlSMo
 raw+oErun8ugVCBNPhAdjVVCqz9xlsnyYM7S2krcpNogzjTGkVHWo8YPr4ObhhnQyh8T
 +3fgTekVNZMkNbl/FNcHr48GR+JQo/31ALw9NRWQD4ENLWzPLxwZhB1FFk9oz59IULyO
 8P9X/fvaYimW630rXNY9e/PKXOX3juX3UxQe7AONZQ1H0OBVwB63dUCddsEsd6TFF+91
 SJX/NLMIXyt21Y07YhwveWnXhbL3i4mfl6nChx+zvtseEMvlyCxJy6fiTVyJSSsdSqZo nw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3phxc2j698-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 03:32:10 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 27 Mar
 2023 03:32:08 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 27 Mar 2023 03:32:08 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 82FA611D4;
        Mon, 27 Mar 2023 08:32:08 +0000 (UTC)
Date:   Mon, 27 Mar 2023 08:32:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ASoC: wm8903: implement DMIC support
Message-ID: <20230327083208.GQ68926@ediswmail.ad.cirrus.com>
References: <20230325083643.7575-1-clamor95@gmail.com>
 <20230325083643.7575-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230325083643.7575-2-clamor95@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: ChH8pAOo6YN8MZg2uI0OBVWvOIKr7fFB
X-Proofpoint-ORIG-GUID: ChH8pAOo6YN8MZg2uI0OBVWvOIKr7fFB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:36:43AM +0200, Svyatoslav Ryhel wrote:
> Add DMIC input and routing.
> 
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF300T
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  sound/soc/codecs/wm8903.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> index 41346e5ec5ad..9c2f0aadcff3 100644
> --- a/sound/soc/codecs/wm8903.c
> +++ b/sound/soc/codecs/wm8903.c
> @@ -9,7 +9,6 @@
>   *
>   * TODO:
>   *  - TDM mode configuration.
> - *  - Digital microphone support.
>   */
>  
>  #include <linux/module.h>
> @@ -816,6 +815,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
>  SND_SOC_DAPM_INPUT("IN2R"),
>  SND_SOC_DAPM_INPUT("IN3L"),
>  SND_SOC_DAPM_INPUT("IN3R"),
> +SND_SOC_DAPM_INPUT("DMIC"),
>  SND_SOC_DAPM_INPUT("DMICDAT"),

There is already a datapath for the DMIC here, DMICDAT. Are you
sure you don't just need to set the "Left/Right ADC Input" muxes
correctly through the ALSA controls?

>  
>  SND_SOC_DAPM_OUTPUT("HPOUTL"),
> @@ -996,6 +996,9 @@ static const struct snd_soc_dapm_route wm8903_intercon[] = {
>  	{ "AIFTXL", NULL, "Left Capture Mux" },
>  	{ "AIFTXR", NULL, "Right Capture Mux" },
>  
> +	{ "ADCL", NULL, "DMIC" },
> +	{ "ADCR", NULL, "DMIC" },
> +

And at any rate these should not be directly connected to the
ADC you need some muxing to indicate whether the DMIC or AMICs
are active. Which the DMICDAT path appears to already have.

Thanks,
Charles
