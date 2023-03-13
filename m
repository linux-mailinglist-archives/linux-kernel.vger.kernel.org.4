Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7226B819E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCMTUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCMTTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:19:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546780933
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:19:12 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DJIaXY028587;
        Mon, 13 Mar 2023 14:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=W3+h24RT/FRIvh+nJCCJR20X1RVO9zAXsfV4MTdzZI0=;
 b=GV22hERHQJLFdjfYMI7lx/nZlPB965e/7DcEMnWPynNUSno1og247tNYtaL7P86nW82v
 8VYy7MOBw/IN4MkICBg/UmUSai9jDUIzlH1EJaK7XhfwoTbyyWY+nbAmqLpPGv+Jn9Hv
 WJQ+Fx+Qj2gtrJ9BckHYkwPJJtD6o5WdTC/iKiKWYdAdmG+61N2+yBiLTKqny9egWJGF
 4OcJe5fqX7k6IceGKZM+YsFBaxnHYNeGv3oFMLGQ3BsIkf/u2Qyw/qtWgVH1mLqLBO2n
 Yqieem/opCtAmGn3ABvEk7aw/wtte1KIUDG1lrBYr39GSRq7KF37L1xgB8VPndV78lk2 dA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3p8qx7bb1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:18:43 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 13 Mar
 2023 14:18:40 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 13 Mar 2023 14:18:40 -0500
Received: from [141.131.206.93] (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.206.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 43D51B06;
        Mon, 13 Mar 2023 19:18:39 +0000 (UTC)
Message-ID: <b2473ea8-c0cb-42c9-6350-dafd737d94e8@opensource.cirrus.com>
Date:   Mon, 13 Mar 2023 14:18:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/5] ASoC: cs35l45: DSP Support
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
References: <20230303192151.2437221-1-vkarpovi@opensource.cirrus.com>
 <20230303192151.2437221-4-vkarpovi@opensource.cirrus.com>
 <20230306092652.GP68926@ediswmail.ad.cirrus.com>
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
In-Reply-To: <20230306092652.GP68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SgijGJeA_QZlYJrQ_FuYwRxbMiylpvwB
X-Proofpoint-GUID: SgijGJeA_QZlYJrQ_FuYwRxbMiylpvwB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/23 03:26, Charles Keepax wrote:
> On Fri, Mar 03, 2023 at 01:21:50PM -0600, Vlad Karpovich wrote:
>> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
>>
>> The CS35L45 digital core incorporates one programmable DSP block,
>> capable of running a wide range of audio enhancement and speaker
>> and battery protection functions.
>>
>> Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
>> ---
>> +#define CS35L45_DAC_MUX_ROUTE(name) \
>> +	{ name" Source", "ASP_RX1",	"ASP_RX1" }, \
>> +	{ name" Source", "ASP_RX2",	"ASP_RX2" }, \
>> +	{ name" Source", "DSP_TX1",	"DSP1" }, \
>> +	{ name" Source", "DSP_TX2",	"DSP1" }
>> +
>> +
> Minor nit, double blank line here.
Thanks. I will fix it
> But otherwise looks pretty good to me:
>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Thanks,
> Charles
