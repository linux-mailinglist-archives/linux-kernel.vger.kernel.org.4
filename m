Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293E56F4893
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjEBQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjEBQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:48:11 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CD1992;
        Tue,  2 May 2023 09:48:09 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pttAS-0000UL-0r;
        Tue, 02 May 2023 18:47:56 +0200
Date:   Tue, 2 May 2023 17:47:48 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: [PATCH 0/4] mtd: ubi: behave like a good MTD citizen
Message-ID: <cover.1683043928.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now one can easily trigger the existence of "ghost" UBI devices
or even worse by removing e.g. the SPI bus driver which previously
provided access to an SPI-NAND chip.

Make UBI behave more like other MTD users and create/remove UBI devices
based on MTD notifications. As removing could previously fail in case
of an ubiblock device still being in use, make sure there are no
excuses preventing release of an already gone MTD partition.

This makes it possible to attach UBI devices immediately after the MTD
partition becomes available, which will allow using UBI volumes as
nvmem-cells provider in the future [1]. Introduce new device tree
compatible "linux,ubi" to be used on MTD partitions which should be
attached.

In order to make sure ubiblock devices are still created according to
the module or kernel parameters, let ubiblock creation from parameters
be triggered by UBI_VOLUME_ADDED notifications instead of trying only
once during boot.

[1]: https://forum.openwrt.org/t/asus-tuf-ax4200-support/155738/44?u=daniel

Daniel Golle (4):
  mtd: ubi: block: don't return on error when removing
  mtd: ubi: block: use notifier to create ubiblock from parameter
  dt-bindings: mtd: partitions: add linux,ubi
  mtd: ubi: attach MTD partition from device-tree

 .../bindings/mtd/partitions/ubi.yaml          |  49 +++++
 drivers/mtd/ubi/block.c                       | 158 ++++++++-------
 drivers/mtd/ubi/build.c                       | 189 ++++++++++++------
 drivers/mtd/ubi/cdev.c                        |   4 +-
 drivers/mtd/ubi/ubi.h                         |   6 +-
 5 files changed, 271 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml


base-commit: b5fda08ef213352ac2df7447611eb4d383cce929
-- 
2.40.1

