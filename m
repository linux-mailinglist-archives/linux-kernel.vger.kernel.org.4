Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0C62459B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKJPZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKJPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:09 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D931FB8;
        Thu, 10 Nov 2022 07:25:09 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so2525364fac.1;
        Thu, 10 Nov 2022 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJE4o8UGPSLDbHBH3td/ssdYbDar1LnD9EEm4jyPN1Y=;
        b=auhldo3qG9yeMDSYl7jgYhWvJwAS1ewzMiLMMJe1yNQwYk9ftiJMrbzICYhzVUhlHm
         QSMyXHOuVivMtF3I8iYVWXoxOlVuJrW/lLuVvbSNzpAmoWcF22uLVl4MkvbIbo9XrcRh
         MhMIC7eb5K+yLTHJJ4huFB0PdcSOrKz/hoT6qR3VCUUGbGrZPDjH/6pO45NQKaX1Nc6H
         fL0sSOozSR/upyvuMNn29quJrkoOHCxq+HN37N6uEZkXMraYQRlW6+wMBtXVWHh+SiLr
         ga53fXSrIUZJ6bTcLqN2Jsil0ML1BLzY4G7ii6Q8RQEd0+HPHm6jvPuOs7Ld/SMTayLQ
         uqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJE4o8UGPSLDbHBH3td/ssdYbDar1LnD9EEm4jyPN1Y=;
        b=RmtPspfy/x02MgMMF8w5Vx4H5sKY7sz0kKU+L4oRln+Uk2n13sSxJjUyU1AL83q9XB
         e74Togctot+JhzP5LCirwNo5pXpKbmsDEI4TLYCNQ6wWcz/Npjd0+GJCQcE41Ry2cRp5
         4ld9hGaltJ99kfBagpmFSKgXEZI68z30+jkFgr5R+SnnP6uomP74nJ5LDVtTZOytqtu3
         DZIfTRxq9npJNueMm1/qSY3kQRljIvXJqE/gK2iNWC54iUAWcjrF8Uspx/bknT0xsNlB
         et/IkRIL/sDrk25b1oz3OKBpx0BSrWOFUCU18LCmyH6jPk1c0M1KWz3vJujFUDzbfwiz
         6NnA==
X-Gm-Message-State: ACrzQf3sHZNyPTQeV6z4llW1OGbLwqrQE/prKmJJIQv+q1h/6y9/D4d5
        5773Y8bZ0XSwA5WogCh58Rg=
X-Google-Smtp-Source: AMsMyM7hIRNSe9l2cywOeEKv+dH1K6Eu7rFiJwyUvZ1SIFCd7RPlm7Ck8qUZKQLihk9jeyZsRnhFlA==
X-Received: by 2002:a05:6870:4687:b0:13e:bdf2:3e6c with SMTP id a7-20020a056870468700b0013ebdf23e6cmr1441935oap.45.1668093908659;
        Thu, 10 Nov 2022 07:25:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ej13-20020a056870f70d00b0011f400edb17sm7649233oab.4.2022.11.10.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/9] thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp
Date:   Thu, 10 Nov 2022 07:24:54 -0800
Message-Id: <20221110152500.3032655-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221110152500.3032655-1-linux@roeck-us.net>
References: <20221110152500.3032655-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to thermal_zone_get_temp() are not protected against thermal zone
device removal. As result, it is possible that the thermal zone operations
callbacks are no longer valid when thermal_zone_get_temp() is called.
This may result in crashes such as

BUG: unable to handle page fault for address: ffffffffc04ef420
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
PGD 5d60e067 P4D 5d60e067 PUD 5d610067 PMD 110197067 PTE 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 3209 Comm: cat Tainted: G        W         5.10.136-19389-g615abc6eb807 #1 02df41ac0b12f3a64f4b34245188d8875bb3bce1
Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.92.0 11/27/2018
RIP: 0010:thermal_zone_get_temp+0x26/0x73
Code: 89 c3 eb d3 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 85 ff 74 50 48 89 fb 48 81 ff 00 f0 ff ff 77 44 48 8b 83 98 03 00 00 <48> 83 78 10 00 74 36 49 89 f6 4c 8d bb d8 03 00 00 4c 89 ff e8 9f
RSP: 0018:ffffb3758138fd38 EFLAGS: 00010287
RAX: ffffffffc04ef410 RBX: ffff98f14d7fb000 RCX: 0000000000000000
RDX: ffff98f17cf90000 RSI: ffffb3758138fd64 RDI: ffff98f14d7fb000
RBP: ffffb3758138fd50 R08: 0000000000001000 R09: ffff98f17cf90000
R10: 0000000000000000 R11: ffffffff8dacad28 R12: 0000000000001000
R13: ffff98f1793a7d80 R14: ffff98f143231708 R15: ffff98f14d7fb018
FS:  00007ec166097800(0000) GS:ffff98f1bbd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc04ef420 CR3: 000000010ee9a000 CR4: 00000000003506e0
Call Trace:
 temp_show+0x31/0x68
 dev_attr_show+0x1d/0x4f
 sysfs_kf_seq_show+0x92/0x107
 seq_read_iter+0xf5/0x3f2
 vfs_read+0x205/0x379
 __x64_sys_read+0x7c/0xe2
 do_syscall_64+0x43/0x55
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

if a thermal device is removed while accesses to its device attributes
are ongoing.

The problem is exposed by code in iwl_op_mode_mvm_start(), which registers
a thermal zone device only to unregister it shortly afterwards if an
unrelated failure is encountered while accessing the hardware.

Check if the thermal zone device is registered after acquiring the
thermal zone device mutex to ensure this does not happen.

The code was tested by triggering the failure in iwl_op_mode_mvm_start()
on purpose. Without this patch, the kernel crashes reliably. The crash
is no longer observed after applying this and the preceding patches.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Simplify error handling 

 drivers/thermal/thermal_helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index c65cdce8f856..fca0b23570f9 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -115,7 +115,12 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	int ret;
 
 	mutex_lock(&tz->lock);
-	ret = __thermal_zone_get_temp(tz, temp);
+
+	if (device_is_registered(&tz->device))
+		ret = __thermal_zone_get_temp(tz, temp);
+	else
+		ret = -ENODEV;
+
 	mutex_unlock(&tz->lock);
 
 	return ret;
-- 
2.36.2

