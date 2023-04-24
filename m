Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4EA6EC680
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjDXGrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDXGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:47:27 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4FF3A98;
        Sun, 23 Apr 2023 23:47:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0DF0442181;
        Mon, 24 Apr 2023 06:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1682318828; bh=3mjf32eyEhhtX71u9VNT0Tq8QAhtEflwUY8NEPfG0YA=;
        h=From:Date:Subject:To:Cc;
        b=nK/pAfgK0QpyxvN1Yv6dFIC/u8XNR5A9XoTtREmr5RAgvAn0ge1bNUFcmjf8axMXu
         qYrdQfpKmdAz1mGf5GqrI2u1O7AIxEYOPajCxtegTlZlQ0h60ZinVwid0BaUtO7VW7
         xXylWHv13SbP2kJGU80LeqBrL3Jym8WDzFhA9RCkqMy/vA3/MyAVzldqP45D0crCwj
         WyMbzBI2U7V5xIAc0GmDQBhpHikv6OOHZKTrShIIIM2jpLEjl0NJhd1ciyqEbi/7bm
         nPJ0RB1T4xm2UR3RkpHmGu1QmU+9hnZEjl5O+9iaoohgAkiMlskk9SzB3moNCiulrp
         wf+MVIG6EJhIg==
From:   Hector Martin <marcan@marcan.st>
Date:   Mon, 24 Apr 2023 15:46:57 +0900
Subject: [PATCH] ACPI / property: Support strings in Apple _DSM props
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230424-acpi-prop-v1-1-ffa9a300b1cd@marcan.st>
X-B4-Tracking: v=1; b=H4sIAOAlRmQC/x2NQQqDMBBFryKz7tAY0wi9SukiiROdTRwmbRHEu
 ze6fPz3eTtUUqYKz24HpR9XXkuD/tZBWkKZCXlqDNbYwTjrMCRhFF0Fx+jH/pGzM5OH5sdQCaO
 Gkpbz8fHGbveoXOavnLsoZd6u1ut9HH/bSjznewAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.kernel.dev, Lukas Wunner <lukas@wunner.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=marcan@marcan.st;
 h=from:subject:message-id; bh=3mjf32eyEhhtX71u9VNT0Tq8QAhtEflwUY8NEPfG0YA=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhhQ31ZdxgScNl4iJMJYH7Ct/aWiVkazPvKF6/7VtKbVTl
 siXWMh0lLIwiHEwyIopsjSe6D3V7Tn9nLpqynSYOaxMIEMYuDgFYCJnfjL8T+xb9/RgrLzFOaft
 lvkfXabt/O77NPHKCVNPds6IuFLFx4wMK09PT1j67nNg3utzX+c9PBfA48xwoX034+HyQxJOFxu
 jGQA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wi-Fi module in x86 Apple machines has a "module-instance" device
property that specifies the platform type and is used for firmware
selection. Its value is a string, so add support for string values in
acpi_extract_apple_properties().

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/acpi/x86/apple.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
index 8812ecd03d55..45d0f16f374f 100644
--- a/drivers/acpi/x86/apple.c
+++ b/drivers/acpi/x86/apple.c
@@ -71,13 +71,16 @@ void acpi_extract_apple_properties(struct acpi_device *adev)
 
 		if ( key->type != ACPI_TYPE_STRING ||
 		    (val->type != ACPI_TYPE_INTEGER &&
-		     val->type != ACPI_TYPE_BUFFER))
+		     val->type != ACPI_TYPE_BUFFER &&
+		     val->type != ACPI_TYPE_STRING))
 			continue; /* skip invalid properties */
 
 		__set_bit(i, valid);
 		newsize += key->string.length + 1;
 		if ( val->type == ACPI_TYPE_BUFFER)
 			newsize += val->buffer.length;
+		else if (val->type == ACPI_TYPE_STRING)
+			newsize += val->string.length + 1;
 	}
 
 	numvalid = bitmap_weight(valid, numprops);
@@ -119,6 +122,12 @@ void acpi_extract_apple_properties(struct acpi_device *adev)
 		newprops[v].type = val->type;
 		if (val->type == ACPI_TYPE_INTEGER) {
 			newprops[v].integer.value = val->integer.value;
+		} else if (val->type == ACPI_TYPE_STRING) {
+			newprops[v].string.length = val->string.length;
+			newprops[v].string.pointer = free_space;
+			memcpy(free_space, val->string.pointer,
+			       val->string.length);
+			free_space += val->string.length + 1;
 		} else {
 			newprops[v].buffer.length = val->buffer.length;
 			newprops[v].buffer.pointer = free_space;

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230424-acpi-prop-7b6715ff40d6

Best regards,
-- 
Hector Martin <marcan@marcan.st>

