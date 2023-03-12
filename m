Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD726B6311
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 04:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCLDsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 22:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCLDsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 22:48:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F065301B0;
        Sat, 11 Mar 2023 19:48:49 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678592927;
        bh=+rMHRDkeP4GJtkRDL8MbsK85+v58lq+Nd+xJTUAGoUU=;
        h=From:Date:Subject:To:Cc:From;
        b=KU+g7t96YIFS7B2isCvvNWrFXjBfgKGm1fVErAV8xjj1k8NJ2xSJmkIBnPhzJuqli
         xVRlXJCDKtyUfcrK2Eila0HHZ/oljLb78c3GUfvSzpUGcdG08b2jYmiOB7JkrRg0na
         TI0am49Kx7ryRE7f453xyvPfecgwozLk+zZjsAjQ=
Date:   Sun, 12 Mar 2023 03:47:57 +0000
Subject: [PATCH] platform/x86: think-lmi: Properly interpret return value
 of tlmi_setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230312-think-lmi-status-v1-1-4e9f36322cc4@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGxLDWQC/x2NywoCMQwAf2XJ2UDbBRf9FfHQR7TBGqXpirDsv
 xs8zsAwGyh1JoXztEGnDyu/xMAfJsg1yp2QizEEF2Y3+4CjsjywPRl1xLEqurIccyKflnICy1J
 UwtSj5GqhrK2ZfHe68ff/uVz3/QfB3gYJdwAAAA==
To:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678592925; l=1193;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+rMHRDkeP4GJtkRDL8MbsK85+v58lq+Nd+xJTUAGoUU=;
 b=qT5CKb7vhit8yR26drfrCP1cnWOS9WR8fzTCo52CJMP0ndSGSZnKum5T+CfijDiWZMhnIs0YQ
 T2Sc6W8/jSRAeW99fLmoL0w4w/usuXyf/iHPXaFZzcZwszbdv/Q+nCU
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

The return value of tlmi_settings() is an errorcode, not an acpi_status.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

Note: This is only compile-tested.
---
 drivers/platform/x86/think-lmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 86b33b74519b..c924e9e4a6a5 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1353,7 +1353,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
 
 static int tlmi_analyze(void)
 {
-	acpi_status status;
 	int i, ret;
 
 	if (wmi_has_guid(LENOVO_SET_BIOS_SETTINGS_GUID) &&
@@ -1390,8 +1389,8 @@ static int tlmi_analyze(void)
 		char *p;
 
 		tlmi_priv.setting[i] = NULL;
-		status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
-		if (ACPI_FAILURE(status))
+		ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
+		if (ret)
 			break;
 		if (!item)
 			break;

---
base-commit: 81ff855485a366a391dc3aed3942715e676ed132
change-id: 20230312-think-lmi-status-0d76cbe1b7d9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

