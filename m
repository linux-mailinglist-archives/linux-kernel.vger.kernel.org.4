Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936246EB1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjDUS7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjDUS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:59:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80C2D71
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:59:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b35789313so1925542b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682103565; x=1684695565;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+EQ/x793Jnsa/kqgXiOJb3p0eah7oFJhucKW106Kl8=;
        b=bQyblJRyAvGuTLy7qPVklUSkkntz5faFsanTHGL8+W8tK7sfMyp8tTFo7QvA60d/UW
         JEVIbrj/vr3OdOv4W9eGM7+H99bBq3vk1HvaueHNN8TyjPI4bOlC4yFpFniBEltfCK9S
         a6SfS4IlzcbdMqiaWhNrZLZmlaZqp4ZX/MOCweDAHIH82q5DvegmFZF/rOG4iBUrgJsE
         /l8K3CJ6JeYhfbZwImHI9bK8nzBZfU1X6YjlosZiMF9YRwLusS1aYk1zweTU7guN0tR9
         KqgXJegycYDF46jiq+R0uNxxQcgUvLwrsKvS97bTmxb6phciqD3Mj/Su/ExzkZSsuk7e
         5pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103565; x=1684695565;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+EQ/x793Jnsa/kqgXiOJb3p0eah7oFJhucKW106Kl8=;
        b=cbRjgg0eUqchrkg0uKFipHbEnOl6gCCZJ5ZZUNy+I9PDALzQRc9jBg+sF23HHkzP/t
         +2l4ggzf1lVRT+Lc9klfmHyxqQJGVA5Ico96BWEORItcWDNV5TpEIix3f161BFYCzpRT
         1Hz3xitC9B64fezgFNQUqr2sS2VgHNpRIl7pJzCq/+a28l6caKU0M/FjitAmcJPn0ULU
         DVuo4z1l9T86cC1UjILhND0W1unuMhpxFP7LLLTxMlnuUq2TTi6JYD1w2ixLBB+6E4/L
         8nNCNjAbw6mRjP2Wgypdb3lzdV+XRSo2jrN3wTolJYepZgCOFW5V6C8vQjO6tczwoPRj
         iMtQ==
X-Gm-Message-State: AAQBX9cBjbQj0HgYkloXL5oZvrVZnfz3kz/5T5NqpxyYDEmLtd1XURg9
        k1aCbtLw0skxX83HqBRyPKYOIg==
X-Google-Smtp-Source: AKy350aPgF7/ICzgPm9D1rqVxYtdqSsows6+k23WW1suuTm43XEGetau1y5211vGXw0C4sHlJCV6lg==
X-Received: by 2002:a05:6a00:13a6:b0:63f:ec9:bc9a with SMTP id t38-20020a056a0013a600b0063f0ec9bc9amr7724187pfg.20.1682103564695;
        Fri, 21 Apr 2023 11:59:24 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id h69-20020a628348000000b0063db25e140bsm3299248pfe.32.2023.04.21.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:59:24 -0700 (PDT)
In-Reply-To: <20230329045329.64565-1-alexghiti@rivosinc.com>
References: <20230329045329.64565-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH v9 0/6] Introduce 64b relocatable kernel
Message-Id: <168191616325.7488.14079862095622576679.b4-ty@rivosinc.com>
Date:   Wed, 19 Apr 2023 07:56:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        =C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Mar 2023 06:53:23 +0200, Alexandre Ghiti wrote:
> After multiple attempts, this patchset is now based on the fact that the
> 64b kernel mapping was moved outside the linear mapping.
> 
> The first patch allows to build relocatable kernels but is not selected
> by default. That patch is a requirement for KASLR.
> The second and third patches take advantage of an already existing powerpc
> script that checks relocations at compile-time, and uses it for riscv.
> 
> [...]

Applied, thanks!

[1/6] riscv: Prepare EFI header for relocatable kernels
      https://git.kernel.org/palmer/c/55de1e4ad43b
[2/6] riscv: Move .rela.dyn outside of init to avoid empty relocations
      https://git.kernel.org/palmer/c/69a90d2fe107
[3/6] riscv: Introduce CONFIG_RELOCATABLE
      https://git.kernel.org/palmer/c/39b33072941f
[4/6] powerpc: Move script to check relocations at compile time in scripts/
      https://git.kernel.org/palmer/c/47981b5cc687
[5/6] riscv: Check relocations at compile time
      https://git.kernel.org/palmer/c/c2dea0bc5339
[6/6] riscv: Use --emit-relocs in order to move .rela.dyn in init
      https://git.kernel.org/palmer/c/559d1e45a16d

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

