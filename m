Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC78745722
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjGCITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjGCITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1568991
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688372302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/pmTH7QHH1n+Sr1Aseof4xJ1nlp+d2SsSN19KkPk+1k=;
        b=KXZUkkrgNENM1pnEAKgHQtWEUwxtZ+pBvlQuEO2DUyrJsCz0qgYMrivDssLkvrLKsRXNns
        +zz/C1rDXELrkGhEbl90wTTYMxWh6a66tCfmYlCi/EH17EdGjgcJtbRe+06k2WO96ZMnrY
        EEUN4PuXU4GeZZLiZNASW7b2ERAjlxA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-wDny9CQ0OESk1g726H3YNg-1; Mon, 03 Jul 2023 04:18:21 -0400
X-MC-Unique: wDny9CQ0OESk1g726H3YNg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7675581a4afso261630085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372300; x=1690964300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pmTH7QHH1n+Sr1Aseof4xJ1nlp+d2SsSN19KkPk+1k=;
        b=KHNOxyMWRKGva0Xwb8Fvqf/6bpdCmjnIYc/d4Hg39uBywsKRHnvgbalu7aCc1zIAli
         wly4dfD7fS9Bch2i6zp6aCVyvrxf8RrDYcQNnczzZ5rzRYA1t7wMT6y+RAgShHEYUoxz
         HNQjho8wwvJb33tfMacXrn6jInQBk3CtFg/juM1roZl+06j3lL5E2knEKPtxgf6M200a
         HGWMuvw64a9YCp4XSwSURzb8P7TBSLDWdrTn6zEfggAmuvoX+mC0Kl6UqNb85lRsRZWI
         slbJpUzD7ATabG1Lx7HQ4637gFyBiVMjOmgS57qeWUzTu1OfMniImkTbeBxl77Yu4sJ8
         1ulQ==
X-Gm-Message-State: AC+VfDy95sFwzadC49igXB8LYMzdMrzugyd50jhfEbAgsZ71XZNLnkAO
        83F7mNUDc0iY/dINnR6/Au3kywvccYCfhGnnvX+/KvpE0hq4G+hIAkqP4XBV9ATM4Mq2Eq5IAHi
        ctmBUQcJqXVcgBucGV0/5bwtMy2DAuC3F
X-Received: by 2002:ac8:5b0f:0:b0:3ff:2fa1:e725 with SMTP id m15-20020ac85b0f000000b003ff2fa1e725mr11276828qtw.0.1688372300552;
        Mon, 03 Jul 2023 01:18:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RTSEK4+Ecg/Cn1QgPkNUHsMhLiMif8GJbqZHZHROrpi4mF85x3CsfC5hkvyJdPFBYNSfKqA==
X-Received: by 2002:ac8:5b0f:0:b0:3ff:2fa1:e725 with SMTP id m15-20020ac85b0f000000b003ff2fa1e725mr11276812qtw.0.1688372300262;
        Mon, 03 Jul 2023 01:18:20 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:4b84:700:e5a3:9a79:b307:264a])
        by smtp.gmail.com with ESMTPSA id v9-20020ac83d89000000b004035cf1cc1asm1024966qtf.41.2023.07.03.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:18:19 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, usama.anjum@collabora.com, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH] selftests/input: add tests for the EVIOCSCLOCKID ioctl
Date:   Mon,  3 Jul 2023 11:18:01 +0300
Message-ID: <20230703081801.900093-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces tests for the EVIOCSCLOCKID ioctl, for full
coverage of the different clkids

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..81d5336d93ac 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,36 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsclockid_set_clockid)
+{
+	struct selftest_uinput *uidev;
+	int clkid = 0;
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	// case CLOCK_REALTIME
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	// case CLOCK_MONOTONIC
+	clkid = 1;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	// case CLOCK_BOOTTIME
+	clkid = 7;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	// case default
+	clkid = -1;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(-1, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

