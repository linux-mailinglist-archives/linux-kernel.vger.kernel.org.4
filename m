Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1BD7278FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjFHHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFHHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:43:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886B1FFA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:43:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso59214a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210208; x=1688802208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OfgmpgDHudBar0PkB75jmvbWcXu/mU1WxwDHf7lT8s=;
        b=U0nOdlvP39p5uX7o0CjgR+gjIRdLQNBvHjRgZIwHS6hQ2DmyhQxQChM21Thf1Ls1ak
         E7uW+mP8GHHdYjKpywOV0XKSAIaMos9pYGy2uHvpO/4PbXPQcY6oQJz/n+438q2MYO91
         DfJ72bfBIVz3HkklASv+mEJ052zPdHsH9BmLM4NSfdNILlp0fYa6RjAZK+GNmZkv77nx
         uZKmwmsb0OJDKY/2VRXXST1ot0t9PB0bBpivphWrp2xkUaAb5qo5um7zAAkqvy2EUBiJ
         Y+ynfcCLLKvoGs7YWuX/TTaKYEH/PB0p1o/xFb6SRXjJpcUo1queiZhfiK3sFiaDvgIk
         XJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210208; x=1688802208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OfgmpgDHudBar0PkB75jmvbWcXu/mU1WxwDHf7lT8s=;
        b=JcbjKH3mWHtKDFDynJp2BIbOGzKzS3RFgoLDO/bITQNS2U8DsToDY3khWcoqpYtBWL
         N4cD5W8WmKDkAY9wS7ee/1xdP7cXVL2tR97gM8uEZgmXE2divLjMUmgajPd46seh0RBx
         iFKmOfAyTyZgwJZqkIuO2XGFOhGm6Sn97ojUSwSqjdS2Ec3BGG51C1Z4SfpAhE000Pjo
         jn3uF2LctrMMyU+3NoNjWro1biaqnW60kaRWCT1tasP5x3g0Nz8hoqJZTRoVOs+D32un
         orEkbySesABJowB3uIgH4Nz3GW6CUzQjdirKMid7OpnmeYY7c0IFzY0tmSPjyVOb66lW
         jlvw==
X-Gm-Message-State: AC+VfDxi9QsL6D4NxqjrnFdMzDIsrjUb6JXkUN8WHwj+u6dAuO01n8HI
        4lyMDLVEYZ71LLTmUjXjFwz3lA==
X-Google-Smtp-Source: ACHHUZ43hUcE3IkfNSVm5eTUzCPpYMps9NfFJ0j+3+bdWcZoAprFIEewEMgnWtVLlnCsvMAUKktKUA==
X-Received: by 2002:a17:902:dacc:b0:1ae:5b7:e437 with SMTP id q12-20020a170902dacc00b001ae05b7e437mr4837803plx.4.1686210208266;
        Thu, 08 Jun 2023 00:43:28 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001acaf7e22bdsm778017plr.14.2023.06.08.00.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 00:43:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] OPP: Staticize `lazy_opp_tables` in of.c
Date:   Thu,  8 Jun 2023 13:13:22 +0530
Message-Id: <167eb2bd947d9c04b0f6f1a5495ce4a99eeab598.1686210112.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`lazy_opp_tables` is only used in of.c, move it there and mark it
`static`.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 3 ---
 drivers/opp/of.c   | 3 +++
 drivers/opp/opp.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7046487dc6f4..9f918077cd62 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -29,9 +29,6 @@
  */
 LIST_HEAD(opp_tables);
 
-/* OPP tables with uninitialized required OPPs */
-LIST_HEAD(lazy_opp_tables);
-
 /* Lock to allow exclusive modification to the device and opp lists */
 DEFINE_MUTEX(opp_table_lock);
 /* Flag indicating that opp_tables list is being updated at the moment */
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 8246e9b7afe7..c740a907ef76 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -21,6 +21,9 @@
 
 #include "opp.h"
 
+/* OPP tables with uninitialized required OPPs */
+static LIST_HEAD(lazy_opp_tables);
+
 /*
  * Returns opp descriptor node for a device node, caller must
  * do of_node_put().
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 2a057c42ddf4..eb71385d96c1 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -26,7 +26,7 @@ struct regulator;
 /* Lock to allow exclusive modification to the device and opp lists */
 extern struct mutex opp_table_lock;
 
-extern struct list_head opp_tables, lazy_opp_tables;
+extern struct list_head opp_tables;
 
 /* OPP Config flags */
 #define OPP_CONFIG_CLK			BIT(0)
-- 
2.31.1.272.g89b43f80a514

