Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEBC63E9A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLAGNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLAGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:13:50 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F01537F0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:13:49 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so810640pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SB3gC4suE9YPw/HdIjJak1brWf67yOqLimdACoUU9r4=;
        b=CzzVq06oV7Pdxm/1ruc8JF0zzekOTzYP98yiYsArXG4hAprtojgD1rgvlF7u6Ap4GC
         P+hviaXrjREUUyvWixb/y6sXenDhv5tVCXf0jygUC5lXfe+NtJiF9isMpX2HMbbLkXj2
         XIgv5vIcmF1vZEyzHZkK4N9poPoaSKepXnZJftMHgpc5AuAQcKC8vydRClVyoijwJIN9
         ma4jNbnCn7AANmoIty6/ZWFfAcci5Ms9yZtOOu3ZY7utKNM50PJbqeqV4icgG9evdVAT
         nLbzBlbk0mD1HZHAoNwMBI9kLJYa/YLOQ2PkP/p4Dj8S7Z4IR7nTJNvmImrqpMhI1wf6
         mknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SB3gC4suE9YPw/HdIjJak1brWf67yOqLimdACoUU9r4=;
        b=zQpU3kZmTjx8uFErwizEyQSZxIgoil+KvxMyctUnooYYDikH+nofG6tWVXeK2wXKBZ
         aYYd5bYIaERoZSpF/K+mZjcxhUz2ZauAS/Z6RmqhssILdzOcz0ZIaypuX28hAZgJhYKk
         7W81rHxhsmIr8yCCSBtPw2zqTPar/nFHyaV5eMPD0aYWuvb03kvMqeoiEpwzi+RuOhwD
         rHEhx3o6ikAmdoy7FfIQyQmmK0rO1X5yuXkYR5FuyVr+x3297btQ3GWN74azesuKGACd
         rmDard2NYX06BQQLSoyqixzENkiIitF8q4CixO2/BZm47g9ejU0Wqf2RixkAtNPWGE70
         mXyQ==
X-Gm-Message-State: ANoB5pmpdcFfbUARLRL+2KCLr2f/5Lvt33E5BzQ1wuCIXU+zxnzYNUKf
        3k0XqYFSzmAY0CbOSKENElEdNg==
X-Google-Smtp-Source: AA0mqf4plg+guamA2LI4DZbHwFCpvgc9DXFjNXyQOAYKUa1x3avYx3FABXx0z730eyAKI5iPILHTMw==
X-Received: by 2002:a63:1f63:0:b0:460:ec46:3645 with SMTP id q35-20020a631f63000000b00460ec463645mr59618735pgm.92.1669875228613;
        Wed, 30 Nov 2022 22:13:48 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c61:2814:3292:e917:48a4:d54d])
        by smtp.gmail.com with ESMTPSA id a10-20020a63d40a000000b004771bf66781sm1829753pgh.65.2022.11.30.22.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 22:13:48 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        will@kernel.org, konrad.dybcio@somainline.org,
        catalin.marinas@arm.com, a39.skl@gmail.com,
        krzysztof.kozlowski@linaro.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SM6115 / SM4250 Interconnect driver
Date:   Thu,  1 Dec 2022 11:43:35 +0530
Message-Id: <20221201061335.2440853-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm SM6115 / SM4250 Interconnect driver.

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- Rebased on linux-next
- Depends on the SM6115 dt-binding and driver patchset, which can be
  seen here: https://lore.kernel.org/linux-arm-msm/20221130103841.2266464-1-bhupesh.sharma@linaro.org/ 

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..993284676c0c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1336,6 +1336,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
+CONFIG_INTERCONNECT_QCOM_SM6115=m
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_INTERCONNECT_QCOM_SM8350=m
-- 
2.38.1

