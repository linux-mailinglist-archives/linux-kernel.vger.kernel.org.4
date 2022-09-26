Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAF5E9DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiIZJgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiIZJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:36:37 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77E24BD4;
        Mon, 26 Sep 2022 02:36:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VQkQP5U_1664184985;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VQkQP5U_1664184985)
          by smtp.aliyun-inc.com;
          Mon, 26 Sep 2022 17:36:25 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/16] Optimizing SM3 and SM4 algorithms using NEON/CE/SVE instructions
Date:   Mon, 26 Sep 2022 17:36:04 +0800
Message-Id: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches uses different instruction sets to optimize
the SM3 and SM4 algorithms, as well as the optimization of different
modes of SM4.

patch 1-2:  NEON instruction set optimization for SM3
patch 3:    Refactored and streamlined SM4 NEON instruction implementation
patch 4-5:  support test for new SM4 mode
patch 6-8:  Refactored and streamlined SM4 CE instruction implementation
patch 9-12: CE accelerated implementation of SM4 CTS/XTS/ESSIV
patch 13:   CE accelerated implementation of SM4 CMAC/XCBC/CBCMAC
patch 14-15: CE accelerated implementation of SM4 CCM/GCM
patch 16:   SM4 ARMv9 SVE cryptography acceleration implementation


Tianjia Zhang (16):
  crypto: arm64/sm3 - raise the priority of the CE implementation
  crypto: arm64/sm3 - add NEON assembly implementation
  crypto: arm64/sm4 - refactor and simplify NEON implementation
  crypto: testmgr - add SM4 cts-cbc/essiv/xts/xcbc test vectors
  crypto: tcrypt - add SM4 cts-cbc/essiv/xts/xcbc test
  crypto: arm64/sm4 - refactor and simplify CE implementation
  crypto: arm64/sm4 - simplify sm4_ce_expand_key() of CE implementation
  crypto: arm64/sm4 - export reusable CE acceleration functions
  crypto: arm64/sm4 - add CE implementation for CTS-CBC mode
  crypto: arm64/sm4 - add CE implementation for XTS mode
  crypto: essiv - allow digestsize to be greater than keysize
  crypto: arm64/sm4 - add CE implementation for ESSIV mode
  crypto: arm64/sm4 - add CE implementation for cmac/xcbc/cbcmac
  crypto: arm64/sm4 - add CE implementation for CCM mode
  crypto: arm64/sm4 - add CE implementation for GCM mode
  crypto: arm64/sm4 - add ARMv9 SVE cryptography acceleration
    implementation

 arch/arm64/crypto/Kconfig           |   66 +-
 arch/arm64/crypto/Makefile          |   12 +
 arch/arm64/crypto/sm3-ce-glue.c     |    2 +-
 arch/arm64/crypto/sm3-neon-core.S   |  600 +++++++++++++
 arch/arm64/crypto/sm3-neon-glue.c   |  103 +++
 arch/arm64/crypto/sm4-ce-asm.h      |  209 +++++
 arch/arm64/crypto/sm4-ce-ccm-core.S |  328 +++++++
 arch/arm64/crypto/sm4-ce-ccm-glue.c |  303 +++++++
 arch/arm64/crypto/sm4-ce-core.S     | 1247 ++++++++++++++++++---------
 arch/arm64/crypto/sm4-ce-gcm-core.S |  741 ++++++++++++++++
 arch/arm64/crypto/sm4-ce-gcm-glue.c |  286 ++++++
 arch/arm64/crypto/sm4-ce-glue.c     |  703 ++++++++++++++-
 arch/arm64/crypto/sm4-ce.h          |   16 +
 arch/arm64/crypto/sm4-neon-core.S   |  630 +++++++++-----
 arch/arm64/crypto/sm4-neon-glue.c   |  172 +---
 arch/arm64/crypto/sm4-sve-ce-core.S | 1028 ++++++++++++++++++++++
 arch/arm64/crypto/sm4-sve-ce-glue.c |  332 +++++++
 crypto/essiv.c                      |   11 +-
 crypto/tcrypt.c                     |   28 +
 crypto/testmgr.c                    |   25 +
 crypto/testmgr.h                    | 1161 +++++++++++++++++++++++++
 21 files changed, 7234 insertions(+), 769 deletions(-)
 create mode 100644 arch/arm64/crypto/sm3-neon-core.S
 create mode 100644 arch/arm64/crypto/sm3-neon-glue.c
 create mode 100644 arch/arm64/crypto/sm4-ce-asm.h
 create mode 100644 arch/arm64/crypto/sm4-ce-ccm-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-ccm-glue.c
 create mode 100644 arch/arm64/crypto/sm4-ce-gcm-core.S
 create mode 100644 arch/arm64/crypto/sm4-ce-gcm-glue.c
 create mode 100644 arch/arm64/crypto/sm4-ce.h
 create mode 100644 arch/arm64/crypto/sm4-sve-ce-core.S
 create mode 100644 arch/arm64/crypto/sm4-sve-ce-glue.c

-- 
2.24.3 (Apple Git-128)

