Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC15168D3A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjBGKH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjBGKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:07:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEAAEB51
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:07:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h16so12961342wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP3LW9NZPdbKneTPu60IP6N2yeUEfnsbaq/RO1FZGIU=;
        b=VgHYintfvS0tJz3xdmGafKAmTFBBoUF9ebHaKDfBk9UvzFCmJuqL0JV4itzigWOo5+
         D3feqGwuq15cJUuH+REkuMdYtP7nxlqqT43oVgL2qAsCJNsEmuj6pKLhH7Z9MZGrRgbV
         PHySYLMEW2gL1JIPId98RPoQJ1eeZri/jakLRo8NNUGXEMQwp0AS4MAp+q0lB1hhfrL0
         mRjK8r/jUs056z8d2U3k/1jRmUZnx/EdWLWbYdkN7lmVEW373G4hGeKtt8wXr697lx7C
         IcO8N5h50Zf4SXgXUUDccUGpVRZ/e8fJUOoc84LQcIHDZGZ/E4cRUR/NsV03/M5Inmc1
         6jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP3LW9NZPdbKneTPu60IP6N2yeUEfnsbaq/RO1FZGIU=;
        b=uPVam9mgLGwM6lnwIseIPAXi4GOLmUoWIfH9cPvlCaJ8BCjl2zwF1uUutc74K4Hsmw
         NhArxHsss4gi3pqXbDR51E/USIvil4Lc2/7CQvK/ykfXFF9LZh35XPeFw8c19oCjb1SC
         RuTxrkKzvajbyYbaP61ArKh2QEKlNjh+LRGdif5sbzv1C5ox1oDyEeNsHv5WN0nyhHOW
         uEWL6I0GS61G9hFa7qHq1egH00BmR9JCT+m8c+ymNF4S9VKZg+0UobSa0sVELbmCXyrF
         vcCgAQXwbDZfKnXBpbtSoZfw25BcqI1bJfIPF0o6uIUQ5aLIia1+7I62Jlgspc3zO1c8
         B4EQ==
X-Gm-Message-State: AO0yUKVoJtF12Nlpa8S0aaKWxQPm5nTDMuXNfrdCzdbW/5yNr8OEc/Tw
        ycO5cB3zPLfm6i1laLKbFdgmDg==
X-Google-Smtp-Source: AK7set9WyLbiZH5oja75Z/gZ1n3Ni3GD/NNp/L1Pv/QpiIAJOXlSbNqTznP0Ah1HnZisjVizJdcLSA==
X-Received: by 2002:a5d:6203:0:b0:2c1:28dc:1561 with SMTP id y3-20020a5d6203000000b002c128dc1561mr1912832wru.44.1675764454069;
        Tue, 07 Feb 2023 02:07:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:274f:8489:6db8:7d33])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4572000000b002c3e7474b0fsm5283173wrc.13.2023.02.07.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:07:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] soc: qcom: smem: Update max processor count
Date:   Tue,  7 Feb 2023 11:07:28 +0100
Message-Id: <20230207100730.218725-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230207100730.218725-1-brgl@bgdev.pl>
References: <20230207100730.218725-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Update max processor count to reflect the number of co-processors on
SA8775P SoCs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 4f163d62942c..7666b3425b7c 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -85,7 +85,7 @@
 #define SMEM_GLOBAL_HOST	0xfffe
 
 /* Max number of processors/hosts in a system */
-#define SMEM_HOST_COUNT		15
+#define SMEM_HOST_COUNT		20
 
 /**
   * struct smem_proc_comm - proc_comm communication struct (legacy)
-- 
2.37.2

