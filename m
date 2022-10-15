Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203375FF7AD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJOArA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJOAq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:46:58 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311E733F9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:46:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r18so5670182pgr.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R97F6tafPKuH3Wb7fiZxQjJXQ8j8fICZkLtVUZ7PMKs=;
        b=QLOUkKXyXKxnryU68yEhMzW1PSO+tRC1EVQ8JePXkfSzUNUQJ0RadH5pPzjAzQTFIT
         X+zIARW2wZiFSM0322qGBZ8JMTApMuHr87RSSBerUKjjkwMjN6cySAwNasjkY+rfRB6g
         FH8xHUljGnHr+qyB3oOQFLvZTK5dme12KdxQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R97F6tafPKuH3Wb7fiZxQjJXQ8j8fICZkLtVUZ7PMKs=;
        b=FNMallB0J07ihgL8LF7y+L525Wa2RKbwGw2dGVahZm9Lx1VTjIgVWTeZfWlBEs+ReZ
         6Gbv+ZeNxcQO0ocjPsTfT/JfgEY7RTF9GA+BQ1IKIvjKKuXtQHZA+T3OI3nqvYYt4kPc
         61Xl5cxEs7pHEueMpNwC2THjelUJPRSuwGlGOGO8THeLLlHE6hXqtjixCUSfJPlWDNu1
         5z4pxqb3UOpgniMuEG265Em1O90jGR0azri/zxo1OIe9MyovfLgW1K8PwSncOICJIuCS
         DACBT4B5SQph7xHA5Z+UHI2Yzdrm+kJfsM2fthZRWJ5YXidpc0dL/3gXyBWTFP7BiFcZ
         JgVA==
X-Gm-Message-State: ACrzQf1/1puId9L5W6qNz++D+GqsdegVgs1YM5zTUHF2IdL2Eg5tS+BO
        U3tYdesB66Ut4XyGIrJIdoStTQ==
X-Google-Smtp-Source: AMsMyM5BFZx0QDc7pR9+g4YFHVAhun5z2HILPgjazDPHaBjdjuDPXO1Gf0dWyqcBdWzhp7aXYiemcg==
X-Received: by 2002:a63:1145:0:b0:46a:e00c:579c with SMTP id 5-20020a631145000000b0046ae00c579cmr479334pgr.279.1665794816651;
        Fri, 14 Oct 2022 17:46:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:9d:2:9f6e:fc87:d13f:1fa6])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902bd4400b0016d72804664sm2230802plx.205.2022.10.14.17.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 17:46:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 1/2] soc: qcom: cmd-db: Mark device as having no PM support
Date:   Fri, 14 Oct 2022 17:46:53 -0700
Message-Id: <20221015004654.3930122-1-swboyd@chromium.org>
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

