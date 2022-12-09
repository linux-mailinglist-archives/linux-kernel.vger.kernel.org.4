Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD96647B6A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLIBZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiLIBY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:24:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350E086F7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:24:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3353686pjd.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 17:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcLY3kF7o4hp9Qm1EsWYqsV0AQOWk7tTMzl2ItbJXk4=;
        b=5HX7yT/A0U+g8ikCK14qiGBl1bzNva9kVvv9IxG6fTvmOv9zZ6GlISswYgT0w0lJlz
         j4aBo0N2ADp5CM97l/xCjYVkAEDAVjh5yP4+ggYNhIdS6avNhA6IOIx5L2+cMho6bOp0
         1dCn9kroPQAaWjZK+QvxD6zWKGwidxpEf8nP7lXNPZ1VJs+6/FglepJLUXy33oZYU9Kd
         PDPaktK8epSW7AbnSOxBqat09ogNg/gApB+KAQspGmThHIxWPwnSAVekv8K1wfQRQSlw
         qlS6nfK8TK+r/fYjwYxrdyD9WNxuMIhknrf+34QxGGHUQnBHwMtVVEY1AdHbVST4ygFs
         fEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcLY3kF7o4hp9Qm1EsWYqsV0AQOWk7tTMzl2ItbJXk4=;
        b=HZMNWx+uWl3Cjnop1du8D3qF51NPoZ1+I9+QxSIA3+0kyRUSGm9FGxmluCbgO8U8Wa
         r5y2y32/PYznf3IfecedkDh5QLgmIbZK6cw8Gd0RnHZCXPb6el/oAlBX44KVlSXatF3Z
         FUG4aCr7jfWk6y/1sTeusNIby5sfmaPcpDNLiOT8UO/81kev+SKhjhZ9Djjj6z3q2RWY
         XfO31apb+GEc7AxftEcjcmOv9FDewci5kpA2sr0n6ICXBSmHxGaMu2zeBWuribUtLpkM
         wq2sy0Xl6ZcKG2RI4p64tjogUJ/qvY183qVKp7X9vrPyD7gaS7EuwZcC4fp9VdKvconW
         voPw==
X-Gm-Message-State: ANoB5pkUCeWz00ax7GkQgMWJCYpmPuLDEXnicok8MIhGeOABNKwe9tWV
        Zp5TSkdwCUvIdHUg3KLt+tsiMA==
X-Google-Smtp-Source: AA0mqf42jnsETLESWtq3xZbsIv62t0abUoTLyjT2n+G+ZH+A3DcMQB11MhsEMWwuOMNZZFTvlI4K/w==
X-Received: by 2002:a17:902:db01:b0:188:77a7:ea9 with SMTP id m1-20020a170902db0100b0018877a70ea9mr5977202plx.55.1670549047399;
        Thu, 08 Dec 2022 17:24:07 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b00189a50d2a3esm53782plx.241.2022.12.08.17.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:24:06 -0800 (PST)
Date:   Thu, 08 Dec 2022 17:24:06 -0800 (PST)
X-Google-Original-Date: Thu, 08 Dec 2022 15:51:11 PST (-0800)
Subject:     Re: [PATCH v5] scripts/gdb: add lx_current support for riscv
In-Reply-To: <20221115221051.1871569-1-debug@rivosinc.com>
CC:     Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
        aou@eecs.berkeley.edu, debug@rivosinc.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     debug@rivosinc.com
Message-ID: <mhng-bdcd75a5-e6d6-4090-8292-a32eb46e4464@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 14:10:51 PST (-0800), debug@rivosinc.com wrote:
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

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!
