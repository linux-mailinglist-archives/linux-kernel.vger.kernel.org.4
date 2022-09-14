Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0697E5B8A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiINOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiINOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:32:09 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C652B1AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:32:08 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDgIMw006022;
        Wed, 14 Sep 2022 09:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=+uvX3O/5+Bc1TjUh5LCmQLOyTTOb43kiT73lo8oCevU=;
 b=P8DNNhIfHhctFqBWEhN3b1+azzXVU/ZMu7cszWsKUVbMAgeWNLqD3YuxQAsKmtBiTmD4
 3cVipWj6IpKA8bz06ota/k42e+tcgc/hHwjUoE+vmUmF931F5/y3ESUvvSZPJEKKirk0
 zBF/wk42+ylipHwQr98uv5gd9fpmZm2v7KqdPC0Hl/eeN5hB8ruOIsQLEExPuIya515K
 icJrhYtIuUeiPI3sdw/p7rPNG3WovtJKSbckVO0zIxnGAV7XBh3CuqMM/24URDboi4kC
 rtHwqm4U/zdeT9uH9FOtay/9k9b5YafRkpXV/JlbeawIlnU4+jQy4YrgKbh3A5ZOYx2c YA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05h4ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 09:30:34 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 09:30:32 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 14 Sep 2022 09:30:32 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B9795468;
        Wed, 14 Sep 2022 14:30:32 +0000 (UTC)
Message-ID: <5ab8f14d-8fa0-ea37-a664-88a0cff9b92f@opensource.cirrus.com>
Date:   Wed, 14 Sep 2022 15:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 4/5] soundwire: cadence: Fix lost ATTACHED interrupts
 when enumerating
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
 <20220914120949.747951-5-rf@opensource.cirrus.com>
 <1b506127-f992-b554-e984-589dc46aa110@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <1b506127-f992-b554-e984-589dc46aa110@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bSpGVebz6QD1fUzgwdCR2e0xCkd219Ev
X-Proofpoint-ORIG-GUID: bSpGVebz6QD1fUzgwdCR2e0xCkd219Ev
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 14:48, Pierre-Louis Bossart wrote:
> 
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 245191d22ccd..2f131604d884 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -954,9 +954,22 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>>   	u32 device0_status;
>>   	int retry_count = 0;
>>   
>> +	/*
>> +	 * Clear main interrupt first so we don't lose any assertions
>> +	 * the happen during this function.
> 
> typo: that happen?
> 

I hate typos.
