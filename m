Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4B6CECFC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjC2Pdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC2Pde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:34 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15014C30;
        Wed, 29 Mar 2023 08:33:30 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T9EBxw021690;
        Wed, 29 Mar 2023 10:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=nKcNlzwm7qE0F3RDbGVCCb1M6tgGymG9oJ9fa9j5Mf8=;
 b=eTlIVmVsKGjq3mnHM6Jr4s9VvJWJcCe3BZ4tu+miceljn7Cs7ndXHSYAvcLHuvLExnnC
 N5AYuTBDGizsaXXuNHKeZIhOYyq888zNB4e3OwoqgdXcSgiMXUBITOqIYt4OGimFZgAN
 yilkDV/p+2APuyiiovGt/RHIDUQbwBxL3omvUJ/dA7xZ8/TqcUab9NVsSn31T63h7blS
 sgk5syUc2BYaochL0WHOhIQjNtfqdgAN1h1IPaePN4XH16qN8KU0bCFQz2NSZ/PMHLuE
 x82dsOVODSu/y5Ho6m9MKRBmi4dTUpv1nzriDtIYAh2p69oEqWCg+2ywzNoUvFF6a1od tw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pmjghgjaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 10:33:11 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 29 Mar
 2023 10:33:10 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 29 Mar 2023 10:33:10 -0500
Received: from [198.61.65.23] (EDIN4L06LR3.ad.cirrus.com [198.61.65.23])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CFE8211D3;
        Wed, 29 Mar 2023 15:33:08 +0000 (UTC)
Message-ID: <57c5a3b3-00cd-5b44-02f4-dedabacc7662@opensource.cirrus.com>
Date:   Wed, 29 Mar 2023 16:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Asoc: wm_adsp: Add support for loading firmware with
 prefix name
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>
References: <20230329130525.15830-1-lujianhua000@gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230329130525.15830-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZcNbkvF3f1WjSY9515Intogj9F5T569W
X-Proofpoint-ORIG-GUID: ZcNbkvF3f1WjSY9515Intogj9F5T569W
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/3/23 14:05, Jianhua Lu wrote:
> For platform using fdt, system_name is NULL, it doesn't provide
> a way to load firmware with prefix name, so add it.

This is intended behavior.

To load per-amp tuning you must know the function of each amp.
You only know that if you know what hardware platform you are running
on.

So if system_name is NULL it should fall back to generic firmware.

> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
>   sound/soc/codecs/wm_adsp.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 216120b68b64..17481e42d440 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -760,6 +760,10 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
>   		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
>   				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
>   				      filetype);
> +	else if (asoc_component_prefix)
> +		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
> +				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, asoc_component_prefix,
> +				      filetype);
>   	else
>   		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, dsp->fwf_name,
>   				      wm_adsp_fw[dsp->fw].file, filetype);
> @@ -831,6 +835,16 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
>   							      NULL, "bin");
>   			return 0;
>   		}
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
>   	}
>   
>   	if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
