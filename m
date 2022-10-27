Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E6560F80B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiJ0Mwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiJ0Mwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F0080F7B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 230DD6217A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79105C433D7;
        Thu, 27 Oct 2022 12:52:41 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] platform/loongarch: laptop: Adjust resume order for loongson_hotkey_resume()
Date:   Thu, 27 Oct 2022 20:50:47 +0800
Message-Id: <20221027125047.3450683-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops don't support SW_LID, but still have backlight control,
move backlight resuming before SW_LID event handling so as to avoid
backlight mistake due to early return.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/platform/loongarch/loongson-laptop.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index f0166ad5d2c2..0e6f4efe21e5 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -199,6 +199,13 @@ static int loongson_hotkey_resume(struct device *dev)
 	struct key_entry ke;
 	struct backlight_device *bd;
 
+	bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
+	if (bd) {
+		loongson_laptop_backlight_update(bd) ?
+		pr_warn("Loongson_backlight: resume brightness failed") :
+		pr_info("Loongson_backlight: resume brightness %d\n", bd->props.brightness);
+	}
+
 	/*
 	 * Only if the firmware supports SW_LID event model, we can handle the
 	 * event. This is for the consideration of development board without EC.
@@ -228,13 +235,6 @@ static int loongson_hotkey_resume(struct device *dev)
 		}
 	}
 
-	bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
-	if (bd) {
-		loongson_laptop_backlight_update(bd) ?
-		pr_warn("Loongson_backlight: resume brightness failed") :
-		pr_info("Loongson_backlight: resume brightness %d\n", bd->props.brightness);
-	}
-
 	return 0;
 }
 
-- 
2.31.1

