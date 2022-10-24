Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769B7609AED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJXHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJXHEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:04:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD6A25EA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 392266102D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1BCC433D7;
        Mon, 24 Oct 2022 07:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666595073;
        bh=Su7NKeLJ8UaGZS7OVRXBv5zP6tQe/cbgu5BIToyLupk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=oLPK4g+7e86PxJt+sODUZz10vdYNUWVNi14HOYe0gNhlCWZEEnWkSkj4R7YkZWnQk
         6pHXCthVvo+WZBaWIPaYJSfEXqoUR0zqzT+79ACierkqVAik26Z0i5lERPdu9A/pXv
         bXWJrrSv0qJrmRBE2PxvjyzDEtIxp9i3v0OZ9yDwGpshwC18eEGwF/YK/arUNHga8U
         AUaUGctslfk2JZI6GK6cvzHZ2DX1Q3x/iif2VqVuYjEGpTdaHkf5e5y8DAZ2CZ/iY7
         I7QjKy2ofCC5gPP1/lWqn8HGDObX6hSPBxavdtFV1V0CmOKI9Jh7WuVsRsHB4nFI1f
         3uc09kenLs6xg==
Date:   Mon, 24 Oct 2022 08:04:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, dmitriy@oss-tech.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_clocksource/drivers/riscv=3A?= =?US-ASCII?Q?_Events_are_stopped_during_CPU_suspend?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a2dc76e8-406e-5f27-0dc6-846c338660c9@sholland.org>
References: <mhng-ea4ae670-742b-424e-9363-c66ad9ee741c@palmer-ri-x1c9> <a2dc76e8-406e-5f27-0dc6-846c338660c9@sholland.org>
Message-ID: <BE338A13-1554-452F-9BC0-FF84905A1228@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 October 2022 06:01:24 IST, Samuel Holland <samuel@sholland=2Eorg> wr=
ote:
>On 10/9/22 18:45, Palmer Dabbelt wrote:
>> On Thu, 29 Sep 2022 14:50:45 PDT (-0700), Conor Dooley wrote:
>>> On Sun, May 08, 2022 at 08:21:21PM -0500, Samuel Holland wrote:
>>>> Some implementations of the SBI time extension depend on hart-local
>>>> state (for example, CSRs) that are lost or hardware that is powered
>>>> down when a CPU is suspended=2E To be safe, the clockevents driver
>>>> cannot assume that timer IRQs will be received during CPU suspend=2E
>>>>
>>>> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
>>>> Signed-off-by: Samuel Holland <samuel@sholland=2Eorg>
>>>> ---
>>>>
>>>> =C2=A0drivers/clocksource/timer-riscv=2Ec | 2 +-
>>>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clocksource/timer-riscv=2Ec
>>>> b/drivers/clocksource/timer-riscv=2Ec
>>>> index 1767f8bf2013=2E=2E593d5a957b69 100644
>>>> --- a/drivers/clocksource/timer-riscv=2Ec
>>>> +++ b/drivers/clocksource/timer-riscv=2Ec
>>>> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long del=
ta,
>>>> =C2=A0static unsigned int riscv_clock_event_irq;
>>>> =C2=A0static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_ev=
ent) =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =2Ename=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "riscv_timer_clockevent",
>>>> -=C2=A0=C2=A0=C2=A0 =2Efeatures=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D CLOCK_EVT_FEAT_ONESHOT,
>>>> +=C2=A0=C2=A0=C2=A0 =2Efeatures=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
>>=20
>> This is listed as being x86-specific in the header, but there's a hanfu=
l
>> of other ports that enable it for timers as well=2E=C2=A0 Looks like ar=
m is
>> setting this based on DT, which seems reasonable to me: we're working
>> around a firmware bug, there should be some way to turn off that
>> workaround for firmware that doesn't have the bug=2E Looks like Intel a=
lready
>> turns this off when ARAT is supported, which seems to be the case for
>> anything modern, so maybe we're just tripping up on some untested behav=
ior here?=C2=A0
>> I'm not sure exactly how we should probe this, but having it only enabl=
ed
>> when we need the workaround seems like the right way to go=2E
>
>I opened an issue against the SBI spec about what exactly it requires,
>but I got no responses:
>
>https://github=2Ecom/riscv-non-isa/riscv-sbi-doc/issues/98
>
>My interpretation of the SBI specification is that it does not require
>maintaining any hart-local state across a non-retentive hart suspend=2E
>Unless the SBI spec says the timer must fire during/after suspend, then
>there is no firmware bug=2E
>
>> That said, I'm not actually sure this C3STOP feature does what we want
>> given the commit description=2E=C2=A0 The timers on RISC-V are sort of =
in this
>> odd middle-ground between being per-CPU timers and system timers: the
>> time they produce is global (or at least close, due to the mtime
>> synchronization rules) but the actual interrupts are only one-shot and
>> only local=2E
>
>And if we cannot rely on the interrupt being delivered, we cannot rely
>on the SBI time extension to work across cpuidle entry=2E
>
>> From poking around the code I think this just tries to
>> setup a periodic broadcast timer, but since we use software fallbacks t=
o
>> emulate those we'll still end up losing the interrupts/ticks if the CPU
>> that was asked for an interrupt has gone to sleep and lost that state=
=2E
>
>So by extension, non-retentive cpuidle states cannot be used if the SBI
>timer is the only available timer, since there is no hardware broadcast
>timer to use as a backup=2E
>
>> I'm not sure if I'm just misunderstanding what's going on here, though=
=2E=C2=A0
>> Is there something that describes the behavior this fixes in more detai=
l?
>
>The motivating scenario for this patch is the C906, where the MTIMER is
>in the same reset domain as the CPU, so the timer state is lost during
>non-retentive suspend=2E Without this patch, if riscv_timer_clockevent is
>the current clockevent driver, then the CPU fails to wake up from
>suspend=2E However, this same problem would occur on any CPU where the
>timer or interrupt delivery stops working during suspend=2E
>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =2Erating=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 100,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =2Eset_next_event=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D riscv_clock_next_event,
>>>> =C2=A0};
>>>
>>> After a bit of a painful bisection (with a misdirection into the v5=2E=
19
>>> printk reverts along the way) I have arrived at this commit for causin=
g
>>> me some issues=2E
>>>
>>> If an AXI read to the PCIe controller on PolarFire SoC times out, the
>>> system will stall, with an expected:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 io scheduler mq-deadline registered
>>> =C2=A0=C2=A0=C2=A0=C2=A0 io scheduler kyber registered
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: host bridge=
 /soc/pcie@2000000000
