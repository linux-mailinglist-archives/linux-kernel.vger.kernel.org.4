Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1B65EEB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjAEO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjAEO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:26:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF894A964
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672928767; x=1704464767;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z67iM0jfw8rBDBXuutR2adWOVf2bd9BhkqQyZcE/mpY=;
  b=bJmGz2yuwoesCJg/qlfR+WaB0Hp24qAjwrrmVH7ARqefSTdmWmO25P98
   S9YogtixSUWanBlaOqyElRirgv9IH92DUmkMDoVq7YUaZEGFnBPRffTcG
   x7nPAi5FznUx/emmoDV2trFYlwnFOOSNP+l/gIQsT7M23ZiPeW8BxS0GO
   Wg1LQm/RVK5pGMoJFHzuy9lemXk/F3ho3LDJ2Ge5LHx2ZPer0IBpXtftE
   MzQYpnM+B3BU4lmflHwgFYbvpLW+AzZk1/JSOQlqyQjM/zDXtY5sWq50l
   WbL8C5cjQ+mZdP+9JI00j9G14SfzIwPPmNqVScjls65+ahpMAu5zR/wZN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="305721809"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="305721809"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 06:13:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="829564429"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="829564429"
Received: from ciarapow-mobl1.ger.corp.intel.com (HELO [10.213.208.73]) ([10.213.208.73])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 06:13:47 -0800
Message-ID: <e745c30e-71cc-49ff-c8bc-543bfbe0504d@linux.intel.com>
Date:   Thu, 5 Jan 2023 14:13:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-gfx] [PATCH 1/5] linux/minmax.h: add non-atomic version of
 xchg
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Jani Nikula' <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        'Andrzej Hajda' <andrzej.hajda@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
 <f58ab17e5c6c4a4e8b0d687b44618c51@AcuMS.aculab.com>
 <Y7bK8drngH/NIlOa@phenom.ffwll.local> <875ydlw1p4.fsf@intel.com>
 <733cd0037bd14a269b54d701e1b80323@AcuMS.aculab.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <733cd0037bd14a269b54d701e1b80323@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/01/2023 13:34, David Laight wrote:
> From: Jani Nikula
>> Sent: 05 January 2023 13:28
>>
>> On Thu, 05 Jan 2023, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Mon, Dec 12, 2022 at 09:38:12AM +0000, David Laight wrote:
>>>> From: Andrzej Hajda <andrzej.hajda@intel.com>
>>>>> Sent: 09 December 2022 15:49
>>>>>
>>>>> The pattern of setting variable with new value and returning old
>>>>> one is very common in kernel. Usually atomicity of the operation
>>>>> is not required, so xchg seems to be suboptimal and confusing in
>>>>> such cases. Since name xchg is already in use and __xchg is used
>>>>> in architecture code, proposition is to name the macro exchange.
>>>>
>>>> Dunno, if it is non-atomic then two separate assignment statements
>>>> is decidedly more obvious and needs less brain cells to process.
>>>> Otherwise someone will assume 'something clever' is going on
>>>> and the operation is atomic.
>>>
>>> Yes, this also my take. The i915 code that uses this to excess is decidely
>>> unreadable imo, and the macro should simply be replaced by open-coded
>>> versions.
>>>
>>> Not moved into shared headers where even more people can play funny games
>>> with it.
>>
>> My stand in i915 has been that the local fetch_and_zero() needs to
>> go. Either replaced by a common helper in core kernel headers, or open
>> coded, I personally don't care, but the local version can't stay.
>>
>> My rationale has been that fetch_and_zero() looks atomic and looks like
>> it comes from shared headers, but it's neither. It's deceptive. It
>> started small and harmless, but things like this just proliferate and
>> get copy-pasted all over the place.
>>
>> So here we are, with Andrzej looking to add the common helper. And the
>> same concerns crop up. What should it be called to make it clear that
>> it's not atomic? Is that possible?
> 
> old_value = read_write(variable, new_value);
> 
> But two statements are much clearer.

In a later thread there was more discussion on this and some new 
suggestions - exchange(), replace() or even take() sound fine to me. 
Last one is perhaps most specialized if it implies zeroing, which I at 
least assume it does.

All three are distant enough from atomic connotations of xchg. If that 
was a concern with __xchg, which I not sure it should be since there is 
"prior art" in the kernel for atomic vs non-atomic like set_bit and 
__set_bit.

My 2c, regardless of what name, that it is not something which is 
strictly needed, but a convenient syntactic sugar. (Exploded line counts 
with sometimes single use local variables are a bit meh.) And I am not 
really sure that open coding is more readable once the new pattern would 
be established. In short, if there can be swap there can be $insert_name 
too I guess.

Bonus points if needlessly atomic sites can be converted but identifying 
them is probably an exercise for a later phase.

Regards,

Tvrtko

P.S. FWIW my preference are either replace() or __xchg().
