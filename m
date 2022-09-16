Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE68B5BA5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIPEdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIPEdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:33:37 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A2A024A;
        Thu, 15 Sep 2022 21:33:36 -0700 (PDT)
Received: from HP-EliteBook-840-G7.. (111-71-63-204.emome-ip.hinet.net [111.71.63.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 48ACD3FDDB;
        Fri, 16 Sep 2022 04:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663302814;
        bh=prBpj7C9jqQogczh9/Q5N69YHwbujqAamyJ+7rRBut4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nswuJ0QBhoy0LCET6ewmH0qbn4R5RhFjouolpcGhIfCF5lNchd3ZCpoTaaKdThBzp
         ZI+8hlf73m0ysWxpxDxxEw4rCv2bBXzv9vtREePs0jBhZBayUhUChbN/8pkKiyxrmF
         re5w86PB03QfG8QAeDppycoDb7SDtSFYuYgmfA9LkspjGXGAnDgQUDjTVZAKtgB2l/
         ypqgz8kd9nc9IeUxA6iuskQuGFbU568BKl3HTPt9EhisoEenu5mE0Eqp7NiNsyEZPj
         dsZZ4rTSn4OSFdiDlkc9h5eDcHzjRvY0LwXVCWYlj3n3K9oJkQmZg13Bp8SbY54C6H
         kyNxwnBVaoLFA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
Date:   Fri, 16 Sep 2022 12:33:17 +0800
Message-Id: <20220916043319.119716-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220916043319.119716-1-kai.heng.feng@canonical.com>
References: <20220916043319.119716-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

