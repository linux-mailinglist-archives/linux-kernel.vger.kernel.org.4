Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1E62B4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKPIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKPIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:16:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73313BD6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:16:52 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t25so42152898ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVDWCbwUloYH7tkRZwkH26cFTCBcLJuC57YrsOYdkkM=;
        b=Dq3EtISqJ2KUEd/SkKnOpMPCeJB4xDLNCNdG+3wTBDNBAEuUG7gE4eYXB0cfgPFsdS
         AVvGsvJruSvy8b2uLwSAxW6hr3DhN1hgkAFvrYOfOSzU+R8kUz6mKEZgzPpZm1o6X0VD
         FoEhHanTwJ7BBBRrtrSWeY+PDK65Yj8KBErsRrU7TPwXOUlySYCSbeB02B4q8oPYR+qN
         QF5Yw4CEt9kdCfazp5np8D8Og87eVHnVqFjt9TUIUqMh2jH7gObGWwnOxeixMloGv3CL
         eHc5Ic1j1vysW6rQjSvoR3eYa3tVE9Aw05tIqRmIvNwmiOuW3ODVkuVDfAI5WFvdGXUN
         ndaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVDWCbwUloYH7tkRZwkH26cFTCBcLJuC57YrsOYdkkM=;
        b=nXZp5dI2BJ6EvUEYaIi7YZVir9bxvSSkDvt9fxLLMXam6YPw1JptcSGrFu/Bx9a/UZ
         tntPupPLjysboh1XcnzKLJjCIUCzJU+bYuYoFZ0MQD6+Asb4XamxzgyJ9h+58hKYGlzX
         LYvXL0BYYVLjV1K5boCyWapYseYpDg1lCzVc8YOaP4QU68sMKHVHCszAgetjZFulOBkt
         GZ3WlaR0AZMbVwJu+s4xSs0x/NTAuvyuFR/adUSzIIymKCicTe0slfEv5dne3nhC/kuC
         RmDY7pGx9DRAIjP888d+cX8sot93KhTc0BIi2eFZv4ClJDIW9Lgib30u1Qc/Gyz8vDmN
         H2Mg==
X-Gm-Message-State: ANoB5pm0n1gMWBtRYNaKgFRQZChriqst1xP9p/cRWJWV9zZthCSVgyf1
        +Y1CHgr0P0eU+u3egFX81IVhGw==
X-Google-Smtp-Source: AA0mqf4ShcdTDjjMd2AhCS5aBhkJ6kWeWe6hMUt0/PkA7HWkOb6S/WaLjdraNSoI1HutrBLtl5NtcA==
X-Received: by 2002:a17:907:7854:b0:78b:5182:7ffa with SMTP id lb20-20020a170907785400b0078b51827ffamr16491710ejc.244.1668586610971;
        Wed, 16 Nov 2022 00:16:50 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o5-20020a056402038500b004619f024864sm7140898edv.81.2022.11.16.00.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 00:16:50 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:16:49 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     conor.dooley@microchip.com, aou@eecs.berkeley.edu,
        jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v5] scripts/gdb: add lx_current support for riscv
Message-ID: <20221116081649.yq7cy7isxj3nmzr3@kamzik>
References: <d65bddf3-c58a-1420-bff9-8333c10edb56@microchip.com>
 <20221115221051.1871569-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115221051.1871569-1-debug@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:10:51PM -0800, Deepak Gupta wrote:
> csr_sscratch CSR holds current task_struct address when hart is in
> user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
> register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
> "tp" with expected user mode value and place current task_struct address
> again in csr_sscratch CSR.
> 
> This patch assumes "tp" is pointing to task_struct. If value in
> csr_sscratch is numerically greater than "tp" then it assumes csr_sscratch
> is correct address of current task_struct. This logic holds when
>    - hart is in user space, "tp" will be less than csr_sscratch.
>    - hart is in kernel space but not in trap handler, "tp" will be more
>      than csr_sscratch (csr_sscratch being equal to 0).
>    - hart is executing trap handler
>        - "tp" is still pointing to user mode but csr_sscratch contains
>           ptr to task_struct. Thus numerically higher.
>        - "tp" is  pointing to task_struct but csr_sscratch now contains
>           either 0 or numerically smaller value (transiently holds
>           user mode tp)
> 
> Patch also adds new cached type "ulong" in scripts/gdb/linux/utils.py
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> ---
> Since patch has changed a little bit from v1 and I didn't include
> changelog earlier, here it is.
> 
> v1 --> v2:
>  - added logic to locate task_struct irrespective of priv
>  - made locating task_struct agnostic to bitness(32 vs 64).
>  - added caching of ulong type in scripts/gdb/linux/utils.py
>  - added more descriptive commit message
> 
> v2 --> v3:
>  - amended commit message and source line to fit column width
> 
> v3 --> v4:
>  - amended commit message and remove whitespace in source
>  - added Reviewed-by for reviewers
> 
> v4 --> v5:
>  - changing the order of changelog and sign off/review tags in commit
> ---
> ---

Everything looks good, but you've got extra ---'s here. They don't hurt,
but if you're still ironing out your workflow you may want to keep in
mind that you don't need them. You only need one, which goes above the
changelog.

Thanks,
drew

>  scripts/gdb/linux/cpus.py  | 15 +++++++++++++++
>  scripts/gdb/linux/utils.py |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..14c22f82449b 100644
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
> +         if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
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
> 
