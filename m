Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD36514ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiLSVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiLSVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:30:56 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64046BF72;
        Mon, 19 Dec 2022 13:30:53 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671485450;
        bh=yefAqOnQbgEx61M7zaR6i9RsAQ8hT0AF7ceHjpBPcXU=;
        h=From:Subject:Date:To:Cc:From;
        b=HzKDeDIP2wU4OBYwDCD4KwAW6ItQkwkL6PW9946IeEf6VhTDLhPlur+Du3Ec6n36O
         YxXHLVcKROXbFQDrQHQ5A4DN4eribbC4FdUY4HBDEs7rHro5tbdC8FSjNts5qm8b6g
         TXwg+MezKUsX7JPRPKBNvJ8Esof+tYswW65BqSpw=
Subject: [PATCH v2 0/2] watchdog: report all watchdog_ident information via sysfs
Date:   Mon, 19 Dec 2022 21:30:39 +0000
Message-Id: <20221216-watchdog-sysfs-v2-0-6189311103a9@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP/XoGMC/w3LSQqAMAwAwK9IzgY0FFF/0yVdQFpoXJDi3+1xD
 tNAuCYW2IcGle8kqeQOGgewUefAmFw30EQ007zgo08bXQkor3hBQ5Y3v3qlNgM9GS2MpupsY2/5
 Oo7v+wEaHPmVZQAAAA==
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Wim Van Sebroeck <wim@iguana.be>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671485447; l=1210;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yefAqOnQbgEx61M7zaR6i9RsAQ8hT0AF7ceHjpBPcXU=;
 b=9PhPfNhBZIiSbkv2LYuf5R1E5d6pohWsQQ/4501FH4TFJxCgVtE6kkuR3ky7W8VX3Sg+EiqVuovl
 xGEtgBV0BpKdJrW94g4PsQSIQ+bDZjO0ndbnPSQVmMUu6vlM/Xx1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This synchronizes the information reported by ioctl and sysfs.
The mismatch is confusing because "wdctl" from util-linux uses the ioctl
when used with root privileges and sysfs without.

Userspace implementation: https://github.com/util-linux/util-linux/pull/1927

To: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

Changes in v2:
- Report options in addition to firmware_version
- Add documentation
- Rename firmware_version to fw_version to avoid conflicts
- Link to v1: https://lore.kernel.org/r/20221214-nsfs-ioctl-compat-v1-0-b169796000b2@weissschuh.net

---
Thomas Weißschuh (2):
      watchdog: report fw_version in sysfs
      watchdog: report options in sysfs

 Documentation/ABI/testing/sysfs-class-watchdog | 13 +++++++++++++
 drivers/watchdog/watchdog_dev.c                | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+)
---
base-commit: 6feb57c2fd7c787aecf2846a535248899e7b70fa
change-id: 20221216-watchdog-sysfs-b2ce9f8f449b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