>>> ranges:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 MEM
>>> 0x2008000000=2E=2E0x2087ffffff -> 0x0008000000
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: axi read re=
quest error
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: axi read ti=
meout
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Freeing initrd memory: 7336K
>>> =C2=A0=C2=A0=C2=A0=C2=A0 mc_event_handler: 667402 callbacks suppressed
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: sec error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 microchip-pcie 2000000000=2Epcie: ded error i=
n pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0 mc_event_handler: 666588 callbacks suppressed
>>> <truncated>
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0mc_event_handler: 666748 callbacks suppressed
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0rcu: INFO: rcu_preempt detected stalls on CPUs=
/tasks:
>>> =C2=A0=C2=A0=C2=A0=C2=A0rcu:=C2=A0=C2=A0=C2=A0=C2=A0 0-=2E=2E=2E0: (1 =
GPs behind) idle=3D19f/1/0x4000000000000002
>>> softirq=3D34/36 fqs=3D2626
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (detected by 1, t=3D5256 ji=
ffies, g=3D-1151, q=3D1143 ncpus=3D4)
>>> =C2=A0=C2=A0=C2=A0=C2=A0Task dump for CPU 0:
>>> =C2=A0=C2=A0=C2=A0=C2=A0task:swapper/0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 state:R=C2=A0 running task=C2=A0=C2=A0=C2=A0=C2=A0 stack:=C2=A0=C2=
=A0=C2=A0 0 pid:=C2=A0=C2=A0=C2=A0
>>> 1 ppid:=C2=A0=C2=A0=C2=A0=C2=A0 0 flags:0x00000008
>>> =C2=A0=C2=A0=C2=A0=C2=A0Call Trace:
>>> =C2=A0=C2=A0=C2=A0=C2=A0mc_event_handler: 666648 callbacks suppressed
>>>
>>> =C2=A0With this patch applied, the system just locks up without RCU st=
alling:
>>> =C2=A0=C2=A0=C2=A0=C2=A0io scheduler mq-deadline registered
>>> =C2=A0=C2=A0=C2=A0=C2=A0io scheduler kyber registered
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: host bridge =
/soc/pcie@2000000000
>>> ranges:
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 MEM
>>> 0x2008000000=2E=2E0x2087ffffff -> 0x0008000000
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: axi read req=
uest error
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: axi read tim=
eout
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: sec error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0microchip-pcie 2000000000=2Epcie: ded error in=
 pcie2axi buffer
>>> =C2=A0=C2=A0=C2=A0=C2=A0Freeing initrd memory: 7332K
>>>
>>> As of yet, I have no idea if RCU stalls for other reasons would also b=
e
>>> lost=2E
>>=20
>> Sorry this broke stuff=2E=C2=A0 I'm not entirely sure why this would ma=
sk RCU
>> stalls, but it seems like we're hitting some pretty odd paths here and
>> I'm not sure this is expected to work at all for us=2E
>
>I'm confused here=2E The RCU stall is itself a bug, right? Are you sure
>this patch is wrongly masking the stall, or is it possibly just avoiding
>some buggy code and not causing a stall in the first place?

