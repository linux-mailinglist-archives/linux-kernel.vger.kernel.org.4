Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0127327A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbjFPGdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbjFPGc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:32:59 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8ED272C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:32:58 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b2c3ec38f0so308686a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1686897178; x=1689489178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEiGxc0bcdVFmhzsmXnMFSNPzbdJ2fxyVgUq2gtSOwE=;
        b=ZEUbV1U8ywhzF6zZSbsVdixkSlHUxOenMtDi96SPl0SdnGOIaDTE0g5g8UT1RY2pTq
         FB2t+uIWA58e9GImiWa095pOZ3OeSoinzAhrIW1XFiXjdvFA/ltPsi0wdnhCxeQO8/js
         izdWofuS19L3NMGgU4bK4a8VFcuFo2MELZmhoHs44Ed/LLlCPVGrWazX2HyIhFu0n2fX
         oUEaaQSVvU7ccnRynvkKu5ybdXSW9+91c4NP40V9DXfalCrxOFtERndPUcCHZry13zTq
         RonR0T31oPEfHoN3X7wIzPAeBn4MdJtd7qn7REyadamETF3JhK6oc5esOTbSI1f+Uy5H
         WNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686897178; x=1689489178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEiGxc0bcdVFmhzsmXnMFSNPzbdJ2fxyVgUq2gtSOwE=;
        b=eSVHvWm3CDJS6iQFlvKySLNqC+6vpUhWTeuNpX+KrKkz1QnfatpH0vOtcuGN9cUrFB
         VPtqPhcL203mHfOhISatOYR+LiAR/aSx9vsIMqiBRPcDzi1qHg3re7Dkg5StkcN8IAuc
         CgQ+PEI1r8YEc/etGWt9ZH5RTkG7gVklg0nVY7pwFGXFWQsZQgIye8SLBVoqXeR52kx6
         ROJIUIghmutvfRF3ouMyMOHVixgNzpVRt8Ku3p70m6bXp9SWY3SsMLkgVidrkwkGsB6b
         F8ga8dx3793XjpjzQ2M0mCDeJzMGYNQZzgypdLE1LWGpHELLTnf+EjGvs3zlv82mZo2+
         z35Q==
X-Gm-Message-State: AC+VfDyxn9AUFLStNK2eNfx7c3k4xTGfc6FxxiytDl2Mrip2nHW4Fcj7
        P71pXkkGpaX0f3duvJmI1IQVYA==
X-Google-Smtp-Source: ACHHUZ6U4/yV5VCV2rWE460G/Hqxnl14VCk7M+s4/0nl5oxkQImHZBZU9znPhxC1siwCN2ygVbz09g==
X-Received: by 2002:a05:6808:221d:b0:39a:aa6d:b9e0 with SMTP id bd29-20020a056808221d00b0039aaa6db9e0mr1387108oib.45.1686897178071;
        Thu, 15 Jun 2023 23:32:58 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a410b00b0025023726fc4sm617596pjf.26.2023.06.15.23.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 23:32:57 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com
Cc:     Eric Lin <eric.lin@sifive.com>
Subject: [PATCH 0/3] Add SiFive Private L2 cache and PMU driver
Date:   Fri, 16 Jun 2023 14:32:07 +0800
Message-Id: <20230616063210.19063-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the SiFive Private L2 cache controller
driver and Performance Monitoring Unit (PMU) driver.

The Private L2 cache communicates with both the upstream L1
caches and downstream L3 cache or memory, enabling a high-
performance cache subsystem. It is also responsible for managing
requests from the L1 instruction and data caches of the core.

The Private L2 Performance Monitoring Unit (PMU) consists of a
set of event-programmable counters and their event selector registers.
The registers are available to control the behavior of the counters.

Eric Lin (2):
  soc: sifive: Add SiFive private L2 cache support
  dt-bindings: riscv: sifive: Add SiFive Private L2 cache controller

Greentime Hu (1):
  soc: sifive: Add SiFive private L2 cache PMU driver

 .../bindings/riscv/sifive,pL2Cache0.yaml      |  81 +++
 drivers/soc/sifive/Kconfig                    |  17 +
 drivers/soc/sifive/Makefile                   |   2 +
 drivers/soc/sifive/sifive_pl2.h               |  45 ++
 drivers/soc/sifive/sifive_pl2_cache.c         | 218 ++++++
 drivers/soc/sifive/sifive_pl2_pmu.c           | 669 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   2 +
 7 files changed, 1034 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
 create mode 100644 drivers/soc/sifive/sifive_pl2.h
 create mode 100644 drivers/soc/sifive/sifive_pl2_cache.c
 create mode 100644 drivers/soc/sifive/sifive_pl2_pmu.c

-- 
2.40.1

