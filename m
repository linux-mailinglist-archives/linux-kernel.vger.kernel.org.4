Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B85FF7B2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJOAt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJOAtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:49:49 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C419280
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:49:47 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-131dda37dddso7807238fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfHTz2OiIbmF5iJHdVMyVQbaziXuWRN/1ILDt+PkeHY=;
        b=MrSYbcpuKKcBRkcAzlV3l7P6XU9wDVllDs/MR3NbeWINr715oJSEWn6iEsPc1CSQWj
         MI0zrDOx6A/wPXt2bIf3TQMUhIEyDYJPQCI6ZBYGqK0zBlJE03t0IEeb+wHG/5oobp6/
         VXIGFF063PHMRaDxv9u4jZuxjaQl23euz1tdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfHTz2OiIbmF5iJHdVMyVQbaziXuWRN/1ILDt+PkeHY=;
        b=3Th26rmyL2adai+zTI3GNOZf7lB3v+eMFnvyDbZpH39NFHH8axkI3AVYDWqpLdmtT3
         Bu/RVDjcZ98dNZKRRKxgjSqr5iI/8R7glm7MBse2HrsN3LiRvLeH5MuxX59VAn+M9rj4
         xFAljw+Z8vAYoajTvL0zBCuoSOONnkJrv93E/vYgr6zX0uGquVxJ8pNmnQhU3gpAaUjU
         8tOLAccrOgqkEYcSBDcijlboEZGz8fm0bKW0JDEpuQiEcDRT7GQQHEafXPKsRPzC9krF
         1eU2fb39gYegQOxcB2c9RRaCcetR+Gf8v6mq6LCMZRymxjDTwKwDEg2hQN8mJ7u78Z6X
         0H+w==
X-Gm-Message-State: ACrzQf3o9w2EXmDTUwDVSdxLw9potHmcUaZVH1ngli5IdQQg4wjcEaQm
        4SfvOWFpaYbb8EgGWHdnmeJGFOWpnRRHtw==
X-Google-Smtp-Source: AMsMyM4VVo6qGwJQySMZ7zlfLU0Fq5lgz4oc223JraE6Pou5fDW6iQi7VlQERJsrU1YszVLxPDT9sA==
X-Received: by 2002:a17:90b:4b49:b0:20d:3e36:3c7d with SMTP id mi9-20020a17090b4b4900b0020d3e363c7dmr20717121pjb.52.1665794976652;
        Fri, 14 Oct 2022 17:49:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:9d:2:9f6e:fc87:d13f:1fa6])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b00179f370dbe7sm2256142pla.287.2022.10.14.17.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 17:49:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH RESEND 1/2] soc: qcom: cmd-db: Mark device as having no PM support
Date:   Fri, 14 Oct 2022 17:49:33 -0700
Message-Id: <20221015004934.3930651-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver purely exposes information from memory to the kernel. Let's
mark it as not having any device PM functionality, so that during
suspend we skip even trying to call a suspend function on this device.
This clears up suspend logs more than anything else, but it also shaves
a few cycles off suspend.

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Resend to fix Bjorn's email.

 drivers/soc/qcom/cmd-db.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 629a7188b576..33856abd560c 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -338,6 +338,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 
 	debugfs_create_file("cmd-db", 0400, NULL, NULL, &cmd_db_debugfs_ops);
 
+	device_set_pm_not_required(&pdev->dev);
+
 	return 0;
 }
 

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
https://chromeos.dev

