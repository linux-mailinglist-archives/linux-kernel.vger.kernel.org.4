Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481806D0306
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjC3LX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjC3LX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:23:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E748E5266;
        Thu, 30 Mar 2023 04:23:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn12so75081588edb.4;
        Thu, 30 Mar 2023 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175433; x=1682767433;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w9ess78RekQl+j0GgPRIqCZqgicZG8oEXugbOrvcayQ=;
        b=bxXErMrISg0uIYKx7mwehjAJXZJIonRouze1VVTRtUbjoTf81LmjY9KS9jQf/HpAgL
         BPVv/HFwyEI/jXQOTOFIuW9TxR+G6R4EnGaa277E/mxnQMCL05x6vgwGCncroP+TJZNX
         x+vHkMAwJcGjC8DG6nOFe54deNB5daiZztyrSBG6pVpsZXXpYFpnG2YhiD2smL37o7iO
         +Ly2TNfyyxW5XwLg2AGbUC2cCmKO05h3MAiC12AB+HB/eLbV5CwWUDNvUZHuqLjXH5k4
         78Upe5adqNMALNHW9awAX0YzDmLL37esdk3X3bxaiimYD2fqp+zA9LfCR6eNB0v8yCk5
         AZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175433; x=1682767433;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9ess78RekQl+j0GgPRIqCZqgicZG8oEXugbOrvcayQ=;
        b=mFLa8hr4hXCJfoSAhsgWkozIj2en45IaWd3+Lluvs0+JvbMoI1d2o6CQxL//k7wZ1d
         teaAMb48dPuEZqlWLREj/nDjaAOPnO4+sLPOCQOog/9XFEIk/pYslEyxKcTuFIpAw4Wy
         acXiGvIzjt0e0+OYgAjEhqI89GCkqm6eyprHm91WQPt4lfCei3eisJG/uFu7ApUFufwU
         9VBlOat94qzPv2ECEpCo/sftpjWuD/BJj5Lj4O1JGnsbzl64bXWPMmBZ/EvlFeM751Sm
         zGVhip8l0BW/nx2clq0GHwTV7ApkJaREYF4Yo3jhUi5c7+umsKGdmZ64il9ThjvgBJyD
         NMiQ==
X-Gm-Message-State: AAQBX9etln4MepCBxy7oySfTcfe1CVQvqJmRfE0I+jqH5OmEo6YoA80y
        S1zvixz5Y7iAj/v5yWOlj/I=
X-Google-Smtp-Source: AKy350bTymMVqIJ9+7ZCeNxTHmMT5xWLIQC91vLLZQ6TJdVDnO6KUk7RuPYGKYeltlyGROBdkuOgzw==
X-Received: by 2002:aa7:c954:0:b0:501:daae:80ce with SMTP id h20-20020aa7c954000000b00501daae80cemr20685172edt.12.1680175433384;
        Thu, 30 Mar 2023 04:23:53 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:b46b:e78:a1d5:4082])
        by smtp.gmail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm17851210edf.63.2023.03.30.04.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:23:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] reset: sti: simplify driver's config and build
Date:   Thu, 30 Mar 2023 13:23:47 +0200
Message-Id: <20230330112347.31137-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330112347.31137-1-lukas.bulwahn@gmail.com>
References: <20230330112347.31137-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 64933513e461 ("reset: sti: Remove STiH415/6 reset support"),
there is only one sti reset driver left and there no need to define a
dedicated config STI_RESET_SYSCFG, which is selected by the config for the
STiH407 reset driver.

Simply add reset-syscfg.c to the build for the STiH407 reset driver.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/reset/sti/Kconfig  | 4 ----
 drivers/reset/sti/Makefile | 4 +---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
index 9455e1c7a5aa..a2622e146b8b 100644
--- a/drivers/reset/sti/Kconfig
+++ b/drivers/reset/sti/Kconfig
@@ -1,11 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 if ARCH_STI
 
-config STI_RESET_SYSCFG
-	bool
-
 config STIH407_RESET
 	bool
-	select STI_RESET_SYSCFG
 
 endif
diff --git a/drivers/reset/sti/Makefile b/drivers/reset/sti/Makefile
index 3eb30f7e8e3d..5e833496cee3 100644
--- a/drivers/reset/sti/Makefile
+++ b/drivers/reset/sti/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_STI_RESET_SYSCFG) += reset-syscfg.o
-
-obj-$(CONFIG_STIH407_RESET) += reset-stih407.o
+obj-$(CONFIG_STIH407_RESET) += reset-stih407.o reset-syscfg.o
-- 
2.17.1

