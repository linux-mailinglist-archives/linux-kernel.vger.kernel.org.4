Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB2B706E52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEQQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjEQQiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:38:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCFE93C3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:37:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510db954476so585900a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684341474; x=1686933474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxFHTRCKX1b6ZPvp5Tbzp6uL023q77o/sho/DiHZlF0=;
        b=ZlTl28XaVoUXtK1R34OnJkyaUON8lN7ZqEl9xlLeb2F1+VNKzXQlqUBUy3hYRe4+Xi
         ybUetVhyCtCPth5UUo3OCKa6R+YiCxy1IwqvcrwWikT73tdqJ49b672dd7+Z8F4UM9g7
         +794RuU2affLlGgyft4JZzow4imJSjLkSG2szqvX5pIw69/0w6ygLxEhAr+YTxUBwRe2
         Ug9i/gcRmusm2cYeUth3Vp9EBacAnars4fWV+8HIUk2j2Vh8nuWVObwz34XOlD7n2pLa
         +M+i4hpBfOIvxZ/z9Ty72PK3C0UgnGdUASeQYcjc7NBSmxP9IyfyF6qNMiD+noYB8xQc
         ufYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341474; x=1686933474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxFHTRCKX1b6ZPvp5Tbzp6uL023q77o/sho/DiHZlF0=;
        b=NFq6WobxMRV3Qegf0cM/uNknh+sgfIAepYCMMZbtfdvtgdpL55O+vsbKRt09GaQRG8
         NG5htwrIsFR3ezsz7z18BWmbCJpU8qPNr7RkPkfxkuNWphSCKyH6EhqnMU3csQs5ck8v
         xO+x10ih9gngUz4nyiqkDL7+J4PoUo6DQ0nv7Wqtq1V1Zu9v1IWG4qwg37jwQmt7XNvG
         XLMpKRWsWPI2uOPyEVeCoXyaYi6UQSWac8DwDYaaXUgJWsGo+V7FI3kaCwBSw0NtBEAs
         woeIMz7zQ1uO+rhxtgG6NDsgPuzlrX5J0ggr7KvE2vcv7gzN+NuuCiRyFsw1AWyPD1ze
         xFvQ==
X-Gm-Message-State: AC+VfDwNcuXOooZlTyv5Fz9xd6JW4TN6yFPjNxgEz4igkDagZfxWhGeE
        HNneeZS5TV92UjNDMlreFrEajA==
X-Google-Smtp-Source: ACHHUZ4v5X5Nl45QaqZ4wy3xZQPUxWAVDqcRKxfdhsGdP1MRZG40xfitQgvgVmpnf2IMERFZMSdA6w==
X-Received: by 2002:a05:6402:1209:b0:50b:d26d:c57e with SMTP id c9-20020a056402120900b0050bd26dc57emr2431904edw.12.1684341473752;
        Wed, 17 May 2023 09:37:53 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id t21-20020aa7d715000000b0050bc041d2a8sm9284827edq.15.2023.05.17.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:37:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] soundwire: debugfs: fix unbalanced pm_runtime_put()
Date:   Wed, 17 May 2023 18:37:50 +0200
Message-Id: <20230517163750.997629-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517163750.997629-1-krzysztof.kozlowski@linaro.org>
References: <20230517163750.997629-1-krzysztof.kozlowski@linaro.org>
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

If pm_runtime_resume_and_get() failed with -EACCES, the driver continued
execution and finally called pm_runtime_put_autosuspend().  Since
pm_runtime_resume_and_get() drops the usage counter on every error, this
lead to double decrement of that counter.

Fixes: b275bf45ba1d ("soundwire: debugfs: Switch to sdw_read_no_pm")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index dea782e0edc4..c3a1a359ee5c 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -56,8 +56,9 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = pm_runtime_resume_and_get(&slave->dev);
+	ret = pm_runtime_get_sync(&slave->dev);
 	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
 		kfree(buf);
 		return ret;
 	}
-- 
2.34.1

