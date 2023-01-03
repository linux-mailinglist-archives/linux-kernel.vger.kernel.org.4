Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9450265BE90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbjACLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjACLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:01:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A8B84
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:01:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk9so72647319ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=pVSDtU7olXhlILdRW39EpiEJBIjwXVR1HyfxicCBJXA=;
        b=jQI6cuA9L7qCnerstCMQGG118OwE+62frT9w34GiJ90I7hHoKM5pC6R9blce01Mg+P
         pIy5YEssGXySRxqu9m/IBcKfqGzycAd+QyIn6oNASBnDTtGeLOKAc/IR2Qcc7vIrRn79
         Jzh4g4EDPdvsExf/Q+H0zAFxH8tMsQz2HEoRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVSDtU7olXhlILdRW39EpiEJBIjwXVR1HyfxicCBJXA=;
        b=yqlPApt5WHvDE4IfUlawIu/BzGzwJzCrC1YCdbNVhWWTb60NPMVdKQHdmyhAvgKBdV
         g2eukJKaOb5SHXpKh0XvXQgpgnFIiQZZq8GNV3MabVoIKO/TDOxazm6hgA2e7oKuAYI9
         oID7FbUZaKIYwkQS2wRHUM8iP5Rds3eDNvxVNxVmcGzJceafdwf6iAhZGrFdHxVt5KYP
         a9yIoriog+55tj5pgsq+bNUbHICz2RwfP9ZgKLsU9ZV9Hy/ylebkJoQIyTXl3X2iXC1b
         Z5u3Ml7VZeMRNzoHutDpZdMh7HhvYUDckHP8ZLP6g1H7whhQ6W+TzxZDv549VMFGrCwq
         +fcQ==
X-Gm-Message-State: AFqh2kpT0bi7YWIi5KcSbhVLbfSamu11jhjAAnqJKk8HJmDIf49J2zMY
        BRjXEq0DpiTnvv2v3sisx/DehTNo+SjuU2akavU=
X-Google-Smtp-Source: AMrXdXvxsuHAkIifWrLekTL0gcNmQ5SuhULbkHRs7c/Rv4XlA8AAKGNGKqh0EnMwzbJ9Gn3Y78MS4A==
X-Received: by 2002:a17:907:b686:b0:7c1:7c3a:ffba with SMTP id vm6-20020a170907b68600b007c17c3affbamr42763636ejc.35.1672743713414;
        Tue, 03 Jan 2023 03:01:53 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef23:1430:9acc:b68])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090615cc00b007c0cd272a06sm13944331ejd.225.2023.01.03.03.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 03:01:53 -0800 (PST)
Subject: [PATCH v3 0/3] media: uvcvideo: Limit Power Line Control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAALtGMC/3WNywqDMBBFf0Wybkpmoql21f8oXeRpAmogqYKI/9
 60u75Ww73cc2Yj2aZgMzlXG0l2CTnEqQR+qIj2cuotDaZkggwRgAG1Mq9ajrR1IFXTtQrQkbJWMl
 uqkpy0L/tpHoZS+pDvMa0v+wLlXL9FC1BGucMa0XLkxl20T3EM83iMqX+qfyMnMKJmXSe4ke/IrT
 AL/vmGBW26RtRQS8Fa/YHu+/4AtSFskBQBAAA=
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 12:01:20 +0100
Message-Id: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=sML02cle1nMarXtXIOsKRVwDVFx3dvEdPkPGJTKYfsQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtAsBue97dn5WQjp/JY9waSbr1wldWFgr+6XGy493
 bWNJ7bqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7QLAQAKCRDRN9E+zzrEiPPGD/
 9+iYTGBndOHU/pcS2VNysgEf5lZYxuukvUVL8AWAWncFphPqiFrj+wckmUQqCjJjyszOUgtyTnvjec
 xPlH8LbClNA7MArXVbap6J6NYw4/A0LWzLF1fM2/gRxs6nsAUKTt8qjwTm6TO9Qhs16XKip2hLQtgr
 rkCYAQtjNkXeXEKzcGwXrW/R6r0R7ghSMnxZ8eWQPCdRdWfG0uUqM6m2nasJMT7T7MnNsSwSWkOIQX
 EeUPc9ICBSwLIX4wKAQIs+hiIsC4mxovhtMYoI4MA0Vp6xX6GiC66/20d1gXD+u5xOTU4zoxb4Y9i8
 8EGuBRC38VLJS/8j3kXSI19RK+CIjIPwP1gW+Y0n98uXmZCJ5EwdjVcHhBQaeZLpnNo1ZOu0PZfNu0
 xnb5mTaTN/BPUr7dDt5J7+t+GMWMiwH/viTAeGPbpjxp+1jUWmpwlk/5oNfdv4vcEjArlUeenZ5K7v
 QU1YKSdgNaIAkaeOnQendLUSFN8aUfprLD2dy/JgDtnxxRR2/SuzwQN6Zn6nkSR3tZSComv9PQ68Cw
 ljYRzEceRimwlVDTosCX3eFXIVks457YF7KSyYTfTRqC2ZFz9LLQw2x74iO9g9RkZl9mF29AH/knRr
 eHipW6Yfx6N64wrYJ2kaf/O38Jqx/hKaxzpKVwnJ1pSBmYY+h4JY77X3Deow==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another set of webcams with invalid PLC controls.

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v3:
- Add patch to refactor uvc_ctrl_power_line_mapping_limited. (Can be ignored)
- Improve commit message. (Thanks Laurent!)
- Reference uvc_ctrl_power_line_mapping_uvc11 from uvc_ctrl.c (Thanks Laurent!)
- Link to v2: https://lore.kernel.org/r/20221101-easycam-v2-0-5956414a608c@chromium.org

Changes in v2:
- Add Lenovo Integrated Camera
- Link to v1: https://lore.kernel.org/r/20221101-easycam-v1-0-71d6409963da@chromium.org

---
Ricardo Ribalda (3):
      media: uvcvideo: Limit power line control for Acer EasyCamera
      media: uvcvideo: Fix power line control for Lenovo Integrated Camera
      media: uvcvideo: Refactor power_line_frequency_controls_limited

 drivers/media/usb/uvc/uvc_ctrl.c   | 41 ++++++++++++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_driver.c | 38 +++++++++++++++++++++--------------
 drivers/media/usb/uvc/uvcvideo.h   |  2 ++
 3 files changed, 55 insertions(+), 26 deletions(-)
---
base-commit: 69b41ac87e4a664de78a395ff97166f0b2943210
change-id: 20221101-easycam-8f1ab598b12f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
