Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA25B9AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIOMWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIOMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:22:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C9F89812;
        Thu, 15 Sep 2022 05:22:20 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F5erk7015415;
        Thu, 15 Sep 2022 07:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=CUUZCN8CbQjdSUIzRh++MknIDM7YeGQKIOTWG5m6Yk0=;
 b=V/9llfCjSPnhOow+ROHdKUa1UlshXzdMA3N+MpTbafilTn9IBHJymHgTFfKI6XruT3Bk
 Dx5Agbd0n/SH1Eu6Y52pa/pJC7FH647QXWtkUIOV+WZtfuHgK0ppxI8ug+tDFn34CJDj
 dqzUqa465i3h6CHoKjHVdgSRtJuFOm9txFrGdXo7AW7ngrMnfgiyFbs2orFB8Xq2hLXj
 s4NRnrlS2EmfFJ6+iTzpObSsm2LJp8DJs3Sw7gYJSUbPxVWqGNWEn3CpHZqU8Q7KTcxp
 L+evTk9rqOTw8hIWoKxTlHEUK1TG25zqm7ZKgSkedXCAVkVayYWgOI8BYNOZ7Q2lpADM 5Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jjxyr2ac4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 07:20:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Thu, 15 Sep
 2022 07:20:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Thu, 15 Sep 2022 07:20:29 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E0C66468;
        Thu, 15 Sep 2022 12:20:22 +0000 (UTC)
Message-ID: <2839a437-a57a-ffc4-da8e-dde9a9a9a5cc@opensource.cirrus.com>
Date:   Thu, 15 Sep 2022 13:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 04/11] ASoC: cs42l42: Split probe() and remove() into
 stages
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matt Flax <flatmax@flatmax.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        - <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <asahi@lists.linux.dev>
References: <20220915094444.11434-1-povik+lin@cutebit.org>
 <20220915094444.11434-5-povik+lin@cutebit.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20220915094444.11434-5-povik+lin@cutebit.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: y3RD2Dp-yKLUCoYgbRs2U3VWByN4ed9F
X-Proofpoint-GUID: y3RD2Dp-yKLUCoYgbRs2U3VWByN4ed9F
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 10:44, Martin Povišer wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> To prepare for adding SoundWire the probe must be split into three
> parts:
> 
> 1) The bus-specific probe
> 2) Common bus-agnostic probe steps
> 3) Initialization of the peripheral registers
> 
> Step (3) must be separate because on SoundWire devices the probe must
> enable power supplies and release reset so that the peripheral can be
> enumerated by the bus, but it isn't possible to access registers until
> enumeration has completed.
> 
> The call to devm_snd_soc_register_component() must be done at stage (2)
> so that it can EPROBE_DEFER if necessary. In SoundWire systems stage (3)
> is not a probe event so a deferral at this stage would not result in
> re-probing dependencies.
> 
> A new init_done flag indicates that the chip has been identified and
> initialized. This is used to prevent cs42l42_remove(), cs42l42_suspend(),
> cs42l42_restore() and cs42l42_irq_thread() from attempting register
> accesses if the chip was not successfully initialized. Although this
> cannot happen on I2C, because the entire probe would fail, it is
> possible on SoundWire if probe succeeds but the cs42l42 is never
> enumerated.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>   sound/soc/codecs/cs42l42.c | 127 +++++++++++++++++++++++++------------
>   sound/soc/codecs/cs42l42.h |   2 +
>   2 files changed, 87 insertions(+), 42 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index 11cb659f03e0..427b29db2252 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -1627,7 +1627,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
>   	int report = 0;
>   
>   	mutex_lock(&cs42l42->irq_lock);
> -	if (cs42l42->suspended) {
> +	if (cs42l42->suspended || !cs42l42->init_done) {
>   		mutex_unlock(&cs42l42->irq_lock);
>   		return IRQ_NONE;
>   	}

This doesn't apply to broonie/for-next. Needs rebasing onto commit:
ea75deef1a73 ("ASoC: cs42l42: Only report button state if there was a
button interrupt")
