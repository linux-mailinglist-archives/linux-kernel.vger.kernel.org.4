Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A674F21E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjGKOYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjGKOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:23:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AB21735
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f954d7309fso7170303e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085351; x=1691677351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw4DGVBDDBg6SI5/SRWJ+maUbLcJsf6ZmIK2Iyv5wTM=;
        b=ZI9AZbQ84tq8plr5L4sNiYUXlokNI8GUuMEE4Dzle71FWUjExoFyFMLZqZGQmVYTLO
         CbcJDs9jmvi+tQwPF0F3fi9ko4Qdd/UnkABnpGufcnjnTsYW2a2k9jWUoM3zuZqY2JHI
         XZNLZUhKfvOzSSVH8Tz23kYGgt/OXQP6EBsUc8wR5d1BZ5pO5qELIXc9LxxQX5KMwHeZ
         1RIK3rODYo8cwqNsfyInT19Fzew4rJQ3P6CbFGl/lKHxafYPWx3iVTeZJ00TsEjIVQeY
         pAEK8l30D31p/+kR8eQpIii8CajV4OtEuuTOt1/dQUBvgcY3EA/HehLPdK/Way7aVphb
         kLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085351; x=1691677351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw4DGVBDDBg6SI5/SRWJ+maUbLcJsf6ZmIK2Iyv5wTM=;
        b=BKb36LaE4uy5nDDjEkg3SKb/BltAOrRfKNTu5pgmvz+R/qP2VITc2YJVr5auWjLP/u
         UxmyoDDrbQxsJJl8hRoHiivt/VPrIaH3u14BexZHwjzPzxpJFNI336cTaNGY8ZnxpGbR
         a4Lpoyx6jl7Fg3sss/NKDg7i9DqTTaC7gxvUqkeMwpA0AESx95lrcfPX0mQqlvpyRH91
         kXUfspbEGEOx8RPrElBSGWW90wDlDq/s8WGytb2XZEEX8gxGCz9YO1bFsYd8kfAB+0Et
         GlitajNa1IzWXas7+9/8V05OCy4j4hWqCluz5t8lVzDyL5thuSyKR3xXT7l+2suVCjU4
         3+cg==
X-Gm-Message-State: ABy/qLZV1ZNXh3BX3Ui2zsjyxJt5RkDLaRwuSZiM3+AiBZCIsNcPRslh
        WrSaPKbQ58Ur8M3uY1g5W7nRDeNXNL0OFSLQERs=
X-Google-Smtp-Source: APBJJlH4J11J970wSN9S0sKheHb05BTteL7vkxcGg2YmvkmjV9l5Uge24eM7h7Q1GSizY9hZgpG9Qw==
X-Received: by 2002:a05:6512:10c3:b0:4f8:6253:540 with SMTP id k3-20020a05651210c300b004f862530540mr6550119lfg.19.1689085351135;
        Tue, 11 Jul 2023 07:22:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u12-20020a056512094c00b004fba5fc7ed8sm334009lft.278.2023.07.11.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 16/18] soc: xilinx: Move power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:22:28 +0200
Message-Id: <20230711142228.751817-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the xilinx power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/xilinx/Makefile                                   | 2 ++
 .../zynqmp_pm_domains.c => genpd/xilinx/zynqmp-pm-domains.c}    | 0
 drivers/soc/xilinx/Makefile                                     | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/xilinx/Makefile
 rename drivers/{soc/xilinx/zynqmp_pm_domains.c => genpd/xilinx/zynqmp-pm-domains.c} (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 193892189f0d..efd955f586e9 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -12,3 +12,4 @@ obj-y					+= starfive/
 obj-y					+= sunxi/
 obj-y					+= tegra/
 obj-y					+= ti/
+obj-y					+= xilinx/
diff --git a/drivers/genpd/xilinx/Makefile b/drivers/genpd/xilinx/Makefile
new file mode 100644
index 000000000000..a706ab699cfa
--- /dev/null
+++ b/drivers/genpd/xilinx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ZYNQMP_PM_DOMAINS)		+= zynqmp-pm-domains.o
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/genpd/xilinx/zynqmp-pm-domains.c
similarity index 100%
rename from drivers/soc/xilinx/zynqmp_pm_domains.c
rename to drivers/genpd/xilinx/zynqmp-pm-domains.c
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index 41e585bc9c67..33d94395fd87 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
-obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
 obj-$(CONFIG_XLNX_EVENT_MANAGER)	+= xlnx_event_manager.o
-- 
2.34.1

