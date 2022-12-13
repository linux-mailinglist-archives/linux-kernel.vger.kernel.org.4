Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3C64B258
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiLMJ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiLMJ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:28:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7980613B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670923738; x=1702459738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bp30MA4PgsFJjTtXWD8JVLEk7r0vjtZzmIyP/wIb+WM=;
  b=GlfzAoK6hCpz+G6PX46+uVcX2yzq57w6jPcdkb8TfRqLTO/XHE+aYgwN
   2HF0Uz6gJnBNFHODCQzj2tcFTQ9xPmKsKK0DijFkDuBttk0VzthUn/AOb
   z/R7ZoXERW1zvuDv5/DbSIZUAadJXpsF+WHg5uDL3NdEBmFnocL/c4fb/
   e2H4jIctriQsLfCbcchgakJkE4TphtbB2GRUTHfhCiTR8GXzZowMnrfii
   MediMfyDmHpBWI7uoSRgW8l+xfMmO5bwiOQM9c81UKtfvyn17Kifm8Auy
   hkw6QiFSMJSQ5qVdn6M+Trc8W/i9rK7ToLh628TYGpIJFgn/+9gUSYFF5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="345147830"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="345147830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 01:28:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="679238977"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="679238977"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.28.83]) ([10.213.28.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 01:28:56 -0800
Message-ID: <53e7e660-9ee0-1177-b34a-365c1397ec3b@intel.com>
Date:   Tue, 13 Dec 2022 10:28:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [Intel-gfx] [PATCH 1/5] linux/minmax.h: add non-atomic version of
 xchg
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
 <b0c38501-440f-42a3-ae0f-dd95527b0e56@app.fastmail.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <b0c38501-440f-42a3-ae0f-dd95527b0e56@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.2022 18:16, Arnd Bergmann wrote:
> On Fri, Dec 9, 2022, at 16:48, Andrzej Hajda wrote:
>> The pattern of setting variable with new value and returning old
>> one is very common in kernel. Usually atomicity of the operation
>> is not required, so xchg seems to be suboptimal and confusing in
>> such cases. Since name xchg is already in use and __xchg is used
>> in architecture code, proposition is to name the macro exchange.
>>
>> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> 
> While I generally don't like type invariant calling conventions
> of xchg() and cmpxchg(), having a new function that has a similar
> name without being able to tell which one is which from the
> name seems more confusing.
> 
> Since __xchg() is only used on 11 architectures as an internal

Quite big number for 'only' :)

> name for the backing of arch_xchg() or arch_xchg_relaxed(),
> maybe we can instead rename those to __arch_xchg() and use the
> __xchg() name for the new non-atomic version?

I will try, but even compile test will be some challenge, need to find 
cross-compilers for these archs.

Btw exchange is not totally new name, for example C++ uses it [1].

[1]: https://en.cppreference.com/w/cpp/utility/exchange

Regards
Andrzej

> 
>> +/**
>> + * exchange - set variable pointed by @ptr to @val, return old value
>> + * @ptr: pointer to affected variable
>> + * @val: value to be written
>> + *
>> + * This is non-atomic variant of xchg.
>> + */
>> +#define exchange(ptr, val) ({		\
>> +	typeof(ptr) __ptr = ptr;	\
>> +	typeof(*__ptr) __t = *__ptr;	\
> 
> I think you can better express this using __auto_type than typeof(),
> it is now provided by all supported compilers now.
> 
>       Arnd

