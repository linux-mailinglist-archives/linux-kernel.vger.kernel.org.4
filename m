Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9029C7315DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbjFOK5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbjFOK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:57:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AE1FE4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:57:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686826664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xg+KmiB2qeRLE7ZrjzFtf6vdLQX6U7TxQqVVMe4Gw7U=;
        b=o1LRosGxzVcv13shcC7WuDak9twSuJhZ97F4x02wv6+4s4KEtIjyjerU0nM09IqqIbcL8H
        qoyNmx+WUcdmFKuNhJHtujb/P96a3begDsnUFTQawha2MnU9XHwBxKvo0loajFIYCmSDUs
        vRWo1ME/txaLEh+KJy0ANzD/qmMjOtGSHG39mcHl40KKJQjJNdzSov/BGHoGpd81hHHB8u
        TTAXQHuBiUrBu194kSVBCf4uyoZt/eOeYvzFAgPM1Oz394Nmpbx4cd34vjaK9jM35Kh8uK
        fuNElcQMahDJh5L2ZdM6WEYXojs7f/Ym8kxqbyBL+yafijLDPIr9lpCNl0C5aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686826664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xg+KmiB2qeRLE7ZrjzFtf6vdLQX6U7TxQqVVMe4Gw7U=;
        b=zxM+xm/dRWYaNIGAF4wqlBFlWMDH2hI1jUxWHgXm9r2Evy1BD7K5Z+bfIu8KH4yJ7KZxMy
        w6G22YJJO2aqaBBg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 3/8] x86/smp: Remove pointless wmb() from
 native_stop_other_cpus()
In-Reply-To: <20230615085828.GC1683497@hirez.programming.kicks-ass.net>
References: <20230613115353.599087484@linutronix.de>
 <20230613121615.762734722@linutronix.de>
 <20230615085828.GC1683497@hirez.programming.kicks-ass.net>
Date:   Thu, 15 Jun 2023 12:57:43 +0200
Message-ID: <874jn9802g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15 2023 at 10:58, Peter Zijlstra wrote:

> On Tue, Jun 13, 2023 at 02:17:58PM +0200, Thomas Gleixner wrote:
>> The wmb() after the successfull atomic_cmpxchg() is complete voodoo along
>> with the comment stating "sync above data before sending IRQ".
>> 
>> There is no "above" data except for the atomic_t stopping_cpu which has
>> just been acquired. The reboot IPI handler does not check any data and
>> unconditionally disables the CPU.
>> 
>> Remove this cargo cult barrier.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
>> ---
>>  arch/x86/kernel/smp.c |    3 ---
>>  1 file changed, 3 deletions(-)
>> 
>> --- a/arch/x86/kernel/smp.c
>> +++ b/arch/x86/kernel/smp.c
>> @@ -174,9 +174,6 @@ static void native_stop_other_cpus(int w
>>  
>>  		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
>>  
>> -		/* sync above data before sending IRQ */
>> -		wmb();
>> -
>>  		apic_send_IPI_allbutself(REBOOT_VECTOR);
>
> There's a second one a little below. That too should go.

Duh, yes.

> More to the point, the apic_send_*() functions should be the ones that
> ensure this if required etc.. See for example weak_wrmsr_fence() for
> x2apic.

Correct.
