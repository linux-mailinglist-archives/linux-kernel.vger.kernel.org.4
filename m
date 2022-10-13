Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DBA5FD43D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJMFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJMFY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:24:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35C25598;
        Wed, 12 Oct 2022 22:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D63C0B81CFF;
        Thu, 13 Oct 2022 05:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56DEC433D6;
        Thu, 13 Oct 2022 05:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665638691;
        bh=9G19LVgt3OG5TfZZzGAbZgZXMYsC/NBKH20RV4NIGuU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=m1tVLvQco2ug6IGhCyfoduhhSLnt4397igtRBqcmbyKVL4+kGQPf7cMqlXeF4dFfr
         fDvk7jXaDnU7q2+i1Y2zuaqqjnX6pdinQeE5jREMLwG3/Fa4OTb999zzkfe2iiuX2t
         6A43oHVP1mSz7n1Hdy0MuoK9WkUZ2FKiVLWWyE8i28+KmCjmvaUMskQO9ijyeIv6Vh
         BvKwevysYS7ZOeaBvo4bjIsfcnN4vcIKQaUhDbXlYKGLwUhhcMHUiHryACnbNF6M/o
         SHMx+qBOo+0iL9wlqdTd6hILFmVu/2kDGmuRii1vYXG4V//kXnq6j/UON80/VJ2V87
         tk8HtvtAe7LyA==
Date:   Thu, 13 Oct 2022 06:24:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
User-Agent: K-9 Mail for Android
In-Reply-To: <55606b89-13f2-5e3b-9176-bacbec8c36d1@linux.alibaba.com>
References: <mhng-f5fdaa37-e99a-4214-a297-ec81f0fed0c1@palmer-mbp2014> <f8d3ae66-73a8-db89-c4c4-918610fb5f35@linux.alibaba.com> <Y0aOcsf06a2+ExrU@wendy> <55606b89-13f2-5e3b-9176-bacbec8c36d1@linux.alibaba.com>
Message-ID: <22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 October 2022 03:28:09 IST, Xianting Tian <xianting=2Etian@linux=2Eal=
ibaba=2Ecom> wrote:
>
>=E5=9C=A8 2022/10/12 =E4=B8=8B=E5=8D=885:52, Conor Dooley =E5=86=99=E9=81=
=93:
>> On Wed, Oct 12, 2022 at 05:42:37PM +0800, Xianting Tian wrote:
>>> =E5=9C=A8 2022/8/12 =E4=B8=8A=E5=8D=8812:17, Palmer Dabbelt =E5=86=99=
=E9=81=93:
>>>> On Thu, 11 Aug 2022 00:41:44 PDT (-0700),
>>>> xianting=2Etian@linux=2Ealibaba=2Ecom wrote:
>>>>> I ever sent the patch 1 in the link:
>>>>> https://patchwork=2Ekernel=2Eorg/project/linux-riscv/patch/202207080=
73150=2E352830-3-xianting=2Etian@linux=2Ealibaba=2Ecom/
>>>>>=20
>>>>> And patch 2,3 in the link:
>>>>> https://patchwork=2Ekernel=2Eorg/project/linux-riscv/patch/202207141=
13300=2E367854-2-xianting=2Etian@linux=2Ealibaba=2Ecom/
>>>>>=20
>>>>> https://patchwork=2Ekernel=2Eorg/project/linux-riscv/patch/202207141=
13300=2E367854-3-xianting=2Etian@linux=2Ealibaba=2Ecom/
>>>>>=20
>>>>>=20
>>>>> This patch set just put these patches together, and with three new
>>>>> patch 4, 5, 6=2E
>>>>> these six patches are the fixups for machine_kexec, kernel mode PC
>>>>> for vmcore
>>>>> and improvements for vmcoreinfo, memory layout dump and fixup
>>>>> schedule out issue
>>>>> in machine_crash_shutdown()=2E
>>>>>=20
>>>>> The main changes in the six patchs as below,
>>>>> Patch 1: Fixup use of smp_processor_id() in preemptible context, to
>>>>> cleanup
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the console prints=
=2E
>>>>> Patch 2: Fixup to get correct kernel mode PC for kernel mode regs
>>>>> for vmcore=2E
>>>>> Patch 3: Fixup schedule out issue in machine_crash_shutdown()
>>>>> Patch 4: Add modules to virtual kernel memory layout dump=2E
>>>>> Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can
>>>>> simplify
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the development of=
 crash tool as ARM64 already did
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (arch/arm64/kernel=
/crash_core=2Ec)=2E
>>>>> Patch 6: Updates vmcoreinfo=2Erst for vmcoreinfo export for RISCV64=
=2E
>>>>>=20
>>>>> With these six patches(patch 2 is must), crash tool can work well to
>>>>> analyze
>>>>> a vmcore=2E The patches for crash tool for RISCV64 is in the link:
>>>>> https://lore=2Ekernel=2Eorg/linux-riscv/20220801043040=2E2003264-1-x=
ianting=2Etian@linux=2Ealibaba=2Ecom/
>>>>>=20
>>>>>=20
>>>>> ------
>>>>> Changes v1 -> v2:
>>>>>  =C2=A0 1, remove the patch "Add a fast call path of crash_kexec()" =
from
>>>>> this series
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 of patches, as it already applied to riscv=
 git=2E
