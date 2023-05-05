Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4F6F84C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjEEOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjEEOX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:23:58 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F82AD06
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683296633;
        bh=rpKCtGOWe1G9O3FHGVApcIowlqKzHeUHB8vaBoR141s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bLWyxN5jSL4RLY3ILzkGg85mRFrQJKUdlFKcN169lL5LufRnbXoTeUMSsPC8puxZI
         YHCWAjxnMLmdGyuTDOC4TjnwhGHyMQn1Z8a8bvNdeetY6/s/4xkV5g5fmRMVE9tPPx
         9RF1jsuOFXV15VAMHsaHYUCsO5wpGl7+YdR8UXS0M2eKooRY+3RIMgQeSaObE4VrOj
         jExDSPjri9WCETFmY2/1AWWnvj8rDmXpr4Wuuckbbyp+H43DiJhuvYL0yLacAw2jOe
         8T7kU4NXCgYam84ue8F4tqP2aTYGFou5xnn0bSViTIke2LyF/xuAlW1miHjIWYqEZV
         jiqeNniY5egKQ==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QCXx51pMsz11lg;
        Fri,  5 May 2023 10:23:53 -0400 (EDT)
Message-ID: <190e5f92-f386-77a4-21c3-7f07b15ac4a3@efficios.com>
Date:   Fri, 5 May 2023 10:23:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 4/4] llist.h: Fix parentheses around macro pointer
 parameter use
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
 <20230504012914.1797355-4-mathieu.desnoyers@efficios.com>
 <87pm7gd4l5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8c28baa8-0945-fd77-3d1d-92c99c7bbbd1@efficios.com>
 <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 13:16, Linus Torvalds wrote:
> On Thu, May 4, 2023 at 7:54 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> +#define list_prepare_entry(pos, head, member) \
>> +       ((pos) ? : list_entry(head, typeof(*pos), member))
>>
>> So even though the fact that "pos" is used as an lvalue specifically in
>> llist_for_each_entry_safe() makes it so that the parentheses are not
>> strictly required around "pos" in typeof(*pos), I argue that we should
>> still add those for consistency.
> 
> Ack. It may not matter in reality because of how 'pos' is supposed to
> be just a local variable name, but I agree that for consistency our
> macros should still follow the usual pattern.
> 
> Of course, *because* of how 'pos' is not some random expression, and
> is supposed to be that local variable, and because of how it is used,
> it must always violate the whole "only use once" usual pattern,.
> 
> Exactly the same way the member name is also typically used multiple
> times because of how it's not an expression, but really a "part of the
> syntax".
> 
> So an alternative might be that we should use a different syntax for
> those things and make it clear that they are not normal expressions.
> Some people use upper-case names for special things like that to make
> them stand out as "not normal" (kind of the same way upper-case macros
> themselves were a warning that they weren't normal and might evaluate
> arguments multiple times).

Is a list iteration position absolutely required to be a local variable,
or can it be a dereferenced pointer ?

Let's say we take "list_for_each()" as example:

#define list_for_each(pos, head) \
         for (pos = (head)->next; !list_is_head(pos, head); pos = pos->next)

and turn "pos" into "POS" to make it clearer that it is used as an lvalue:

#define list_for_each(POS, head) \
         for (POS = (head)->next; !list_is_head(POS, head); pos = POS->next)

The following usage pattern is still broken:

struct list_head list;

void f(struct list_head **ppos)
{
   list_for_each(*ppos, &list) {
     //...
   }
}

Because ->next has higher operator precedence than "*", which is unexpected.

I would argue that even if we choose to capitalize the macro special arguments used
as lvalues and as member names so they stand out, it does not eliminate the need to
be careful about proper use of parentheses around those parameters when they are also
used as rvalues.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

