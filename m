Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6602604F31
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJSR5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJSR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:57:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B18F1CC3F6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666202262; x=1697738262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EM1i9zRc6r7e4/BjI4bv8O4Xf6LqXiAGUyd+IGnrqlk=;
  b=aRD1QQBo5L9yBZOQPLzCpMlRrthgNMQfnK1tJ1f3DSqBbpBBOJIQGYEr
   7NWf5aPVyXz1syFEh4D4W0zYrbiy5wih3FytCehdMYeXiNI6k+eHYdh7J
   VyY4JIy0SXelNuPIhulZE1HsmDOP9G/le/b8RDrwVawAS/wMM3kfS0nwX
   pA3Dq/Vb52I0TQ7uNJpiqplM8/bG42FiCUXxt922KpgiJzgzItpKqhtvn
   4VN8mpKeeXa92L1Qi7c0Ue5V45fpwzLSw3xvknqDrBh4ndBTkf9OkB3hV
   9/o41UrdB7pHe10JskOzDshlAEvzA8UqvHKVZc0OSE3v8mDilMV1HPiWQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="293883471"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="293883471"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:57:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="698196915"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="698196915"
Received: from mjmcener-mobl1.amr.corp.intel.com (HELO [10.213.233.40]) ([10.213.233.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:57:40 -0700
Message-ID: <41455798-1dcb-135f-516d-25ab9a8082f5@linux.intel.com>
Date:   Wed, 19 Oct 2022 18:57:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: signal: break out of wait loops on kthread_stop()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com>
 <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/10/2022 17:00, Jason A. Donenfeld wrote:
> On Wed, Oct 19, 2022 at 7:31 AM Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> Hi,
>>
>> A question regarding a7c01fa93aeb ("signal: break out of wait loops on
>> kthread_stop()") if I may.
>>
>> We have a bunch code in i915, possibly limited to self tests (ie debug
>> builds) but still important for our flows, which spawn kernel threads
>> and exercises parts of the driver.
>>
>> Problem we are hitting with this patch is that code did not really need
>> to be signal aware until now. Well to say that more accurately - we were
>> able to test the code which is normally executed from userspace, so is
>> signal aware, but not worry about -ERESTARTSYS or -EINTR within the test
>> cases itself.
>>
>> For example threads which exercise an internal API for a while until the
>> parent calls kthread_stop. Now those tests can hit unexpected errors.
>>
>> Question is how to best approach working around this change. It is of
>> course technically possible to rework our code in more than one way,
>> although with some cost and impact already felt due reduced pass rates
>> in our automated test suites.
>>
>> Maybe an opt out kthread flag from this new behavior? Would that be
>> acceptable as a quick fix? Or any other comments?
> 
> You can opt out by running `clear_tsk_thread_flag(current,
> TIF_NOTIFY_SIGNAL);` at the top of your kthread. But you should really
> fix your code instead. Were I your reviewer, I wouldn't merge code
> that took the lazy path like that. However, that should work, if you
> do opt for the quick fix.

Right, but our hand is a bit forced at the moment. Since 6.1-rc1 has 
propagated to our development tree on Monday, our automated testing 
started failing significantly, which prevents us merging new work until 
resolved. So a quick fix trumps the ideal road in the short term. Just 
because it is quick.

Also, are you confident that the change will not catch anyone else by 
surprise? In the original thread I did not spot any concerns about the 
kthreads being generally unprepared to start receiving EINTR/ERESTARTSYS 
from random call chains.

Regards,

Tvrtko