>>>>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/riscv/linux=2Egi=
t/commit/?h=3Dfor-next&id=3D3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>>>>>  =C2=A0 2, add 'Reviewed-by' based on the comments of v1=2E
>>>>> Changes v2 -> v3:
>>>>>  =C2=A0 use "riscv" instead of "riscv64" in patch 5 subject line=2E
>>>>> Changes v3 -> v4:
>>>>>  =C2=A0 use "riscv" instead of "riscv64" in the summary of patch 5 s=
ubject
>>>>> line=2E
>>>>> Changes v4 -> v5:
>>>>>  =C2=A0 add a new patch "RISC-V: Fixup schedule out issue in
>>>>> machine_crash_shutdown()"
>>>>> Changes v5 -> v6:
>>>>>  =C2=A0 1, move "fixup" patches to the start of the patch set=2E
>>>>>  =C2=A0 2, change patch 1, 2, 6's subject to make it tell more what =
it's
>>>>> about=2E
>>>>>  =C2=A0 3, add Fixes for patch 3=2E
>>>>>  =C2=A0 4, adjuest the changes format for patch 6=2E
>>>>>=20
>>>>>=20
>>>>> Xianting Tian (6):
>>>>>  =C2=A0 RISC-V: kexec: Fixup use of smp_processor_id() in preemptibl=
e context
>>>>>  =C2=A0 RISC-V: Fixup get incorrect user mode PC for kernel mode reg=
s
>>>>>  =C2=A0 RISC-V: Fixup schedule out issue in machine_crash_shutdown()
>>>>>  =C2=A0 RISC-V: Add modules to virtual kernel memory layout dump
>>>>>  =C2=A0 RISC-V: Add arch_crash_save_vmcoreinfo support
>>>>>  =C2=A0 Documentation: kdump: describe VMCOREINFO export for RISCV64
>>>>>=20
>>>>>  =C2=A0=2E=2E=2E/admin-guide/kdump/vmcoreinfo=2Erst=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 31 +++++++++++++++++++
>>>>>  =C2=A0arch/riscv/kernel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +
>>>>>  =C2=A0arch/riscv/kernel/crash_core=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 ++++++=
+++++++++++
>>>>>  =C2=A0arch/riscv/kernel/crash_save_regs=2ES=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>>  =C2=A0arch/riscv/kernel/machine_kexec=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++++++++---
>>>>>  =C2=A0arch/riscv/mm/init=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
>>>>>  =C2=A06 files changed, 89 insertions(+), 6 deletions(-)
>>>>>  =C2=A0create mode 100644 arch/riscv/kernel/crash_core=2Ec
>>>> Thank=2E=C2=A0 I've taken the first 4 onto for-next, which is still t=
argeted
>>>> for 5=2E20, as they're fixes=2E=C2=A0 I'm not opposed to taking the d=
ocumentation
>>>> patch for this cycle as well, it just needs some going-over as the
>>>> wording looks very odd (or at least it does to me right now, maybe I'=
m
>>>> just still half asleep)=2E=C2=A0 Patch 5 is a new feature, and given =
that it's
>>>> being spun during the merge window it's too late=2E
>>> Hi Palmer
>>>=20
>>> Do you plan to merge the two patch to Linux 6=2E1 to support crash too=
l work?
>>> thanks
>>>=20
>>>  =C2=A0 RISC-V: kexec: Fixup use of smp_processor_id() in preemptible =
context
>> 357628e68f5c ("RISC-V: kexec: Fixup use of smp_processor_id() in preemp=
tible context"
>>=20
>>>  =C2=A0 RISC-V: Fixup get incorrect user mode PC for kernel mode regs
>> 59c026c359c3 ("RISC-V: Fixup get incorrect user mode PC for kernel mode=
 regs")
>>=20
>> Hey Xianting, those two commits already seem to have been applied, do
>> you perhaps instead mean the documentation patch and the addition of
>> support for arch_crash_save_vmcoreinfo? I recalled asking if you needed
>> to respin at the time, but do not see a response:
>> https://lore=2Ekernel=2Eorg/linux-riscv/39fdc85e-b2d5-863c-4878-4b3380d=
76bc4@microchip=2Ecom/
>> IIRC Bagas had some outstanding comments on the documentation change
>> too=2E Was I incorrect?
>
>Sorry, It is the two patches:
>
>=C2=A0 RISC-V: Add arch_crash_save_vmcoreinfo support
>=C2=A0 Documentation: kdump: describe VMCOREINFO export for RISCV64
>
>I saw Palmer already merged the two patches to his riscv-crash branch, it=
 means they are OK?

Dunno, but no harm in resending given it's been a while cycle since then=
=2E

>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/palmer/linux=2Egit/lo=
g/?h=3Driscv-crash
>
>I saw Bagas's comments, I will send new version patch for the two patches=
, thanks for the reminder=2E
>
>>=20
>> Thanks,
>> Conor=2E
