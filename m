Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3CF6DCC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjDJUyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDJUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:53:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE2F2118
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e22so5442694wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160022; x=1683752022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mEz7s6yXlIw25RW3QnKrwFn+iq3xNtUieG1OCq5dPk=;
        b=NlLccR0KaN5Ll/7MrXFcv0iaJaQMvc9Kqagpb1at2P4U852rFGmVf2y2OQE9s2mL5k
         ytRuSnPFYurJpACKpwJOfhDci6BllshkGnz2eDgHc5RwR47dC3sbKK2WmUeKJ6EPqHHJ
         6cHrV9pUVWno3115aq5NNQzMfO4QRmn6Ai03OZtl7HSJ79QuCJPU3zwkRgWA3Zvuqnby
         o3te8dPJz9quPZ3ADWRglYk1/brpRGN272ndnRdq1x2zlK7AcUuZOk5cUXFdx1ykUBOy
         IXI7+P+t+rBBJEmulk3yKZFoj+cOj743k7aEr7D1mOAThuQjfCxiWu3vgT2S4cmZL0Xf
         fcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160022; x=1683752022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mEz7s6yXlIw25RW3QnKrwFn+iq3xNtUieG1OCq5dPk=;
        b=DhnZvHfy5rgYfXw3BdBIumNbcxC8XB/M4L++WaBVoBABirCWBCjDSMOsMZCTR+YLFL
         dzCwrAHSg3ZGbk/Hnzjey+kUx/OgPSYZbYunI7bty/e4k2OlouQ0OObEaXs3bhXFksAi
         6pOj+9IpNCfStCZOfJqBkgDeEJavnghlMkTlU7S4DczTYgufythlS54HUsph5kA8gSTs
         jv9FwIi8fbwW9tsDWdZPxd788TGIPDvt5FC9gzPkeER6pYlKZie6cWUTe7qNVVraLbJ0
         Buk7DqJU73Mf6YPt5laAIvdFd1EJWD397BzdNQ7X6InTkSLbFEMFs1dQPrsBNtkCvg9E
         z0Qw==
X-Gm-Message-State: AAQBX9fnSd7m22bQ1LSWLj1GKsBraK0DfvfSlR+aPmpeK5/YwBraIEbH
        x4DUcWo/FkOhqXg7kIqej+8muA==
X-Google-Smtp-Source: AKy350aNGX6fjxWMXUkHK1m5zFHBH9TADms1ks0RD+DYVYGB/clRzrNGq0INQ7lPmE1ZHchKlEnxNw==
X-Received: by 2002:a5d:6588:0:b0:2d1:53f5:900c with SMTP id q8-20020a5d6588000000b002d153f5900cmr7843051wru.20.1681160021960;
        Mon, 10 Apr 2023 13:53:41 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 5/7] thermal/core: Prepare sanitizing thermal class sysfs content
Date:   Mon, 10 Apr 2023 22:53:03 +0200
Message-Id: <20230410205305.1649678-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers are accessing the thermal zone device structure to create
specific entries in /sys/class/thermal regardless the documentation.

It is questionable as the specific information should be in the
driver's sysfs directory, not the framework it is dealing with.

It has been long time these specific attributes were added in the
thermal sysfs directory and are limited to the ACPI thermal driver and
the Menlon driver.

It is probable those are not really needed, so in order to figure out
if that is the case, let's create a default option disabling the
attribute in order to prepare a definitive removal.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4cd7ab707315..cca4e5cf6f30 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -33,6 +33,18 @@ config THERMAL_STATISTICS
 
 	  If in doubt, say N.
 
+config THERMAL_SYSFS_OBSOLETE_SINGULARITY
+	bool "Enable obsolete and undocumented sysfs extra information"
+	def_bool n
+	help
+	  Enable sysfs extra information added in the thermal zone and
+	  the driver specific sysfs directories. That could be a link
+	  to the associated thermal zone as well as a link pointing to
+	  the device from the thermal zone. By default those are
+	  disabled and are candidate for removal, if you need these
+	  information anyway, enable the option or upgrade the
+	  userspace program using them.
+
 config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
 	int "Emergency poweroff delay in milli-seconds"
 	default 0
-- 
2.34.1

