Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C06746AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGDHqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGDHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:46:03 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288BCA;
        Tue,  4 Jul 2023 00:45:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BD81F41491;
        Tue,  4 Jul 2023 07:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688456758;
        bh=lkUhVHLr2kT3Uz1Nhg29KNs1j5fZGCeKmuPwJkP9IQE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bob7LbA0qP3MsdGQiWOb4iskOLfQt5PyJirGVsfuJFBis7NQ6LFQ6mLe/zxqpBma2
         SmLT4omedm1GBkTWP7bxnGguLvxZ3bRTAkYLK3WzdCawyYLjWalmflqzm/b5Xgns0M
         DzUPwe04IzeK+P6uVOyksz3FjlmpI2+SOe3gGWAtKD4LPLU6UItv4Pem1u3Aatz4A4
         wt/FZUtMOhtSjbAjxrBMm9IZE6JPd7KhTUTpLhv7FDo/0xHADI9eU1pMGlRsTZc4DM
         4JhVwLoxg7eOfx3NXntnQC3wtin0CAjnI7mTG0VaDYG95ylZD8vWUqSVXEZ7uF4Jix
         0AyNjZCBs+Pag==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
Date:   Tue,  4 Jul 2023 15:45:06 +0800
Message-Id: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Screen brightness can only be changed once on some HP laptops.

Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
for all ACPI devices:
    Scope (\_SB.PC00.GFX0)
    {
        Scope (DD1F)
        {
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
                {
                    \_SB.PC00.LPCB.EC0.SSBC ()
                }
            }
	    ...
	}
	...
    }

_PS0 doesn't get invoked for all ACPI devices because of commit
7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
during initialization").

For now explicitly call _PS0 for ACPI video to workaround the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/acpi/acpi_video.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 62f4364e4460..793259bd18c8 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	if (error)
 		goto err_put_video;
 
+	acpi_device_fix_up_power_extended(device);
+
 	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
-- 
2.34.1

