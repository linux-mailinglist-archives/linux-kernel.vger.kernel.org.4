Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871C267A379
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjAXT6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAXT6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531F6EBB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674590270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Czuty/IXmZh0Ej+a6tXx+TzxJZ0sK5TjGVX3sprTlhc=;
        b=GG1evi+N8vsJACv64rzq/Sp2qufqfRfe2SPG1zL2DnfCSlgzgV6j61mwQY6eQPlSVKPv2q
        ExkFAAhTe61cFF+t7MdrvBpsoQ0FiOjkNk5NKftnCVdQwttUVomHRTKtHYi1Su/4g5kja7
        Bim1gTTSMx1fOdyqLqkI0nrjYTSTndI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-VG0pHfNIMjafxwdro8O_qg-1; Tue, 24 Jan 2023 14:57:49 -0500
X-MC-Unique: VG0pHfNIMjafxwdro8O_qg-1
Received: by mail-qt1-f199.google.com with SMTP id ay18-20020a05622a229200b003b69411516cso5785782qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Czuty/IXmZh0Ej+a6tXx+TzxJZ0sK5TjGVX3sprTlhc=;
        b=XFCbT/jAkVt/U6Dv90mDVFiwMLx8/dLyS3bEe3mdHqXtVL1SclMgKempykMdwWLtZt
         a2ZTjkIpalOmk8snyUF5OQDJunwAvte8AhpJdD9Bip/yxOY8arGrxmHVgEqreLTg4LpU
         3digGhXmi+fhjvEhjetNbrdDpSl3sN1B25As58HyVgRbg42XGjOZz4sYYifXwqkVmeao
         vWUcYTrIecNQ2PmHgrYDoukrSJxv9rHDOI+FVx446tGxZZfQ+Kguo89oLQf4rX2RxNpN
         5a7Av/x8F9p32EGt64uBzu9Woe4SQKNHd7XM+74tSgmROsvkSjPyMQ0sn4pqu6B8FXE3
         ob9w==
X-Gm-Message-State: AO0yUKVdcsg3xkcsyrwHM2nNPMkrd53rSR2k/7Xb8ycrISB27ePbIMvI
        RUr2szfJhsW8JGLMoqWOPEv/Dz/FToJs/MJ95SJKToTx0Oj92BG7cxhajNAbjsLOv05ulDJX1T+
        dmjf18znEHx6DArffYtTKIkxU
X-Received: by 2002:a05:6214:459b:b0:537:6e23:f350 with SMTP id op27-20020a056214459b00b005376e23f350mr3160690qvb.31.1674590268595;
        Tue, 24 Jan 2023 11:57:48 -0800 (PST)
X-Google-Smtp-Source: AK7set9kKYBDFdSjmr+lGrxgWaKhFEYSXIS1MBxhMFZ/vCcevsONki7kxiyHr9fwQS2F+JNHi11TBg==
X-Received: by 2002:a05:6214:459b:b0:537:6e23:f350 with SMTP id op27-20020a056214459b00b005376e23f350mr3160672qvb.31.1674590268414;
        Tue, 24 Jan 2023 11:57:48 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c38-20020a05620a26a600b006ea7f9d8644sm2012405qkp.96.2023.01.24.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:57:48 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     jic23@kernel.org, lars@metafoo.de, andrea.merello@iit.it
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: imu: fix spdx format
Date:   Tue, 24 Jan 2023 11:43:01 -0800
Message-Id: <20230124194301.656518-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch reports
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
FILE: drivers/iio/imu/bno055/bno055_ser_trace.c:1:
+//SPDX-License-Identifier: GPL-2.0

Add a space

Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/imu/bno055/bno055_ser_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055_ser_trace.c b/drivers/iio/imu/bno055/bno055_ser_trace.c
index 48397b66daef..ab564186d19c 100644
--- a/drivers/iio/imu/bno055/bno055_ser_trace.c
+++ b/drivers/iio/imu/bno055/bno055_ser_trace.c
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 
 /*
  * bno055_ser Trace Support
-- 
2.26.3

