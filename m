Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254F96F0E41
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbjD0WSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344052AbjD0WSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:18:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A452235BD;
        Thu, 27 Apr 2023 15:18:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115e652eeso8320948b3a.0;
        Thu, 27 Apr 2023 15:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682633885; x=1685225885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrgbNBTkkVblpvAn2v9YOOmUXIXg/Fdyqm0l3sunmw8=;
        b=K7EwckKGPdG1c9lc16yhp7Rv4+pouv9SGrkYiLp+rc/pUobLUEA0b1iekkOupx/Kjj
         z8R8rNf2UlV8nrZ01T1h8Po/2qh8fNirp3P3EkQKzF2Yg0mPEjIAQe55S4XzDqoxUDEn
         vR+hUt7KqTOKOB5whmA0I+4DWvwbkhUyOYCEohfFxZ0HVciVB1fF7W58b5IxmlcK0LbP
         nshKB7UHMusdA79/aolgAGmMsraUxU3A9C/ybW8ewegfQ4IhxcmBo1XgSay9pSYiuUsH
         s1YjF8lWSY3jYSf0lL6gSGTVxypSPkKHzwNVp9J7ynxzoUrgrJdieul3WSbxIirdSbHL
         tHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633885; x=1685225885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrgbNBTkkVblpvAn2v9YOOmUXIXg/Fdyqm0l3sunmw8=;
        b=HLu1wtVGXC+3Uv15+aeEauLChZ2tCmIslBOIJnapc74rGCE5YA7cDF3ZLctIJpNrRi
         Z2x7+ge4vgj9JaAFhZdiVLo/7n9UtsHX/+ELyy/VImep3KFJbT9Iq5skRrPSlOvJPoB6
         Xx405ecVY2eVFeGOWMJJeG3n9VdCFo12R/R27LH+Ns+Q322RtftK0wbIQDASU/3P0M+k
         67B2fHjfSKTY0AclDtuX+bPSBbn7oDBHYpXyxK+Zgwnt3+VZh++K81OtVj7T1yYOhvAx
         JUEkxsawDk8XEg5+nxX2jmjDmEasKSIWsbTAZ+zyIVzbuknUptea0m82/knEW9xIAJ9p
         QyEw==
X-Gm-Message-State: AC+VfDxPmZBh92MJAAEV9gJ+7dbvneqO13pBjhJx1DeQbBgF/j91bYfy
        67aE8/V45JfJgksucIhZN5E=
X-Google-Smtp-Source: ACHHUZ5SLrdWKXr6zzoUWHku3g/qBdYWiINb0XUUUhO3tj6ZCbUPTWqVv9TiRaqO4u24BPdtRi8DYA==
X-Received: by 2002:a17:902:d4c7:b0:1a6:dc3b:9ed2 with SMTP id o7-20020a170902d4c700b001a6dc3b9ed2mr4197913plg.13.1682633885089;
        Thu, 27 Apr 2023 15:18:05 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709027b8800b001a661000398sm12022783pll.103.2023.04.27.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:18:04 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] input: gpio-keys - add device links of children
Date:   Thu, 27 Apr 2023 15:16:24 -0700
Message-Id: <20230427221625.116050-3-opendmb@gmail.com>
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

Since the child nodes of gpio-keys are implemented by the
gpio-keys device driver, that driver should explicitly create
the appropriate device links to support proper device power
management and shutdown sequencing.

Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 0516c6279d8a..7a0dcfeb02dc 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -865,6 +865,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		const struct gpio_keys_button *button = &pdata->buttons[i];
+		struct fwnode_link *link;
 
 		if (!dev_get_platdata(dev)) {
 			child = device_get_next_child_node(dev, child);
@@ -882,6 +883,12 @@ static int gpio_keys_probe(struct platform_device *pdev)
 			fwnode_handle_put(child);
 			return error;
 		}
+		if (child) {
+			list_for_each_entry(link, &child->suppliers, c_hook) {
+				device_link_add(dev, link->supplier->dev,
+						DL_FLAG_AUTOREMOVE_CONSUMER);
+			}
+		}
 
 		if (button->wakeup)
 			wakeup = 1;
-- 
2.34.1