(Apologies for not truncating the message, phone=2E=2E=2E)
The lockup is caused by a bad PCI root port sending many error interrupts=
=2E
This patch doesn't cause the lockup, that's caused by a problem in the har=
dware=2E
Instead it causes the RCU stall detection to not trigger=2E
Without this patch, the stall detection kicks in and with this patch the s=
ystem locks up and never progresses=2E

Hope that makes it clearer?=20

>
>Regards,
>Samuel
>
>> If non-x86 architectures are meant to be able to set
>> CLOCK_EVT_FEAT_C3STOP, maybe we should document what it's supposed to d=
o
>> in a more platform-agnostic fashion?
>>=20
>>> Thanks,
>>> Conor=2E
>>>
>>> git bisect start
>>> # status: waiting for both good and bad commits
>>> # good: [7699f7aacf3ebfee51c670b6f796b2797f0f7487] RISC-V: Prepare
>>> dropping week attribute from arch_kexec_apply_relocations[_add]
>>> git bisect good 7699f7aacf3ebfee51c670b6f796b2797f0f7487
>>> # bad: [63d5172e148bcc174398040861d867bbd2770be4] HACK: jogness
>>> git bisect bad 63d5172e148bcc174398040861d867bbd2770be4
>>> # good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag
>>> 'drm-next-2022-05-25' of git://anongit=2Efreedesktop=2Eorg/drm/drm
>>> git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
>>> # good: [907bb57aa7b471872aab2f2e83e9713a145673f9] Merge tag
>>> 'pinctrl-v5=2E19-1' of
>>> git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/linusw/linux-pinctrl
>>> git bisect good 907bb57aa7b471872aab2f2e83e9713a145673f9
>>> # good: [4ad680f083ec360e0991c453e18a38ed9ae500d7] Merge tag
>>> 'staging-5=2E19-rc1' of
>>> git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/gregkh/staging
>>> git bisect good 4ad680f083ec360e0991c453e18a38ed9ae500d7
>>> # good: [23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1] Merge tag
>>> 'for-5=2E19/parisc-2' of
>>> git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/deller/parisc-linux
>>> git bisect good 23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1
>>> # bad: [7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0] Merge tag
>>> 'gpio-fixes-for-v5=2E19-rc2' of
>>> git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/brgl/linux
>>> git bisect bad 7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0
>>> # bad: [1f192b9e8d8a5c619b33a868fb1af063af65ce5d] Merge tag
>>> 'drm-misc-fixes-2022-06-09' of
>>> git://anongit=2Efreedesktop=2Eorg/drm/drm-misc into drm-fixes
>>> git bisect bad 1f192b9e8d8a5c619b33a868fb1af063af65ce5d
>>> # good: [b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8] Merge tag
>>> 'scsi-misc' of git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/jejb/=
scsi
>>> git bisect good b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8
>>> # bad: [e17fee8976c3d2ccf9add6d6c8912a37b025d840] Merge tag
>>> 'mm-nonmm-stable-2022-06-05' of
>>> git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/akpm/mm
>>> git bisect bad e17fee8976c3d2ccf9add6d6c8912a37b025d840
>>> # bad: [c049ecc523171481accd2c83f79ffeecbf53a915] Merge tag
>>> 'timers-core-2022-06-05' of
>>> git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/tip/tip
>>> git bisect bad c049ecc523171481accd2c83f79ffeecbf53a915
>>> # bad: [9c04a8ff03def4df3f81219ffbe1ec9b44ff5348]
>>> clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
>>> git bisect bad 9c04a8ff03def4df3f81219ffbe1ec9b44ff5348
>>> # bad: [7160d9c4cce94612d5f42a5db392cd606a38737a]
>>> clocksource/drivers/armada-370-xp: Convert to SPDX identifier
>>> git bisect bad 7160d9c4cce94612d5f42a5db392cd606a38737a
>>> # bad: [a98399cbc1e05f7b977419f03905501d566cf54e]
>>> clocksource/drivers/sp804: Avoid error on multiple instances
>>> git bisect bad a98399cbc1e05f7b977419f03905501d566cf54e
>>> # good: [41929c9f628b9990d33a200c54bb0c919e089aa8]
>>> clocksource/drivers/ixp4xx: Drop boardfile probe path
>>> git bisect good 41929c9f628b9990d33a200c54bb0c919e089aa8
>>> # bad: [232ccac1bd9b5bfe73895f527c08623e7fa0752d]
>>> clocksource/drivers/riscv: Events are stopped during CPU suspend
>>> git bisect bad 232ccac1bd9b5bfe73895f527c08623e7fa0752d
>>> # first bad commit: [232ccac1bd9b5bfe73895f527c08623e7fa0752d]
>>> clocksource/drivers/riscv: Events are stopped during CPU suspend
>
