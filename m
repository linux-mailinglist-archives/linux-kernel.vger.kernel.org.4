Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F122B659549
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiL3F7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiL3F7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:59:40 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0636BDA6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:59:38 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r72so10691669iod.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 21:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusetak.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yI8IXYC+g9VQSXXRePDAV8T9sfECoiHVCxWFbYMy90=;
        b=L8FlM01Qw+KPRAq4TQYCzNv9OqjVHphSzOsoBQTg8uYqT5Al8JvAZ63zYrQ3vm8FkG
         iDt8wlJygbG85G5Zheyj2p9VAy0VBe/zmzMIMZiLbSBneeCXrBLEvloTaNJxur6awAwT
         3dwBbgn+ro659MhTRaJLNktDJEQFkLYTCqLRdyEj8TmlpfB7Wruh1kS6QEe1iB34UFwI
         9d4WzBD4+7hdFBPKzEQQDCnnQCS6UxnGmklE91wF4rEY9+PE/hh9rVIzSsvB8QsB+Wry
         bPEAhUdfTDczcwOwTfE2ILpr72aiYxm1/0/Mox8e2ff3xOhCYix0h1HsFXl+mVAkbrJt
         WUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yI8IXYC+g9VQSXXRePDAV8T9sfECoiHVCxWFbYMy90=;
        b=xXuSrsCKq3eCUFKbOyRHDJQnylpI7ZMwkHw9oaNtRW0WKI8fV4eaN5D6rW8Ik3jIkx
         rQupwCcPS5rQoldVijzXlKuZyq6tk65tT1VyWISQm1vA+iIqhRxj52UtJKSBtkdJQXCo
         eurkNWoFdsIpkU1SfZ3YiizJRuJdpAOb/LYjW0pg6lqKUDXMJUxq9gRxPZEUnY72fCS6
         WzRrrV0+noGBoorh0aZk39kh66rhYmyoyD0Fktfz+Bmi6ZO/SthJoBPkigC3uvBEHx9n
         ZlQZOXJkWW4Bf4Xa8PO1rh/fBjFgUnhByBOKsa9FYedjh+xYpBzogGENEbZn935NndG2
         zHFg==
X-Gm-Message-State: AFqh2koxrw3d/cNwZAiH6qp0qRFaNAppdI5vA5FgvZ6h0SlO8FiXLeD0
        Q2XlCnXbUubGVkhzAYgCfk/KOA==
X-Google-Smtp-Source: AMrXdXuM4etmGmDpYZ0xl/zWaBGf+MDv8vaf/sF8eU6r33RNdz7gKwKotRJ9yx5DUxVI0nm1uMf+cA==
X-Received: by 2002:a6b:6310:0:b0:6d6:4daf:623f with SMTP id p16-20020a6b6310000000b006d64daf623fmr19420602iog.6.1672379978278;
        Thu, 29 Dec 2022 21:59:38 -0800 (PST)
Received: from fusetakDesktop.internal.fusetak.net ([99.247.2.235])
        by smtp.gmail.com with ESMTPSA id u4-20020a02cb84000000b003762308fe54sm6558942jap.93.2022.12.29.21.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 21:59:37 -0800 (PST)
From:   Tamim Khan <tamim@fusetak.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
        Tamim Khan <tamim@fusetak.com>, zelenat <zelenat@gmail.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA
Date:   Fri, 30 Dec 2022 00:58:39 -0500
Message-Id: <20221230055839.80885-1-tamim@fusetak.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the Asus Expertbook B2502CBA and various Asus Vivobook laptops,
the Asus Expertbook B2402CBA has an ACPI DSDT table that describes IRQ 1
as ActiveLow while the kernel overrides it to Edge_High. This prevents the 
keyboard from working. To fix this issue, add this laptop to the 
skip_override_table so that the kernel does not override IRQ 1.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216864
Tested-by: zelenat <zelenat@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
---
This patch is very similar to 7203481fd12b1257938519efb2460ea02b9236ee
(ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks) and just adds
another ExpertBook that has the same IRQ override problem to the quirks list.

 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 16dcd31d124f..153e3f8b446f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -432,6 +432,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		.ident = "Asus ExpertBook B2402CBA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
+		},
+	},
 	{
 		.ident = "Asus ExpertBook B2502",
 		.matches = {
-- 
2.38.1

