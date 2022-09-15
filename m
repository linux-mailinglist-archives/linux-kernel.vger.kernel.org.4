Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22FF5BA193
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIOTl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiIOTlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:41:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFCA9D671
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:38:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id h28so14177273qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IFHyF3bgLmRCz7L1OXA+Yzmng1wr1QB+FbuCdYFy/tI=;
        b=P7wrNtaVdIOrlW37f0LPcfnU8hmMUK2jaYeanePYkOaTMdlGNSguzpBt73lkoKp0Sb
         i7B7+qgdb1F6INrk3zgGj7KX82s4XVBJ4OnjZgn4smtDkK9krE1kaK/rtNzNpYUDOiwV
         ZlBtHLtF7ylHYIQ6CqRPnp/Ip0/nITf4wEWkJab/i3LeBNse9CbM/UBN2ERF2vwlOb8t
         f9Y6w1fxmvmcKYNc9AFLG2pZDF75Ih+DQC39s2hCVzzc4ARglhDXZax0+qjBT6zrbj3U
         NNXkkCiEnAN+mEky/USAsQdyn8r0WkICeuLhvccfnawu91AnN+S1C/0Npo4JD8luo2iu
         1Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IFHyF3bgLmRCz7L1OXA+Yzmng1wr1QB+FbuCdYFy/tI=;
        b=J4M98byOPR/fk6XUHnRQ2shrzAD9z/JK0QI6EfoSrJT5qNQX2Hc10hojzyBurS4v1s
         uZDV3bSOGEPRTJ/87W2tKin34VImiwVUB9g1gf2cjvsVyA4//qYgAvLcweOlK5zvEh5M
         xSEifQfegy/J3ynZZofJxoqSG3eWqDT60bdEj2hq3KMWYCcEPS0thj6ejz2Rv/wwILYn
         Yg/DTfxKRN4sInpG3qKDp5kxFTQRQAm6FzrK/YoNeQzl9dZPcm7lOpFhFEtHOowKvTKO
         qhMXImqmxJV6L1igF7pUQGvcxLiOnCjnFCOjaQE1AU4HUdAA3GfMjzcDyYPE4pS/XaeR
         /36A==
X-Gm-Message-State: ACrzQf0yYPgtlgW/TdJF0v/OWC1IYZXiJ/CGVjcyETK2hpPaylwLKJFX
        tdZ6gwKfCI+jIlWs/Lpo+0tq+g==
X-Google-Smtp-Source: AMsMyM4CHd0lOE8Rm/3v4PwlgRx/bBQe+7EooBJvnnY6/buIywrcVpw3hNDVZiC0kDU37vTvXNd06Q==
X-Received: by 2002:a05:620a:4483:b0:6ce:8e57:254b with SMTP id x3-20020a05620a448300b006ce8e57254bmr1395661qkp.540.1663270633518;
        Thu, 15 Sep 2022 12:37:13 -0700 (PDT)
Received: from abrestic-xps.ba.rivosinc.com (pool-71-105-112-35.nycmny.fios.verizon.net. [71.105.112.35])
        by smtp.gmail.com with ESMTPSA id r1-20020ae9d601000000b006b872b606b1sm4596459qkk.128.2022.09.15.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 12:37:13 -0700 (PDT)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        Conor.Dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v4 0/2] Make mmap() with PROT_WRITE imply PROT_READ
Date:   Thu, 15 Sep 2022 15:37:00 -0400
Message-Id: <20220915193702.2201018-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
invalid") made mmap() reject mappings with only PROT_WRITE set in an
attempt to fix an observed inconsistency in behavior when attempting
to read from a PROT_WRITE-only mapping. The root cause of this behavior
was actually that while RISC-V's protection_map maps VM_WRITE to
readable PTE permissions (since write-only PTEs are considered reserved
by the privileged spec), the page fault handler considered loads from
VM_WRITE-only VMAs illegal accesses. Fix the underlying cause by
handling faults in VM_WRITE-only VMAs (patch 1) and then re-enable
use of mmap(PROT_WRITE) (patch 2), making RISC-V's behavior consistent
with all other architectures that don't support write-only PTEs.

Both patches are tagged as fixes for the aforementioned commit since that
commit made a userspace visible change that will break any software relying
on mmap(PROT_WRITE). (Also cc: stable since the offending commit was
itself backported to stable).

v1 -> v2: Allow handling of load faults in VM_WRITE VMAs
v2 -> v3: Split into two pathces
v3 -> v4: Fixes tags (+ this cover letter)

Andrew Bresticker (2):
  riscv: Make VM_WRITE imply VM_READ
  riscv: Allow PROT_WRITE-only mmap()

 arch/riscv/kernel/sys_riscv.c | 3 ---
 arch/riscv/mm/fault.c         | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.25.1

