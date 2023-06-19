Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE77734D71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjFSIUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:20:27 -0400
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF07E50;
        Mon, 19 Jun 2023 01:20:21 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.129])
        by APP-05 (Coremail) with SMTP id zQCowAD3_7vUDZBkfYFsAQ--.5512S2;
        Mon, 19 Jun 2023 16:12:04 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     dwlsalmeida@gmail.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH 1/2] media: vidtv: psi: Add check for kstrdup
Date:   Mon, 19 Jun 2023 16:12:01 +0800
Message-Id: <20230619081202.25283-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAD3_7vUDZBkfYFsAQ--.5512S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry7ury8Zw4xCr1rZw4fKrg_yoW5CF1Upa
        yrW3Z0yrWIgr4Yga15Jw1kZFy5Can7tF4rCry2qw13Z34fur45KF17A3WY9rs5A34Svr4a
        vFW5tw13Wry5JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMKZJUUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.

Fixes: 7a7899f6f58e ("media: vidtv: psi: Implement an Event Information Table (EIT)")
Fixes: c2f78f0cb294 ("media: vidtv: psi: add a Network Information Table (NIT)")
Fixes: f90cf6079bf6 ("media: vidtv: add a bridge driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/media/test-drivers/vidtv/vidtv_psi.c | 45 +++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index ce0b7a6e92dc..2a51c898c11e 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -301,16 +301,29 @@ struct vidtv_psi_desc_service *vidtv_psi_service_desc_init(struct vidtv_psi_desc
 
 	desc->service_name_len = service_name_len;
 
-	if (service_name && service_name_len)
+	if (service_name && service_name_len) {
 		desc->service_name = kstrdup(service_name, GFP_KERNEL);
+		if (!desc->service_name)
+			goto free_desc;
+	}
 
 	desc->provider_name_len = provider_name_len;
 
-	if (provider_name && provider_name_len)
+	if (provider_name && provider_name_len) {
 		desc->provider_name = kstrdup(provider_name, GFP_KERNEL);
+		if (!desc->provider_name)
+			goto free_desc_service_name;
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
+
+free_desc_service_name:
+	if (service_name && service_name_len)
+		kfree(desc->service_name);
+free_desc:
+	kfree(desc);
+	return NULL;
 }
 
 struct vidtv_psi_desc_registration
@@ -355,8 +368,13 @@ struct vidtv_psi_desc_network_name
 
 	desc->length = network_name_len;
 
-	if (network_name && network_name_len)
+	if (network_name && network_name_len) {
 		desc->network_name = kstrdup(network_name, GFP_KERNEL);
+		if (!desc->network_name) {
+			kfree(desc);
+			return NULL;
+		}
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
@@ -442,15 +460,32 @@ struct vidtv_psi_desc_short_event
 		iso_language_code = "eng";
 
 	desc->iso_language_code = kstrdup(iso_language_code, GFP_KERNEL);
+	if (!desc->iso_language_code)
+		goto free_desc;
 
-	if (event_name && event_name_len)
+	if (event_name && event_name_len) {
 		desc->event_name = kstrdup(event_name, GFP_KERNEL);
+		if (!desc->event_name)
+			goto free_desc_language_code;
+	}
 
-	if (text && text_len)
+	if (text && text_len) {
 		desc->text = kstrdup(text, GFP_KERNEL);
+		if (!desc->text)
+			goto free_desc_event_name;
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
+
+free_desc_event_name:
+	if (event_name && event_name_len)
+		kfree(desc->event_name);
+free_desc_language_code:
+	kfree(desc->iso_language_code);
+free_desc:
+	kfree(desc);
+	return NULL;
 }
 
 struct vidtv_psi_desc *vidtv_psi_desc_clone(struct vidtv_psi_desc *desc)
-- 
2.25.1

