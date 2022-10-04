Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A35F3B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJDD27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJDD25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:28:57 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796CD2EF12
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 20:28:54 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 29437FRx092748;
        Tue, 4 Oct 2022 11:07:15 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 Oct
 2022 11:28:48 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] Add Aspeed ACRY driver for hardware acceleration
Date:   Tue, 4 Oct 2022 11:28:37 +0800
Message-ID: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 29437FRx092748
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aspeed ACRY engine is designed to accelerate the throughput of
ECDSA/RSA signature and verification.

These patches aim to add Aspeed ACRY RSA driver support.
This driver also pass the run-time self tests that take place at
algorithm registration on both big-endian/little-endian system
in AST2600 evaluation board .

Tested-by below configs:
- CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
- CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
- CONFIG_DMA_API_DEBUG=y
- CONFIG_DMA_API_DEBUG_SG=y
- CONFIG_CPU_BIG_ENDIAN=y

Change since v1:
- Fix dt-bindings description.
- Refine the Makefile which has been addressed.

Neal Liu (4):
  crypto: aspeed: Add ACRY RSA driver
  ARM: dts: aspeed: Add ACRY/AHBC device controller node
  dt-bindings: crypto: add documentation for Aspeed ACRY
  dt-bindings: bus: add documentation for Aspeed AHBC

 .../bindings/bus/aspeed,ast2600-ahbc.yaml     |  46 +
 .../bindings/crypto/aspeed,ast2600-acry.yaml  |  49 +
 MAINTAINERS                                   |   2 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |  13 +
 drivers/crypto/aspeed/Kconfig                 |  11 +
 drivers/crypto/aspeed/Makefile                |   2 +
 drivers/crypto/aspeed/aspeed-acry.c           | 848 ++++++++++++++++++
 7 files changed, 970 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
 create mode 100644 drivers/crypto/aspeed/aspeed-acry.c

-- 
2.25.1

