Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E96F6E60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjEDO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjEDOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:55:47 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81F7EDF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683212045;
        bh=8kTJiqb+pIkw8hAq1bltSLSNujeQ8GEsK3WpcmGhgjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=u4q9CtHC5ODkqYygQ7gLrA+BVC5Z2wwQo4sIo6WzPojXa0c2yF9ayDj05B5TlQhlN
         ZFy41AJhDB8hhL4IPevgAahjib8LmxsBKsQBW6kulr7meRrxNBqujDSDUOb+6SdS5b
         akXRLSC7IKWelpxwm5ZD1bgpcfiwP75vAcpBxtBNTP/WiQeVP6YmB+5hae/sVJppCm
         Suo1xU5y5xMn769BWqWujnCMWqwHi7IzoULm7BhoEt+C6KUYmJvXtscAEqzck0KRXC
         iRt2Wdvw97Hb71mb9uNSYZX+7xS6ZTw9bmZYXZY0YikY5t5vQAxpTH4Q4LCINs7bOF
         C0MV2z3vRxYJA==
Received: from [172.16.0.73] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBxfP1cPNz11H3;
        Thu,  4 May 2023 10:54:05 -0400 (EDT)
Message-ID: <8c28baa8-0945-fd77-3d1d-92c99c7bbbd1@efficios.com>
Date:   Thu, 4 May 2023 10:54:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer
 parameter use
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
 <20230504012914.1797355-4-mathieu.desnoyers@efficios.com>
 <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 01:54, Huang, Ying wrote:
> Hi, Mathieu,
> 
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> 
>> Add missing parentheses around use of macro argument "pos" in those
>> patterns to ensure operator precedence behaves as expected:
>>
>> - typeof(*pos)
>> - pos->member
>>
>> The typeof(*pos) lack of parentheses around "pos" is not an issue per se
>> in the specific macros modified here because "pos" is used as an lvalue,
>> which should prevent use of any operator causing issue. Still add the
>> extra parentheses for consistency.
> 
> I don't think it's necessary to add parentheses here.  As you said,
> "pos" is used as an lvalue.

I agree that it's not strictly necessary to add the parentheses around
"pos" in typeof(*pos) when pos is also used as an lvalue within a macro,
but if we look at what happened in list.h, we can see why having a consistent
pattern is good to eliminate issues as the code evolves.

When code from list_for_each_entry_continue was lifted into
list_prepare_entry(), we had a situation where "pos" was initially used
as an lvalue in the original macro, but not in list_prepare_entry(), for
which the parentheses were relevant.

This example is from the pre-git era, in tglx's history tree:

commit a3500b9e955d47891e57587c30006de83a3591f5
Author: Linus Torvalds <torvalds@home.osdl.org>
Date:   Wed Feb 11 21:00:34 2004 -0800

     Fix "bus_for_each_dev()" and "bus_for_each_drv()", which did not
     correctly handle the "restart from this device/driver" case, and
     caused oopses with ieee1394.
     
     This just uses "list_for_each_entry_continue()" instead.
     
     Add helper macro to make usage of "list_for_each_entry_continue()"
     a bit more readable.

[...]

+/**
+ * list_prepare_entry - prepare a pos entry for use as a start point in
+ *                     list_for_each_entry_continue
+ * @pos:       the type * to use as a start point
+ * @head:      the head of the list
+ * @member:    the name of the list_struct within the struct.
+ */
+#define list_prepare_entry(pos, head, member) \
+       ((pos) ? : list_entry(head, typeof(*pos), member))

So even though the fact that "pos" is used as an lvalue specifically in
llist_for_each_entry_safe() makes it so that the parentheses are not
strictly required around "pos" in typeof(*pos), I argue that we should
still add those for consistency.

> 
>> Remove useless parentheses around use of macro parameter (node) in the
>> following pattern:
>>
>>    llist_entry((node), typeof(*pos), member)
>>
>> Because comma is the lowest priority operator already, so the extra pair
>> of parentheses is redundant.
> 
> This change looks good for me.

Thanks,

Mathieu

> 
> Best Regards,
> Huang, Ying
> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>   include/linux/llist.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/llist.h b/include/linux/llist.h
>> index 85bda2d02d65..45d358c15d0d 100644
>> --- a/include/linux/llist.h
>> +++ b/include/linux/llist.h
>> @@ -173,9 +173,9 @@ static inline void init_llist_head(struct llist_head *list)
>>    * reverse the order by yourself before traversing.
>>    */
>>   #define llist_for_each_entry_safe(pos, n, node, member)			       \
>> -	for (pos = llist_entry((node), typeof(*pos), member);		       \
>> +	for (pos = llist_entry(node, typeof(*(pos)), member);		       \
>>   	     member_address_is_nonnull(pos, member) &&			       \
>> -	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
>> +		(n = llist_entry((pos)->member.next, typeof(*(n)), member), true); \
>>   	     pos = n)
>>   
>>   /**

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

