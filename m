Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD45629C39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKOOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiKOOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:38:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4241D0E0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668523126; x=1700059126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5v0DP53feCYo7PgTo+QK93dELwfjr9wlhPwVR8nosZo=;
  b=lfnkN5/xXXn4EKW+XZtxe04anil66saTEhJ8T4FNRtH9gHDpme7Dq0h1
   ameK2nEFAA7RUm3VRdBGi/2yVZYFbTXNzltJryMSsezuVzajvsoowvZ8f
   uiEu7jUKlwAFQMbmoULlN1fpUC691TjXJumlskVNYz8fxPuiSQWccSP6P
   xBXZ5Od2rjT+OxWHLXIKeIyACCwVpkj4iEcer0w9LD7bzHJAM2PhhKHvI
   qpdovXM4BmBCkI6m2kMBS0NA7j39rhCupzrH50cJDdGWZAOhYx9rvYJEI
   bLfRjFWKPEhOsBzGQxTR2oKR9D6Az/drY0VfWOb7XKFL3Sf0+9RAimMx2
   g==;
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="189059446"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2022 07:38:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 15 Nov 2022 07:38:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 15 Nov 2022 07:38:44 -0700
Date:   Tue, 15 Nov 2022 14:38:27 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Deepak Gupta <debug@rivosinc.com>
CC:     <aou@eecs.berkeley.edu>, <jan.kiszka@siemens.com>,
        <kbingham@kernel.org>, <linux-kernel@vger.kernel.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3] scripts/gdb: add lx_current support for riscv
Message-ID: <Y3OkY6myfea00BaK@wendy>
References: <20221115012917.1781185-1-debug@rivosinc.com>
 <20221115084923.1822572-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221115084923.1822572-1-debug@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Deepak,

On Tue, Nov 15, 2022 at 12:49:23AM -0800, Deepak Gupta wrote:
> csr_sscratch CSR holds current task_struct address when hart is in
> user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
> register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
> "tp" with expected user mode value and place current task_struct address
> again in csr_scratch CSR.
> 
> This patch assumes "tp" is pointing to task_struct. If value in
> csr_scratch is numerically greater than "tp" then it assumes csr_scratch

nit: s/scratch/sscratch/ ?

> is correct address of current task_struct. This logic holds when
>    - hart is in user space, "tp" will be less than csr_scratch.
>    - hart is in kernel space but not in trap handler, "tp" will be more
>      than csr_scratch (csr_scratch being equal to 0).
>    - hart is executing trap handler
>        - "tp" is still pointing to user mode but csr_scratch contains
>           ptr to task_struct. Thus numerically higher.
>        - "tp" is  pointing to task_struct but csr_scratch now contains
>           either 0 or numerically smaller value (transiently holds
>           user mode tp)
> 
> Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

I noticed when looking into patchwork complaining about checkpatch
errors in v2, that b4 had actually downloaded v3 but I could not see
this patch on the RISC-V list. I don't see a changelog anywhere here
from v2 either, nor did you pick up Drew's Reviewed-by.

What's the story there?

One really minor thing below. Should be able to fix it up trivially up
& submit a v4, CCing the linux-riscv list.

> ---
>  scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
>  scripts/gdb/linux/utils.py |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..ca5215a660c7 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -173,6 +173,21 @@ def get_current_task(cpu):
>           else:
>               raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>                                  "while running in userspace(EL0)")
> +    elif utils.is_target_arch("riscv"):
> +         current_tp = gdb.parse_and_eval("$tp")
> +         scratch_reg = gdb.parse_and_eval("$sscratch")
> +
> +         # by default tp points to current task
> +         current_task = current_tp.cast(task_ptr_type)
> +
> +         # scratch register is set 0 in trap handler after entering kernel.
> +         # When hart is in user mode, scratch register is pointing to task_struct.
> +         # and tp is used by user mode. So when scratch register holds larger value
> +         # (negative address as ulong is larger value) than tp, then use scratch register.
> +         if (scratch_reg.cast(utils.get_ulong_type()) >  current_tp.cast(utils.get_ulong_type())):
                                                          ^^
extra space here?


> +             current_task = scratch_reg.cast(task_ptr_type)
> +
> +         return current_task.dereference()
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                             "supported with this arch")
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index 1553f68716cc..ddaf3089170d 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -35,12 +35,17 @@ class CachedType:
>  
>  
>  long_type = CachedType("long")
> +ulong_type = CachedType("ulong")
>  atomic_long_type = CachedType("atomic_long_t")
>  
>  def get_long_type():
>      global long_type
>      return long_type.get_type()
>  
> +def get_ulong_type():
> +    global ulong_type
> +    return ulong_type.get_type()
> +
>  def offset_of(typeobj, field):
>      element = gdb.Value(0).cast(typeobj)
>      return int(str(element[field].address).split()[0], 16)
> -- 
> 2.25.1
