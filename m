Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B415EEE67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiI2HG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiI2HFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:05:44 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06322131F55;
        Thu, 29 Sep 2022 00:05:42 -0700 (PDT)
Received: from ubuntu.. (1-171-217-173.dynamic-ip.hinet.net [1.171.217.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1940B3FC45;
        Thu, 29 Sep 2022 07:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664435141;
        bh=prBpj7C9jqQogczh9/Q5N69YHwbujqAamyJ+7rRBut4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lHDOrvI76jV4t8HTbtjYmd5vfStwpoaTn0f5GRfD0uUZeaigGUeTgRBJ6HCLGJFUc
         vKPijPOY4CzAb9sm7SKLYhhPvLFhz0eBGF62JdW5VCT9QtdWuDfR1ELGLoDNykd690
         2r57hMz59lSBtZwjvaz5SOP7vHsKwYgb5Yck3UuZpAU9f3DWKT+kM00uHBAFewNu4Z
         POfAS/xhCNRTLbRcuouRrumFUansDp+C58+VYmmLOs6K1Jn3QY6ZbpEgHFnPytEeF8
         CDd3d7BExe9ocyRBrWI+46PShxJ6R0MC9nfNDnlbRn6mmeDc5Rg5k6RPbZWvtk2His
         WJP/fVfjiiADw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
Date:   Thu, 29 Sep 2022 15:05:24 +0800
Message-Id: <20220929070526.143907-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220929070526.143907-1-kai.heng.feng@canonical.com>
References: <20220929070526.143907-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Using S5 for reboot is default behavior under Windows, "A full shutdown
(S5) occurs when a system restart is requested" [1].

[1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-state

Cc: Josef Bacik <josef@toxicpanda.com>
Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 - Add comment and add more info to commit message.
v3:
 - Use new API to invoke ACPI S5.
v2:
 - Use do_kernel_power_off_prepare() instead.

 drivers/acpi/sleep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index ad4b2987b3d6e..0b557c0d405ef 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1088,6 +1088,14 @@ int __init acpi_sleep_init(void)
 		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
 					 SYS_OFF_PRIO_FIRMWARE,
 					 acpi_power_off, NULL);
+
+		/*
+		 * Windows uses S5 for reboot, so some BIOSes depend on it to
+		 * perform proper reboot.
+		 */
+		register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
+					 SYS_OFF_PRIO_FIRMWARE,
+					 acpi_power_off_prepare, NULL);
 	} else {
 		acpi_no_s5 = true;
 	}
-- 
2.37.2

