Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB6693A63
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 23:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBLWE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 17:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBLWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 17:04:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1196E060
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:04:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bu23so10378513wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u22a5v5o3jT0vNW8efPv3ynkn8H76zJKW0PLjbBhfLs=;
        b=TzLVsDZBWBgb/SR3CX3JayNjW1U06W79VeSnMIFsPH0eWxogdISC3Mpghp1v1+i87X
         Npp5GUACoxWT7rF4VLjehzsMqMQQK2+qJjMsvXQ4ZJSBNfTz5FdAr9XBx8fHcWeQ4cpZ
         j7M23j2dE6JWmfm6Y86xS2TaWJvLz2TM2c03fVdCmPU7VaDSCY1lmNI1uOhkaBJehF6x
         gkOeTmLKBDbmm4GFbmQKBb3En7k+zPjPADfU4d59GNXSOn6X/E9jiWrLJ7TUi8gIDJt8
         ZwiDjDSdzXBQ4wgr+u88Loy5tglL+vMagPCrcrkukosXEfKtzpE1t1b5JtMmvpfaxmTA
         P77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u22a5v5o3jT0vNW8efPv3ynkn8H76zJKW0PLjbBhfLs=;
        b=VDKhmDtyn4K3ppryvtNRUDOOXgb2x4W01vsMFiAoVrlA4LE5NvwYTH/dIwrzYc2ZB4
         KKGnezfHSWblPgqmsNvxMJJPrdqYxfGCdn+Uq61eMn6bAdZNNknC81MQE1SbqW2vmT5q
         J/g3RnMGZeky43/UjDM0xqxLUieAh3NXP4Z3BR8UgqW1sY/ALj/hYOBFi1e3i9SlV11v
         XRbbDUfumn3WLmKfQQ/5z6CuvENrmq3JI1ftTEcVuKzEb2l+YYcjk5Mk9t5wnAe/fMU6
         lwKAHo0ONaQzhe9qeC4vbAEc3g2RyqIfDHbzoJN6CHk9biMcDPivyuah0TN8YTOL4Vz2
         IyNg==
X-Gm-Message-State: AO0yUKVXATfr0Bh3cDOy7aI72YB8mD8c3qf0535qnjEGeMbCIoXcreoF
        2nmC6JEOc1a2hNcpj3mJGGY8ZYLqXkrKKQ==
X-Google-Smtp-Source: AK7set/9uoYp9n6DS7AV7tmAltFizY4S7pg3bgjl6MoqSudoKgLQsOVvetPiJ8T+c1VzWjO/Nk6oOg==
X-Received: by 2002:a5d:6e8d:0:b0:2c5:4c5e:412b with SMTP id k13-20020a5d6e8d000000b002c54c5e412bmr5784788wrz.23.1676239485959;
        Sun, 12 Feb 2023 14:04:45 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id i4-20020a05600011c400b002c556f36116sm1882361wrx.66.2023.02.12.14.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 14:04:45 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver: core: Prevent NULL pointer dereference in device name functions
Date:   Sun, 12 Feb 2023 23:04:41 +0100
Message-Id: <20230212220441.258258-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Prevent similar scenarios:

Unable to handle kernel NULL pointer dereference at virtual address 00000038
...
PC is at dev_driver_string+0x0/0x38

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/base/core.c    | 3 +++
 include/linux/device.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..4ff2ddea7c9b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2174,6 +2174,9 @@ const char *dev_driver_string(const struct device *dev)
 {
 	struct device_driver *drv;
 
+	if (!dev)
+		return "<null>";
+
 	/* dev->driver can change to NULL underneath us because of unbinding,
 	 * so be careful about accessing it.  dev->bus and dev->class should
 	 * never change once they are set, so they don't need special care.
diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..ff9e19e6d78c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -696,6 +696,9 @@ static inline bool device_iommu_mapped(struct device *dev)
 
 static inline const char *dev_name(const struct device *dev)
 {
+	if (!dev)
+		return "<null>";
+
 	/* Use the init name until the kobject becomes available */
 	if (dev->init_name)
 		return dev->init_name;
@@ -712,6 +715,8 @@ static inline const char *dev_name(const struct device *dev)
  */
 static inline const char *dev_bus_name(const struct device *dev)
 {
+	if (!dev)
+		return "<null>";
 	return dev->bus ? dev->bus->name : (dev->class ? dev->class->name : "");
 }
 
-- 
2.39.1

