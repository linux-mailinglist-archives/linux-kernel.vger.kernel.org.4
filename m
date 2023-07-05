Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57D2747DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjGEHAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjGEHAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:00:02 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC5134;
        Tue,  4 Jul 2023 23:59:59 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id DC4FF100073;
        Wed,  5 Jul 2023 09:59:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DC4FF100073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688540397;
        bh=w9TfBjympA65WIQ8B01PoVwkn2a+efXJwLYEf3bue0A=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=HDzwTxugnu/x5f5fBNgZEOr7Rp8L6Ta8vQ0qvMkhvNJYmTTqN4/rcXoxM13nGc+Ep
         H8mjFeYxWxeL8DWZzOVkudikWc/QSk7eiRBkuKlMn3ZsFMcm0cgdq1hM+CXbAE0y/0
         eKm9XHm7YxowR0euNXYv9TXrNMpR30QdVocy/PboDbneknJKaVQ8lYwNhJDqpmJ4bC
         lofQpZS5iLH9t9XuYVo/G/yztYnx78qB3mK5jl6PG+gidt87FYpVMoqjQHtMia6vxG
         hbEfH/AW0exZd+r4cMLLWiheyo/vAuCoyzqWzn+Zi5nU94flLkqdmsEZWoLhxJausN
         vrAi3CyEUMqFw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 09:59:57 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 09:59:56 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/2] support 512B ECC step size for Meson NAND
Date:   Wed, 5 Jul 2023 09:54:32 +0300
Message-ID: <20230705065434.297040-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178437 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/05 05:56:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/05 05:56:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 01:35:00 #21564271
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patchset adds support for 512B ECC step size for Meson NAND. Current
implementation only supports 1024B. There are two patches:

1) Update for device tree bindings to replace 'const' type of field
   'nand-ecc-step-size' with 'enum' which contains 512 and 1024. Example
   is also updated.

2) Update for Meson driver - new enum value for 512B ECC and reworked
   ECC capabilities structure to support both 512B and 1024B ECC. By
   default this driver uses 1024B ECC, 512B could be enabled in device
   tree.

Changelog:
v1 -> v2:
 * Add default value of 1024 to the bindings patch (0001).
 * Remove "Acked-by: Rob Herring <robh@kernel.org>" from the bindings
   patch (0001) due to added default value.
 * Remove invalid calculation of OOB bytes, available for ECC engine
   from patch 0002. This logic is incorrect from the origins, so I don't
   touch it in this patchset. It will be fixed by another patch, as in
   fact, it doesn't affect this patchset.

Links:
v1:
https://lore.kernel.org/linux-mtd/20230628092937.538683-1-AVKrasnov@sberdevices.ru/

Arseniy Krasnov (2):
  dt-bindings: nand: meson: support for 512B ECC step size
  mtd: rawnand: meson: support for 512B ECC step size

 .../bindings/mtd/amlogic,meson-nand.yaml      |  4 +-
 drivers/mtd/nand/raw/meson_nand.c             | 45 ++++++++++++++-----
 2 files changed, 37 insertions(+), 12 deletions(-)

-- 
2.35.0

