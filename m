Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C481C6278AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiKNJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiKNJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:07:19 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16025C9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:03 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso6267484otf.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKw1kYqmjYasEn7Y3COewOUZsq0MAu8mFPfBLKwkoSc=;
        b=O9JaNmH2blWNsRYkIQF/AKIekwf42J2n7+hgMUvgMgw6SHjgjwEDFQJj1w/l/keZD8
         +W6MJqzZDlgwdFEKkUb4eIiglnhy0mZbiCltCvR/idsnixQUFq1MFOHxVinExoHjaPYR
         OvZ0I0xj1vuBQG3zMHvLGWQIpnxwHLA54d74P96ijpomxVbppmZxnIzX2FhcptuQcYtz
         xjB5GyV/ZS2RI9W7aP7hRm2y84K+X6Fb6Ru/wm6UQaqd3oSgyCDq2KrEzVaJpeWiCT7H
         P9epcA2se9ZJ4vCBl1/9/PtBcRC87R8FtfZwospjb34v8N3Eb1zIJmf5r/Biz980Lm7G
         AjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKw1kYqmjYasEn7Y3COewOUZsq0MAu8mFPfBLKwkoSc=;
        b=PmNQ3PKK7egTzZJRw2HEbWtPz6DKM3nSmexDKOMWVLwpDODBL/U8xrdtvRx6LSai9q
         b5z5PIc8Owekr9stYwA5GmhyA/qmJJNVVf5RmR9amZwoQ0gk4XlSQ0xks72xz5S6d0x5
         jnbDcWl44uFti8j9107z9pe1NgNAWLZOly1DUXqU3W8HfLo5uUGXMRwgz6eUIPhjUW7z
         3w5lfdpkWVgorjN+KsF8/WXenSbtH+rhjqF8UrVK/eSzD7hJ+6mXLbYCVo0HiUDl42+N
         G4tVDODdOPfrXr1CAgi8yM9Dl5izo5j3Fbk3GLebmRi6QhgWaq1k+rZ/9H5rR/bAkHKa
         nCdw==
X-Gm-Message-State: ANoB5pnWa1gSlLSKIKzcL38jPlOeUNsaXOya8Vi6sXvBjj84s8guryli
        FcatW1SQ9O/cDRHtHXNFj7vCWA==
X-Google-Smtp-Source: AA0mqf4hsNss0/ZP2F7hDgRFMVLQAV1D2MFi3QBya1k67HNn04mBI2V7miEgbFgtUa5MsT7XD4wfbQ==
X-Received: by 2002:a05:6830:2812:b0:637:1464:cebf with SMTP id w18-20020a056830281200b006371464cebfmr5924869otu.100.1668416762681;
        Mon, 14 Nov 2022 01:06:02 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020aca2402000000b00354948e04e4sm3432939oic.2.2022.11.14.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:06:02 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 0/3] Add PMEM support for RISC-V
Date:   Mon, 14 Nov 2022 14:35:33 +0530
Message-Id: <20221114090536.1662624-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux NVDIMM PEM drivers require arch support to map and access the
persistent memory device. This series adds RISC-V PMEM support using
recently added Svpbmt and Zicbom support.

First two patches are fixes and remaining two patches add the required
PMEM support for Linux RISC-V.

These patches can also be found in riscv_pmem_v6 branch at:
https://github.com/avpatel/linux.git

Changes since v5:
 - Rebased on Linux-6.1-rc5
 - Directly add pmem.o in obj-y of PATCH3
 - Dropped PATCH1 since this is already merged.

Changes since v4:
 - Simplify PATCH2 by implementing RISC-V specific arch_memremap_wb()

Changes since v3:
 - Pickup correct version of Drew's patch as PATCH1

Changes since v2:
 - Rebased on Linux-6.1-rc1
 - Replaced PATCH1 with the patch proposed by Drew

Changes since v1:
 - Fix error reported by test bot
   https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/

Anup Patel (3):
  RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
  RISC-V: Implement arch specific PMEM APIs
  RISC-V: Enable PMEM drivers

 arch/riscv/Kconfig           |  1 +
 arch/riscv/configs/defconfig |  1 +
 arch/riscv/include/asm/io.h  |  5 +++++
 arch/riscv/mm/Makefile       |  1 +
 arch/riscv/mm/pmem.c         | 21 +++++++++++++++++++++
 5 files changed, 29 insertions(+)
 create mode 100644 arch/riscv/mm/pmem.c

-- 
2.34.1

