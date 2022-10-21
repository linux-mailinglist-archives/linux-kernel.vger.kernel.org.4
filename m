Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674F760720D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJUIWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJUIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:21:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D226624C97B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666340491; x=1697876491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h2fCMR48Gpr6g0cjkfiTbdcqeaJO7CWEJP2WPO9iyJM=;
  b=PtIo4+qAQX0n8RhFRCFEbafYWJLibRuiy5LQmU4UzPP8CBS9P0ISHwQw
   khbB1dgAjrVw0KZtdlOK8dVBPFJfmcgMzDfSkyFtEnsLlbyehDv8RI73u
   +pX00z79BJtosp+EyQCQ4GzkEmvT7JWl+nd1tBCRffT9FrqBN7cUKsWG1
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Oct 2022 01:21:31 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:21:31 -0700
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 21 Oct
 2022 01:21:29 -0700
Message-ID: <1dd08ecb-2b08-0556-64ac-3f39a8fec76c@quicinc.com>
Date:   Fri, 21 Oct 2022 16:21:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/1] mm/page_isolation: fix clang deadcode warning
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <ziy@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <mike.kravetz@oracle.com>, <opendmb@gmail.com>
References: <20221021051936.15346-1-quic_aiquny@quicinc.com>
 <20221021051936.15346-2-quic_aiquny@quicinc.com>
 <d00d6e23-6e4f-074f-67c3-5f00e8a913d2@redhat.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <d00d6e23-6e4f-074f-67c3-5f00e8a913d2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 2:54 PM, David Hildenbrand wrote:
> On 21.10.22 07:19, Maria Yu wrote:
>> When !CONFIG_VM_BUG_ON, there is warning of
>> clang-analyzer-deadcode.DeadStores:
>> Value stored to 'mt' during its initialization
>> is never read.
>>
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   mm/page_isolation.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 04141a9bea70..a7a478a22123 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -330,9 +330,8 @@ static int isolate_single_pageblock(unsigned long 
>> boundary_pfn, int flags,
>>                         zone->zone_start_pfn);
>>       if (skip_isolation) {
>> -        int mt = 
>> get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
> 
> __maybe_unused should work as well. Was that considered?
> 
good idea.

-- 
Thx and BRs,
Aiqun(Maria) Yu
