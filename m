Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E768763B6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 01:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiK2Akp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 19:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiK2Akn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:40:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB381303F5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:40:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k7so11841862pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tsit4tlwMOX7OLaXEWLPn1yxtLp/SKg+N7GuTQ1fWwA=;
        b=VmXH+uk31ZdNwX/cNTPka1aAEVDXQNUPZwrVaAEMj3Y6uZep2GmQe2ifDTyyAcTKES
         u4pLCmzOmdvp7ykaqCNn/q0KFDaTfL8yaPBAfeCHS6DaGLZ7wur36JaO1qPM7W9zX8q1
         bhCHA23BR/xNdNc1NIaiXxNHJg8L31sMvjYnnjttkNau6Y6aZ3QJF1582mCuyZuKOo++
         GaCysIPDnJ91QtUdtVuTSPO1drQT0SPN3A81t0W09cwUmQ2ZxvO1bL0/8ht2EVTT0YFH
         g1k6JZKZEUrsG24X5fjG3MbmjmLRzKjOB/joyQq7DNMAIZBzXMPlnELahd5q8zER7w1Y
         BQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsit4tlwMOX7OLaXEWLPn1yxtLp/SKg+N7GuTQ1fWwA=;
        b=YNZnXnc2xjgyLYfHbnTk/q1WwDYEqlK3I6JpfOHajkcvlrg0OlQRhfiaW44zD24eX2
         eSwUPdv69Xv2PpGTs3xNVboTdWtMGRhil6RL9A9twmHoFAyNzUDbD9+MEBvOTpgPspe5
         VqkbWYLmOFNfDYgNC08O0OzJt+chFRK1Eo1jyS7p1hGdQXfGAu5pQdr+KVdVNG8jkMWz
         NjA+2sRc1lCUMPIlwWVd6ANy1AVHYooT4H3etmd1S1Dw8QaAqTC72KF5+EJQ0owfIsTz
         2nVd9l/379K6ORk0pDEzgTbRlVLLnHfwd3Qfm33EifVKVfHN+WcoOOKtYDVF8PWf7tMZ
         edaQ==
X-Gm-Message-State: ANoB5pl1mtCrhrM2T8YUMSdF0iL3eRnSD7Iaic39qJ91/SZQptRhBWJy
        puJYSsUNbhRyJHxCQ0FCZ6ocqg==
X-Google-Smtp-Source: AA0mqf5quQYZKjwkT4OsKge/2/VlQVCrOwGSdEL14y1KEQ342ret+Y1AyH+R46iv/AysaYS4OUWhvQ==
X-Received: by 2002:a17:90b:4b4a:b0:214:6fc:31cf with SMTP id mi10-20020a17090b4b4a00b0021406fc31cfmr60966051pjb.21.1669682441361;
        Mon, 28 Nov 2022 16:40:41 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b001708c4ebbaesm9337622plh.309.2022.11.28.16.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 16:40:40 -0800 (PST)
In-Reply-To: <20221121133303.1782246-1-alexghiti@rivosinc.com>
References: <20221121133303.1782246-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH] riscv: Sync efi page table's kernel mappings before switching
Message-Id: <166968223551.19322.16657482033494349394.b4-ty@rivosinc.com>
Date:   Mon, 28 Nov 2022 16:37:15 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-efi@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 14:33:03 +0100, Alexandre Ghiti wrote:
> The EFI page table is initially created as a copy of the kernel page table.
> With VMAP_STACK enabled, kernel stacks are allocated in the vmalloc area:
> if the stack is allocated in a new PGD (one that was not present at the
> moment of the efi page table creation or not synced in a previous vmalloc
> fault), the kernel will take a trap when switching to the efi page table
> when the vmalloc kernel stack is accessed, resulting in a kernel panic.
> 
> [...]

Applied, thanks!

[1/1] riscv: Sync efi page table's kernel mappings before switching
      https://git.kernel.org/palmer/c/3f105a742725

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
