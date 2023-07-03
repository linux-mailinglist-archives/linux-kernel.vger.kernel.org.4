Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CBE7462AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGCSps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:45:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F4E64
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:45:45 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b049163c93so3182927fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688409944; x=1691001944;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7AIvtb9DOtvdgayMFLYWm4PP8pCfqI9Rkr8XYzQloI=;
        b=Pn8W4T8luvLP7RAngVhUqYS3NHcGF9/rlvtaiuHJFZjB+15oPEI2ZxP1TObdycwBIS
         ZXqUs91ORVW1YXTF5gaNWECWk0xcv34aVuzhl4cv+0CQZCVvF3EZJs3gYU8vUeqkMEQl
         lWfwddnCOlhWKqqAAeVsAHapnIYbacs6Stfs5JWO98vSLAsLoSPNb3hnsXyuuqXRgjyG
         DSZaZb2oIGeAb3ZHOTtWqIVjb9++12aNHmQTvdiAfjxSyTWXMcIJteaxKpWvCYFd/9xN
         oCRK/J4flYOAR3RqRXp9QJAGnet2BZ1/Cn1d5GWln0s8dNAuL+06V9UWG6k/YrgnEtQw
         af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409944; x=1691001944;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7AIvtb9DOtvdgayMFLYWm4PP8pCfqI9Rkr8XYzQloI=;
        b=R4MJUj7Zs7kkEwUWp3V+VtgaFUeJLQUUsKD/hnMrTPzjQdaO+oe2Bu1NTkwC6gL6+G
         TTxK1R6RjcimjLcili1ETp4xhDarYrzkGkbJd4YRz5QvCvMCe/gDONa0wtQtdYZ+bCbW
         wHWhNGO8nDBniB/wF0G9Eh14Z5ngjwM7c2wSlOPzyHCvNInH5SIfCPeUBg1WiV9WIVyu
         CUMbzrN/fhi+OgxBsGFPnaj+7zNwm+h2Vs2D5xOljwyJD3cPr2RlY4pmcAWhL8lOgHLj
         5ANligeMDC5JZvFjggFQ3UpEcqTZOee3i2EiUwHeKzBMH0RF9tADxhUPjBLCZYBGvqzJ
         9xLA==
X-Gm-Message-State: ABy/qLZTrUN7nZceBh1f0M5D1Jnt/dwkp6KbW4IwhuVUCDA4/ZFYlmw9
        x6FdGY4mUorUBOwqLNFYtWegNeDrp7oEK4dz5XU=
X-Google-Smtp-Source: ACHHUZ4eca7L8l4O8Tn6iC2ehH3/g2bniWJZV4ZwUCiFKfMu7R5yiUu+W6EpBc8KgBJovUUyTgcdvQ==
X-Received: by 2002:a05:6870:d98:b0:1b0:3118:1e83 with SMTP id mj24-20020a0568700d9800b001b031181e83mr9553954oab.49.1688409944006;
        Mon, 03 Jul 2023 11:45:44 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id lf14-20020a17090b484e00b0026094c23d0asm15795217pjb.17.2023.07.03.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:45:43 -0700 (PDT)
Date:   Mon, 03 Jul 2023 11:45:43 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jul 2023 11:45:40 PDT (-0700)
Subject:     Re: [PATCH] risc-v: Fix order of IPI enablement vs RCU startup
In-Reply-To: <20230703183126.1567625-1-maz@kernel.org>
CC:     linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        apatel@ventanamicro.com,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-bb5689ac-5b69-423f-8ea5-42938d5bab85@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023 11:31:26 PDT (-0700), Marc Zyngier wrote:
> Conor reports that risc-v tries to enable IPIs before telling the
> core code to enable RCU. With the introduction of the mapple tree
> as a backing store for the irq descriptors, this results in
> a very shouty boot sequence, as RCU is legitimately upset.
>
> Restore some sanity by moving the risc_ipi_enable() call after
> notify_cpu_starting(), which explicitly enables RCU on the calling
> CPU.
>
> Fixes: 832f15f42646 ("RISC-V: Treat IPIs as normal Linux IRQs")
> Reported-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20230703-dupe-frying-79ae2ccf94eb@spud
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  arch/riscv/kernel/smpboot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index bb0b76e1a6d4..f4d6acb38dd0 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -238,10 +238,11 @@ asmlinkage __visible void smp_callin(void)
>  	mmgrab(mm);
>  	current->active_mm = mm;
>
> -	riscv_ipi_enable();
> -
>  	store_cpu_topology(curr_cpuid);
>  	notify_cpu_starting(curr_cpuid);
> +
> +	riscv_ipi_enable();
> +
>  	numa_add_cpu(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
>  	probe_vendor_features(curr_cpuid);

Thanks.  I was going to send another PR this week anyway, I can just 
pick this up if you want?  Either way I'll look, I've still got a few 
hiccups from trying to clean up my staging bits post-merge but hopefully 
it's not too bad...
