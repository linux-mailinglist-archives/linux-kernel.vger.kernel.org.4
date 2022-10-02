Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA14E5F25D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJBWDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJBWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:03:18 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0152C275FC;
        Sun,  2 Oct 2022 15:03:18 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a20so5508477qtw.10;
        Sun, 02 Oct 2022 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Qg4yyErPUncyCJdQ1nvfpMRxyzrZyv+cJzjP7rwEnbM=;
        b=ak9flzB6kb576roEAB/Tqn1RMvZylEju9CQd9g/lppQGP5pd5OcGDzy7It+HwiyVYG
         uQaTQOkMrLfMOKv+HL53moNArxsm+/uGG0fyCoyO96eln8K8FDHGwxsrx4e/ze2jhT1U
         yZUzcNO4S9aEdEPoIo8rbGETjOzEjT3+PsH5y1iMAf+vb6LvBZRpuaOc9NOyYxoFER46
         JUGKK1fA5yg+MJ72Rf+ALLAfnn44w9MQBki3198Pa0jyxI+ujRlrViQfMUWd4G715jz9
         PIv59a93blxlU3UlGV0uplHbR9kIVJBTdVaGqICzwnAhLTT61kU+U8hJ0NqUTckinYAm
         Cmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Qg4yyErPUncyCJdQ1nvfpMRxyzrZyv+cJzjP7rwEnbM=;
        b=lBa9JT33cOSKPrkyBBVIZf2DB8Jz/tHEOTrGWkGk/A6heQaxhw5ANziE1j2e/b4e/X
         Dl2TDmskb9PfU6u+5wpgqMnxfJkJ3d9insi5VXvUNWfBoJpF05n58rTUWZiqDlrnPb5d
         uCwcqdONkKvk0jGJbP5ewnHoBHxcF7hVlBacBqdDZllOWAUByooyZfJYp3bbtAc+ohxg
         gK7YSbgWUvs9kIVSgegdUoWqvpfHBeq+j4iyx4UlZSA3hQdoDWVT+n2RsjsMGsmBmESa
         UEBQBf0VGrw69ouFEU6zjzIhU0Y8DTEtpxYfg+v/reczrAV67263w5fQwf0+e561tnOz
         dkvA==
X-Gm-Message-State: ACrzQf0fGHD0wbiROZbfaANWtmlCeOUwCWL/AeYcudj6JjkNVLcJmW78
        YsGY21dNSX9JoUSzTDF8m/U=
X-Google-Smtp-Source: AMsMyM4BsmRrwW9N5x8bCcGDiSwjuPVrqNuyGxSqaW0/rrSYx7gCsbYFSNWkUD9kwIuKLHGCxBNN4A==
X-Received: by 2002:ac8:5e12:0:b0:35c:bd2e:9ccd with SMTP id h18-20020ac85e12000000b0035cbd2e9ccdmr14016081qtx.522.1664748197146;
        Sun, 02 Oct 2022 15:03:17 -0700 (PDT)
Received: from localhost.localdomain ([200.87.153.193])
        by smtp.googlemail.com with ESMTPSA id v8-20020a05622a144800b0031eddc83560sm8086669qtx.90.2022.10.02.15.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 15:03:16 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     thunderbird2k@gmail.com
Cc:     Henry Castro <hcvcastro@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers: hid: adjust gyro calibration data
Date:   Sun,  2 Oct 2022 18:03:01 -0400
Message-Id: <20221002220301.18921-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.30.2
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

For some reason my DualShock 4 get the calibration
data values equal:

	gyro_pitch_plus == gyro_pitch_minus

Probably due to some defect in the DS4 hardware, and cause
a CPU division exception to crash the linux kernel.

At least with the patch, I can continue play Retroarch
without using the Gyroscope :)

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---
 drivers/hid/hid-sony.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 87b538656f64..656caa07b25f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1823,6 +1823,15 @@ static int dualshock4_get_calibration_data(struct sony_sc *sc)
 	acc_z_plus       = get_unaligned_le16(&buf[31]);
 	acc_z_minus      = get_unaligned_le16(&buf[33]);
 
+	if (gyro_pitch_plus == gyro_pitch_minus)
+		gyro_pitch_minus *= -1;
+
+	if (gyro_yaw_plus == gyro_yaw_minus)
+		gyro_yaw_minus *= -1;
+
+	if (gyro_roll_plus == gyro_roll_minus)
+		gyro_roll_minus *= -1;
+
 	/* Set gyroscope calibration and normalization parameters.
 	 * Data values will be normalized to 1/DS4_GYRO_RES_PER_DEG_S degree/s.
 	 */
-- 
2.20.1

