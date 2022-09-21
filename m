Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89A25BF5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 07:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIUFUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 01:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIUFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 01:20:27 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D2E24F17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 22:20:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQMWsxm_1663737621;
Received: from 30.240.97.89(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQMWsxm_1663737621)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 13:20:22 +0800
Message-ID: <09ddb8f0-9ea3-2dd0-fa77-430ff3380f85@linux.alibaba.com>
Date:   Wed, 21 Sep 2022 13:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v1 2/2] mm/damon/sysfs: use kzmalloc instead kmalloc to
 simplify codes
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220920162542.52554-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220920162542.52554-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/21 上午12:25, SeongJae Park 写道:
> Hi Xin,
>
> On Tue, 20 Sep 2022 09:58:41 +0800 haoxin <xhao@linux.alibaba.com> wrote:
>
>> 在 2022/9/20 上午1:22, SeongJae Park 写道:
>>> On Mon, 19 Sep 2022 23:12:01 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>>>
>>>> In damon_sysfs_access_pattern_alloc() adn damon_sysfs_attrs_alloc(),
>>>> we can use kzmalloc to alloc instance of the related structs, This makes
>>>> the function code much cleaner.
>>> This definitely makes the code cleaner, thank you.  But, the initial intent of
>>> the code is to initialize the fiedls that really need to be initialized at the
>>> point, for the efficiency and also for making it clear which field is needed to
>>> be initialized to what value here.  It's also intended to make readers wonder
>>> about where and how the remaining fields are initialized.
>> Maybe the other func like damon_sysfs_kdamonds_alloc() also need to do
>> like this, you can see it return directly by
>>
>> kzalloc.
>>
>> static struct damon_sysfs_kdamonds *damon_sysfs_kdamonds_alloc(void)
>> {
>>               return kzalloc(sizeof(struct damon_sysfs_kdamonds),
>> GFP_KERNEL);
>> }
> In this case, all the fields of the struct need to be initialized as zero.
> That's why we use kzalloc() there.
>
> Of course, my opinion is not a static and concrete rule, but changing mind.
> And obviously everyone makes many mistakes and DAMON code has many rooms for
> improvement.
Understand your concern,  at least, there is no point in simplifying the 
code too mush if we are ignoring its readability.
>   I really appreciate for your greatful efforts for that.  But, at
> least in this case, I think it doesn't really need the change at the moment,
> IMHO.
>
>
> Thanks,
> SJ
>
> [...]
