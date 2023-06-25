Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B346D73D0EE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjFYMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91949F0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687696264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Jw7D3cDIPezb5KyTrtfg6zC3lbK4rtQzoMzmA2DE1o=;
        b=N4oAEwINTVeUYTAnBDLmHnckWsPHrUUdohsJHAY0whLp5zRADcfKVnOqusaae427A4XVyu
        3pPyez+y2GEXE8ZMXzc//30viaFgcrK0YLB22CXi44BvYrmMdu8NFkG/LSimjLn6oaMEsx
        1gHFEcf/nRGZJCs9CzzC/xWhv5mn4WQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-gjwXINnZPuKRX0ClEwRERg-1; Sun, 25 Jun 2023 08:31:03 -0400
X-MC-Unique: gjwXINnZPuKRX0ClEwRERg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313c930ee0eso725341f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687696262; x=1690288262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Jw7D3cDIPezb5KyTrtfg6zC3lbK4rtQzoMzmA2DE1o=;
        b=Wt1XHU2tMwwb2O+eio0DZe3LRItGhc74LFBp6ioUznIVS2Z9yskqlKcp/6yPVj70iZ
         cIYcsqiWWEEgCEWhcxmLZabxqOyl/6dlnzIXqFcxEwfhaCk0N6jrzK+KJIoBZ2Zfat9U
         uCwMhxO82DUsH0so44Qh1z2JuuICDIxDcgUxOYShyMj6QMbazt3xLaUWnwzy6gUKUsxU
         PtSkHWI7k3DEtub15SzO5jOTsfXUhg+B4MpssBLnNpjMFT3WEIKBMpXXGy1ZNFaua/gx
         brtYLJ1C26t5LfzkTpL9jENTQfMABELqr05HgLS0eqmc3YyP3ELjb3yC9XPeaw+Y5Zma
         X4xA==
X-Gm-Message-State: AC+VfDyhnkFDDEVSf8N8fPB5YwlDo4vHxD5I9+kKvzVYj+pZBbQAwJEr
        uFTQNX6Um5Wl3MRZ8SZh8o3SWfXvgU9yUvpAXgXbyb5fzzAkzmnYoePsm2Hwj49tz0xAkYqCOVv
        xVAjTBzfo4PU3YW+TbjkvGfSj
X-Received: by 2002:a5d:4bc1:0:b0:30a:ae5b:9e93 with SMTP id l1-20020a5d4bc1000000b0030aae5b9e93mr16944157wrt.11.1687696262144;
        Sun, 25 Jun 2023 05:31:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42ubQM2wG9PKLJJNI76/IVi6hdgCnTu3rml1+kpgQQUDv1VSsAbmGkoJBZxLVQZKeLxlUjvA==
X-Received: by 2002:a5d:4bc1:0:b0:30a:ae5b:9e93 with SMTP id l1-20020a5d4bc1000000b0030aae5b9e93mr16944147wrt.11.1687696261794;
        Sun, 25 Jun 2023 05:31:01 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id hn31-20020a05600ca39f00b003fa745f3264sm4614881wmb.43.2023.06.25.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 05:31:01 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH v2] selftests/input: add tests for the EVIOCSABS ioctl
Date:   Sun, 25 Jun 2023 15:30:37 +0300
Message-ID: <20230625123037.8384-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two tests for the EVIOCSABS ioctl. The first one
checks that the ioctl fails when the EV_ABS bit was not set, and the
second one just checks that the normal workflow for this ioctl
succeeds.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index 4c0c8ebed378..7afd537f0b24 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -279,4 +279,27 @@ TEST(eviocgrep_get_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsabs_set_abs_value_limits)
+{
+	struct selftest_uinput *uidev;
+	struct input_absinfo absinfo;
+	int rc;
+
+	// fail test on dev->absinfo
+	rc = selftest_uinput_create_device(&uidev), -1;
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+	rc = ioctl(uidev->evdev_fd, EVIOCSABS(0), &absinfo);
+	ASSERT_EQ(-1, rc);
+	selftest_uinput_destroy(uidev);
+
+	// ioctl normal flow
+	rc = selftest_uinput_create_device(&uidev, EV_ABS, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+	rc = ioctl(uidev->evdev_fd, EVIOCSABS(0), &absinfo);
+	ASSERT_EQ(0, rc);
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

