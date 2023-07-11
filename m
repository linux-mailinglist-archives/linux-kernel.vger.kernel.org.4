Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3974E86B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGKHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjGKHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:54:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A6CF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:54:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so29870125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689062077; x=1691654077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkPK/GMPSBp/4g2qtcrJmujy1568nlXOGlV287FaDRc=;
        b=K19Nrzp1xAN9FNNb8XRkpzz0wzk3pqohF7q8+RkvdexxFbKKM7d+ucdX6H3xvRoCoo
         IAvl+ydAs/IUYirGbQwvOuyp4A0dkj0s/nO7Wc0g1z2W/DpIfxDUlqKRDsMZPbh+6SZG
         UCe4MHkpZvEjCz72zHCdheewAIwOwYPwkVsqdEE4tkrDZGuGTwCnzvidF2fVjDqYCvIA
         qBjO2GW0gO8pham8mPm4K1v0bW74ZtjwGzEIJCFFnbFQdOXWS+dnNjbtCeWOne6Ej7AW
         hqxv8/DVt4rvAqBoBN53nUXsUuqopDb/uAEA2da0pu6momATMv5C5drS+dFGgJdqinm7
         l2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689062077; x=1691654077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkPK/GMPSBp/4g2qtcrJmujy1568nlXOGlV287FaDRc=;
        b=in6BJH4uByzvT1/KVQxQ2wHFuUSLae5AEEmJa87XSbImuxO61K3fFw22EHU4roLNF9
         URz7lP10LPrYPkx+UIcXv0Y8fLyxFhUevp+9dQ5b/kFZpkVvqEVOmOUKw61TFdQyMxfC
         9czBSzW1Gx+ZdltDMk/NLhdBFrBmszfqaEocSVyvzJZd2jHt09ZZhc2Ndl9Nd9bEDTyi
         bIHS5k/TB19uo2I5R/Co3vDfQo7Tjss0DzZBxYVhom41ajPjvHwPHGMjHXd5eRbj4YU1
         cbuVVGhgozoNdw0ukGRVCT0dZGh/Ny+Vqt5BdO19SitdwS4jQDNME2aWVwSwf2lTRi4B
         jObg==
X-Gm-Message-State: ABy/qLYEPh2nEzwnoK+NQoT7RCvSFOHgp4y+RMnD2UiIdF3S4IZdyfqy
        SpkZ0k9xHrW4cBLQiid+clXpGg==
X-Google-Smtp-Source: APBJJlH0eknonRxAkA8j5z+QdOB01QLG+MwLKDfRYjX56LEKFmW17Z4Edj1lXAEKj0Nz8QWKQj+7hA==
X-Received: by 2002:a5d:6947:0:b0:314:2736:ba3e with SMTP id r7-20020a5d6947000000b003142736ba3emr17296610wrw.3.1689062076885;
        Tue, 11 Jul 2023 00:54:36 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d55c6000000b003145521f4e5sm1481156wrw.116.2023.07.11.00.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:54:36 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/4] riscv: tlb flush improvements
Date:   Tue, 11 Jul 2023 09:54:30 +0200
Message-Id: <20230711075434.10936-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series optimizes the tlb flushes on riscv which used to simply
flush the whole tlb whatever the size of the range to flush or the size
of the stride.

Patch 3 introduces a threshold that is microarchitecture specific and
will very likely be modified by vendors, not sure though which mechanism
we'll use to do that (dt? alternatives? vendor initialization code?).

Next steps would be to implement:
- svinval extension as Mayuresh did here [1]
- BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
- MMU_GATHER_RCU_TABLE_FREE
- MMU_GATHER_MERGE_VMAS

Any other idea welcome.

[1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchitale@ventanamicro.com/

Alexandre Ghiti (4):
  riscv: Improve flush_tlb()
  riscv: Improve flush_tlb_range() for hugetlb pages
  riscv: Make __flush_tlb_range() loop over pte instead of flushing the
    whole tlb
  riscv: Improve flush_tlb_kernel_range()

 arch/riscv/include/asm/tlb.h      |  6 +-
 arch/riscv/include/asm/tlbflush.h | 12 ++--
 arch/riscv/mm/tlbflush.c          | 93 +++++++++++++++++++++++++++----
 3 files changed, 94 insertions(+), 17 deletions(-)

-- 
2.39.2

