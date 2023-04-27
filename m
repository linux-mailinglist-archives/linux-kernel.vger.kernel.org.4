Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB16F0E43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbjD0WSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjD0WSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:18:08 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20C30EE;
        Thu, 27 Apr 2023 15:18:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a66911f5faso71049525ad.0;
        Thu, 27 Apr 2023 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682633887; x=1685225887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ELp9fgud3UdxJ+O/AE6SN/Ok6X9uyjRmf7Sz0Ap8bU=;
        b=rutWmViHAVTCnPlrOdFrruYI9nWxH/zuvPxIMijiltKm8YZfif8gK1a5xq1WwaOH5n
         cC82n3hxMjk591mM1MXheDJIrz6pg/7YZ+sM2+uljG7FM4v2UFcglWZjs780Ce6OlxK0
         Twla7eFxpx3OzebpqAmJcM89cBFW+klKLuXotR2cGCIvGvykR2r59LWxJhgic/SrsaDG
         Yk0lfnvEs3sQl3KPvPg6JLIsnO6D5UwB1cAKSO5UkBuaF7nCrYJwun++f2wdJGqD4LIP
         CgVynXRWwqPGh8jYpBgCQwWSDvx3Wi96ucJtYaqD61OdkPxCz50BNuz44vB9Tul7OMRm
         tQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633887; x=1685225887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ELp9fgud3UdxJ+O/AE6SN/Ok6X9uyjRmf7Sz0Ap8bU=;
        b=bbkZ+JlDvhgbbBq2zimuk+CwVzbZoxLNTvHCfu2JLR+yoAj1P50V4lha3eu3p1/9/Y
         U/woVqrMVgXqD6mIVY8TOl44Dso3CfZH0Z9i4BvScBeoNm3k6y8ZVtLMQ0mUivm2VyHv
         Hbl3VIGw2gUhyYp7OjN3YurHFyO2qiUrqLZZy7yXNqUMz+GgNddYR3Ml0DmvdpFlMJhP
         Ic0Ocenih0d6xIerpRj+uc0B1Mt+NCxbWoR60QvjURUqJPGpjCumi/6rit+Er08qbjhv
         DU3B4ZEBvY13kNikKoB/sQLgtXr9vVCRrSlMHFN/VvFv0XlgrI2BmnRlVb4O8pGw0mOx
         Ko6w==
X-Gm-Message-State: AC+VfDyAJJ48vAQKgy/TCQDrvZcEdE3CEwy25aCi8q+DY8R3XJs2aNRw
        cK36EVlK5iv37ra0nvtqw/k=
X-Google-Smtp-Source: ACHHUZ7xFhhJ+tYpzUP5m76t79QUtMWC24oLMYDs2179NHFqdIhjg5fMjTUumuDsN45niyKYoN0PbA==
X-Received: by 2002:a17:902:c950:b0:1a9:546c:1593 with SMTP id i16-20020a170902c95000b001a9546c1593mr3199355pla.14.1682633887039;
        Thu, 27 Apr 2023 15:18:07 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b001a661000398sm12022783pll.103.2023.04.27.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:18:06 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>
Subject: [RFC PATCH 3/3] Revert "input: gpio-keys - use device_pm_move_to_tail"
Date:   Thu, 27 Apr 2023 15:16:25 -0700
Message-Id: <20230427221625.116050-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427221625.116050-1-opendmb@gmail.com>
References: <20230427221625.116050-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2569873096f7eb1acf63624e9772d82b23923bf4.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/base/core.c                | 1 -
 drivers/input/keyboard/gpio_keys.c | 2 --
 include/linux/device.h             | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8385df4d9677..6878dfcbf0d6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -428,7 +428,6 @@ void device_pm_move_to_tail(struct device *dev)
 	device_pm_unlock();
 	device_links_read_unlock(idx);
 }
-EXPORT_SYMBOL_GPL(device_pm_move_to_tail);
 
 #define to_devlink(dev)	container_of((dev), struct device_link, link_dev)
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 7a0dcfeb02dc..e5af0a254a3f 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -810,8 +810,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	int i, error;
 	int wakeup = 0;
 
-	device_pm_move_to_tail(dev);
-
 	if (!pdata) {
 		pdata = gpio_keys_get_devtree_pdata(dev);
 		if (IS_ERR(pdata))
diff --git a/include/linux/device.h b/include/linux/device.h
index dad40bd45509..1508e637bb26 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1082,7 +1082,6 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
-void device_pm_move_to_tail(struct device *dev);
 
 extern __printf(3, 4)
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
-- 
2.34.1

