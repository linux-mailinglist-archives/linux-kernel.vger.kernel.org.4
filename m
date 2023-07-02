Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFDB7451D2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGBT6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjGBT45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE4619AA;
        Sun,  2 Jul 2023 12:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C9460C81;
        Sun,  2 Jul 2023 19:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97132C433CA;
        Sun,  2 Jul 2023 19:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327571;
        bh=x7QgD5cbrpnxYXtiHTDilUKOuTppJo9uI3sOZCIeioE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLmUpkZysWRswgc6i6yxrOe//M6ZdJLpcMX9P7U1Cpz4nduu2cK0rEeMlEk2TxZhE
         eNErwunlebCowU3Lt7bPXHCRzh84+Ryyj7SLTSvm1sN+wzyDILhs95unaNoyJXHhny
         7mdnxrMn4j3hwYbm1mT5r+HfFPCj4Xg8hmuiil9oagd0Plo+lLAclrK/ywYStB0ASB
         M9jdW62aKB8fNj5U9F9Z09VaSoMyXpTVOIKmO6BC2WRW3Cnde8fJTCYpCKoHOThezl
         Pjkfna0hL5EeFIADCXC0KiLfkSRn1Wx6t7qDy/NViL5CIvcXU5SRvWQk2qklWrWZf9
         1doTKRjCLZ1tw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/5] ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
Date:   Sun,  2 Jul 2023 15:52:44 -0400
Message-Id: <20230702195247.1788860-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195247.1788860-1-sashal@kernel.org>
References: <20230702195247.1788860-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 48436f2e9834b46b47b038b605c8142a1c07bc85 ]

Linux defaults to picking the non-working ACPI video backlight interface
on the Apple iMac11,3 .

Add a DMI quirk to pick the working native radeon_bl0 interface instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 038542b3a80a7..872b5351f0d8f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -332,6 +332,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple iMac11,3 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.39.2

