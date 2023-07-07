Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475B474AEA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGGKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGGKSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:18:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602110B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:18:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688725121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2d3houmsYkGVGZJ+TnslUxorhkLSwL4n9/p70tnZL7A=;
        b=y4doa5DKfOzdCF21tIHXXGEp7Tighcyi2aqc4+bE5su2grB8igK69DcILbae5lykTRs5JV
        PYm8S351m8I52i6O6betlp1NJBOuaDOhcpSjHpAf5gkPS4ql4bPs59vUfRwN0hS9oBxuGZ
        HjfgVjqt5FZpSyJuXRwsWXqLu6J3UyRqhFNdrmogJQ1uVYvApG4e2Mrb+3YSpKMjw+Fuhg
        aRPDRjqsb/hyTS0kFyDNsh6kwdQIYmX8MSLyHPhJp7wTnbDAeNbh9ORfvwHzHkqL0p85+B
        TOR0s68ZDsmb21uc+eK6qJ/CoWkJZQt1mKvLGEyZipI8aM+1MJbfWzOqwFeCDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688725121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2d3houmsYkGVGZJ+TnslUxorhkLSwL4n9/p70tnZL7A=;
        b=9tdprbeuz34HJLn6OXpF/f1dsXMyUURUW2bxIbsBMyXUbdtkctVG/W3f9EIP518gzZTyL0
        btin56Kv04H/BoDg==
To:     Baokun Li <libaokun1@huawei.com>
Cc:     arjan@linux.intel.com, ashok.raj@intel.com,
        ashok.raj@linux.intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        tonyb@cybernetics.com, x86@kernel.org,
        yangerkun <yangerkun@huawei.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, Baokun Li <libaokun1@huawei.com>
Subject: Re: [BUG REPORT] Triggering a panic in an x86 virtual machine does
 not wait
In-Reply-To: <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com>
References: <20230615193330.608657211@linutronix.de>
 <71578392-63ed-02a9-24da-2adf8cce38c7@huawei.com> <87ttui91jo.ffs@tglx>
 <d7f266fd-e34d-e26e-e371-ee6ff13b6696@huawei.com>
Date:   Fri, 07 Jul 2023 12:18:39 +0200
Message-ID: <87lefs81og.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06 2023 at 14:44, Baokun Li wrote:
> On 2023/7/5 16:59, Thomas Gleixner wrote:
>> +	/*
>> +	 * If this is a crash stop which does not execute on the boot CPU,
>> +	 * then this cannot use the INIT mechanism because INIT to the boot
>> +	 * CPU will reset the machine.
>> +	 */
>> +	if (this_cpu)
>> +		return false;

> This patch does fix the problem of rebooting at panic, but the
> exported stack stays at stop_this_cpu() like below, instead of showing
> what the corresponding process is doing as before.
>
> PID: 681=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TASK: ffff9ac2429d3080=C2=A0 CPU: =
2=C2=A0=C2=A0=C2=A0 COMMAND: "fsstress"
>  =C2=A0#0 [ffffb00200184fd0] stop_this_cpu at ffffffff89a4ffd8
>  =C2=A0#1 [ffffb00200184fe8] __sysvec_reboot at ffffffff89a94213
>  =C2=A0#2 [ffffb00200184ff0] sysvec_reboot at ffffffff8aee7491
> --- <IRQ stack> ---
>  =C2=A0=C2=A0=C2=A0 RIP: 0000000000000010=C2=A0 RSP: 0000000000000018=C2=
=A0 RFLAGS: ffffb00200f8bd08
>  =C2=A0=C2=A0=C2=A0 RAX: ffff9ac256fda9d8=C2=A0 RBX: 0000000009973a85=C2=
=A0 RCX: ffff9ac256fda078
>  =C2=A0=C2=A0=C2=A0 RDX: ffff9ac24416e300=C2=A0 RSI: ffff9ac256fda9e0=C2=
=A0 RDI: ffffffffffffffff
>  =C2=A0=C2=A0=C2=A0 RBP: ffff9ac2443a5f88=C2=A0=C2=A0 R8: 000000000000000=
0=C2=A0=C2=A0 R9: ffff9ac2422eeea0
>  =C2=A0=C2=A0=C2=A0 R10: ffff9ac256fda9d8=C2=A0 R11: 0000000000549921=C2=
=A0 R12: ffff9ac2422eeea0
>  =C2=A0=C2=A0=C2=A0 R13: ffff9ac251cd23c8=C2=A0 R14: ffff9ac24269a800=C2=
=A0 R15: ffff9ac251cd2150
>  =C2=A0=C2=A0=C2=A0 ORIG_RAX: ffffffff8a1719e4=C2=A0 CS: 0206=C2=A0 SS: f=
fffffff8a1719c8
> bt: WARNING: possibly bogus exception frame
>
> Do you know how this happened? I would be grateful if you could fix it.

No, I don't. But there is clearly a hint:

> bt: WARNING: possibly bogus exception frame

So the exception frame seems to be corrupted. I have no idea why.

The question is, whether this goes away when you revert that commit or not.
I can't oracle that out from your report.

Can you please revert 45e34c8af58f on top of Linus tree and verify that
it makes the issue go away?

Thanks,

        tglx
