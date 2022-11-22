Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F326F63379E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiKVI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiKVI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:57:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393742993
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E27CB8199C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3120C43148
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669107441;
        bh=20Lb4h4hKpElcqPKAPVKg9tS5raMSAP/TDIlwV1az40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uWH7CDpdL2iwmIELLKCz4rek722osss3GXQYbAFdGjkS0PWSgsiY0we5Y8VXCo1/d
         6wxrYxof0Rnd+v3r6auFdcGKQwVD/dtWr1RzE4GRzugzJZVx60lp7CyRJoHI6jgxS2
         UWSGqNHSGXeqeu6HvrMkf8X/kNNX0rvYGAeqTJ1/NVnZyWCMfcsT4hbpFqS28qt3+W
         h2y2m+z1Eo2umITqsBAcOP+K1/+cz0JaJVO3GQU9c/afEQIhpCz+WvGCINfFfr5cYD
         QvHH57xHyZQdICgor2AY1YBAICMQmL1efJcVlcO9/XUJysdSwAQO/MckRr0E/7sgbP
         cgP6SoguI293g==
Received: by mail-ej1-f53.google.com with SMTP id vv4so24918422ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:57:21 -0800 (PST)
X-Gm-Message-State: ANoB5pk+qBiEhnLae0Yrjyj1giH81yJ2IoqkECtLT+tiGuP0AcjfMlnt
        XL/VaPeHrqCnaYHurvF+TNMq6nC5t8kjmq4lS6U=
X-Google-Smtp-Source: AA0mqf4DOIC6AqTPH/jK9xIvXwr2uEcUK3FVPG51NR8naPKVpoOXx/4BCLx9XJyVjzm3dlsJX4z+d5s11dXiD6tDCXA=
X-Received: by 2002:a17:906:19d7:b0:7b2:b782:e1df with SMTP id
 h23-20020a17090619d700b007b2b782e1dfmr14901373ejd.308.1669107439947; Tue, 22
 Nov 2022 00:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20221122075440.1165172-1-suagrfillet@gmail.com>
In-Reply-To: <20221122075440.1165172-1-suagrfillet@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 22 Nov 2022 16:57:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQWuu2wUk-7WhFdov0PG5R1z_F_+OLqHM0nGnMiC1Yi_w@mail.gmail.com>
Message-ID: <CAJF2gTQWuu2wUk-7WhFdov0PG5R1z_F_+OLqHM0nGnMiC1Yi_w@mail.gmail.com>
Subject: Re: [PATCH] riscv/ftrace: fix ftrace_modify_call bug
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 3:54 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> With this commit (riscv: ftrace: Reduce the detour code size to half)
> patched, ftrace bug occurred When hosting kprobe and function tracer
> at the same function.
>
> Obviously, the variable caller in ftrace_modify_call was assigned by
> rec->ip with 4 offset failing the code replacing at function entry.
> And the caller should be assigned by rec->ip directly to indicate
> the function entry.
Thank you, it's my fault, but I think the problem is:

Before (riscv: ftrace: Reduce the detour code size to half)
     0: REG_S  ra, -SZREG(sp)
     4: auipc  ra, ?          <- We need "rec->ip + 4" here
     8: jalr   ?(ra)
    12: REG_L  ra, -SZREG(sp)

After (riscv: ftrace: Reduce the detour code size to half)
     0: auipc  t0, ?  <- We needn't "rec->ip + 4" anymore
     4: jalr   t0, ?(t0)

I copied rec->ip + 4 blindly, then caused the bug. Right?

>
> The following is the ftrace bug log.
>
> ```
> [  419.632855] 00000000f8776803: expected (ffe00297 1a4282e7) but got (1a8282e7 f0227179)
> [  419.633390] ------------[ ftrace bug ]------------
> [  419.633553] ftrace failed to modify
> [  419.633569] [<ffffffff802091cc>] kernel_read+0x0/0x52
> [  419.633863]  actual:   97:02:e0:ff:e7:82:82:1a
> [  419.634087] Updating ftrace call site to call a different ftrace function
> [  419.634279] ftrace record flags: e0000002
> [  419.634487]  (2) R
> [  419.634487]  expected tramp: ffffffff800093cc
> [  419.634935] ------------[ cut here ]------------
> ```
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 8c77f236fc71..61b24d767e2e 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -132,7 +132,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>                        unsigned long addr)
>  {
>         unsigned int call[2];
> -       unsigned long caller = rec->ip + 4;
> +       unsigned long caller = rec->ip;
>         int ret;
>
>         make_call_t0(caller, old_addr, call);
> --
> 2.20.1
>


-- 
Best Regards
 Guo Ren
