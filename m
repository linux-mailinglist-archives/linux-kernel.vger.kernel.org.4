Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17939699112
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBPKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBPKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F46719F25
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676542983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QOwqem5TMYYh4Cx3CrHJhF1Ij/hHutMZXfG8C/L9PEg=;
        b=QMT84Zo9rigvr0HtaKvu3GIQtRJDL1deLTyGWgzfWke3SSGIuvCNd8F2oKWyZ5nPH9q9i9
        pPpfN3Pe2AZDE1aXoetuv9OUyKlUUYrKNHVFg8OlYUBtG3YIaykw5DRmbhXUEOTf2w5U9R
        2fHYSqTNvWEvHJ4H+VjbnRMwLYgf5fU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-WaYvPS9nM8Kt-KjVIVLQ1Q-1; Thu, 16 Feb 2023 05:23:02 -0500
X-MC-Unique: WaYvPS9nM8Kt-KjVIVLQ1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D351885A5A3;
        Thu, 16 Feb 2023 10:23:01 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.195.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8235CC15BA0;
        Thu, 16 Feb 2023 10:23:00 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 16 Feb 2023 11:22:58 +0100
Subject: [PATCH v2] HID: mcp-2221: prevent UAF in delayed work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-wip-mcp2221-v2-1-109f71fd036e@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAEE7mMC/22NQQ6CMBBFr0Jm7RhmtBJceQ/DorSDbQKFtIgaw
 t2trF2+l/z/VkgSvSS4FitEWXzyY8jAhwKM0+Eh6G1m4JJPJZPCl59wMBMzE9ZVbc9ESrpWQV6
 0Ogm2UQfj8iY8+z7LKUrn33vi3mR2Ps1j/OzFhX72//lCSGgrS1bzhbQytyjW6floxgGabdu++
 vx1Q7wAAAA=
To:     Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676542980; l=1566;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=FkBSaRYN7wsSzM/cVpBjXwJ4rzMw6Y0ZZJ1Mr4BH7Y8=;
 b=PPnGovhZwBART4w+ZM1Bh3xeYkWeFpsLwENiNtnGBaQpMHsX3OaOYqJhOSiXPOBDKHC+gC9MA
 FCdr99BxQ/UCGGG94+yUsIixq1jOXwRFgRTZlN4a8HB9ZKCxB8j0V/z
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is plugged/unplugged without giving time for mcp_init_work()
to complete, we might kick in the devm free code path and thus have
unavailable struct mcp_2221 while in delayed work.

Canceling the delayed_work item is enough to solve the issue, because
cancel_delayed_work_sync will prevent the work item to requeue itself.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Similar to Pietro's series, we can see the pattern in hid-mcp2221,
except that this time the ledclass is not involved.

Link: https://lore.kernel.org/linux-input/20230125-hid-unregister-leds-v4-5-7860c5763c38@diag.uniroma1.it/
---
Changes in v2:
- drop the spinlock/boolean
- Link to v1: https://lore.kernel.org/r/20230215-wip-mcp2221-v1-1-d7d1da261a5c@redhat.com
---
 drivers/hid/hid-mcp2221.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e61dd039354b..f74a977cf8f8 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -922,6 +922,9 @@ static void mcp2221_hid_unregister(void *ptr)
 /* This is needed to be sure hid_hw_stop() isn't called twice by the subsystem */
 static void mcp2221_remove(struct hid_device *hdev)
 {
+	struct mcp2221 *mcp = hid_get_drvdata(hdev);
+
+	cancel_delayed_work_sync(&mcp->init_work);
 }
 
 #if IS_REACHABLE(CONFIG_IIO)

---
base-commit: d883fd110dc17308a1506c5bf17e00ce9fe7b2a2
change-id: 20230215-wip-mcp2221-979d4115efb5

Best regards,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

