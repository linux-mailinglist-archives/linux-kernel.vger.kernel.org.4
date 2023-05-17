Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31CF706D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEQPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjEQPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F865139
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684337922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sFSW/rJ7fDDjIxttxVeMCJF/ndkubr2uTYnxxErUO0w=;
        b=anEOrWnkfZL3I/zFP/ZDJe7hUo+N7ViaLXligDAs+ctHP1Hn0O6+nrhlHluW0RU+xM/DkK
        MKZHIR+Blji0t7Pf0hmU51aTvbfPeoT7+N3H8jM7jlVLM9AEChD29DY9sTM2zwKIF8VvNB
        5aLjWNhUbwedaZwoYCnMn6Y+9MldqDU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-dJPKZRvFNnCP9D2_rxpVGg-1; Wed, 17 May 2023 11:38:40 -0400
X-MC-Unique: dJPKZRvFNnCP9D2_rxpVGg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3093cb05431so656512f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684337920; x=1686929920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFSW/rJ7fDDjIxttxVeMCJF/ndkubr2uTYnxxErUO0w=;
        b=gWEkgVXlka1po5CSH+/BPIgVxxCZvMr4IlCxtciCvDWPJE711xcpFQTFgN8dLs8noA
         2lsfs1jXZ6pQADcxdo3Yavchs75yFdLNLL0g3VIlFubbNbcLptXV57I6NnJYLBHbb1Jw
         YW+0Ek5e+csM99YWfwA8JFtAvnhzwOHaPOUVTvec0r/qYMV/EiFKzTufW1UiKBatZ/Tu
         CrE7oIJkIJv/MZo6U5DycRhGx0wThZb1jMarB32XqlGPcEIZ9Ew+f3ocQU1KZtmUMXRi
         EtSWlpNqEUhqBoDOVZdaFfzYK119Fnu8lKx6poRorjCi3U0853cGjQr+kuyPA1WAXFWT
         O+Zg==
X-Gm-Message-State: AC+VfDwZzW9AlhlDw5bAdKsAZrnX6vbYlhglFV0uvJRbj5yefcU7L5w+
        Nco0ZHWQXts6zyjtS0bI7TE1ODCOvPEVTB+oHuFoZWoDZxFUHVbl56cM4ieL4YeD/0DyPNULfnA
        EUiYzwPGIHcNkcvMvMkFkiR8I
X-Received: by 2002:a5d:518d:0:b0:309:45d1:2ba with SMTP id k13-20020a5d518d000000b0030945d102bamr515973wrv.2.1684337919739;
        Wed, 17 May 2023 08:38:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72kMduV/zRb5lHqkK+uD7n8X6t7t99R9wTv7bK6vkhcSq9Fc3pPC+d+KG2ax9LovKx2PVOqg==
X-Received: by 2002:a5d:518d:0:b0:309:45d1:2ba with SMTP id k13-20020a5d518d000000b0030945d102bamr515957wrv.2.1684337919400;
        Wed, 17 May 2023 08:38:39 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id k6-20020a056000004600b003077a19cf75sm3129052wrx.60.2023.05.17.08.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:38:38 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     eballetb@redhat.com, dmitry.torokhov@gmail.com, javierm@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH v2] Input: tests: add test to cover all input_grab_device() function
Date:   Wed, 17 May 2023 18:31:45 +0300
Message-Id: <20230517153145.513095-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently input_grab_device() isn't covered by any tests
Thus, adding a test to cover the cases:
1. The device is grabbed successfully
2. Trying to grab a device that is already grabbed by another input
   handle

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Use input_put_device() to decrement the refcount increased by get().
- Remove unnecessary struct input_handle test_handle variable.

 drivers/input/tests/input_test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index 25bbf51b5c87..cea0167a74d2 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -124,10 +124,33 @@ static void input_test_match_device_id(struct kunit *test)
 	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
 }
 
+static void input_test_grab(struct kunit *test)
+{
+	struct input_dev *input_dev = test->priv;
+	struct input_handler handler;
+	struct input_handle handle;
+	struct input_device_id id;
+	int res;
+
+	handler.name = "handler";
+	handler.id_table = &id;
+
+	handle.dev = input_get_device(input_dev);
+	handle.name = dev_name(&input_dev->dev);
+	handle.handler = &handler;
+	res = input_grab_device(&handle);
+	KUNIT_ASSERT_TRUE(test, input_grab_device(&handle));
+
+	res = input_grab_device(&handle);
+	KUNIT_ASSERT_EQ(test, res, -EBUSY);
+	input_put_device(input_dev);
+}
+
 static struct kunit_case input_tests[] = {
 	KUNIT_CASE(input_test_polling),
 	KUNIT_CASE(input_test_timestamp),
 	KUNIT_CASE(input_test_match_device_id),
+	KUNIT_CASE(input_test_grab),
 	{ /* sentinel */ }
 };
 
-- 
2.40.1

