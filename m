Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17763F81D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLATYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLATYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:24:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E8C5E32
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:24:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so3107705pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EyC+l2xoTg21FRJVHmDMpGpIwBHjk+EZXckKbYJ+bM=;
        b=Wvpk6usHFf08wgUpOcO61wbMziW2fNh4OWe2RL89HYS0FFeCsZxunqN5skgJbIb8aW
         o/jRO40/pTnhi0DuRlkNclEKnBLFNvn6hkVF2UUc+ZNQBPMCT/wMJREn8ZsMyY8JXFwl
         FUHLao2DRyLhv4voSy6fqh0VjBWyGm13QYGS1m5OJFJ1SyIOxsSESqAA/2Y3TOh5EFOe
         mJIlZkBIS7r50Uhc6Imtc0twTUqmDbHHHsgdCMyfyJkpZzgWLuQb7mHRS3rMSMCH0gGP
         g/fLkQ17sWj9fj3Wieg/mqPvIUWXFN/6z4TpNli4y+FQDPdEQPxFkcemuUn7Jmz+MpxB
         hNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EyC+l2xoTg21FRJVHmDMpGpIwBHjk+EZXckKbYJ+bM=;
        b=MNVwYNitvhBlXGLxsgr5NuxEJFWQRQQFtIy+kiXEAY4M1vkGX/iYuLSKx18MfsZvb2
         zzu5Vopun53wfh3VSdhNqDSV/3Xf57kMxXcfghiPUUq4ab/ol1/x9Zh4JmfJ7zoeukgT
         QBFYw8HLtoswlUQsaNKyj1YtySNrkR1GJQU8YFJqyj7jmSKurXdowcI8wTllxWKcYl5P
         Q3fMDeusUeKpTdMFAk5wYJIgP4dH5yowWs6VrDFSKUFyA6Yd1c4PBbnwDlu3ntYBQ+k9
         SKnypvVOTxyGD5on5pIkoDSgqIRAlGhGlS62R9orMbeFpOxeQMHAATkwj/ZTQRX4gob4
         icEA==
X-Gm-Message-State: ANoB5pkhnFfvI8Fz1F7XW3HGuIWqKkqqtFPgoON1nZdJVIzgS5Gz0Xo5
        LiDAwURYjB7xDheXH7QkKquFCA==
X-Google-Smtp-Source: AA0mqf48dwpXs3J0JRG21XUWX/PuQXxmt3SsEI7+2JhTfc0RC63eVOE3Yv3fog/cYbprpi8COni6JA==
X-Received: by 2002:a17:903:28f:b0:189:8a36:1b70 with SMTP id j15-20020a170903028f00b001898a361b70mr22952985plr.12.1669922689973;
        Thu, 01 Dec 2022 11:24:49 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902778d00b00176ba091cd3sm3982639pll.196.2022.12.01.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:24:49 -0800 (PST)
Date:   Thu, 01 Dec 2022 11:24:49 -0800 (PST)
X-Google-Original-Date: Thu, 01 Dec 2022 11:24:27 PST (-0800)
Subject:     Re: [PATCH 1/1] riscv: Fix P4D_SHIFT definition for 3-level page table mode
In-Reply-To: <20221201135128.1482189-2-alexghiti@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        panqinglin2020@iscas.ac.cn, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-46a9363c-895f-4cc2-a8e3-3a48f2fee418@palmer-ri-x1c9a>
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

On Thu, 01 Dec 2022 05:51:28 PST (-0800), alexghiti@rivosinc.com wrote:
> RISC-V kernels support 3,4,5-level page tables at runtime by folding
> upper levels.
>
> In case of a 3-level page table, PGDIR is folded into P4D which in turn
> is folded into PUD: PGDIR_SHIFT value is correctly set to the same value
> as PUD_SHIFT, but P4D_SHIFT is not, then any use of P4D_SHIFT will access
> invalid address bits (all set to 1).
>
> Fix this by dynamically defining P4D_SHIFT value, like we already do for
> PGDIR_SHIFT.
>
> Fixes: d10efa21a937 ("riscv: mm: Control p4d's folding by pgtable_l5_enabled")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable-64.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index dc42375c2357..42a042c0e13e 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -25,7 +25,11 @@ extern bool pgtable_l5_enabled;
>  #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
>
>  /* p4d is folded into pgd in case of 4-level page table */
> -#define P4D_SHIFT      39
> +#define P4D_SHIFT_L3   30
> +#define P4D_SHIFT_L4   39
> +#define P4D_SHIFT_L5   39
> +#define P4D_SHIFT      (pgtable_l5_enabled ? P4D_SHIFT_L5 : \
> +		(pgtable_l4_enabled ? P4D_SHIFT_L4 : P4D_SHIFT_L3))
>  #define P4D_SIZE       (_AC(1, UL) << P4D_SHIFT)
>  #define P4D_MASK       (~(P4D_SIZE - 1))

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Too late for this week, but if someone's got a concrete regression then 
I'm happy to take it next week.  Otherwise it'll end up on for-next, 
it'll be backported anyway but this way it'll have a touch more time.

Thanks!
