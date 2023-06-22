Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48F973A2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjFVOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFVOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE910DB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687443540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SuhxBXJ6cKLy3QQhzr3pF9dmirmGTLkErjm6gq5Ry2Q=;
        b=c4gAS2MQtoT816lY1MKgmXSoQz1e12GZLhba6uQqhXrGp0IhHY03hTp3ebC2i9NPoP/6j5
        avU/vFAw4Zq4lW860MJdRxR6toNaVUXuqFvLPrO6Yf+xbfj3y1AGzoh4AB4IE7fcNIas+0
        1QORM2kMNfno1NiZi6tCtasfDQtXlJU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-l2w74TeUOHe5d0i6-OH_Lw-1; Thu, 22 Jun 2023 10:18:58 -0400
X-MC-Unique: l2w74TeUOHe5d0i6-OH_Lw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ff2770311dso56548991cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443524; x=1690035524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuhxBXJ6cKLy3QQhzr3pF9dmirmGTLkErjm6gq5Ry2Q=;
        b=O7H0IU+V/CWVsWo31ioZJqpel9gS5lLch+4oak/q+1CJ+gwPG5b1UrpN0pdqFdFAn2
         oTZs0+MpvarihdJHNm63230ht/xIVj9brwo4upslYej1vP6Ex+OMtvN5Mgm/X9xE5WZP
         JjmiMITJ4Bybn+DalDEvY5MBsJDdPHYd7wJ3VJZ+X+/AZU/Of/JcCWfRXGzqUAO+2AxV
         MXXL/AiQbOy8ke80sHt4A5uH2kwVSFPO1XArw5LvUFr5rsHXOwc9t2+1G0sOrFRMVzoC
         bmJ7qoUW6ZYMZrikipV7k35HSdSnWMprH2TVEz3vfHKx7hVyRCndiEH+799GMgbxg8Ke
         3bUQ==
X-Gm-Message-State: AC+VfDzXxlzgdmXuPD6huusZ/zcgMqL7H3LOWneTCPpCpaxGwZxeLWn1
        9GHhZPR/A0POkmBbM/hZqxNFSXwrHE1pRnvIRXRs9jdojfbsUHVC/7MO2Yq7+m9i1Hv6YLVpAg3
        RhfyM4Dm0aLvvn9IZfY8zqEA1
X-Received: by 2002:a05:622a:64b:b0:3fd:ebfa:2c58 with SMTP id a11-20020a05622a064b00b003fdebfa2c58mr17712038qtb.40.1687443524065;
        Thu, 22 Jun 2023 07:18:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ErR1UXiWuEJjQNTo1bUaPkpUj/PlO46WSHTrzVNvEyhspH1DbqNDaLRkaW5S3+07HWXRKZA==
X-Received: by 2002:a05:622a:64b:b0:3fd:ebfa:2c58 with SMTP id a11-20020a05622a064b00b003fdebfa2c58mr17712014qtb.40.1687443523634;
        Thu, 22 Jun 2023 07:18:43 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id d7-20020ac86147000000b003eabcc29132sm3643155qtm.29.2023.06.22.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:18:43 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH v3] selftests/input: introduce a test for the EVIOCGKEY ioctl
Date:   Thu, 22 Jun 2023 17:18:02 +0300
Message-ID: <20230622141802.135723-1-dangel101@gmail.com>
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

This patch introduces a specific test case for the EVIOCGKEY ioctl.
The test covers the case where len > maxlen in the
EVIOCGKEY(sizeof(keystate)), keystate) ioctl.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
Changes in v3:
- Edited commit's subject and description
- Renamed variable rep_values to keystate
- Added argument to selftest_uinput_create_device()
- Removed memset

Changes in v2:
- Added following note about the patch's dependency

This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/
 tools/testing/selftests/input/evioc-test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..e0f69459f504 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,21 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocgkey_get_global_key_state)
+{
+	struct selftest_uinput *uidev;
+	int keystate = 0;
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	/* ioctl to create the scenario where len > maxlen in bits_to_user() */
+	rc = ioctl(uidev->evdev_fd, EVIOCGKEY(0), keystate);
+	ASSERT_EQ(0, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

