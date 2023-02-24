Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5AF6A23EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBXVlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBXVk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:40:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC1570B5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QttqpK2797Ks5N1i0YxTIMisslxuJT7i4EUzuHYK3zo=; b=L6yvGjoJ67WQhJzxgfGVWr7yjo
        XmFpYndLabGR/lckZXXQGdJS72MNV5IsSRpiY8uSwSkHAlS9xBf6tQdxr3z1c7TnWYBH1bkvo+Hhw
        1WZLYCTPPn14XItZpZlPkF8jisPtEJ03hxo9Bjd0S1dxyEKnnZpR0QdSKUrWbSyVuZGFoWtHVv5Dm
        g6VaWEKRCwtLBJq3cO/3xdPrUjPCgHonpJcujYc81yZSUfpNxoc4Wz97qA5FabBGlnehNVEpXW/ak
        bbk+yngujYpO8Rz82e3ooFXYLk84OG+IfY8h9MUpjupHhBzjQbQ87Vl0IjbYpE4fLVv+J7rMKaf/h
        NQ84VhqA==;
Received: from [2001:8b0:10b:5:8a7e:ca5b:c10a:39fc] (helo=[IPv6:::1])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pVfo5-00DKOW-2X;
        Fri, 24 Feb 2023 21:40:47 +0000
Date:   Fri, 24 Feb 2023 21:40:46 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BExternal=5D_=5BPATCH_v2_0/5=5D_x86-6?= =?US-ASCII?Q?4=3A_Remove_global_variables_from_boot?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com>
References: <20230224154235.277350-1-brgerst@gmail.com> <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com> <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com>
Message-ID: <496CF416-A21D-4F61-9FDC-E83E858A6D41@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 February 2023 21:38:41 GMT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Fri, Feb 24, 2023 at 3:40 PM Usama Arif <usama=2Earif@bytedance=2Ecom>=
 wrote:
>>
>>
>>
>> On 24/02/2023 15:42, Brian Gerst wrote:
>> > This is based on the parallel boot v11 series=2E
>> >
>> > Remove the global variables initial_gs, initial_stack, and
>> > early_gdt_descr from the 64-bit boot code=2E  The stack, GDT, and GSB=
ASE
>> > can be determined from the CPU number=2E
>> >
>> > v2: - Dropped first two patches which were merged into another patch =
in
>> >        the parallel boot series=2E
>> >      - Fixed a compile error in patch 1 found by the kernel test robo=
t=2E
>> >      - Split out the removal of STARTUP_SECONDARY into a separate pat=
ch
>> >        and renumber the remaining flags=2E
>> >
>> > Brian Gerst (5):
>> >    x86/smpboot: Remove initial_stack on 64-bit
>> >    x86/smpboot: Remove early_gdt_descr on 64-bit
>> >    x86/smpboot: Remove initial_gs
>> >    x86/smpboot: Simplify boot CPU setup
>> >    x86/smpboot: Remove STARTUP_SECONDARY
>> >
>> >   arch/x86/include/asm/processor=2Eh |  6 +-
>> >   arch/x86/include/asm/realmode=2Eh  |  1 -
>> >   arch/x86/include/asm/smp=2Eh       |  5 +-
>> >   arch/x86/kernel/acpi/sleep=2Ec     |  5 +-
>> >   arch/x86/kernel/head_64=2ES        | 99 ++++++++++++---------------=
-----
>> >   arch/x86/kernel/smpboot=2Ec        |  6 +-
>> >   arch/x86/xen/xen-head=2ES          |  2 +-
>> >   7 files changed, 49 insertions(+), 75 deletions(-)
>> >
>>
>> Its weird putting something in earlier patches like
>> STARTUP_APICID_CPUID_*,STARTUP_SECONDARY=2E=2E and removing/changing it
>> later on in *the same series*=2E Maybe better to keep this as a separat=
e
>> series from parallel smp? i=2Ee=2E not include this in v12 and review i=
t
>> separately? Happy with whatever you and David decide=2E=2E
>>
>> Thanks,
>> Usama
>
>Removing the globals before the parallel boot series, would be the
>best option IMO=2E  That would make the transition simpler=2E

Yeah, makes sense=2E=2E Let's do that=2E
