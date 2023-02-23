Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F9D6A00E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBWBv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBWBv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:51:26 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184A75FDE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:51:22 -0800 (PST)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 31N1pDD2024309;
        Thu, 23 Feb 2023 10:51:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Thu, 23 Feb 2023 10:51:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 31N1pDqV024305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Feb 2023 10:51:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3d82949d-9951-abf3-134a-8734ec81af3b@I-love.SAKURA.ne.jp>
Date:   Thu, 23 Feb 2023 10:51:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Intel-gfx] How is the progress for removing
 flush_scheduled_work() callers?
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e170edc2-e5b9-4c8b-4ed3-7e2d7a2850dc@I-love.SAKURA.ne.jp>
 <877czv2ov8.fsf@intel.com> <Y3TgO7pHo9z9FINO@intel.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y3TgO7pHo9z9FINO@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/16 22:06, Ville Syrjälä wrote:
> On Wed, Nov 16, 2022 at 12:08:27PM +0200, Jani Nikula wrote:
>> On Sun, 06 Nov 2022, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
>>> macro") says, flush_scheduled_work() is dangerous and will be forbidden.
>>> We are on the way for removing all flush_scheduled_work() callers from
>>> the kernel, and there are only 4 callers remaining as of linux-20221104.
>>>
>>>   drivers/gpu/drm/i915/display/intel_display.c:8997:      flush_scheduled_work();
>>
>> Thanks for the reminder, I've pinged folks to get someone working on
>> this. We do schedule quite a bunch of work, so it's not immediately
>> obvious (at least to me) what exactly needs flushing.
> 
> Here's my earlier cursory analysis of the subject:
> https://lore.kernel.org/intel-gfx/Yy3byxFrfAfQL9xK@intel.com/

Now that a patch for mptscsih.c was proposed as
https://lkml.kernel.org/r/0b9ebcfb-b647-1381-0653-b54528a64a86@I-love.SAKURA.ne.jp ,
intel_display.c is going to become the last flush_scheduled_work() user.

If fixing the hpd disable path takes more time, should we start with moving
related works from system_wq to a local workqueue dedicated for intel_display.c ?

> 
>>
>> https://gitlab.freedesktop.org/drm/intel/-/issues/7546
>>
>>>   drivers/gpu/drm/i915/gt/selftest_execlists.c:88:        flush_scheduled_work();
>>
>> Removed by commit 7d33fd02dd94 ("drm/i915/selftests: Remove
>> flush_scheduled_work() from live_execlists") in drm-next.
>>
>> BR,
>> Jani.
>>
>> -- 
>> Jani Nikula, Intel Open Source Graphics Center
> 

