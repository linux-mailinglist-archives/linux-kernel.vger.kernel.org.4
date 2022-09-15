Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB065B92B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiIOCos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIOCoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:44:44 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6951A1B0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:44:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPqlKcb_1663209877;
Received: from 30.240.97.215(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPqlKcb_1663209877)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 10:44:38 +0800
Message-ID: <408fbc89-8711-0ea2-16e7-99b746e1f09e@linux.alibaba.com>
Date:   Thu, 15 Sep 2022 10:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] mm/hugetlbfs: use macro SZ_1K to replace 1024
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, SeongJae Park <sj@kernel.org>
References: <20220914115723.38271-1-xhao@linux.alibaba.com>
 <YyIEsuOm0wEkmpAA@ZenIV>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <YyIEsuOm0wEkmpAA@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/15 上午12:43, Al Viro 写道:
> On Wed, Sep 14, 2022 at 07:57:23PM +0800, Xin Hao wrote:
>> Using macro SZ_1K in hugetlbfs_show_options() has no any functional
>> changes, just makes code more readable.
> Why is it any more readable that way?
The main purpose of this code is to convert size to 'K', and 'M'. I 
think using SZ_1k does look more appropriate than 1024, that's all.
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   fs/hugetlbfs/inode.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index f7a5b5124d8a..9b9784ffe8de 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1023,10 +1023,10 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
>>   	if (sbinfo->max_inodes != -1)
>>   		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
>>
>> -	hpage_size /= 1024;
>> +	hpage_size /= SZ_1K;
>>   	mod = 'K';
>> -	if (hpage_size >= 1024) {
>> -		hpage_size /= 1024;
>> +	if (hpage_size >= SZ_1K) {
>> +		hpage_size /= SZ_1K;
>>   		mod = 'M';
>>   	}
>>   	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
>> --
>> 2.31.0
