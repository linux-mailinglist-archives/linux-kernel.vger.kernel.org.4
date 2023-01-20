Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB794675487
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjATMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:32:06 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5151BC770
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:32:05 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KBhexR013434;
        Fri, 20 Jan 2023 06:31:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=ISvx4QPRI255I7DbCcL2cdTfvRFtbsUPzekrvWHQ+0k=;
 b=Om3QHFd7YBZM5pgGz0DkO728Rxk972BYum+K1mr7NtM7gtKqPLiEz/XC7mwLPZCQ+9Ni
 8JTJwpQHfEJ5u1qteezgPotZK6Fq4kE75AW/BJEriCCtZvLceTy6Uvax+g3Hel08UCPR
 EcG70RN/2r2pgGnuH7vuAAa7iAowQXzGfgbteasMEAKPhlSgthukS8A1CeXzkpM7HjlM
 f0Ba1PNRPS8/PBLDNsiLJCMJPoQmP0ZmF3gX/ThmrQdBqJA9wm5PAetE33zHXGlQwW3x
 fsZKIrvm4UTLhODdmbZqBksMXeXlcMwfIY5NFlzOqvfAdBXhR9x9d7svW8JkZ9dUtOom 8g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n3tp6hwt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 06:31:55 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 20 Jan
 2023 06:31:53 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Fri, 20 Jan 2023 06:31:53 -0600
Received: from [198.61.64.248] (EDIN4L06LR3.ad.cirrus.com [198.61.64.248])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3F6562A1;
        Fri, 20 Jan 2023 12:31:53 +0000 (UTC)
Message-ID: <a082e0c9-64de-3e27-5889-0207944aac85@opensource.cirrus.com>
Date:   Fri, 20 Jan 2023 12:31:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/8] ASoC: cs42l42: Add Soundwire support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-7-sbinding@opensource.cirrus.com>
 <33130336-b2ce-330e-fdec-166eee977e13@linux.intel.com>
 <418f6b73-b5ac-8d87-a856-3413ec103f91@opensource.cirrus.com>
 <6ea1b85f-22e2-8744-9638-6321a5a21acf@linux.intel.com>
 <32fd1755-0128-8f32-9a88-a92f1647f903@opensource.cirrus.com>
 <c45d34ba-1aee-16aa-1ccf-79c43c8c4ed4@linux.intel.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c45d34ba-1aee-16aa-1ccf-79c43c8c4ed4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wxr_x9Qw8jM7HfxAM-NY7ZLJPgiRK8ao
X-Proofpoint-GUID: wxr_x9Qw8jM7HfxAM-NY7ZLJPgiRK8ao
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/1/23 16:27, Pierre-Louis Bossart wrote:
> 
>>> You lost me here. Are you saying the soundwire bus clock is only known
>>> in the prepare stage?
>>>
>>
>> hw_params() doesn't know the Soundwire bus clock so it can't do the
>> check. We need to wait until we have both the sample rate and the
>> chosen SWIRE_CLK.
> 
> Yes, makes sense. I forgot that all the stream management and bandwidth
> allocation takes place in the prepare stage at the dailink level, and
> the dai prepare happens after that. Thanks for the clarification.

Also, this isn't validating the params passed by the application.
The application cannot pass us "bad" params that would cause pll_config
to fail.

The only way the pll_config could fail is if the SoundWire core code
chose a SWIRE_CLK that CS42L42 cannot support. This should never happen
and if it does it means there's an error in the ACPI or the machine
driver.
