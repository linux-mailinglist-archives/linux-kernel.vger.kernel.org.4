Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE0700A56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbjELOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjELOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:32:27 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42AAE45
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683901943;
        bh=kzZZ/3c9LS8Et5uPA4pKEd5d8sC2DDkUchvN0t9U9Uc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AwDxp5r7Qp5oBwcd1x7jfgdCs0ZD+x0zcP9ppgiLiYoDrN5oz0RKzCBhHJ3E15zay
         p5PjCS8izxY6GBr1UfywBLQzs7G2VOh7vM1/dj7Rqwpns75Dbx98IOy/eL9I41gxNm
         JEwNBe42Z6OkClY9HrIxZlWvrwX2t2ddbfx41GwyZNs8t6xgze3j/XVuc7qLSGR0Dq
         6nOKa0CdIZ/d7jzUD4DW5/RQwpPZbucA6GnF106uOCTgIe8fLMuK7N7BTPLZevbccN
         kFl5ssuxD63ZkbTFCKsFhLECwMaQiK5AAbdQuh68d0UWjOA2hrH5uwOCeMdAJ945xU
         9jXBvsWyO7b7g==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QHrng1jYvz12ZQ;
        Fri, 12 May 2023 10:32:23 -0400 (EDT)
Message-ID: <57f86cba-72f1-2573-3c5a-388614d8415a@efficios.com>
Date:   Fri, 12 May 2023 10:32:27 -0400
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
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-6-mathieu.desnoyers@efficios.com>
 <ZFjoJqbDn/BL1GQT@smile.fi.intel.com>
 <6971bfd0-b200-6cb8-7cd8-9973b72ef9ba@efficios.com>
 <ZF4crs8iKBGH3lJe@smile.fi.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZF4crs8iKBGH3lJe@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-12 07:02, Andy Shevchenko wrote:
> On Mon, May 08, 2023 at 09:46:40AM -0400, Mathieu Desnoyers wrote:
>> On 2023-05-08 08:16, Andy Shevchenko wrote:
> 
> ...
> 
>> The only use I found that would break is as follows:
>>
>> LIST_HEAD(testlist);
>>
>> int f2(void)
>> {
>>          return 1;
>> }
>>
>> #define eval(...)       __VA_ARGS__
>>
>> void f(void)
>> {
>>     struct list_head *pos;
>>
>>     list_for_each(pos, eval(f2(), &testlist)) {
>>             //...
>>     }
>> }
>>
>> Because "eval()" will evaluate "f(), &testlist" with comma and all, without
>> enclosing parentheses.
>>
>> So the question is: do we want to support this kind-of-odd macro evaluation,
>> considering that it requires adding parentheses around pretty much all macro
>> parameters when used as expressions between commas?
> 
> Similar question can be asked for your initial motivation to support indirect
> pointers. I found the double pointer as weird as this macro case. But it can be
> only me. Hence I left this to the more experienced developers to express their
> opinions.
> 

The main motivation behind my changes is to make macro code consistent, 
and to eliminate classes of issues that can arise from unexpected 
operator precedence around use of macro arguments that lack parentheses.

The examples I provide in the commit messages are just instances showing 
how the lack of parentheses can lead to unexpected effects due to 
operator precedence.

My end goal is not to "support" specific use-cases. My goal is to 
eliminate inconsistency, increase robustness of the kernel macros, and 
lessen the cognitive burden that comes with using and maintaining those 
macros.

I hope that we can spend less time figuring out operator precedence 
corner-cases and more brain power thinking about and documenting things 
that really matter like memory barriers and synchronization.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

