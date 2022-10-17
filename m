Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D68600FED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJQNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJQNJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED97AF5AC;
        Mon, 17 Oct 2022 06:09:18 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id g10so12001857oif.10;
        Mon, 17 Oct 2022 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFT2bMEFQh2yF9QQTbmTtz9HkQZeU5AhJSQdSV4KX2k=;
        b=IFPC22K6m4tJHLjYDOFeFSue5qG2Yhz81ayq2GsU1/rLnZ0K6mu+Ngjx0JleNXoxf/
         5ugvYTPouTSq+cOgDmKAVVOiDS+TGmoLX7vLgsQjVMXgSn9rKwp+FbMb/TX/ILrA9SJG
         ZeN5NbzZTMFRzCCT514W+R9Jw8MnVmJhMi7ZSDyAJQueptsBSPW9Y9n76qXOVNP5DL9k
         nTRYI36ym/TIqv9YXDK1Y5Nay420OoNzpXpg3vjcSGSaLn5oE8pee9xKFlxYcCrbRMsW
         84kCerpqlCYQorji22Md1Eo2z46zJZcozgeExFFFaNHc91+3fn4SyGvAgVF5aMzasLw5
         2Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFT2bMEFQh2yF9QQTbmTtz9HkQZeU5AhJSQdSV4KX2k=;
        b=eml99viomPyjXUl2l9cZRgRDB9IY1F6WtfyQOgcErierguBuGzQh5QmkzPPPWpoqR9
         FBgc2l3Z1BBa/LTXMb16PFMvd+ivrxJNNdtvg0LlGSPjzxI14QN1VBrbyPqxx4rRvZa8
         F3Cd4x/DkJ6GYphMS91aRIs7fV01dtCMZDVlmbb03k32p7llu5aeNYrjeyc8bdgn7Ww4
         sRQ60tWnXQXyLfSn76DpMhpFKLpoLHebAt5LkdrzUdFSH6YESIuodxAzTqfm9BKlWJTe
         6zIj3BLA/3iKipoJeETf+2iTqD1sQI5akRN46kMC9SVIr80Yitma1gw9UF1meFYtPg8L
         GhCg==
X-Gm-Message-State: ACrzQf3QUCQTuV8e4pHpYpOVJOtHzV6ER1oVIcqaDyi8myY0mLJT9oeL
        LBEfJQ3a/MH9+hHaMZWfCCY=
X-Google-Smtp-Source: AMsMyM5PBkuWcIRQLpX/c56RRBnN6yNlcdMAlJp9wlSg1PzWJslY073fIbWDHBgS8xM2d8x1lNwSdQ==
X-Received: by 2002:a05:6808:238c:b0:355:1b0b:6cf8 with SMTP id bp12-20020a056808238c00b003551b0b6cf8mr7691993oib.99.1666012158303;
        Mon, 17 Oct 2022 06:09:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q28-20020a056808201c00b003544db0ebfdsm4284689oiw.4.2022.10.17.06.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/9] thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp
Date:   Mon, 17 Oct 2022 06:09:04 -0700
Message-Id: <20221017130910.2307118-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221017130910.2307118-1-linux@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
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
 drivers/thermal/thermal_helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index c65cdce8f856..3bac0b7a4c62 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -115,7 +115,12 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	int ret;
 
 	mutex_lock(&tz->lock);
+	if (!device_is_registered(&tz->device)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 	ret = __thermal_zone_get_temp(tz, temp);
+unlock:
 	mutex_unlock(&tz->lock);
 
 	return ret;
-- 
2.36.2

