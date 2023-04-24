Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0D6EB1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjDUS7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjDUS7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:59:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF6030D7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:59:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a50cb65c92so22244475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682103563; x=1684695563;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JnRCEEUMbL4VHxSaKuZGWLgXCAjCR6wrwzaIjE1iCNc=;
        b=1eyKirCqpN+P2lDW1Kog6EOhR4gZSK1257YOtYnrvSWxujPo0TJy3JM4uEJj4Oaqtp
         Giv3pKWxeTYVsJqwu+nGvVA1SQYfCzggSSa5nGFeC82PQy8yuK0+/fQEZexJUsZC+5xH
         Kx98Bl4+CWxaMKvtCMOqSR/ZKFkElFGgGQe9Dpxyn3d9pXmNvqQUKtbpHhmyRL14Ul7l
         2CYj0EJ0+5lW0vVZvPceEE97h6ySo1LzU3iHEuVjsQ39buzCHkmf17WhYkXQj0q+OAEc
         T2LLeAZxdZHGuSRl+oNzRF3z3Yx/dhcIb9ON78i3JpHr8KdfMR5NybhjcazsT5FnP5op
         JOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682103563; x=1684695563;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnRCEEUMbL4VHxSaKuZGWLgXCAjCR6wrwzaIjE1iCNc=;
        b=D00dJHFL5XtLOBIkGnwpEMRXUSHHfnuSlRvGR5/I9PI3EmIHENT2o01LdICRZP9257
         PqMEpjBYbhlmMET+67RW/Ybz7i89/Xoi+1APlaKlHLVqaA915WkctJ0l+77PPY93rQGh
         xRuGNYr5aTRBxeknHlo93q0WOmMkJTztGQanLMkTZLvudTCsRxWnfTbH+EH9qIDjdHHW
         3x2Kw5wDHISU+9qBVFLvfD08rTkLOgqOxOg96WH9zzzpwZNXBKc+iUjDiYv+HMjDglXn
         v3c8DK5ObdLt7VSj4TJtq3ZAmK0o8Z+3Qnf3i1DfNBR1QRXV2rep1lrw6zTRcuv1UwuD
         vHEg==
X-Gm-Message-State: AAQBX9fZPyHkKKob9EaPeOkl3kX4iuUTyZJeCMaR3Qd/LTn1ju8I7orY
        o6oyQB+XtPS3TEwjptMDPyfIVg==
X-Google-Smtp-Source: AKy350abIyt+aghs8+DVHIwBTnjeSWu6DXV0RCHJyPgTF8tnDrFlXaBH+mvfis5bh8pk2PcPF+EjFA==
X-Received: by 2002:a17:903:41d1:b0:1a6:492c:df22 with SMTP id u17-20020a17090341d100b001a6492cdf22mr7006809ple.17.1682103563482;
        Fri, 21 Apr 2023 11:59:23 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ba8900b001a0742b0806sm3055707pls.108.2023.04.21.11.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:59:22 -0700 (PDT)
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH v4 0/6] RISC-V kasan rework
Message-Id: <168191616322.7488.11200893464689398522.b4-ty@rivosinc.com>
Date:   Wed, 19 Apr 2023 07:56:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Feb 2023 08:52:26 +0100, Alexandre Ghiti wrote:
> As described in patch 2, our current kasan implementation is intricate,
> so I tried to simplify the implementation and mimic what arm64/x86 are
> doing.
> 
> In addition it fixes UEFI bootflow with a kasan kernel and kasan inline
> instrumentation: all kasan configurations were tested on a large ubuntu
> kernel with success with KASAN_KUNIT_TEST and KASAN_MODULE_TEST.
> 
> [...]

Applied, thanks!

[1/6] riscv: Split early and final KASAN population functions
      https://git.kernel.org/palmer/c/cd0334e1c091
[2/6] riscv: Rework kasan population functions
      https://git.kernel.org/palmer/c/96f9d4daf745
[3/6] riscv: Move DTB_EARLY_BASE_VA to the kernel address space
      https://git.kernel.org/palmer/c/401e84488800
[4/6] riscv: Fix EFI stub usage of KASAN instrumented strcmp function
      https://git.kernel.org/palmer/c/617955ca6e27
[5/6] riscv: Fix ptdump when KASAN is enabled
      https://git.kernel.org/palmer/c/ecd7ebaf0b5a
[6/6] riscv: Unconditionnally select KASAN_VMALLOC if KASAN
      https://git.kernel.org/palmer/c/864046c512c2

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

