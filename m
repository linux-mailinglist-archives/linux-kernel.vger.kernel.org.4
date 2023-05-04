Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2909F6F6DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjEDOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEDOpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:45:16 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D13CD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683211513;
        bh=HmUqcQHWR1GPfo7qcRsxY8yYNYLW02LpBYc5FEFsqHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XZQEkixgFbZ0LGv4S5U7hOgUkTYW3iG42pfZqxIjosrx5ScFlClKApj787cZuXEmW
         yxseZwyRh8Tz6DMYUfFQ9DBh/cHavZZoYuK3VKX8kGvIjfPC9ZoQPR1se4A4Hag5KT
         sy2t/+L4lIgSgtxsxZId7XLTMunfyVWLaY2RLmMeIeuHWLWXr1pbITQZhiXQOB0tbH
         tC01Tcum53pW+S3QH4TVu7N9bXjWeUxbvkJlHH14iMV+29YTofEiLlMaEIy6JQyuur
         Bl2TJsY72M3XCvAlGk6uFX9WvJOIlwsE7nZKDBKye76LHXHE3wCGZCDS9w/MBfifwo
         i6y4KWnLuTJMw==
Received: from [172.16.0.73] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBxS95vvxz11nS;
        Thu,  4 May 2023 10:45:13 -0400 (EDT)
Message-ID: <532c91c5-5655-2a15-8bf1-82ee939c156b@efficios.com>
Date:   Thu, 4 May 2023 10:45:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 2/4] list.h: Fix parentheses around macro pointer
 parameter use
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
 <20230504012914.1797355-2-mathieu.desnoyers@efficios.com>
 <ZFPEEVvHTw2uukun@smile.fi.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZFPEEVvHTw2uukun@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 10:41, Andy Shevchenko wrote:
> On Wed, May 03, 2023 at 09:29:12PM -0400, Mathieu Desnoyers wrote:
>> Add missing parentheses around use of macro argument "pos" in those
>> patterns to ensure operator precedence behaves as expected:
>>
>> - typeof(*pos)
>> - pos->member
>>
>> Remove useless parentheses around use of macro parameter (head) in the
>> following pattern:
>>
>> - list_is_head(pos, (head))
>>
>> Because comma is the lowest priority operator already, so the extra pair
>> of parentheses is redundant.
>>
>> This corrects the following usage pattern where operator precedence is
>> unexpected:
>>
>>    LIST_HEAD(testlist);
>>
>>    struct test {
>>            struct list_head node;
>>            int a;
>>    };
>>
>>    // pos->member issue
>>    void f(void)
>>    {
>>            struct test *t1;
>>            struct test **t2 = &t1;
> 
> I'm not against the patch, but I'm in doubt, looking into this example, it's useful.
> Any real use case like above in the Linux kernel, please?

There aren't because the code would not compile with the current header 
implementation. But it's unexpected that this kind of pattern does not work.

It's not about being useful, but rather about eliminating unexpected 
operator precedence within macros, and about being consistent everywhere.

Thanks,

Mathieu

> 
>>            list_for_each_entry((*t2), &testlist, node) {   /* works */
>>                    //...
>>            }
>>            list_for_each_entry(*t2, &testlist, node) {     /* broken */
>>                    //...
>>            }
>>    }
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

