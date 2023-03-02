Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811356A882E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCBR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCBR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:59:25 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37D34C11
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:59:21 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3226u9RS031295;
        Thu, 2 Mar 2023 11:59:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=hfZGSmFBT/xzIYEjag0JyBPNqsj8KWXPKjm4UN+XDHs=;
 b=guDveCFAYEc3Qgm0TSx1rv909VdBAhqiYuKzzGGE7go69ldpWZ2UrqfpSCZLLhOJU5/W
 6b/wNFxok+lPxOhf4rwEQ0eH49ya0aLmy3UZRraAw+JIUcvCBN+5uii3aGCZwYcavF+z
 QzM89Hq6QxbWACiGTa7Ax9+t/Z3sHYDpn/HP28yccR3Il+LTptWcLVBREFlqiEaKEuRx
 2m2G+jYXlmcGms0PApwJxvOy2utIYdyEnpAejfsxAe2p8FtFMkCI4+lUeFsctHuTMiYj
 9qXkO7sC+BTLQEvZgd2/Z7BQ+DOCgAn2ACB0vF9m9AgLbHP/ncZpLgIxocCvmQzU/hpC cg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nyfmt94bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 11:59:08 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 2 Mar
 2023 11:59:06 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 2 Mar 2023 11:59:06 -0600
Received: from [141.131.206.93] (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.206.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C40FA11AC;
        Thu,  2 Mar 2023 17:59:05 +0000 (UTC)
Message-ID: <6f34d2c8-21b5-5b75-a3cd-15f88ba0f760@opensource.cirrus.com>
Date:   Thu, 2 Mar 2023 11:59:05 -0600
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
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
In-Reply-To: <8aef2c0c-9bd0-4c3a-86e1-7732ddedabfd@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sYWc5fOdMqr9WDkM3aoyWZyDTRU7qa_5
X-Proofpoint-GUID: sYWc5fOdMqr9WDkM3aoyWZyDTRU7qa_5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS35L45 features a low-power Hibernation State. In this state, all 
register contents are lost, but the contents of
RAM are retained. In the Hibernation State, only always-on digital 
functions to support wake-up are enabled.
Entry to this state is achieved via the register interface (either by an 
external driver using the control port, or the
programmable DSP). Exit from this state is triggered by activity on 
device GPIO pins, intended SPI transaction, or I2C
transaction with intended slave address

On 3/2/23 11:19, Mark Brown wrote:
> On Thu, Mar 02, 2023 at 11:11:54AM -0600, Vlad Karpovich wrote:
>> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
>>
>> Adds support for the amplifier hibernation controlled by
>> DSP firmware.
> What is amplifier hibernation?
