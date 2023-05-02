Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0746F3CB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjEBE27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjEBE2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EC9273F;
        Mon,  1 May 2023 21:28:50 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1683001728;
        bh=BeFg8v8OfXssu4fkWhQYkGpmzVPUGjmIEtd1FeQhc8U=;
        h=From:Subject:Date:To:Cc:From;
        b=Y/RM9qYZYG1vXcOkB1sQ6demroY5aO+7spKfFHOWniVG95z0WfUBjsI5jjL09FHYL
         xmJCIJ/mIvPjVtG+VgAH4SzSXSVA3/Hcj3PqVQMMcVR82ArQakHZpwTU5XSQ8/ZWEZ
         1IKAzprGpAlEDHYGbTj4suEfPv9Z5s7PL7xmZow0=
Subject: [PATCH v2 0/2] power: supply: remove unneeded include of
 linux/leds.h
Date:   Tue, 02 May 2023 06:28:43 +0200
Message-Id: <20230212-include-power_supply-leds-v2-0-e9910a3f5837@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHuRUGQC/42NWwrDIBBFtxL8rkVtQOhX91FC8TGpA2LEiUlDy
 N5rs4J+ngP3np0RFARi925nBRYknFIDdemYCya9gaNvzJRQN6Gk4phcrB54nlYoL6o5x41H8MR
 HkF5Lp622irW9NQTcFpNcaA+pxthkLjDi5ww+h8YBaZ7KdvYX+bP/pBbJJdfG21H3qhdCPVZAI
 nKhhmuCmQ3HcXwBG5UhpNwAAAA=
To:     Sebastian Reichel <sre@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, kernel test robot <lkp@intel.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683001727; l=859;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BeFg8v8OfXssu4fkWhQYkGpmzVPUGjmIEtd1FeQhc8U=;
 b=3+mN3pNtjfFOty41fg/pdL2xROrRxzG7AWRWGktbgwNJoQiDdhSdyGil+xklBSo8FhSsJnblD
 iHlfL7p6hOZBrHOj4Pz19pvKzlXlRLMJIPWRze9Nho4GFm/S2sZDoBx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently power_supply.h includes leds.h to get access to
struct led_trigger.
This propagates the inclusion unnecessarily to all users of
power_supply.h.

Replace this inclusion by a single forward declaration.

---
Changes in v2:
- Add an explicit include to drivers/hid/hid-lg4ff.c
- Link to v1: https://lore.kernel.org/r/20230212-include-power_supply-leds-v1-1-7adbf7424002@weissschuh.net

---
Thomas Weißschuh (2):
      HID: lg4ff: explicitly include linux/leds.h
      power: supply: remove unneeded include of linux/leds.h

 drivers/hid/hid-lg4ff.c      | 1 +
 include/linux/power_supply.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 865fdb08197e657c59e74a35fa32362b12397f58
change-id: 20230212-include-power_supply-leds-fe1d71c7b7b2

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

