Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62392657313
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiL1GJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1GIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:08:16 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BEAE0B0;
        Tue, 27 Dec 2022 22:06:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x26so3883795pfq.10;
        Tue, 27 Dec 2022 22:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2pU4Ljf/baXLHkKM+0GW9OZ+a+3/dhLhTsDpyWdPkY=;
        b=J4rsImfjSAB9ftOXVUGlyeDy4HhqXCrEuncwIMH47Kkumi18w/3toVyuMb4wHstQe/
         14DqUxdW2vzJeotM9o1RylgZUT71RCJKW6sJ8oMpicYdi5/O76A0QR5tXdVVm83f2qn+
         x6FcogvB8kDygHsitrYqL+eilBiPhsz7K0LTf5V8bPQIkmYJwe7QGceiReDVsM/FtBvu
         Z1c6UAPBEup7ZNFM1K6TZR4LdmUK0ReYH54xAMarW0SgiJFGLNIhSc7Bhvrukk9WRZi4
         cMGRrRxXKwsHM0Ns8ti+DVWw6Hu1QQIO3FVzCUccpqiAsW/EylqSI1XppAcAt9m4/+us
         olcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2pU4Ljf/baXLHkKM+0GW9OZ+a+3/dhLhTsDpyWdPkY=;
        b=yUzx2nM7vR9DiPC6o76nxBizwTICtBEx5pNuVpEnkoh9dbPObUUHG14vh5qGUm80Ci
         Gm5L5HDKfJZ2LXBkrBcqdeRiMccClyfRsYCpAAkxECCfBvqd3BN5v2XHK1+wlljUw6jl
         Ussjujr7VWojox4Q3VWfek8J3+1X1APkvue0fX56PuoKUh0wIk4L5WU42c+NtLvjOG4C
         b9q6DSGoTm27oVrehe0RQrXjO/L4CoisWF0ZDRPCd89M8AhQGpyLcXF4lknuaDQhbKbz
         eDNSx+da7u+zR3u5Dp0Ovs6cOApSHrRrYWd+XH5QQqTlviV60sRGkjkI0N6cojhbGPPX
         r1Rg==
X-Gm-Message-State: AFqh2kpgDOrwkmt12h8hy/oQaQ3tqqpyGhY0/4G6qa3K0TtBJU98qefW
        VqSys807wzNkZjxFDnu+qmY=
X-Google-Smtp-Source: AMrXdXssL+HoU539KBbanMYtFjkMjsC+NRAwSnxjXIyIOsXHMFQfiSMu1K3sxpr04gDr+bBjLPh56w==
X-Received: by 2002:aa7:8209:0:b0:581:3328:b468 with SMTP id k9-20020aa78209000000b005813328b468mr7808000pfi.6.1672207598250;
        Tue, 27 Dec 2022 22:06:38 -0800 (PST)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id w186-20020a6262c3000000b005772f762e43sm9831769pfb.13.2022.12.27.22.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:06:37 -0800 (PST)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     zhangxuezhi1@coolpad.com, erazor_de@users.sourceforge.net,
        jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: roccat: convert sysfs snprintf to sysfs_emit
Date:   Wed, 28 Dec 2022 14:06:33 +0800
Message-Id: <20221228060633.1459256-1-zhangxuezhi3@gmail.com>
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
 drivers/hid/hid-roccat-isku.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index e95d59cd8d07..d356a0ac770c 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -63,7 +63,7 @@ static ssize_t isku_sysfs_show_actual_profile(struct device *dev,
 {
 	struct isku_device *isku =
 			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	return snprintf(buf, PAGE_SIZE, "%d\n", isku->actual_profile);
+	return sysfs_emit(buf, "%d\n", isku->actual_profile);
 }
 
 static ssize_t isku_sysfs_set_actual_profile(struct device *dev,
-- 
2.25.1

