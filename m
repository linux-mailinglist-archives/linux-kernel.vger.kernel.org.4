Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF86400EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiLBHKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiLBHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:10:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F5AA8D4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB7F7CE1E18
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE90CC433D7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669964996;
        bh=dTHdSO2Wn9CsGfPV2sYmXDYEvxH1WFE9uaIGBIqnrB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HLlteQobS+XZSNozT/gUjJihmoiG/RlrP52WAO/7PRltnuK1NG/eB4hGYBR0EDucL
         rwQsxw3SRHisEyb991PqHkXP6t5ddNfsULpwE6+TVeVViSBDvQl65W5DHW6kv8DeG/
         FUosxffJfEM6dnuhviPHkRbfDHDP0KcrliRF9DvoVEt16L/xtxxrm8PJmkHSW9+2M2
         8zjZc5RqNgwQCPWdZLCcEhgGEwOyGne5EVFn7gnS1bi/VYjrS6k8GQunv9gebOtcps
         JeZTAADz6WBXec5RdJSFDMedcqD+a+DFeILNAGs4wWX5VYWsTpWLuYxKAntlZ2PqE7
         Z/IXTI0zZnVVg==
Received: by mail-ed1-f51.google.com with SMTP id d14so370402edj.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 23:09:56 -0800 (PST)
X-Gm-Message-State: ANoB5plJk4/39c05uQW+aiF1S6taCMgJwD5NnL9+PQFIPutYBC/i6KLt
        eFGxro7AmGo9kRBHcIsvcGpH/QvWXgqbn3NFK7w=
X-Google-Smtp-Source: AA0mqf7OYqynGhtk1eSd1H+p/vQPcblDH58wYrjfuhXThfO9R3ph9Jqo/6vkLOHPgUaQ9Okhma3t5IuHrJY8bonqZuQ=
X-Received: by 2002:a05:6402:1013:b0:463:f3a:32ce with SMTP id
 c19-20020a056402101300b004630f3a32cemr47352914edu.366.1669964995083; Thu, 01
 Dec 2022 23:09:55 -0800 (PST)
MIME-Version: 1.0
References: <1669796376-4608-1-git-send-email-yangtiezhu@loongson.cn> <1669796376-4608-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1669796376-4608-3-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 2 Dec 2022 15:09:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4vLsfRyVXsxZXNhP+KodK-vmxXNdcCUs3GyD8=tp4kpw@mail.gmail.com>
Message-ID: <CAAhV-H4vLsfRyVXsxZXNhP+KodK-vmxXNdcCUs3GyD8=tp4kpw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] LoongArch: Use stop_machine_cpuslocked() to modify instruction
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Wed, Nov 30, 2022 at 4:19 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Rename the current larch_insn_patch_text() to patch_text_nosync(),
> then redefine larch_insn_patch_text() with stop_machine_cpuslocked()
> to modify instruction to avoid CPU race, this is preparation for later
> patch.
I don't think stop_machine is a good idea for this, because it is too
expensive, maybe Masami can give us a better suggestion.

Huacai
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/inst.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index aaaf9de..d842405 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>   */
>  #include <linux/sizes.h>
> +#include <linux/stop_machine.h>
>  #include <linux/uaccess.h>
>
>  #include <asm/cacheflush.h>
> @@ -10,6 +11,12 @@
>
>  static DEFINE_RAW_SPINLOCK(patch_lock);
>
> +struct patch_insn {
> +       void *addr;
> +       u32 insn;
> +       atomic_t cpu_count;
> +};
> +
>  int larch_insn_read(void *addr, u32 *insnp)
>  {
>         int ret;
> @@ -34,7 +41,7 @@ int larch_insn_write(void *addr, u32 insn)
>         return ret;
>  }
>
> -int larch_insn_patch_text(void *addr, u32 insn)
> +static int patch_text_nosync(void *addr, u32 insn)
>  {
>         int ret;
>         u32 *tp = addr;
> @@ -50,6 +57,30 @@ int larch_insn_patch_text(void *addr, u32 insn)
>         return ret;
>  }
>
> +static int patch_text_cb(void *data)
> +{
> +       struct patch_insn *param = data;
> +       int ret = 0;
> +
> +       if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
> +               ret = patch_text_nosync(param->addr, param->insn);
> +               atomic_inc(&param->cpu_count);
> +       } else {
> +               while (atomic_read(&param->cpu_count) <= num_online_cpus())
> +                       cpu_relax();
> +               smp_mb();
> +       }
> +
> +       return ret;
> +}
> +
> +int larch_insn_patch_text(void *addr, u32 insn)
> +{
> +       struct patch_insn param = { addr, insn, ATOMIC_INIT(0) };
> +
> +       return stop_machine_cpuslocked(patch_text_cb, &param, cpu_online_mask);
> +}
> +
>  u32 larch_insn_gen_nop(void)
>  {
>         return INSN_NOP;
> --
> 2.1.0
>
>
