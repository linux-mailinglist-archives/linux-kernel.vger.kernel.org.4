Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5564C6FB1FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjEHNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjEHNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:46:40 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562235D94
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683553595;
        bh=/cSiXhiFvMYAaJxpoDMBzGlk9C+yOlLOWY8dSayYoys=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VK/q15FGkAiLco+KoBE8oAHJcjYFf/TtUDsNNwMI9Jl0zuau0qNTm6Vtpji4u4kD9
         q+iqfdc/W1mUBH/e62WmQOJEHuvO+JRlEoIYT/6eAOe2C5+C5uwu0NRQC4NkbwVw4W
         zzinAn/Okanr05Jz72S/23u6n99Glvjv4w7VFrXKZowv7SxsnpmAI7NEXL4LenlKq1
         0BpIarcybOrVS+MvTPQm6lKSEiD809UHwKL28sqqNb/E612JAdzJpAbk8gWKF2C6Z1
         EvuziMvX+xXIqlcZY5/qKZAgkZ+yXXZHhYZEr0QPgGg2/V0pPo+tAhnSfqBNTxPbrp
         keFAnDS++XU+g==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QFMyg522Wz12Bt;
        Mon,  8 May 2023 09:46:35 -0400 (EDT)
Message-ID: <6971bfd0-b200-6cb8-7cd8-9973b72ef9ba@efficios.com>
Date:   Mon, 8 May 2023 09:46:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 05/13] list.h: Fix parentheses around macro pointer
 parameter use
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-6-mathieu.desnoyers@efficios.com>
 <ZFjoJqbDn/BL1GQT@smile.fi.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZFjoJqbDn/BL1GQT@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-08 08:16, Andy Shevchenko wrote:
> On Thu, May 04, 2023 at 04:05:19PM -0400, Mathieu Desnoyers wrote:
>> Add missing parentheses around use of macro argument "pos" in those
>> patterns to ensure operator precedence behaves as expected:
>>
>> - typeof(*pos)
>> - pos->member
>> - "x = y" is changed for "x = (y)", because "y" can be an expression
>>    containing a comma if it is the result of the expansion of a macro such
>>    as #define eval(...) __VA_ARGS__, which would cause unexpected operator
>>    precedence. This use-case is far-fetched, but we have to choose one
>>    way or the other (with or without parentheses) for consistency,
>> - x && y is changed for (x) && (y).
>>
>> Remove useless parentheses around use of macro parameter (head) in the
>> following pattern:
>>
>> - list_is_head(pos, (head))
>>
>> Because comma is the lowest priority operator already, so the extra pair
>> of parentheses is redundant.
> 
> But strictly speaking it might be something like
> 
> 	list_...(..., (a, b))
> 
> where (a, b) is the head. No?

The following case still works after removing the extra parentheses 
around "head" because the parentheses are present where the macro is used:

LIST_HEAD(testlist);

int f2(void)
{
         return 1;
}

void f(void)
{
    struct list_head *pos;

    list_for_each(pos, (f2(), &testlist)) {
            //...
    }
}

The only use I found that would break is as follows:

LIST_HEAD(testlist);

int f2(void)
{
         return 1;
}

#define eval(...)       __VA_ARGS__

void f(void)
{
    struct list_head *pos;

    list_for_each(pos, eval(f2(), &testlist)) {
            //...
    }
}

Because "eval()" will evaluate "f(), &testlist" with comma and all, 
without enclosing parentheses.

So the question is: do we want to support this kind-of-odd macro 
evaluation, considering that it requires adding parentheses around 
pretty much all macro parameters when used as expressions between commas?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

