Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66665B9AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIOM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIOM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:28:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCAE6B177;
        Thu, 15 Sep 2022 05:28:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k10so30090038lfm.4;
        Thu, 15 Sep 2022 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MaGdFnLCpSMA+IJx0Eh6twnrnz2nUrZZyIlOBHr3IkQ=;
        b=PyZwB5Mg1edLnUAenrfBkM7b1fpr6jiWi6M1eIbU4I3YZCWrsgHKHjpMXBml13YUQZ
         V++kXbE9QttgBfXA+K5IY00wtOdckFaH4pteXgjadNRVUFJHs3V8QFTeiQpc9uRbbisg
         vA7RueMfjtgcL9uMBkVma/bPxMLrryQuj2qUiqyOiklGC9JbqA9FueyMdlmGYUBLXSi8
         TjIZKBk2s86xGiCBxdc5KtwERORtMpZ0Br6C0oEgs71AapEJ4HWH+QeMhtNLtVn/GCU9
         YAHDxJiJvRWENDvs1bYZY02mEEjcZq0XB3J0GSWBVIIQexc67TieiFIzaICHDfuO/mZL
         N6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MaGdFnLCpSMA+IJx0Eh6twnrnz2nUrZZyIlOBHr3IkQ=;
        b=KZKz+GGepHy1jJ1CIu/crtbh3Ej8nA6qNXYlJ5KyBkqHiRf45aR0MNTZ1JS3CMPK4y
         ij+hLOLQ4tO0VaWb5zPJ7Kha2h+V1qBjbM+ytCxnQyTGN/x/oalyJx2p8GKsmneELkJY
         dKpNKz8DkUhFL2jELDPEePxy/5dYc3KRxG/zSUrn9csbCRlDP1mIac2Cr+GYQzpP2CyR
         hPm0mH443wXGMuyhO13qhaeOkH7aXlDX/vU/zYeMoBL4zR9ur7LswpIxuj6H/hulCVNY
         M8JjyPLFNhMOyxADBC/YEbNsP+70aqw1tfRr2S1wWESnBOz1H+TImF2En7HtcUoZpPC6
         n2Aw==
X-Gm-Message-State: ACgBeo22TnqnUC9iRd/XryX5TUxEj+dFtDt4PJIeC7lzsK9oaIxgMs0x
        1a9/UMy9q+QklbdF42mDAcI=
X-Google-Smtp-Source: AA6agR4ROe2zc06P1OYRP6kEhNbwvMV7nKzcO0zUuUhrzR1PXkjDH6UBunh1DcR46N19yNmamsETcw==
X-Received: by 2002:a05:6512:39d6:b0:498:f615:df07 with SMTP id k22-20020a05651239d600b00498f615df07mr10111372lfu.387.1663244916434;
        Thu, 15 Sep 2022 05:28:36 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id y26-20020a05651c221a00b0026ad1da0dc3sm3097752ljq.122.2022.09.15.05.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:28:35 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: hid-cmedia: use device managed resources
Date:   Thu, 15 Sep 2022 14:34:22 +0200
Message-Id: <20220915123422.520721-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we do not need to free() any memory in .remove, we can remove
cmhid_remove as well.
hid_device_remove() will call hid_hw_stop() as default .remove function
if no function is specified.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/hid/hid-cmedia.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-cmedia.c b/drivers/hid/hid-cmedia.c
index cab42047bc99..87786a88b119 100644
--- a/drivers/hid/hid-cmedia.c
+++ b/drivers/hid/hid-cmedia.c
@@ -145,11 +145,9 @@ static int cmhid_probe(struct hid_device *hid, const struct hid_device_id *id)
 	int ret;
 	struct cmhid *cm;
 
-	cm = kzalloc(sizeof(struct cmhid), GFP_KERNEL);
-	if (!cm) {
-		ret = -ENOMEM;
-		goto allocfail;
-	}
+	cm = devm_kzalloc(&hid->dev, sizeof(struct cmhid), GFP_KERNEL);
+	if (!cm)
+		return -ENOMEM;
 
 	cm->hid = hid;
 
@@ -159,28 +157,16 @@ static int cmhid_probe(struct hid_device *hid, const struct hid_device_id *id)
 	ret = hid_parse(hid);
 	if (ret) {
 		hid_err(hid, "parse failed\n");
-		goto fail;
+		return ret;
 	}
 
 	ret = hid_hw_start(hid, HID_CONNECT_DEFAULT | HID_CONNECT_HIDDEV_FORCE);
 	if (ret) {
 		hid_err(hid, "hw start failed\n");
-		goto fail;
+		return ret;
 	}
 
 	return 0;
-fail:
-	kfree(cm);
-allocfail:
-	return ret;
-}
-
-static void cmhid_remove(struct hid_device *hid)
-{
-	struct cmhid *cm = hid_get_drvdata(hid);
-
-	hid_hw_stop(hid);
-	kfree(cm);
 }
 
 static const struct hid_device_id cmhid_devices[] = {
@@ -195,7 +181,6 @@ static struct hid_driver cmhid_driver = {
 	.raw_event = cmhid_raw_event,
 	.input_configured = cmhid_input_configured,
 	.probe = cmhid_probe,
-	.remove = cmhid_remove,
 	.input_mapping = cmhid_input_mapping,
 };
 
-- 
2.37.1

