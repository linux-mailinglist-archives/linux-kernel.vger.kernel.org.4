Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851A3648C93
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 03:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLJCvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 21:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJCvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 21:51:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A451C80A01
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 18:51:13 -0800 (PST)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NTXS92BnrzRpkv;
        Sat, 10 Dec 2022 10:50:17 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Dec 2022 10:51:11 +0800
Message-ID: <8ed91647-f429-493e-b4e1-1f6bf11c228b@huawei.com>
Date:   Sat, 10 Dec 2022 10:51:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH-next] lib: parser: optimize match_NUMER apis to use local
 array
To:     Tejun Heo <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <bingjingc@synology.com>, <ebiggers@google.com>,
        <james.smart@broadcom.com>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>
References: <20221209063434.1566682-1-lilingfeng3@huawei.com>
 <Y5No5kMNGGJkmcPn@slm.duckdns.org>
From:   "lilingfeng (A)" <lilingfeng3@huawei.com>
In-Reply-To: <Y5No5kMNGGJkmcPn@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.155]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/10 0:57, Tejun Heo 写道:
> Hello,
>
> In general, I think this is a great idea. Some nits below:
>
> On Fri, Dec 09, 2022 at 02:34:34PM +0800, Li Lingfeng wrote:
>> +/*
>> + * max size needed by diffrent bases to express U64
>> + * HEX: "0xFFFFFFFFFFFFFFFF" --> 18
>> + * DEC: "18446744073709551615" --> 20
>> + * OCT: "01777777777777777777777" --> 23
>> + * pick the max one to define U64_MAX_SIZE
>> + */
>> +#define U64_MAX_SIZE 23
> Bikeshedding but how about naming it like NUMBER_BUF_LEN and including the
> space for '\0'? Or just give it some extra space and make it 32 bytes.
Yes, it's my mistake, I'll send a new patch soon.
>> +static int match_strdup_local(const substring_t *s, char *buf)
> I find it weird to name this as generic as match_strdup_local() and make it
> assume that the buffer length is U64_MAX_SIZE + 1. Maybe just let the caller
> pass in the buffer length as a parameter? Then, it's just strcpy and there
> already is match_strlcpy() so we don't need this at all.

Thank you for your advice. But I think match_number() is aimed to turn the
string to num, so maybe it's better to return an error code rather than
using match_stlcpy() to truncate it to give a wrong num when the string
is too long to store.

>> +{
>> +	size_t len = s->to - s->from;
>> +
>> +	if (!s->from)
>> +		return -EINVAL;
> If we use match_strlcpy() we lose the above null check but given that other
> match_*() functions aren't doing it, this likely shouldn't matter.

Like this:
match_strdup
  kmemdup_nul
   if (!s) // null check has been done here
    return NULL
So I think null check may be necessary.

Thanks.

> Thanks.
>
