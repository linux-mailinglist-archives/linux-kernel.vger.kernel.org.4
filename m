Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9560E728
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiJZS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiJZS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:27:07 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475683204;
        Wed, 26 Oct 2022 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666808824; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=6ZrvLSXvvv0uDdPE3lr/VF7GjcvkIC96qj205SXc2VE=;
        b=jMcF1UB8949J3O4a8DVl4zkjAfc9KqPBxp1GDZdxK5/5CPiTTRyWy64PDStj0DZUSXZANm
        w0Aty9OmKQ/VXCkoAmsZhKMaGrE60K2M0/3HPVbflmOARUaX4/+OUoMzaJ5JaGQJRUQhN0
        AuZJQ0AW3A7VdDu3d/toHOz31MCf0i0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, od@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/7] musb: Update to use generic PHY
Date:   Wed, 26 Oct 2022 19:26:50 +0100
Message-Id: <20221026182657.146630-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset updates the musb core to add support for the generic PHY
framework.

It also updates the jz4740 driver to use the generic PHY driver
(drivers/phy/ingenic/phy-ingenic-usb.c) instead of the USB PHY one
(drivers/usb/phy/phy-jz4770.c) which is then removed.

If you are looking for the V1, it was sent two years ago [1] and
received zero feedback.

Anyway, V1 had only patches 1-4 and if I'm not mistaken the V2 patches
are exactly the same.

Patches 5-7 are new, and update the jz4740 driver to support generic
PHYs, and ultimately remove the old phy-jz4770 USB PHY driver which has
been replaced.

Cheers,
-Paul

[1]: https://lore.kernel.org/all/20201207130332.120681-1-paul@crapouillou.net/

Paul Cercueil (7):
  usb: musb: Add and use inline functions musb_{get,set}_state
  usb: musb: Add and use inline function musb_otg_state_string
  usb: musb: Allow running without CONFIG_USB_PHY
  usb: musb: Support setting OTG mode using generic PHY
  usb: musb: jz4740: Don't disable external hubs
  usb: musb: jz4740: Support the generic PHY framework
  usb: phy: jz4770: Remove driver

 drivers/usb/musb/Kconfig        |   1 -
 drivers/usb/musb/jz4740.c       |  62 +++++-
 drivers/usb/musb/musb_core.c    | 107 +++++-----
 drivers/usb/musb/musb_core.h    |  24 +++
 drivers/usb/musb/musb_debugfs.c |   6 +-
 drivers/usb/musb/musb_gadget.c  |  61 +++---
 drivers/usb/musb/musb_host.c    |  18 +-
 drivers/usb/musb/musb_virthub.c |  33 ++-
 drivers/usb/phy/Kconfig         |   8 -
 drivers/usb/phy/Makefile        |   1 -
 drivers/usb/phy/phy-jz4770.c    | 353 --------------------------------
 11 files changed, 195 insertions(+), 479 deletions(-)
 delete mode 100644 drivers/usb/phy/phy-jz4770.c

-- 
2.35.1

