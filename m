Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2045BB549
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiIQBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIQBR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:17:57 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14884BCCFF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:17:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VPz2Le7_1663377472;
Received: from 30.27.91.208(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VPz2Le7_1663377472)
          by smtp.aliyun-inc.com;
          Sat, 17 Sep 2022 09:17:53 +0800
Message-ID: <354da702-ae1f-d884-3cc4-b8cde3ae9757@linux.alibaba.com>
Date:   Sat, 17 Sep 2022 09:17:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH V2] mm/hugetlb: add is_resv_equal_free() func
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220916064127.1904-1-xhao@linux.alibaba.com>
 <20220916131249.68d59133cdb0366e0831592b@linux-foundation.org>
 <YyTmJUsKqAPVk6BH@monkey>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <YyTmJUsKqAPVk6BH@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/17 上午5:09, Mike Kravetz 写道:
> On 09/16/22 13:12, Andrew Morton wrote:
>> On Fri, 16 Sep 2022 14:41:27 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>>
>>> In hugetlb.c file, there are several places to compare the values of
>>> 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
>>> there add a new is_resv_equal_free() func to do these.
>>>
>>> ...
>>>
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1191,6 +1191,11 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>>>   	return NULL;
>>>   }
>>>
>>> +static inline bool is_resv_equal_free(struct hstate *h)
>> I'm not sure that's a well chosen name.  A better name would reflect
>> the *meaning* of free_huge_pages being equal to resv_huge_pages.  Maybe
>> something like reserves_exhausted()?
> How about calling it free_non_reserved_huge_pages() and returning the actual
> value (h->free_huge_pages - h->resv_huge_pages)?
>
> Perhaps available_huge_pages()?
Ok, I am going to use available_huge_pages() in the patch v3, thanks.
> It could then be used in at least one other place
> - if (h->free_huge_pages - h->resv_huge_pages > 0)
>
>> This would all be clearer if we'd bothered to document the fields of
>> struct hstate :(
> Agree, and discussed elsewhwere some may even be able to be eliminated.  I can
> add that to my todo list.
