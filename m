Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B695B9AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIOM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIOM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:28:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484E29A6B1;
        Thu, 15 Sep 2022 05:28:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j13so7278178ljh.4;
        Thu, 15 Sep 2022 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7MEqmixf7oKJC0TYP9LRoy1+tomU2S+4T4vfCkaGAiw=;
        b=Qjcs6cCczVpc8J9WaDW0ysja/acavYD6qrcAm9NCyri/XhaHw0d/F8mj941jbPm7Hw
         RyeF3V4izLHd0J/SCayUJyg3PwL67p5UeMXlFsOU43AQXeqSNYbdoo/KRqxc+6nB95qW
         Y0wNjV20xHO5FXLIDpoYMpgkuEAeA2drU8ZTwhRzzgw1sfWUPraffY14Qna0azLATynb
         neJI5rvyDPVLBSj52L5D+wXcE5b8/RnS3CMxgZkZPAeYu+YYoCEaWz00NfczCFkerHy/
         gJ6H7bHEImQY9H9xjHJCT9qSvFzAHNTbVNGVxEWqh3aHPk6sR2R5HXU/DN4wWNg8ma+C
         ZWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7MEqmixf7oKJC0TYP9LRoy1+tomU2S+4T4vfCkaGAiw=;
        b=i+SeU2jQtWqLEFNBxLxBK/vpUWOCmUfwzdDWig8jJtpwBeK4ZozEd8hyD3yMkMEYzG
         9BwjC+nj7PY3ps/glQWWp6UE3m38Ny4gS0hFb49BSIxV6K3SU5wnZSM0aRwbapUA0ifE
         LB6czIqK6gB/kPfbyxylfBUZWHZR8Kz6r3Cg3+k2BE5VaIpNUo6jyycbriA18CnbYzFF
         0wo7j2/jZhBe1IzIAnareXOCOzU8Je3wr49Y85HmAxpfWz6F9/92epIslgQb9r792qTi
         KUcB3HMFlfO0pX81scwuLoE5tdvmx3T/L1TwWfhWlef7J09kR7zkrUGT4OmsCozCNOQd
         4xeA==
X-Gm-Message-State: ACgBeo0NqvGAyH8EVNO1M5X7ov2bnMIO7T2FCcQ2F1zCVBGXBzmi13Qr
        KNOUmkQP5vM5aR+SzjO60fI=
X-Google-Smtp-Source: AA6agR5MvnA4AjvtjqfqhPav+vFs+IyJuzuTcxbsELvntfCXgTm3guf+bFAcArAkdzHjiVeeoAwdwA==
X-Received: by 2002:a2e:9799:0:b0:26b:dd3c:7080 with SMTP id y25-20020a2e9799000000b0026bdd3c7080mr11198171lji.297.1663244925122;
        Thu, 15 Sep 2022 05:28:45 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k5-20020a2e9205000000b0026181f65600sm3113713ljg.136.2022.09.15.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:28:44 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: hid-alps: use default remove for hid device
Date:   Thu, 15 Sep 2022 14:34:38 +0200
Message-Id: <20220915123438.520775-1-marcus.folkesson@gmail.com>
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

hid_device_remove() will call hid_hw_stop() as default .remove function
if no function is specified.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/hid/hid-alps.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 2b986d0dbde4..9abaff6f3afb 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -820,11 +820,6 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 }
 
-static void alps_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-}
-
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
@@ -840,7 +835,6 @@ static struct hid_driver alps_driver = {
 	.name = "hid-alps",
 	.id_table		= alps_id,
 	.probe			= alps_probe,
-	.remove			= alps_remove,
 	.raw_event		= alps_raw_event,
 	.input_mapping		= alps_input_mapping,
 	.input_configured	= alps_input_configured,
-- 
2.37.1

