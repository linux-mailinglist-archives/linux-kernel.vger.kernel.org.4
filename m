Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0D64F208
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiLPTzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiLPTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:54:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B34F61D40
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:54:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w23so3306474ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1xCmJVdTDddB6iEaD3p69qrSp4IMZuGPG9N/vesLgI=;
        b=RU3tNp9nWwxxG94nS9cUQ99fFCChj6ARVeO7awtuN29D9SsAZy0Cm7KAF6Bv5SBnKY
         V2cfud87xNaOXRn3Ytt3sDlviAoW0S5JdNNDw5e6VXCH9UJrsWAkMy+WaJILZGkZ/zvM
         5rt9rY9ikVoVuxS6B0WYiJeRfP/9DU0ZxE/433gxIOGnV+BJSD3c6d+VgbGj/vE+r2DV
         u8Mos39vDNK4oGTUgoh3zeTmuPClwwOCo8FAToGVZkfeZo9W3Fee5mMqC4LjzdjTyt9M
         f2hRe2HpV6uxi/2FqhrT2b+NIODK1OR/p1sDz3MblgnJYNBF+H0brKoEHHmfFwLLZW3Q
         /eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1xCmJVdTDddB6iEaD3p69qrSp4IMZuGPG9N/vesLgI=;
        b=cXy2ysMJucwUVJd6rzMAsOJ5RnVTFCCB0PmX9EmRCLoyFmVnv+0mKzolaZdr5NId0M
         L2RyvQ5KwV7qLLg97Jh9boZEfFrLysSorqryg0cvTGcyu6or1V9rPN2Lkl7ANJRHADIo
         2ycRCZwuEw6KOUTWQz0GSEWkx89mqdrvw7vrCIqmZc/bP12CTh/5GH4NsFVMSqPTxblI
         F6Y0dYtVaBjWLNaCi98GgsSbsMYJXQ7QdqCGMbFiho/bE4m4aIjUH3zLy7dWftxcWWay
         TPvV73ZJqL4Q8mVzCGPnrtxXZVt8PM1HaGi4Scwuky6kiujM4yHi3mjC4ZB9h+c4wl6N
         pqMQ==
X-Gm-Message-State: ANoB5plTlXgVs+Se1iufPJQtdlLgYUx67zM2dmJsySAoVZa0kHuvnHfy
        G/vVQepeoT9Sednivg+EZEGCBg==
X-Google-Smtp-Source: AA0mqf6ec1BAdxIvtjxtWjAto85BO9bAbN8u9avMqyo2iJ721NQQ0Ak3YqqBXLmhwUJLHkCDC88tuQ==
X-Received: by 2002:a17:902:ec8a:b0:189:bda4:4a39 with SMTP id x10-20020a170902ec8a00b00189bda44a39mr44094322plg.49.1671220479835;
        Fri, 16 Dec 2022 11:54:39 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b00186b86ed450sm2002544plk.156.2022.12.16.11.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:54:39 -0800 (PST)
Date:   Fri, 16 Dec 2022 11:54:39 -0800 (PST)
X-Google-Original-Date: Fri, 16 Dec 2022 11:54:21 PST (-0800)
Subject:     Re: [PATCH] riscv: avoid enabling vectorized code generation
In-Reply-To: <39636675da60fc6c54cc8bbab64ddbac@codethink.co.uk>
CC:     abdulras@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ben.dooks@codethink.co.uk, ndesaulniers@google.com,
        nathan@kernel.org
Message-ID: <mhng-d601613f-1c73-48e0-bb06-7f87acd60cfa@palmer-ri-x1c9a>
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

On Fri, 16 Dec 2022 11:45:21 PST (-0800), ben.dooks@codethink.co.uk wrote:
>
>
> On 2022-12-16 18:50, Saleem Abdulrasool wrote:
>> The compiler is free to generate vectorized operations for zero'ing
>> memory.  The kernel does not use the vector unit on RISCV, similar to
>> architectures such as x86 where we use `-mno-mmx` et al to prevent the
>> implicit vectorization.  Perform a similar check for
>> `-mno-implicit-float` to avoid this on RISC-V targets.
>
> I'm not sure if we should be emitting either of the vector or floating
> point instrucitons in the kernel without explicitly marking the section
> of code which is using them such as specific accelerator blocks.

Yep, we can't let the compiler just blindly enable V or F/D.  V would 
very much break things as we have no support, but even when that's in 
we'll we at roughly the same spot as F/D are now where we need to handle 
the lazy save/restore bits.

This looks like an LLVM-only option, I see at least some handling here

https://github.com/llvm/llvm-project/blob/a72883b7612f5c00b592da85ed2f1fd81258cc08/clang/lib/Driver/ToolChains/Clang.cpp#L2098

but I don't really know LLVM enough to understand if there's some 
default for `-mimplicit-float` and I can't find anything in the docs.  
If it can be turned on by default and that results in F/D/V instructions 
then we'll need to explicitly turn it off, and that would need to be 
backported.

Maybe Nick or Nathan knows what's up here?
