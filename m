Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3B7118BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbjEYVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjEYVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:02:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F76E4C;
        Thu, 25 May 2023 14:02:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510b6a249a8so5360954a12.0;
        Thu, 25 May 2023 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048538; x=1687640538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQfAznflSLQf5yGCCk12QztHSZl1wyJLiF++XZ+fpqM=;
        b=Q6yzT5KjUTw2Kvb/+1ZiCaQtT68GkF15Rclvk+ZChtF5UuT6yBjqpNtk4tAIEy1J3v
         SCMhzJVdCF2mFGm0WlqcI+PGxi0Eqfg07So7MZOpYLEEWR0H2Ysd1Zz5ZzX8Pxpfm/ru
         LhBQcK/089X1lzaVcRpGd/Yo1geFq0D4gxtDEpeQfGzDjxDEKFJB7LTC1OM8yZ2TEKvY
         W0uzh/A8sln20dpmz2liUljdHPLTsXUMbjw4pZeq/WhOejgyK/C0CH6nL+XXzMXnXgW4
         bT29B89cRUvR8pv8CaNr4XDbRhJ4XA4E+h6SthGtvi44QnDe35pEBLjHOpsRH8ihJ+ho
         jJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048538; x=1687640538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQfAznflSLQf5yGCCk12QztHSZl1wyJLiF++XZ+fpqM=;
        b=gzxL53GhhA4O8KP5jd5Hr3+bfHUp39IVrd5SId9ZiQg+4P5jIqCqK8mwc+99SU3Bh+
         JXj7wKvjbkz6mQ+7L2kJW4TbGmk3Wz3ntqODxELMzb+euVpVopg2OU5rrtJFGqfcYayA
         twh/NgOTgJiFHnLJElX383q1LT/3FPZta8rkVVr7NgYiJGkSUq8nsgTaQTzvaidWMp5M
         efWjmEsbLvL2BQj0KmR7MJcBTy6CoIe6NlMe1TvUKg4/yaqfTVTz24Y6pjl8MyzR1SeK
         Ut+GSjuj7ikVi5KQWcBguMJ1vTVZy/JC3/2+/cW4tGT1Q/bzohxOtJdL2icbmh2CBGlL
         55aw==
X-Gm-Message-State: AC+VfDxdxfDB/5n2QNPe4EnBTaQGLwuBMltD8tuzSLhiFRCg5piAZdJ2
        thGNPFwd2HIUUtOmUCL45Q36rVcufYk1ig==
X-Google-Smtp-Source: ACHHUZ5aI1Mmu2w4k+jIIe0GcOpYfhFK3+q4TwdrOjaA5r/8+1YW5zWLFXuOefXE6CFZRH8aL7wxeQ==
X-Received: by 2002:aa7:da44:0:b0:50b:c308:7b4f with SMTP id w4-20020aa7da44000000b0050bc3087b4fmr4881715eds.17.1685048538262;
        Thu, 25 May 2023 14:02:18 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id c25-20020aa7df19000000b0050e04125a46sm913010edy.10.2023.05.25.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:02:17 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>,
        Trilok Soni <tsoni@quicinc.com>
Subject: [PATCH v4 2/5] soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
Date:   Thu, 25 May 2023 23:02:11 +0200
Message-Id: <20230525210214.78235-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525210214.78235-1-robimarko@gmail.com>
References: <20230525210214.78235-1-robimarko@gmail.com>
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

SMEM has been GPL licensed from the start, and there is no reason to use
EXPORT_SYMBOL() so switch to the GPL version.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Trilok Soni <tsoni@quicinc.com>
---
 drivers/soc/qcom/smem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6be7ea93c78c..bc98520c4969 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -500,7 +500,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 
 	return ret;
 }
-EXPORT_SYMBOL(qcom_smem_alloc);
+EXPORT_SYMBOL_GPL(qcom_smem_alloc);
 
 static void *qcom_smem_get_global(struct qcom_smem *smem,
 				  unsigned item,
@@ -674,7 +674,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 	return ptr;
 
 }
-EXPORT_SYMBOL(qcom_smem_get);
+EXPORT_SYMBOL_GPL(qcom_smem_get);
 
 /**
  * qcom_smem_get_free_space() - retrieve amount of free space in a partition
@@ -719,7 +719,7 @@ int qcom_smem_get_free_space(unsigned host)
 
 	return ret;
 }
-EXPORT_SYMBOL(qcom_smem_get_free_space);
+EXPORT_SYMBOL_GPL(qcom_smem_get_free_space);
 
 static bool addr_in_range(void __iomem *base, size_t size, void *addr)
 {
@@ -770,7 +770,7 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
 
 	return 0;
 }
-EXPORT_SYMBOL(qcom_smem_virt_to_phys);
+EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
 
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
-- 
2.40.1

