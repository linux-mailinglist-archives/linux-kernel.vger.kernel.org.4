Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425625BE1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiITJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiITJRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:17:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1424E2D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:17:49 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7UgYp001414;
        Tue, 20 Sep 2022 04:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=5iQ7Hk97DDzsd/9mpNc/KXu5Xgutl+Nll03FBIeS0S0=;
 b=ckT1VIouTN8aWdhtUD1phL1fw90bHxvFZHrhlhD/3GHxxMVBtD7+Ox9vONRbxcQfSTrj
 QXvzqkinZ7O0FMmdkmpolOZEmCRoNcgsJUgRkZWH8eyQ2Rx6xmKuWjQI1821KxeZm9S7
 /FvePxCgQ/1NjQ1N0h7sttYrBPHzMn4aKHmxbsnbozqbQpws5dZkRIAYwWCjYP4g66Pw
 172Gm1MtzaTyPcGB1UqzfseK4sUpR96426F5e5PqyP7XwUIC9jOYuDowoweWgT8dr2IX
 ShqCQO8w4jQ5FIeHTohLsFHt7XCVLshQyk6axImj4PmcbI+eD5P7hjEaeh8GSGcZC15V NQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jnanmka8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 04:17:30 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 20 Sep
 2022 04:17:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Tue, 20 Sep 2022 04:17:29 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 201CA475;
        Tue, 20 Sep 2022 09:17:29 +0000 (UTC)
Message-ID: <633a7b75-91f8-9a54-c042-87079d27cc8c@opensource.cirrus.com>
Date:   Tue, 20 Sep 2022 10:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] soundwire: bus: Fix wrong port number in
 sdw_handle_slave_alerts()
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20220917140256.689678-1-rf@opensource.cirrus.com>
 <9edb1178-7454-eb3f-60a5-d3f73d01c9d6@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <9edb1178-7454-eb3f-60a5-d3f73d01c9d6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FfAq9d8vE1bFE8VL_Xw0G6Lxgh3j7hlq
X-Proofpoint-ORIG-GUID: FfAq9d8vE1bFE8VL_Xw0G6Lxgh3j7hlq
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 09:44, Pierre-Louis Bossart wrote:
> 
> 
> On 9/17/22 16:02, Richard Fitzgerald wrote:
>> for_each_set_bit() gives the bit-number counting from 0 (LSbit==0).
>> When processing INTSTAT2, bit 0 is DP4 so the port number is (bit + 4).
>> Likewise for INTSTAT3 bit 0 is DP11 so port number is (bit + 11).
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Another thing that never worked, but no one has used port interrupts so
> far. I only used it for PRBS tests in early enabling some 3 years ago,
> and it was for port 2 IIRC.
> 

Except us because Cirrus Soundwire requires a full DP prepare sequence,
it doesn't support simplified DP_SM.

There's still the problem of the code deadlocking while waiting for the
prepare interrupt, because it holds the bus lock while waiting for the
completion, so the alert handler can't run. That's something I need to
look at fixing. But it's not a blocker, just means that the code has to
wait the whole timeout for each amp. (That's another thing, couldn't we
issue all the DP prepares first so the amps prepare in parallel, then
wait for them to ack?)
