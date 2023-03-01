Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D86A6BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCALjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCALjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:39:33 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCD73D084
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:39:11 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3217vT1f022110;
        Wed, 1 Mar 2023 05:38:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=bLMPG0Ee1xwF8LqU5XMM+S9jeovX8oh9KyuYoA7Shz4=;
 b=pednQAqfj389OC61BBGfg4+v0zMQC9RtfXU0buBDUwcfFzJbfqL59v5JBgxCCJ5y4oEF
 rCxBgZgJ3MbuIIh1Zd+1O1sUMIpjIYlU9zbJpHfs46z1yzhK20DAoWZkcTH7GxWEHorZ
 0KdyFrsf5wAP4E59b41UJ/yLbei6sA5sjMmKcRmv1vt9VF9aiF5Zvc4T88uMXbuCw1nc
 xpQ2g4OJeFsaPxjftFGsMakTOwYAQFa5f2bjomW80ZvuHOmRaRvSf7eDB/VPr2MkuoBz
 3yWo6h/vYvwCJnUX+AmhQGeACJfmDCDvB9I9h2qudCgVGxzmm2J3BW+SnR0DUYGLuF5H hw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nygm6xuny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 05:38:45 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 1 Mar
 2023 05:38:43 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 1 Mar 2023 05:38:42 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D80CC45;
        Wed,  1 Mar 2023 11:38:42 +0000 (UTC)
Date:   Wed, 1 Mar 2023 11:38:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <lucas.tanure@collabora.com>
CC:     David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <kernel@collabora.com>
Subject: Re: [PATCH] ASoC: cs35l41: Steam Deck Shared boost properties quirk
Message-ID: <20230301113842.GM68926@ediswmail.ad.cirrus.com>
References: <20230301103113.12612-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230301103113.12612-1-lucas.tanure@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 9kjL_-hlMI8MraEifz8ilbOGAxTP8j6z
X-Proofpoint-GUID: 9kjL_-hlMI8MraEifz8ilbOGAxTP8j6z
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:31:13AM +0000, Lucas Tanure wrote:
> Add support for Steam Deck bios old properties. If a Steam deck didn't
> upgrade the BIOS, the driver should be able to handle the previous
> properties for shared boost types.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
>  sound/soc/codecs/cs35l41.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
> index c223d83e02cf..d5f9eee88cba 100644
> --- a/sound/soc/codecs/cs35l41.c
> +++ b/sound/soc/codecs/cs35l41.c
> @@ -1037,9 +1037,17 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
>  	unsigned int val;
>  	int ret;
>  
> -	ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
> -	if (ret >= 0)
> -		hw_cfg->bst_type = val;
> +	if (device_property_read_bool(dev, "cirrus,shared-boost-active")){
> +		hw_cfg->bst_type = CS35L41_SHD_BOOST_ACTV;
> +	}
> +	else if (device_property_read_bool(dev, "cirrus,shared-boost-passive")) {

else should really be on the same line as the closing bracket.
But apart from that minor nit, looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
