Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0816D65697A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiL0KdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0KdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:33:02 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A698313C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:33:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gt4so12877777pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D98c/vE+38IOV8dkMl6n24h07zFnXGt4msyCREFSvMk=;
        b=Nz+IyioWLbwfU1PNxtyPhyXylGuEGNkUo08n/XHz5Y/mzQUa+Y4kMBbeULVfsgsnak
         kVli+BqikiA/yWskFuGCdwfTVtrk4FcgbnClTGWut9Mdy21EiRI7RNFc5QRScf/M6tJg
         ZkpQFSbDc79RDfgSo9hlWslS4SG/T7KOGKCT4iKfDq8TaZLWQC2tHZeiQ3YPgIN2RnCO
         lsty9XGtjoUsB6VnA4Jd0h6bV5mGyHrZUMpteV25FWfqvURFZQT6p0Nm35B1llYzmbvU
         hQpm9BeEz9wT/qL5FxACFTwdyXWfAPijvGzv6FQzB3fdJtZ3RsN7o6J6EWfJ/A/A0XsT
         BM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D98c/vE+38IOV8dkMl6n24h07zFnXGt4msyCREFSvMk=;
        b=ZW8RuwbuTw7M7gYjKjjPASXbDUg4sHxUf/SljgCQhmGeO4j1J0IEXdX+Mj5K7idmWG
         nMdWMTADqVquxxa/GW1l+WuOuEud9nUIcxJaGCgMd2uAXTykxNRGSwNsX0jP8GsmIFEg
         l6cqtn5hBPtO0RxzGStYSAsr9O/hnUzZt+CQ40vUllShUTSL1zUfNxmzBm3F2eJrnMZm
         sTvHOjvhbe+GlUsBqJh98vpjlYHQBGkhvlDzomGhWjh6dChJAzPa170+Q0toprKLC37B
         QxzRIXiEZfxgJ/HoTh4jlQt4QDvBesTKUBDZ4AixYf7nUUYrVgM3gncX0kYf1w0knUTn
         1ZmA==
X-Gm-Message-State: AFqh2kqUogswp9MiabR6Z2/RLowpjV4kUls6dvIzzEM6/hunvUF39Viu
        W+bVaOIGN+vpIFmrSMOzg0Q=
X-Google-Smtp-Source: AMrXdXs0RJ+ro9vjlK+3tOQA2yBQCyx+mgu/6he3YO1ejEqOAovtngRmTyBEil3ah5ILXrKuZbHM+A==
X-Received: by 2002:a17:902:ab4e:b0:186:fb8d:f4d3 with SMTP id ij14-20020a170902ab4e00b00186fb8df4d3mr23528518plb.5.1672137181174;
        Tue, 27 Dec 2022 02:33:01 -0800 (PST)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001926c38cd42sm5573683plb.192.2022.12.27.02.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 02:33:00 -0800 (PST)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     zhangxuezhi1@coolpad.com, stuyoder@gmail.com,
        laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] bus: fsl-mc-bus: convert sysfs snprintf to sysfs_emit
Date:   Tue, 27 Dec 2022 18:32:57 +0800
Message-Id: <20221227103257.1431720-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 774f307844b4..e83d16a54c47 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -201,7 +201,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.25.1

