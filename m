Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FDF646191
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLGTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGTXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:23:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FF4E63D5C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:23:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2A823A;
        Wed,  7 Dec 2022 11:23:12 -0800 (PST)
Received: from [10.57.8.186] (unknown [10.57.8.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 128233F71A;
        Wed,  7 Dec 2022 11:23:04 -0800 (PST)
Message-ID: <2f58d821-000e-8612-31d0-e4e7be02cd4a@arm.com>
Date:   Wed, 7 Dec 2022 19:23:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm: mali-dp: Add check for kzalloc
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, brian.starkey@arm.com,
        airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20221207092118.20603-1-jiasheng@iscas.ac.cn>
 <17efaae0-9b6c-86ea-5fec-568d024d229f@arm.com>
 <Y5CxbDENPVbyqM6C@e110455-lin.cambridge.arm.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y5CxbDENPVbyqM6C@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-07 15:29, Liviu Dudau wrote:
> On Wed, Dec 07, 2022 at 01:59:04PM +0000, Robin Murphy wrote:
>> On 2022-12-07 09:21, Jiasheng Jiang wrote:
>>> As kzalloc may fail and return NULL pointer, it should be better to check
>>> the return value in order to avoid the NULL pointer dereference in
>>> __drm_atomic_helper_connector_reset.
>>
>> This commit message is nonsense; if __drm_atomic_helper_connector_reset()
>> would dereference the NULL implied by &mw_state->base, it would equally
>> still dereference the explicit NULL pointer passed after this patch.
> 
> Where?

Exactly, that function already checks conn_state for NULL anyway, so any 
reasoning based on it not doing that is clearly erroneous. Even if 
something else changed in future to actually make this a bug, it still 
wouldn't strictly dereference NULL, but some small non-NULL value.

>> The current code works out OK because "base" is the first member of struct
>> malidp_mw_connector_state, thus if mw_state is NULL then &mw_state->base ==
>> NULL + 0 == NULL. Now you *could* argue that this isn't robust if the layout
>> of struct malidp_mw_connector_state ever changes, and that could be a valid
>> justification for making this change, but the reason given certainly isn't.
> 
> I appreciate the input and I agree with your analysis, however I don't have the same
> confidence that compilers will always do the NULL + 0 math to get address of base.
> Would this always work when you have authenticated pointers or is the compiler going
> to generate some plumbing code that checks the pointer before doing the math?

For the current definition of struct malidp_mw_connector_state, 
&mw_state->base is equal to mw_state, that's just how C works:

"A pointer to a structure object, suitably converted, points to its 
initial member (or if that member is a bit-field, then to the unit in 
which it resides), and vice versa. There may be unnamed padding within a 
structure object, but not at its beginning."

Indeed a C compiler is technically at liberty to make checks for whether 
any pointer points to a valid object when evaluating it, but in practice 
no compiler is going to do that because it would be horrendously 
inefficient, and since the behaviour of dereferencing an invalid pointer 
is undefined, compilers are also able to simply assume all pointers are 
valid and generate good code based on that. Don't forget that there are 
several compiler optimisations that Linux actually depends on; AFAICT 
this is one of them.

>> Arithmetic on a (potentially) NULL pointer may well be a sign that it's
>> worth a closer look to check whether it really is what the code intended to
>> do, but don't automatically assume it has to be a bug. Otherwise, good luck
>> with "fixing" every user of container_of() throughout the entire kernel.
> 
> My understanding is that you're supposed to use container_of() only when you're sure
> that your pointer is valid. container_of_safe() seems to be the one to use when you
> don't care about NULL pointers.

I was thinking more along the lines of the "((type *)0)->member" 
expression in the definition, but fair enough, that's perhaps not the 
best example since you can argue it's an operand of typeof() which won't 
actually be evaluated. Try `git grep '&((.\+ *)\(0\|NULL\))->'` for more 
examples that will be. If none of those are going to work as intended, 
the kernel likely has bigger problems than how one driver might behave 
in OOM conditions.

Anyway, like I say I'm not objecting to the code change - even if the 
current non-bug wasn't an oversight, it's still a bit too clever for its 
own good. However, if the *justification* for making that change is 
going to go beyond "do this because static analysis suggested it", then 
it needs to explain a potential issue that actually exists and is worthy 
of fixing, not make up one that doesn't.

Cheers,
Robin.
