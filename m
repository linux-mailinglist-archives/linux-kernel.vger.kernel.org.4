Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D87736581
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjFTH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFTH6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0864E12C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687247828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Snds2MMFULbsGTHGwj66Dlo7izMts2DqALhHBNLw5/I=;
        b=I127N8MiUUBs5bUYYSX9W1LkFf2TN7XsxJgrB5jgfI9JhLri1E4Tkz2gZeVedcgTgYIGaK
        9IcpwUXZNbM+rsETVkXVFw9/SKBrMlhRgzqtefzhliiuPDjNH4aUACAkVP6OUYwbWhbHxz
        ma0QijfKAXEjAFebGDkOGM/eQFvLyfs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-VyK14YJGM9KkHwjlXEGjPw-1; Tue, 20 Jun 2023 03:57:03 -0400
X-MC-Unique: VyK14YJGM9KkHwjlXEGjPw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-762577786e1so285827085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247823; x=1689839823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Snds2MMFULbsGTHGwj66Dlo7izMts2DqALhHBNLw5/I=;
        b=gBg/o/IqANz4spAWyCD51wUT88mIe5PyXpv0X/oApXzlBTszo0NSWNUofY2CekKa7u
         9YLSXSwEVp2cdFBkcn1NwT9Va+Uad63RAdUZajDG3Yi+yeAlxobC0opH3Ao3CR7rhaO6
         /JngVFlnEk4e/qcmmWEDLPIMpRXshMbyvz9zLdVc2IKpmr0p8oyetOV7Doyql3sFJe7n
         AY0k7hXGYap2nqXrfvN8sKIcgRj4DXJhYFuahXIUmrf+GevyCvZx3dIVw9cxT0eqY2io
         PO+CAFZuU/fhKXA9VKlYL02G8Talm1fjPKt6295oLVVaglomOPMfJkVTlson3xVwWiEu
         +x9w==
X-Gm-Message-State: AC+VfDxlDNl+eDHnuxNlXzgNDJ4wEkoxzY5h43C2a6XswqzmFOFSeuVK
        sGLNQT+ddvOUXaf9TxwZP8fbTI7nxNKNPkCyJfj7R/Fp3CcJhINcd+T8uTOXaUN3emtMXN6afr8
        tzk2EHqv3Bxt1wPz7SbDptcNH
X-Received: by 2002:a05:620a:9046:b0:763:b08c:1bef with SMTP id rl6-20020a05620a904600b00763b08c1befmr952111qkn.38.1687247823257;
        Tue, 20 Jun 2023 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VAo8FNQed1xNbUum0JLZ9eGLq7EYEo4fRgwrZZyiJngQ4drjXUe0hBNY+LU4ZYAkju0WEUg==
X-Received: by 2002:a05:620a:9046:b0:763:b08c:1bef with SMTP id rl6-20020a05620a904600b00763b08c1befmr952099qkn.38.1687247822950;
        Tue, 20 Jun 2023 00:57:02 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:476e:4300:fe29:2a5c:9188:df81])
        by smtp.gmail.com with ESMTPSA id x25-20020ae9e919000000b00763a23c1f23sm858415qkf.7.2023.06.20.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:57:01 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
X-Google-Original-From: Dana Elfassy <dangel101@gmail.com>
To:     shuah@kernel.org, eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: [PATCH] selftests/input: add test to cover failure on dev->absinfo
Date:   Tue, 20 Jun 2023 10:56:45 +0300
Message-ID: <20230620075645.536827-1-dangel101@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added coverage for the case where !dev->absinfo, and executing the
normal flow as well.

Signed-off-by: Dana Elfassy <dangel101@gmail.com>
---
This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/ 

 tools/testing/selftests/input/evioc-test.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..1a688002e1e7 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -234,4 +234,27 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsabs_set_abs_value_limits)
+{
+	struct selftest_uinput *uidev;
+	struct input_absinfo absinfo;
+	int rc;
+
+	// fail test on dev->absinfo
+	rc = selftest_uinput_create_device(&uidev);
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

