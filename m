Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90E872822C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjFHOF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjFHOFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:05:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693E2722
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:05:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b039168ba0so4608475ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 07:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686233123; x=1688825123;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiTCui1w+W8sNchnu7jhDwLSkHbv4+LC8J3CAsZCpJw=;
        b=dWFaFLnb4/x7tW6GRCJP3ZHo5tIBZtmvKwXnYIrrjlSabMRKrfdaUL9q3++8soguwN
         IBHba0/E1pTRAtdkpxTk5v4+Lud7L+zSCZ8UJQ/5IJJLQmQtSljFIbVzLnpDjtk9UiJL
         dZfociUBXG4F1jpkWHEOlTidTA+ARnKs+5KRXLiP0VmBxbdcMmS4mWqVhDQQ1y6v2WC9
         Cx8VHjkZS1ABoDQP6VQayf75oLfq0BbygOE93lRSitUKo9+VyhgIdpPaZALDhuaS5ZsN
         Q8PCSehqO2HjHPYe7P/AI8AIgN/J3Ua09ncivG7ZIL4tP9YeVfO+PcmtLROts4AdlQwd
         kQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686233123; x=1688825123;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiTCui1w+W8sNchnu7jhDwLSkHbv4+LC8J3CAsZCpJw=;
        b=KU0AuhOMxWgatCpZjuzt8/096vwYZ32MvjytSZktg1FnOLpvjbJrUcIur0xLS39DDD
         PiQJb7c+8osmXVnKDeHPSHgfEhNhyu1cQyPf1VL+eHdCbfkl6ngzby1MXV6CF/cwznjD
         qHhFHqr9/EXZ1rxpSsi6k7yIQTUKUW3duETP4dLc1fTsHRUUme5qjmwgFuX9HPY6zzDC
         kZOgdb0BlJTo5GGmVXCt2mDOkhJpDL2NYLYoXHhSL6OyuD/SSIz8QRtoQOa60n/gMZXn
         XqITKFU+d6n6ps/5m97pBAcHgNazLeU3pNcDqtl0UFQCqmYJohq1TOB05mNzjgQNS13i
         Ypjw==
X-Gm-Message-State: AC+VfDy9Vp7yNtfAjaYgvcH4yGMCGcfga37Noll6KCioYOSRQSff4VvI
        rVqZsfRj91n/Xg/+hfXbsV7VxQ==
X-Google-Smtp-Source: ACHHUZ7P5/AN251f/wAmo8JcMi33bVvOtrS3JIRw4guBNejoHDsoME04LkLUer5qOF7A40y5m0Hy+A==
X-Received: by 2002:a17:902:c411:b0:1ac:5717:fd5 with SMTP id k17-20020a170902c41100b001ac57170fd5mr11654586plk.60.1686233123522;
        Thu, 08 Jun 2023 07:05:23 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902860a00b00192aa53a7d5sm1502362plo.8.2023.06.08.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 07:05:22 -0700 (PDT)
In-Reply-To: <20230606130444.25090-1-alexghiti@rivosinc.com>
References: <20230606130444.25090-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH] riscv: Fix kfence now that the linear mapping can be
 backed by PUD/P4D/PGD
Message-Id: <168623309503.19530.6891077660786418703.b4-ty@rivosinc.com>
Date:   Thu, 08 Jun 2023 07:04:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     syzbot+a74d57bddabbedd75135@syzkaller.appspotmail.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 06 Jun 2023 15:04:44 +0200, Alexandre Ghiti wrote:
> RISC-V Kfence implementation used to rely on the fact the linear mapping
> was backed by at most PMD hugepages, which is not true anymore since
> commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear
> mapping").
> 
> Instead of splitting PUD/P4D/PGD mappings afterwards, directly map the
> kfence pool region using PTE mappings by allocating this region before
> setup_vm_final().
> 
> [...]

Applied, thanks!

[1/1] riscv: Fix kfence now that the linear mapping can be backed by PUD/P4D/PGD
      https://git.kernel.org/palmer/c/25abe0db9243

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

