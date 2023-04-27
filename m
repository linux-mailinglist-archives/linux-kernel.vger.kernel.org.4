Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711686F0E42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbjD0WSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344058AbjD0WSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:18:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18483584;
        Thu, 27 Apr 2023 15:18:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso8828709a12.1;
        Thu, 27 Apr 2023 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682633883; x=1685225883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es1k5EjqLrEC+NljuMDyo0wk9bQclI6Hf3tCC6xmdYE=;
        b=cFuXRwsZ34marh8kZZRpUTpL2f+2CNidWexMSC05HsB5LNA2k7PcxL0TI81mPuE96y
         E1uYQysxlmBglOt3Uddn3IURTYpY/3yBNAfPKDoKQrp0cnA3VFxOTNosvKsEPM4DmdSa
         wMJcheix1fLAy0dSipLDPw5su9sBEBl7T7knR6IFsUQapa784f29M9Gb/ffMocYx8rZs
         VeVyJk6N7plQEZDyvRjJK/XvrD86rd2NY68r4xc/jcP7UwNkPNAZF+yApaRVaRDFP7xF
         jaRPyCd23uHhd1AmCkiJXjsySb3Z9F5Py6164HvofmlUKnKOtyrnLVld+D1lT+AANiEo
         1j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633883; x=1685225883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es1k5EjqLrEC+NljuMDyo0wk9bQclI6Hf3tCC6xmdYE=;
        b=bS/dFTSofMrad1VfGJMaIBV0IhwtiZQBQm05EOI0gqY9HtHxBYKE/3X/cT0oiDDFM6
         FbyMDdLUBDORWTvW+paYNLzmr1J98wFVsILRkFHIbTBdK+CWnTtJ4h1Ro984++EfJkwz
         hXHXVJm8n2RgXj8cKs8nxatY4nwNJ0OWNgofo3trID3hA3JU8/VkpChMNJruJUsIgSKa
         MmpS2N//EvKaS/XgmMLHzarROBAyo+nRmTfD6F9EUguwvwWFM4no/yKY2BCvwyudiQuF
         e3plVLrSkB6vTHH88K2cuAFGiODrm05Yua5Dqf3MEcIJrlqeFY/FJbAATzaF4qYMckwN
         iAZg==
X-Gm-Message-State: AC+VfDxh2TpY/7tLmk81ijHKpWbWYIyW9bkQliO4As4EjvY+EntRKrC0
        AO6NrGdzygeL4TSw9K3uREc=
X-Google-Smtp-Source: ACHHUZ6NB0tgFcr/spIeSsOD2gaUVO3Th0HUJs0gVc+aQhdtyCOthMe0ePblA7hhYlPSy9U+26bw+A==
X-Received: by 2002:a17:902:f790:b0:1a6:d15f:3ce1 with SMTP id q16-20020a170902f79000b001a6d15f3ce1mr3038657pln.34.1682633883167;
        Thu, 27 Apr 2023 15:18:03 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b001a661000398sm12022783pll.103.2023.04.27.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:18:02 -0700 (PDT)
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
Subject: [RFC PATCH 1/3] input: gpio-keys - use device_pm_move_to_tail
Date:   Thu, 27 Apr 2023 15:16:23 -0700
Message-Id: <20230427221625.116050-2-opendmb@gmail.com>
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

The gpio-keys device driver implements the functionality of its
child nodes which do not receive dedicated drivers. This means
it should inherit the dependencies of these child nodes and
their effects on suspend/resume and shutdown order.

This commit exposes the device_pm_move_to_tail function to
allow the driver to move itself to the end of the lists upon a
successful probe to allow proper sequencing when other methods
are not available.

Fixes: 722e5f2b1eec ("driver core: Partially revert "driver core: correct device's shutdown order"")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/base/core.c                | 1 +
 drivers/input/keyboard/gpio_keys.c | 2 ++
 include/linux/device.h             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6878dfcbf0d6..8385df4d9677 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -428,6 +428,7 @@ void device_pm_move_to_tail(struct device *dev)
 	device_pm_unlock();
 	device_links_read_unlock(idx);
 }
+EXPORT_SYMBOL_GPL(device_pm_move_to_tail);
 
 #define to_devlink(dev)	container_of((dev), struct device_link, link_dev)
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index c42f86ad0766..0516c6279d8a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -810,6 +810,8 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	int i, error;
 	int wakeup = 0;
 
+	device_pm_move_to_tail(dev);
+
 	if (!pdata) {
 		pdata = gpio_keys_get_devtree_pdata(dev);
 		if (IS_ERR(pdata))
diff --git a/include/linux/device.h b/include/linux/device.h
index 1508e637bb26..dad40bd45509 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1082,6 +1082,7 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
+void device_pm_move_to_tail(struct device *dev);
 
 extern __printf(3, 4)
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
-- 
2.34.1

