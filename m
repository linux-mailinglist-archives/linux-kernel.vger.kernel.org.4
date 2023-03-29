Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE07E6CDB87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjC2OH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC2OHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:07:53 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68355A3;
        Wed, 29 Mar 2023 07:06:50 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9DfFW021397;
        Wed, 29 Mar 2023 09:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=JGh/hvjvBMdxlLHaLhPm0XGhnA/5dNCgYG0Izty01zk=;
 b=Lj+BjEli4LAR+SVPbVtGv1Z25ZfCumbCwZbmMK3gRw8ibqGwcZyJQTAJNfHYKu5KPkkR
 0YCrOwntWbwCorS9iMVOwhG7dp2uqfB6X957z5dQ0OLhATv4q3QlU2yj3r8Ebc27Fb/E
 868E2zgbUj2opyXcnrkTdTlOb27OGMqFABGC7Hm6AG8qwGW7rYOm/9EO0hWKuwCeLLwS
 u9qrw4sy/IadIt0j8dmDjGXO7TJxddL/hgbRteAW28cHen+qmB3rL4ED9cqWj1zNCNg8
 NTRQak/Ir47EQfyRGsKLCFOPwhVGqCD6ewx/oorhfnrjhH4hu2LTCG3GC9+Z3axKiz8y sA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pmjghgc9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 09:05:25 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 29 Mar
 2023 09:05:24 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 29 Mar 2023 09:05:24 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2BA5111DA;
        Wed, 29 Mar 2023 14:05:24 +0000 (UTC)
Date:   Wed, 29 Mar 2023 14:05:24 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jianhua Lu <lujianhua000@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>
Subject: Re: [PATCH] Asoc: wm_adsp: Add support for loading firmware with
 prefix name
Message-ID: <20230329140524.GU68926@ediswmail.ad.cirrus.com>
References: <20230329130525.15830-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230329130525.15830-1-lujianhua000@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: EeUUs62KZ6mNxdeiDQAx0DvUuftRFwmz
X-Proofpoint-ORIG-GUID: EeUUs62KZ6mNxdeiDQAx0DvUuftRFwmz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:05:25PM +0800, Jianhua Lu wrote:
> For platform using fdt, system_name is NULL, it doesn't provide
> a way to load firmware with prefix name, so add it.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>  sound/soc/codecs/wm_adsp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 216120b68b64..17481e42d440 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -760,6 +760,10 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
>  		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
>  				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
>  				      filetype);
> +	else if (asoc_component_prefix)
> +		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
> +				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, asoc_component_prefix,
> +				      filetype);
>  	else
>  		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, dsp->fwf_name,
>  				      wm_adsp_fw[dsp->fw].file, filetype);
> @@ -831,6 +835,16 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
>  							      NULL, "bin");
>  			return 0;
>  		}
> +	} else if (asoc_component_prefix) {
> +		if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
> +						   cirrus_dir, NULL,
> +						   asoc_component_prefix, "wmfw")) {
> +			adsp_dbg(dsp, "Found '%s'\n", *wmfw_filename);
> +			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
> +							      cirrus_dir, NULL,
> +							      asoc_component_prefix, "bin");
> +			return 0;
> +		}
>  	}

This direction seems slightly problematic, especially in the
context of amps (which I presume this relates to, please let know
if that is wrong). It would probably be better to be fixing
things up such that the amp in question sets system_name when
registered through DT. Generally speaking the idea is the amp
tuning is going to be specific to the enclosure/speaker involved,
so a generic tuning for say left amps doesn't really make a lot
of sense.

Thanks,
Charles
