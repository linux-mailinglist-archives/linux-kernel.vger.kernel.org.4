Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499AD6A89FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCBUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCBUDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:03:49 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D475BFE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:03:48 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3225Wadw007775;
        Thu, 2 Mar 2023 14:03:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=fOHSeroJA8FHPgBl3h6LaVSUiV0xH80umq7ifSqCLWc=;
 b=f0QvTBNpOTzwo/Zxwv7XO1KLzENBgjQB48CxYJHa5uqA1V5TtzCOtsNorRhlVsAb3brl
 1c3HAnyFBoqEYPSe9YsxRXYhRjdPVdBDeN1u4Eo+l7vY9AOLETsL+XZI7IwOx28yWpH5
 AUohLgzUiuNb6+4DSiEn3F4NeT1PrnuxJW1vo8OLHKFsGSLxWPkT6hDDPU72dMSu08wZ
 A4WW0jtMv58T2ENhFibbRmbdXaEAiQggO5SAJNs54UkQ1sJeP0kfI4zYSTjHD+nrBe81
 TB6Ny4/t09gyhSHimEBv1++TjfmWkjBs3Q8GGPF69EdDcsy2pENcRCDJLK/i+7jdxKhB IQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nygm71cbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 14:03:33 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 2 Mar
 2023 14:03:30 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 2 Mar 2023 14:03:30 -0600
Received: from [141.131.206.93] (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.206.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D891611AC;
        Thu,  2 Mar 2023 20:03:29 +0000 (UTC)
Message-ID: <c7d98128-32ce-9a63-7dae-2f4b735d95e9@opensource.cirrus.com>
Date:   Thu, 2 Mar 2023 14:03:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] ASoC: cs34l45: Hibernation support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
References: <20230302171154.2342527-1-vkarpovi@opensource.cirrus.com>
 <20230302171154.2342527-5-vkarpovi@opensource.cirrus.com>
 <8aef2c0c-9bd0-4c3a-86e1-7732ddedabfd@sirena.org.uk>
 <6f34d2c8-21b5-5b75-a3cd-15f88ba0f760@opensource.cirrus.com>
 <1f9fd2b8-f5d5-4a9c-8c52-63386c85101d@sirena.org.uk>
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
In-Reply-To: <1f9fd2b8-f5d5-4a9c-8c52-63386c85101d@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vvTdbDPU2cb_LezY_RWUdGDORwSTVmGB
X-Proofpoint-GUID: vvTdbDPU2cb_LezY_RWUdGDORwSTVmGB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/23 12:08, Mark Brown wrote:
> On Thu, Mar 02, 2023 at 11:59:05AM -0600, Vlad Karpovich wrote:
>> The CS35L45 features a low-power Hibernation State. In this state, all
>> register contents are lost, but the contents of
>> RAM are retained. In the Hibernation State, only always-on digital functions
>> to support wake-up are enabled.
>> Entry to this state is achieved via the register interface (either by an
>> external driver using the control port, or the
>> programmable DSP). Exit from this state is triggered by activity on device
>> GPIO pins, intended SPI transaction, or I2C
>> transaction with intended slave address
> OK, so it's essentially just a faster mechanism for bringing the device
> out of runtime suspend?

I don't think it is a faster way since it requires interaction with DSP 
and restoring all wiped registers.

But it saves a some power comparing a low power state in the current driver

>   I would suggest doing something in the code to
> clarify that this is not the same thing as system level hibernation,
> having references to hibernate in the driver is likely to lead to
> confusion down the line.

The feature is named hibernation in the data sheet.  Renaming it in the 
driver will add confusing for the driver user.

>   I'd also include a bit more description in the
> commit message too.
I will do in next version.
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.
Thanks. I will do.
