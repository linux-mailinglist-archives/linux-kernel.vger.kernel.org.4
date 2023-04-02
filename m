Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FB6D376D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDBKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDBKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:52:02 -0400
X-Greylist: delayed 609 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Apr 2023 03:51:59 PDT
Received: from smtp26.services.sfr.fr (smtp26.services.sfr.fr [93.17.128.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6D9618B;
        Sun,  2 Apr 2023 03:51:59 -0700 (PDT)
X-mail-filterd: {"version":"1.6.0","queueID":"4Pq9Z420W8z1LQQTJ","contextId":
 "82589fd5-e3f4-4fdd-8b54-781f08bdbfdf"}
Received: from [192.168.1.30] (atoulouse-656-1-945-91.w90-11.abo.wanadoo.fr [90.11.30.91])
        by msfrf2609.sfr.fr (SMTP Server) with ESMTP id 4Pq9Z420W8z1LQQTJ;
        Sun,  2 Apr 2023 12:41:48 +0200 (CEST)
X-mail-filterd: {"version":"1.6.0","queueID":"4Pq9Z23RRyz1LQKdm","contextId":
 "fc67f35d-c3c5-461f-99b6-2acf33930aee"}
X-sfr-mailing: LEGIT
X-sfr-spamrating: 36
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cegetel.net; s=202006;
 t=1680432108; h=Date:Subject:To:Cc:References:From:In-Reply-To; bh=xckmOE+w8K
  q09zdWEw5llLIZulp1y3UB0erw52JQ0Wo=; b=i82tQmqgH1q3/5Dypnha2XB2CMAN9aIRsYX1GR
  STzG0Flr/WkVe8vyxqFae3sPhxlcr02tfdp1QiEPaRn6OqrZG28ppSvNcKrI/FYDhuDgHOgyngzl
  FN5gaoGzDHCIJDDEvWi8kcBskLhyqgaOitnvz3vYjGxsgDEwJCtNjyhH6rLjsyK6bbV40pI+i/hc
  ePCb71Fn8qBUg4sqsWDl3Xcqjx5UlRe1+yuq6aUcnBZJyA2wNcbIDP1KORXH02OD8/oedgbj3R9k
  ewrrcwEd4manqC/tTu8zMB8dR+MTIJGo8OHnrDuMO46FJSEZvN4EeRYNjtG/6Wtb/7pNGhTHkv1A
  ==
Received: from [192.168.1.30] (atoulouse-656-1-945-91.w90-11.abo.wanadoo.fr [90.11.30.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: guy.durrieu@cegetel.net)
        by msfrf2609.sfr.fr (SMTP Server) with ESMTPSA id 4Pq9Z23RRyz1LQKdm;
        Sun,  2 Apr 2023 12:41:46 +0200 (CEST)
Authentication-Results: sfr.fr; auth=pass (PLAIN) smtp.auth=guy.durrieu@cegetel.net
Message-ID: <c02a2a2f-2b40-e13e-ac40-e5d19a66b5ba@cegetel.net>
Date:   Sun, 2 Apr 2023 12:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
To:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>, 1033732@bugs.debian.org
References: <20230105041059.39366-1-kvijayab@amd.com>
Content-Language: fr
From:   Guy Durrieu <guy.durrieu@cegetel.net>
In-Reply-To: <20230105041059.39366-1-kvijayab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/01/2023 à 05:10, Kishon Vijay Abraham I a écrit :

> Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.5
> spec mandates that both "enabled" and "online capable" Local APIC Flags
> should be used to determine if the processor is usable or not.
>
> However, Linux doesn't use the "online capable" flag for x2APIC to
> determine if the processor is usable. As a result, cpu_possible_mask has
> incorrect value and results in more memory getting allocated for per_cpu
> variables than it is going to be used.
>
> Make sure Linux parses both "enabled" and "online capable" flags for
> x2APIC to correctly determine if the processor is usable.
>
> Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reported-by: Leo Duran <leo.duran@amd.com>
> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>

Hello everyone,

My system worked fine with kernel 6.1.15, but stopped booting after
upgrading to 6.1.20 and resulted in a kernel panic:

---
[ 0.117782] Kernel panic — not syncing: timer doesn’t work through Interrupt-remapped IO-APIC
[ 0.117848] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-7-and64 #1 Debian 6.1.20-1
[ 0.117913] Hardware name: Gigabyte Technology Co., Ltd. ABS50M-Gaming 3/AB350M-Gaming 3-CF, BIOS F50d 07/02/2020
[ 0.117982] Call Trace:
[ 0.118634] <TASK>
[ 0.118685] dump_stack_lvl+0x44/0x5c
[ 0.118143] panic+0x118/0x2ed
[ 0.118198] panic_if_irq_remap.cold+0x5/0x5
[ 0.118256] setup_I0_APIC+0x3db/0x64b
[ 0.118313] ? _raw_spin_unlock_irqrestore+0x23/0x40
[ 0.118372] ? clear_IO_APIC_pin+0x169/0x240
[ 0.118429] apic_intr_node_init+0x101/0x106
[ 0.118485] x86_late_time_init+0x20/0x34
[ 0.118542] start_kerne1+0x667/0x727
[ 0.118598] secondary_startup_64_no_verify+0xe5/0xeb
[ 0.118658] </TASK>
[ 0.118711] ---[ end Kernel panic - not syncing: timer doesn’t work through Interrupt-remapped IO-APIC J---
---
I tried an update of the BIOS up to F51h without any effect.

I sent a bug report to Debian Bug Tracking System. In reply Bjørn Mork 
identified ce7d894bed1a539a8d6cff42f6f78f9db0c9c26b from the linux-6.1.y 
branch as the likely culprit.

After building a 6.1.20 kernel with just that commit reverted, my system boots normally again.

I reported that all tohttps://bugs.debian.org/1033732  and were asked to report the issue 'upstream' (which is what that mail is).

Hope it will help!

Best regards.

-- Guy Durrieu

