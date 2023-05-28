Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B372971412C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjE1XEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjE1XEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:04:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593BB9;
        Sun, 28 May 2023 16:04:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so17495345e9.1;
        Sun, 28 May 2023 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685315041; x=1687907041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgEav/hObHKXa2xZtcQl+SOXTH/TT1wQEchg+9UM0xs=;
        b=IucpAicZ/A7MOMAcp/J4yV9jSazj4tat35tHVRoka7TB2W6GVMmuE4+UN81wDOGMjN
         ZGd3TZtL250mxwuK3TURoTL+11S+/1nNuItFCN9t+WnAxSeiB+fLZiqzwKxzHL/52W0w
         GuAu3IgBictgjWt/3shoCbxCwDuj0Zx9MRwpXs42QKH3bD+oJZjVvHWJRPpLRzWDAV6k
         poo1lLtsDzUa2OmP3h962DUqJYbMS6eJ0Mt39ttASd/iIJh8WxQFO0Ea+Ok3pgarcEWE
         1pd3pgeYoI9OxK4PwZNcioULc5trpsfkin71QWzdk3ppaJWpAcxD0p0aC2A+NhoXTvbz
         fQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685315041; x=1687907041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgEav/hObHKXa2xZtcQl+SOXTH/TT1wQEchg+9UM0xs=;
        b=f+QDtDSZR9geQq0yqVyjw3IXUjjljM791tPIiS358IVGU1hxenzfkkWT6UDUlvmGV2
         cNbkPJS1YzlSU+6olRqO+zvV5qUbhV2Gzd/MCKA3ommZCWCOFJIFWmp+jrJdmUQiOj0b
         RI8NVeB3BttZ5Ru0JoVucK5IYmWABuRMhcL8K5rlxa6y9Q9CNm6QVu8PKUzQs62+NMgk
         59F1YxJwc4gwBt5dq0IavMCMPEOFmW/aMEbRHZ6Wpd8E6/EQtPf7cWcC1cWRmy6LlNi1
         iAU7lmTUdDgbWAVpN32nhEnukRZsQjbU5ERguU3JMepaZHawXytLFS7XHF9bkPiTiLo6
         FPOg==
X-Gm-Message-State: AC+VfDwAryT/5PGlQXu1qGNY5rBUuVSWe+UCzdHaSOXTnPZ7pw5Vlfkt
        y5pCSBEJhHNn2B30xmBnLEs=
X-Google-Smtp-Source: ACHHUZ5DXywXVq1lyzG93eycamF7ymupphFNS9FC8zj74bAE5JeIucupDNwrAvtcwPLzctqQrsseMA==
X-Received: by 2002:a1c:7716:0:b0:3f1:8c5f:dfc5 with SMTP id t22-20020a1c7716000000b003f18c5fdfc5mr8175364wmi.39.1685315041182;
        Sun, 28 May 2023 16:04:01 -0700 (PDT)
Received: from xws.localdomain (pd9ea3c90.dip0.t-ipconnect.de. [217.234.60.144])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003f4e47c6504sm15995411wmg.21.2023.05.28.16.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:04:00 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] firmware: qcom_scm: Clear scm pointer on probe failure
Date:   Mon, 29 May 2023 01:03:49 +0200
Message-Id: <20230528230351.168210-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528230351.168210-1-luzmaximilian@gmail.com>
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
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

When setting-up the IRQ goes wrong, the __scm pointer currently remains
set even though we fail to probe the driver successfully. Due to this,
access to __scm may go wrong since associated resources (clocks, ...)
have been released. Therefore, clear the __scm pointer when setting-up
the IRQ fails.

Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Patch introduced in v4

---
 drivers/firmware/qcom_scm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index fde33acd46b7..d0070b833889 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1488,8 +1488,10 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	} else {
 		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
 						IRQF_ONESHOT, "qcom-scm", __scm);
-		if (ret < 0)
+		if (ret < 0) {
+			__scm = NULL;
 			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
+		}
 	}
 
 	__get_convention();
-- 
2.40.1

