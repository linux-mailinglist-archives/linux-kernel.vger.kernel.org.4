Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3A5B67D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiIMGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiIMGVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:21:50 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB982CE13;
        Mon, 12 Sep 2022 23:21:18 -0700 (PDT)
Received: from HP-EliteBook-840-G7.. (1-171-215-55.dynamic-ip.hinet.net [1.171.215.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9539F3FDC4;
        Tue, 13 Sep 2022 06:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663050076;
        bh=LiDG8FrfTYaa0AmzxLH7DWNm3Yjyr6Vzh7RHEY6totM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=F0FG0aked9Qzb2athEyWhdNhH6/lNuQjRhRg8bvMoFa3nITwHBYQndwiFAsndPNDJ
         o7yDFMy7RYVI5BTpQRbbGhX/tVGfpeWGb2lSTro3P57KTQtjdvK00Or6KJYqDqB/3p
         5Ef0fLjM6zccaQxk3Y5EKEUSb/6wS72PgUfSV1WDMFqnZzhq2eQWWgwJ0ZZMWZ5JYb
         3vGy/gSUlZTHPPNP6g8ZqxRZ0phEDc5Yrb3pdxnCO/dBBkw2FA2V7aesLhzWAWIuFo
         ITO8S9uz4Ubk1QDSl7R7w+4ihh5I/zK+0ToxyISnxKjGLo/r0Zx3lMBmaPJHtLUTIo
         EOnwOx6qLpyZg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
Date:   Tue, 13 Sep 2022 14:20:40 +0800
Message-Id: <20220913062042.1977790-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220913062042.1977790-1-kai.heng.feng@canonical.com>
References: <20220913062042.1977790-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
PowerEdge r440 hangs at reboot.

The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
system reboot to avoid triggering AER"), so use the new sysoff API to
reinstate S5 for reboot on ACPI-based systems.

Cc: Josef Bacik <josef@toxicpanda.com>
Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Use new API to invoke ACPI S5.

v2:
 - Use do_kernel_power_off_prepare() instead.

 drivers/acpi/sleep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index ad4b2987b3d6e..dce5460902eed 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1088,6 +1088,10 @@ int __init acpi_sleep_init(void)
 		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
 					 SYS_OFF_PRIO_FIRMWARE,
 					 acpi_power_off, NULL);
+
+		register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
+					 SYS_OFF_PRIO_FIRMWARE,
+					 acpi_power_off_prepare, NULL);
 	} else {
 		acpi_no_s5 = true;
 	}
-- 
2.36.1

