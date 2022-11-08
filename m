Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BE620D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKHK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKHK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:28:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48160B873
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:27:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05D22B81A00
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B151C433D6;
        Tue,  8 Nov 2022 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667903276;
        bh=XmXAMhLprGXDMRo5fiZJmyS/+wonVwXxZx5NgkKFdeM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=q8c5nrc987RX11a4APalb9zO+ZIbGbiAnje+fmuo710RL+hB5/IIzHlv+fcoxiGyf
         nqye7T1N4JW9WqHVidOCBzTt2v9Lvf76eGGx5Nk7N6yA3Co6kHEbIu7i+fIrx2W54d
         PIJ8NC+4VxgveAbA0txKScaMqEqMELjrh7zxRGwtmAJge1LcMBdF6L0DPFAaWOTMEs
         4CXwpq12p5Dr8zuIy2bXamE/XA7F2dmbcW0x/chT0VYnY8r7iV6s+ryoHqNZ5FJpCH
         eU83U7pvZ07c4tQJw7IzAM9nIgiBu3HBVZc+mut/GJ5e/KV9FLzm0pmh1GsNY32V4u
         qgMJiNYRgDaRg==
Date:   Tue, 08 Nov 2022 10:27:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, guoren@kernel.org,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu
CC:     linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND=5D_riscv=3A_asid=3A_Fixup_?= =?US-ASCII?Q?stale_TLB_entry_cause_application_crash?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221108102044.3317793-1-guoren@kernel.org>
References: <20221108102044.3317793-1-guoren@kernel.org>
Message-ID: <D91557B5-7E60-4A29-8669-34FF42454F8C@kernel.org>
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



On 8 November 2022 10:20:44 GMT, guoren@kernel=2Eorg wrote:
>From: Guo Ren <guoren@linux=2Ealibaba=2Ecom>
>
>After use_asid_allocator enabled, the userspace application will
>crash for stale tlb entry=2E Because only using cpumask_clear_cpu without
>local_flush_tlb_all couldn't guarantee CPU's tlb entries fresh=2E Then
>set_mm_asid would cause user space application get a stale value by
>the stale tlb entry, but set_mm_noasid is okay=2E
>
>Here is the symptom of the bug:
>unhandled signal 11 code 0x1 (coredump)
>   0x0000003fd6d22524 <+4>:     auipc   s0,0x70
>   0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
>=3D> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
>(gdb) i r s0
>s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
>(gdb) x/16 0x3fd6d92490
>0x3fd6d92490:   0xd80ac8a8      0x0000003f
>The core dump file shows that the value of register s0 is wrong, but the
>value in memory is right=2E This is because 'ld s0, -148(s0)' use a stale
>mapping entry in TLB and got a wrong value from a stale physical
>address=2E
>
>When task run on CPU0, the task loaded/speculative-loaded the value of
>address(0x3fd6d92490), and the first version of tlb mapping entry was
>PTWed into CPU0's tlb=2E
>When the task switched from CPU0 to CPU1 without local_tlb_flush_all
>(because of asid), the task happened to write a value on address
>(0x3fd6d92490)=2E It caused do_page_fault -> wp_page_copy ->
>ptep_clear_flush -> ptep_get_and_clear & flush_tlb_page=2E
>The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need
>tlb flush, but CPU0 had cleared the CPU0's mm_cpumask in previous switch_=
mm=2E
>So we only flushed the CPU1 tlb, and setted second version mapping
>of the pte=2E When the task switch from CPU1 to CPU0 again, CPU0 still us=
ed a
>stale tlb mapping entry which contained a wrong target physical address=
=2E
>When the task happened to read that value, the bug would be raised=2E
>
>Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
>Signed-off-by: Guo Ren <guoren@linux=2Ealibaba=2Ecom>
>Signed-off-by: Guo Ren <guoren@kernel=2Eorg>
>Cc: Anup Patel <apatel@ventanamicro=2Ecom>
>Cc: Palmer Dabbelt <palmer@rivosinc=2Ecom>
>---
> arch/riscv/mm/context=2Ec | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/arch/riscv/mm/context=2Ec b/arch/riscv/mm/context=2Ec
>index 7acbfbd14557=2E=2E8ad6c2493e93 100644
>--- a/arch/riscv/mm/context=2Ec
>+++ b/arch/riscv/mm/context=2Ec
>@@ -317,7 +317,9 @@ void switch_mm(struct mm_struct *prev, struct mm_stru=
ct *next,
> 	 */
> 	cpu =3D smp_processor_id();
>=20
>-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
>+	if (!static_branch_unlikely(&use_asid_allocator))
>+		cpumask_clear_cpu(cpu, mm_cpumask(prev));
>+
> 	cpumask_set_cpu(cpu, mm_cpumask(next));
>=20
> 	set_mm(next, cpu);

This is a completely different patch to what you already sent=2E Why have =
you marked it RESEND rather than v2?
