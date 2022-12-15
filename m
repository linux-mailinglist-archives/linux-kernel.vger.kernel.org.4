Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2022064E49D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLOXVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:21:13 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79BDFBF;
        Thu, 15 Dec 2022 15:21:11 -0800 (PST)
Received: from rustam-GF63-Thin-9RCX.. (unknown [93.175.1.130])
        by mail.ispras.ru (Postfix) with ESMTPSA id 70FD040D403D;
        Thu, 15 Dec 2022 23:21:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 70FD040D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671146467;
        bh=H5crU78K2zee4DdEMLmYCKLNeQWcvsMzZNn++UaUCUw=;
        h=From:To:Cc:Subject:Date:From;
        b=TW3AGIqCEXiBI6wHJW24PtJsv3PGrEj7RLl0TKUh5C3MzIW2cR6Xgi3YPwZq+hMjH
         8fce9uRpLjyyLEtabNcGWUobcFY4Tf4R3xsyJ2RVLwaPWYus+DOD3XLRk6GopVBIia
         Jqp6fP+8+j+q7qtJkVFua0mRcfBbQ+Qi34ueT+wM=
From:   Rustam Subkhankulov <subkhankulov@ispras.ru>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Rustam Subkhankulov <subkhankulov@ispras.ru>,
        Mark Gross <markgross@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] dell-smbios: fix double free in dell_smbios_init() and fixes in dell_smbios_exit()
Date:   Fri, 16 Dec 2022 02:17:41 +0300
Message-Id: <20221215231741.154355-1-subkhankulov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs in function build_tokens_sysfs(), then all the memory
that has been allocated is correctly freed at certain labels at the end
of this function.

build_tokens_sysfs() returns a non-zero value on error, function
free_group() is called, resulting in a double-free. Removing
free_group() function call will fix this problem.

Also, it seems that instead of free_group() call, there should be
exit_dell_smbios_smm() and exit_dell_smbios_wmi() calls, since there is
initialization, but there is no release of resources in case of an error.

Since calling 'exit' functions for 'smm' and 'wmi' is unsafe if
initialization failed, in dell_smbios_exit() and dell_smbios_init()
we need to call 'exit' only if initialization before was successful.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
Fixes: 25d47027e100 ("platform/x86: dell-smbios: Link all dell-smbios-* modules together")
---
 drivers/platform/x86/dell/dell-smbios-base.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index fc086b66f70b..cfef8cdd1215 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -29,6 +29,8 @@ static struct device_attribute *token_location_attrs;
 static struct device_attribute *token_value_attrs;
 static struct attribute **token_attrs;
 static DEFINE_MUTEX(smbios_mutex);
+static bool wmi_initialized;
+static bool smm_initialized;
 
 struct smbios_device {
 	struct list_head list;
@@ -607,6 +609,9 @@ static int __init dell_smbios_init(void)
 			goto fail_sysfs;
 	}
 
+	wmi_initialized = !(wmi);
+	smm_initialized = !(smm);
+
 	return 0;
 
 fail_sysfs:
@@ -628,8 +633,16 @@ static int __init dell_smbios_init(void)
 
 static void __exit dell_smbios_exit(void)
 {
-	exit_dell_smbios_wmi();
-	exit_dell_smbios_smm();
+	if (wmi_initialized) {
+		exit_dell_smbios_wmi();
+		wmi_initialized = 0;
+	}
+
+	if (smm_initialized) {
+		exit_dell_smbios_smm();
+		smm_initialized = 0;
+	}
+
 	mutex_lock(&smbios_mutex);
 	if (platform_device) {
 		if (da_tokens)
-- 
2.34.1

