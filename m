Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CAA6546A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLVTdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiLVTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:32:59 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9238623306
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:32:56 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p8RJE-0004Um-1f;
        Thu, 22 Dec 2022 20:32:52 +0100
Date:   Thu, 22 Dec 2022 19:32:46 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/2] ubi: wire up parent device
Message-ID: <cover.1671737443.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up device parents of UBI devices and ubiblock devices (UBI volume
devices are already correctly wired to their parent UBI device). This
makes more sense than having UBI devices free-standing in
/sys/devices/virtual/ubi/ without any connection to their parent MTD
device, and ubiblock devices in /sys/devices/virtual/block/ which would
be better hosted by the UBI volume device they belong to.

The purpose of these changes is to allow downstream tools to more
easily identify UBI<->hardware relationship, and potentially also
improve power management and scheduling performance in future.

Daniel Golle (2):
  mtd: ubi: wire-up parent MTD device
  mtd: ubi: block: wire-up device parent

 drivers/mtd/ubi/block.c | 2 +-
 drivers/mtd/ubi/build.c | 1 +
 drivers/mtd/ubi/kapi.c  | 1 +
 include/linux/mtd/ubi.h | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)


base-commit: e45fb347b630ee76482fe938ba76cf8eab811290
-- 
2.39.0

