Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5A73A1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFVNR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjFVNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FB1FF1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687439705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K2ZkiY3h1e+pdydS87wK/l+Se+zZo9jQmPSOziGg2h4=;
        b=GyZ7S/p+GegvV66rTigJXybgyTo+BsIOhUd+2aBdwEVaVPsUmnCQxM2JP2yNCk39hq80Uz
        iUkmyaAbjsw8PmuAdJdftjP7kWV4/MGxLErTdbVZW93qhfpLrQGi8rmLcmG7AzFVz0zIBW
        BcNmXwfFKW2OAR3MYMQNCKIj7sIF8II=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-QGJXQVlzMye0h8XGLSs_ng-1; Thu, 22 Jun 2023 09:15:02 -0400
X-MC-Unique: QGJXQVlzMye0h8XGLSs_ng-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-471cce5f82fso1264057e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687439702; x=1690031702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2ZkiY3h1e+pdydS87wK/l+Se+zZo9jQmPSOziGg2h4=;
        b=FVZqgrpRdTJuV+pjJcSYu3aei0p4+uNHeKsRZFyDgmWX3UOCU32ION2c5lzsqyFnC3
         ZTsroWz/4bRn7Otr9SRF67AHi97Zob2HeN1skS9sjngrWkBkPWnuBP6OVzB7eRV+9ge9
         MSJ+LQLLCGSTHnmgjBzvyGYOnbU2SddTdiyHlV/XtuwPdyDHJg8Ok4SZVHm2zTTG2d6u
         IGtwzsSm3CCrYSddWQeYnGkiIUh381e+Fowh0VYYkt7dirhkVOG/5OVC8rU6GC8GGQwr
         h8xnPFT3W0S/kIqHKsPoPmbW5IJs0U5AFFXdzEuZ7X2OJ6b9TwWR6kTD6BrPzuz7p53v
         ObrA==
X-Gm-Message-State: AC+VfDyzwwZlzNhslTGP1Mjlaoe46Fr/0/hY+fPNJibqtWagIZOoghgd
        aeEnE0saLioeuKEHDDYRYd5o08BUJ5X4DhY+vzw+lxfCQMYjo6WiHsdFquvPb55pZi5NXS5Wrpo
        HtHIPvcVGiJ9ZXjBNbr+4YepY
X-Received: by 2002:a1f:4395:0:b0:471:53e9:376d with SMTP id q143-20020a1f4395000000b0047153e9376dmr4970617vka.4.1687439701750;
        Thu, 22 Jun 2023 06:15:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5W5DxiVuwRx7/IXq3nEY+fcjfbw1GPt92XZe/MPKnssDclCDV9biKYd4cQNHBzgiW8865QqA==
X-Received: by 2002:a1f:4395:0:b0:471:53e9:376d with SMTP id q143-20020a1f4395000000b0047153e9376dmr4970605vka.4.1687439701380;
        Thu, 22 Jun 2023 06:15:01 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a01f600b00763b9b390b1sm2457874qkn.107.2023.06.22.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:15:00 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH] selftests/input: introduce a test for the EVIOCGLED ioctl
Date:   Thu, 22 Jun 2023 16:14:40 +0300
Message-ID: <20230622131440.59859-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a specific test case for the EVIOCGLED ioctl.
The test covers the case where len > maxlen in the
EVIOCGLED(sizeof(all_leds)), all_leds) ioctl.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..2bf1b32ae01a 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,21 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocgled_get_all_leds)
+{
+	struct selftest_uinput *uidev;
+	int leds[2];
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	/* ioctl to set the maxlen = 0 */
+	rc = ioctl(uidev->evdev_fd, EVIOCGLED(0), leds);
+	ASSERT_EQ(0, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

