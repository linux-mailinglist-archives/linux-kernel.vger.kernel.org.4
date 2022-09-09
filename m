Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D465B3C38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiIIPlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIIPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:41:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25CB58B7A;
        Fri,  9 Sep 2022 08:41:48 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2896txfn019569;
        Fri, 9 Sep 2022 10:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Clf9mXR3sw1334kjnflf4AmtbQrj5dxGIw3Qv1BRiok=;
 b=OcTUM6mkHq0wl0WFSBs72vimJiPvwf91uMHCKGl2yJ2aHGnPz3y9VGaqhdaF99ssEten
 RETe1dIwjJZSAiVOqzoMjYJUABaIO9zgxkcWwDtfwwaJ0qYPp5zwA8uG/GUqT4tQu/tg
 XSBnldU/dkpVoz15dbhXTnma1brCzI3wFj0Vgj0+Ehel7mU51OySNa75frojH6BxUMLY
 ULYOodY1Ox0LkBpNGtpO00+tpah3sW5RiuX5PgTzbZFrwggVRYGKA8Oxv9uVazxIspAj
 3hakfa+bskj8gCf+S0PlWE1s3TlND4EGu0gmA/5AlNsZOMjjzEE34PWpwIg0aHu3O8+D tw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jc4b2hst4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 10:40:20 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Fri, 9 Sep
 2022 10:40:18 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Fri, 9 Sep 2022 10:40:18 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 16512B16;
        Fri,  9 Sep 2022 15:40:18 +0000 (UTC)
Message-ID: <aabae52f-8230-f837-c17a-59d781b5af62@opensource.cirrus.com>
Date:   Fri, 9 Sep 2022 16:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 07/10] ASoC: cs42l42: Split I2C identity into separate
 module
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <asahi@lists.linux.dev>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
 <20220909135334.98220-8-povik+lin@cutebit.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20220909135334.98220-8-povik+lin@cutebit.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y-D6NcGbOnTjQoKFLYGA2bCwWrsx9q_W
X-Proofpoint-ORIG-GUID: Y-D6NcGbOnTjQoKFLYGA2bCwWrsx9q_W
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 14:53, Martin Povišer wrote:
> +static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
> +{
> +	struct device *dev = &i2c_client->dev;
> +	struct cs42l42_private *cs42l42;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	cs42l42 = devm_kzalloc(dev, sizeof(*cs42l42), GFP_KERNEL);
> +	if (!cs42l42)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs42l42->dev = dev;
> +	cs42l42->regmap = regmap;
> +	cs42l42->irq = i2c_client->irq;
> +
> +	ret = cs42l42_common_probe(cs42l42, &cs42l42_soc_component, &cs42l42_dai);
> +	if (ret)
> +		return ret;
> +
> +	ret = cs42l42_init(cs42l42);
> +	if (ret)
> +		cs42l42_common_remove(cs42l42);

This introduces a bug that regulator_bulk_disable() is called
twice if there is an error.

cs42l42_init() was supposed to clean up if it returns an error, which
it nearly does, but my original patch is missing the call to free_irq()
in the error paths of cs42l42_init().
