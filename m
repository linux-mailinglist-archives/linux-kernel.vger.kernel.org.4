Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F36177C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKCHky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiKCHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:40:49 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5D10A2;
        Thu,  3 Nov 2022 00:40:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VTrcGFd_1667461243;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VTrcGFd_1667461243)
          by smtp.aliyun-inc.com;
          Thu, 03 Nov 2022 15:40:45 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, elliott@hpe.com
Cc:     zelin.deng@linux.alibaba.com, artie.ding@linux.alibaba.com,
        guanjun@linux.alibaba.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuchun.shang@linux.alibaba.com
Subject: [PATCH v3 RESEND 0/9] Drivers for Alibaba YCC (Yitian Cryptography Complex) cryptographic accelerator
Date:   Thu,  3 Nov 2022 15:40:34 +0800
Message-Id: <1667461243-48652-1-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Hi,

This patch series aims to add drivers for Alibaba YCC (Yitian Cryptography Complex)
cryptographic accelerator. Enables the on-chip cryptographic accelerator of
Alibaba Yitian SoCs which is based on ARMv9 architecture.

It includes PCIe enabling, skcipher, aead, rsa, sm2 support.

Please help to review.

Thanks,
Guanjun.

Change log:
v3 -> v3 RESEND:
 - [*/09] Fix compile warnings when sparse turned on

v2 -> v3:
 - [01/09] Fix the lost "$" in Makefile
 - [08/09] Fix compile warnings when both CONFIG_CRYPTO_SM2 and CONFIG_CRYPTO_DEV_YCC are enabled

v1 RESEND -> v2:
 - [01/09] Remove char device that is not used now.

v1 -> v1 RESEND:
  - [01/09] Adjust the Kconfig entry in alphabetical order
  - [05/09][07/09][08/09] Adjust the format of algorithm names

v2: https://lore.kernel.org/all/1664350687-47330-1-git-send-email-guanjun@linux.alibaba.com/
v1: https://lore.kernel.org/all/1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com/
v1 RESEND: https://lore.kernel.org/all/1662435353-114812-1-git-send-email-guanjun@linux.alibaba.com/

Guanjun (3):
  crypto/ycc: Add skcipher algorithm support
  crypto/ycc: Add aead algorithm support
  crypto/ycc: Add rsa algorithm support

Xuchun Shang (1):
  crypto/ycc: Add sm2 algorithm support

Zelin Deng (5):
  crypto/ycc: Add YCC (Yitian Cryptography Complex) accelerator driver
  crypto/ycc: Add ycc ring configuration
  crypto/ycc: Add irq support for ycc kernel rings
  crypto/ycc: Add device error handling support for ycc hw errors
  MAINTAINERS: Add Yitian Cryptography Complex (YCC) driver maintainer
    entry

 MAINTAINERS                            |   8 +
 drivers/crypto/Kconfig                 |   2 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/ycc/Kconfig             |  18 +
 drivers/crypto/ycc/Makefile            |   7 +
 drivers/crypto/ycc/sm2signature_asn1.c |  38 ++
 drivers/crypto/ycc/sm2signature_asn1.h |  13 +
 drivers/crypto/ycc/ycc_aead.c          | 646 ++++++++++++++++++++++
 drivers/crypto/ycc/ycc_algs.h          | 176 ++++++
 drivers/crypto/ycc/ycc_dev.h           | 157 ++++++
 drivers/crypto/ycc/ycc_drv.c           | 567 ++++++++++++++++++++
 drivers/crypto/ycc/ycc_isr.c           | 276 ++++++++++
 drivers/crypto/ycc/ycc_isr.h           |  13 +
 drivers/crypto/ycc/ycc_pke.c           | 946 +++++++++++++++++++++++++++++++++
 drivers/crypto/ycc/ycc_ring.c          | 649 ++++++++++++++++++++++
 drivers/crypto/ycc/ycc_ring.h          | 170 ++++++
 drivers/crypto/ycc/ycc_ske.c           | 925 ++++++++++++++++++++++++++++++++
 17 files changed, 4612 insertions(+)
 create mode 100644 drivers/crypto/ycc/Kconfig
 create mode 100644 drivers/crypto/ycc/Makefile
 create mode 100644 drivers/crypto/ycc/sm2signature_asn1.c
 create mode 100644 drivers/crypto/ycc/sm2signature_asn1.h
 create mode 100644 drivers/crypto/ycc/ycc_aead.c
 create mode 100644 drivers/crypto/ycc/ycc_algs.h
 create mode 100644 drivers/crypto/ycc/ycc_dev.h
 create mode 100644 drivers/crypto/ycc/ycc_drv.c
 create mode 100644 drivers/crypto/ycc/ycc_isr.c
 create mode 100644 drivers/crypto/ycc/ycc_isr.h
 create mode 100644 drivers/crypto/ycc/ycc_pke.c
 create mode 100644 drivers/crypto/ycc/ycc_ring.c
 create mode 100644 drivers/crypto/ycc/ycc_ring.h
 create mode 100644 drivers/crypto/ycc/ycc_ske.c

-- 
1.8.3.1

