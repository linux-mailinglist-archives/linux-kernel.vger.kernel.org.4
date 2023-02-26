Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D36A2F47
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 12:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBZLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 06:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 06:17:15 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E210CA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 03:17:14 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31QBGjuh012802;
        Sun, 26 Feb 2023 05:16:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=RgMk+o6bjLRn/uUXR1k7fSFgtfqaVQznhifuZa+DBD0=;
 b=g9xJbvV6muErLpDUu607cVrvFvyf6RB8tskQPP3uhV9piO+HHonWm7PPTbAX3zAHME/Y
 uV3P+O4GHT0eoFFUtSBM0uEuyiNFnEfwayT89NiYezLD/xY1DnU5ZmW/zo5VamOwxkpT
 LJIWhiEk7IJzoElTzV/v0PeVvv6vneT9N+gihMc6DgltP9qmlwyfWiG6Mm443v6viEKi
 j/NAd+yukfTfdOWIG/cSQWnIg9rY+4zwJE3CFuc9CcVwoy7uUrjyF3iHoqS8hLmjxzP1
 5EVBFwTc0EbbgNNAQLFgaPd0+x3x19BoYXS8QeEoDccZ77O5Ain8yPUxT8dZYYrOjzxR 5w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nyfmt1k6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Feb 2023 05:16:45 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Sun, 26 Feb
 2023 05:16:43 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sun, 26 Feb 2023 05:16:43 -0600
Received: from [198.61.64.48] (EDIN4L06LR3.ad.cirrus.com [198.61.64.48])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 66C6945;
        Sun, 26 Feb 2023 11:16:43 +0000 (UTC)
Message-ID: <ca8e1fe4-1c1e-ff1f-8c61-6c9228edb5ca@opensource.cirrus.com>
Date:   Sun, 26 Feb 2023 11:16:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] ALSA: hda: cs35l41: Correct error condition
 handling
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Martin Wolf <info@martinwolf.pub>
References: <20230213145008.1215849-1-sbinding@opensource.cirrus.com>
 <20230213145008.1215849-2-sbinding@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230213145008.1215849-2-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oioqMFNo11PP4f9fTGxCD_zOjzAs-spF
X-Proofpoint-GUID: oioqMFNo11PP4f9fTGxCD_zOjzAs-spF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/2/23 14:50, Stefan Binding wrote:
> From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> 
> Function cs_dsp_coeff_write_ctrl() can return 3 possible values:
> 0 - no change, 1 - value has changed and -1 - error, so positive value
> is not an error.
> Fixes: 7406bdbc4fb8 ("ASoC: wm_adsp: Return whether changed when writing controls")
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>   sound/pci/hda/hda_cs_dsp_ctl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
> index 5433f6227ac9..463ca06036bf 100644
> --- a/sound/pci/hda/hda_cs_dsp_ctl.c
> +++ b/sound/pci/hda/hda_cs_dsp_ctl.c
> @@ -218,10 +218,10 @@ int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
>   	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
>   	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
>   	mutex_unlock(&dsp->pwr_lock);
> -	if (ret)
> +	if (ret < 0)
>   		return ret;
>   
> -	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
> +	if (ret == 0 || (cs_ctl->flags & WMFW_CTL_FLAG_SYS))
>   		return 0;
>   
>   	ctl = cs_ctl->priv;

Hi Takashi

Could you queue this patch as a bugfix for 6.2 please?
The cs_dsp patch to return 1 for changed has gone into 6.2
but we missed that this hda_cs_dsp code would break.
