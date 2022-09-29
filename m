Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28915EEE46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiI2HDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiI2HDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:03:00 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A5BB5004D;
        Thu, 29 Sep 2022 00:02:53 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 994891E80CAB;
        Thu, 29 Sep 2022 14:58:24 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gaVU_ioiiltU; Thu, 29 Sep 2022 14:58:21 +0800 (CST)
Received: from [172.30.38.107] (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5B9AB1E80C7C;
        Thu, 29 Sep 2022 14:58:21 +0800 (CST)
Subject: Re: [PATCH] cxl/pmem: Use size_add() against integer overflow
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liqiong@nfschina.com" <liqiong@nfschina.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <20220927070247.23148-1-yuzhe@nfschina.com>
 <YzMjdXArM28bDsQf@iweiny-desk3>
From:   Yu Zhe <yuzhe@nfschina.com>
Message-ID: <eeec4e7f-01e1-a601-f89e-3dfa2611b039@nfschina.com>
Date:   Thu, 29 Sep 2022 15:02:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <YzMjdXArM28bDsQf@iweiny-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022年09月28日 00:23, Ira Weiny 写道:

> On Tue, Sep 27, 2022 at 12:02:47AM -0700, Yu Zhe wrote:
>> "struct_size() + n" may cause a integer overflow,
>> use size_add() to handle it.
>>
>> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
>> ---
>>   drivers/cxl/pmem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 7dc0a2fa1a6b..8c08aa009a56 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -148,7 +148,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
>>   		return -EINVAL;
>>   
>>   	/* 4-byte status follows the input data in the payload */
>> -	if (struct_size(cmd, in_buf, cmd->in_length) + 4 > buf_len)
>> +	if (size_add(struct_size(cmd, in_buf, cmd->in_length), 4) > buf_len)
> I don't see any benefit here.
>
> struct_size() calls __ab_c_size() which already calls check_add_overflow()?  So
> why wrap that in another check?
"struct_size() + 4" still might cause overflow, so there need to use 
"size_add" to check it.
> Were you able to get this to fail with some user input?
>
> Ira
>
>>   		return -EINVAL;
>>   
>>   	set_lsa =
>> -- 
>> 2.11.0
>>
>>
