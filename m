Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF16B9826
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCNOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCNOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:40:42 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46094F68
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:40:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o12so507294iow.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678804829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RAFoCrpjNlYi5vJikPY3OrGJrL41+cdzECkQM5fWXq8=;
        b=GpanjdyDxZ6cMWqUN39peyDc1aDT6ThpTVYheOMedrqt6fDcoyT2+lyLjjvCe9EPQy
         2pHRNNcbEswV+jpaMOr1YQB7bqLq1r+1YeejCDd7N5jQjPRdjNRzlp0aAJGZqQxtMi3V
         uHbZbixJx7LJofSMxy5pWvpFytcWmoHa8N1UBwzB2cGbfASteUH0JJel25SLOxORqX20
         OGkP3Dro19YVufXXuqTW0yXidKxMidEtSU5VHNy+hLTXuiom013JEvuipU4fkpHgj96Z
         mIbuwXGTXQjo6VQSAdKYPe9EHIgc3jg/iDrplqTHIukfP1JEB0rJ2zzGfA1DqohFxQtd
         /gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678804829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAFoCrpjNlYi5vJikPY3OrGJrL41+cdzECkQM5fWXq8=;
        b=Ib6toIJU+7Qk2w8Tj2hUeA4Ecpmt965bNl8HpTm7OhTKuPkZxG2oFXWkh6Uh2Lsrpo
         erEVEpvtAPR2zj73V1Qu8rk74kIy+lOtuNTVFIvIkQ2lKkA1zynDM0bEoK4H91RwYIjE
         KPs7ujkr9Q0443uuJpCuCZAOVW3+4mESGWg3cnGEoD08o0VlD7TbEnZkO9HLbLjA0Ab4
         8S67LYQqf7aXpH7tYUT/rXBmWFe5kQu+EjJG2Fc5zNaL8MeyfEJJ+kRi/TNlfEr1QbEC
         YxdOWv4pOlbl9AWBWMTI+2LrFmbszvQI8fzvC5bxwOcNBBNRAym0Y5O8Bkijw0rcIIfY
         cWRg==
X-Gm-Message-State: AO0yUKUl6ATKJ2VryaUrUK5FXoPrHplyTJFc5aGYwssj71XKq6Q2OGQb
        qOcQ79aIE3aURiRrfOZBvT4sFni+OL8=
X-Google-Smtp-Source: AK7set89atq5XWjZoINr1LMGQH1RADdszz0pG55bvhOTWSFxLDqd/d83VJBJn/Yt30vdYp/CJ+/H2A==
X-Received: by 2002:a6b:6a05:0:b0:73d:eb4b:345e with SMTP id x5-20020a6b6a05000000b0073deb4b345emr23497850iog.6.1678804829041;
        Tue, 14 Mar 2023 07:40:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k23-20020a5d97d7000000b00740694b5f43sm861339ios.46.2023.03.14.07.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 07:40:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <38695adb-c654-c83f-5bbf-ad22a59a62bd@roeck-us.net>
Date:   Tue, 14 Mar 2023 07:40:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Linux 6.3-rc2
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen>
 <dc031bc7-8ca4-7ca7-c24f-9db65b5547e4@roeck-us.net>
 <ZBBYCSZUJOWBg1s8@localhost.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZBBYCSZUJOWBg1s8@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 04:18, Frederic Weisbecker wrote:
> Le Mon, Mar 13, 2023 at 05:52:49PM -0700, Guenter Roeck a écrit :
>> On 3/13/23 16:11, Frederic Weisbecker wrote:
>> [   11.360487] WARNING: CPU: 0 PID: 233 at kernel/locking/lockdep.c:5527 check_flags (./arch/arm/include/asm/current.h:36 (discriminator 12) ./include/asm-generic/preempt.h:11 (discriminator 12) kernel/locking/lockdep.c:5528 (discriminator 12))
>> [   11.361102] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
>> [   11.361173] Modules linked in:
>> [   11.361730] CPU: 0 PID: 233 Comm: rcS Tainted: G                 N 6.3.0-rc2-dirty #2
>> [   11.361921] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
>> [   11.362303] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
>> [   11.362441] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
>> [   11.362519] dump_stack_lvl from __warn (./include/linux/jump_label.h:260 ./include/linux/jump_label.h:270 ./include/trace/events/error_report.h:69 kernel/panic.c:681)
>> [   11.362598] __warn from warn_slowpath_fmt (./arch/arm/include/asm/current.h:36 ./include/asm-generic/preempt.h:16 ./include/asm-generic/preempt.h:59 ./include/linux/context_tracking.h:154 kernel/panic.c:706)
>> [   11.362702] warn_slowpath_fmt from check_flags (./arch/arm/include/asm/current.h:36 (discriminator 12) ./include/asm-generic/preempt.h:11 (discriminator 12) kernel/locking/lockdep.c:5528 (discriminator 12))
>> [   11.362780] check_flags from lock_is_held_type (./arch/arm/include/asm/percpu.h:37 kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5713)
>> [   11.362851] lock_is_held_type from rcu_read_lock_sched_held (kernel/rcu/update.c:125)
>> [   11.362933] rcu_read_lock_sched_held from trace_rcu_dyntick (./include/trace/events/rcu.h:480 (discriminator 28))
>> [   11.363016] trace_rcu_dyntick from ct_nmi_enter (./arch/arm/include/asm/percpu.h:37 (discriminator 4) ./include/linux/context_tracking_state.h:90 (discriminator 4) kernel/context_tracking.c:301 (discriminator 4))
>> [   11.363108] ct_nmi_enter from irq_enter (kernel/softirq.c:625)
>> [   11.363177] irq_enter from generic_handle_arch_irq (kernel/irq/handle.c:238)
>> [   11.363251] generic_handle_arch_irq from call_with_stack (arch/arm/lib/call_with_stack.S:45)
>> [   11.363339] call_with_stack from __irq_svc (arch/arm/kernel/entry-armv.S:232)
>> [   11.363438] Exception stack(0xd1819f60 to 0xd1819fa8)
>> [   11.363629] 9f60: ecac8b10 40000000 b6f88418 c1c2607c 00000000 40000000 c4acc00b 00000001
>> [   11.363740] 9f80: 00000b00 c0101278 c4acc0f0 00000000 00000051 d1819fb0 c01011c4 c0103c1c
>> [   11.363833] 9fa0: 00000013 ffffffff
>> [   11.363896] __irq_svc from vfp_reload_hw (arch/arm/vfp/vfphw.S:149)
>> [   11.364015] irq event stamp: 1626
>> [   11.364069] hardirqs last enabled at (1625): __und_usr (arch/arm/kernel/entry-armv.S:465)
>> [   11.364199] hardirqs last disabled at (1626): __irq_svc (arch/arm/kernel/entry-armv.S:221)
>> [   11.364290] softirqs last enabled at (1424): __do_softirq (./arch/arm/include/asm/current.h:36 ./include/asm-generic/preempt.h:11 kernel/softirq.c:415 kernel/softirq.c:600)
>> [   11.364396] softirqs last disabled at (1323): __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650)
>> [   11.364494] ---[ end trace 0000000000000000 ]---
>> [   11.364637] preempt_count(): 201 softirq_count(): 200
>>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Ok so this is a softirq disabled section that doesn't handle the lockdep
> part.
> 
> How does the following look like as a culprit?
> 
> 62b95a7b44d1 (ARM: 9282/1: vfp: Manipulate task VFP state with softirqs disabled)
> 

I'll give it a try. Sorry for the misleading bisect results I sent earlier.

Thanks,
Guenter

