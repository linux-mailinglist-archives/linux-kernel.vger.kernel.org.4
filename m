Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F196535BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLUSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiLUSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:00:02 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C224BCB;
        Wed, 21 Dec 2022 10:00:01 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671645598;
        bh=SdgSWth07klhr4Skhg4H8tcWIzAhkIpCxA9sSKEowlA=;
        h=From:Subject:Date:To:Cc:From;
        b=bm7kMjkect4hXM7VFoVj9ePOv4DYaHMEt+FPQvOTNd6Q6OGww+4hpWi3bQcdpCyLc
         KeFSRa8vL4en7JrXnqXUTarb3Eu9eDKnshX57Mn2unwdt9mJrGDC7+A/WP0LausvoO
         PIeHjo5ljC+I1s9frvMdP1iWScTOPbrYvKpyGej0=
Subject: [PATCH 0/3] platform/x86: asus-wmi: Fix issues on fanless device
Date:   Wed, 21 Dec 2022 17:59:49 +0000
Message-Id: <20221221-asus-fan-v1-0-e07f3949725b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJZJo2MC/x2MwQqDQAxEf0VyNlAXarG/UnqIMVsDEmWDIiz+e
 4Mwlze8mQouRcXh3VQocqjragFd2wDPZD9BnYIhPVLqIki+O2YyHEiIX9Nz4J4h9JFccCxkPMfA
 9mWJciuS9bz/P9/r+gOFtIjTbwAAAA==
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671645591; l=989;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SdgSWth07klhr4Skhg4H8tcWIzAhkIpCxA9sSKEowlA=;
 b=Jxb19dQToMI7qIU0WOvGr4omd+zQDpc2gGwq+NGABvp32ptIn8y6qdcSB8taH3/nT4BJFlIus9L1
 vRuZQQH2Al4rLVDQOwNngc4C+0iguE23HHlRjmo8Pf9WkPvXJK8e
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes issues experienced on a fanless ASUS VivoBook E410MA.

To: Corentin Chary <corentin.chary@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
To: Mark Gross <markgross@kernel.org>
To: "Luke D. Jones" <luke@ljones.dev>
Cc: acpi4asus-user@lists.sourceforge.net
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
Thomas Weißschuh (3):
      platform/x86: asus-wmi: Add quirk wmi_ignore_fan
      platform/x86: asus-wmi: Ignore fan on E410MA
      platform/x86: asus-wmi: Don't load fan curves without fan

 drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
 drivers/platform/x86/asus-wmi.c    |  7 ++++++-
 drivers/platform/x86/asus-wmi.h    |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
change-id: 20221221-asus-fan-9aeac7d59c6c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
