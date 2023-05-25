Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5B710BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjEYMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjEYMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:10:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306CE10B;
        Thu, 25 May 2023 05:10:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-970028cfb6cso102191866b.1;
        Thu, 25 May 2023 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685016601; x=1687608601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqHt/Go8RthQVhVjmmrUcvTjDhA8Lt3EQbNyl9cwF7Y=;
        b=S3GoNPHLbgYnGsdrSNuL6+UlC1JIuKVF9MpiMN4jRcFF7V/CzmwFAg2c9va1jd81Sd
         /Lrou9b+Vy6SKu6FUKz7LsdzGpe2YNdMgBnFVTksylJYs7emkgcB60VNp9KhLNwK87R8
         KS4CxbGUd0VkbGEPhIhfDTDvWKyIU8jcEuooWSH5KuWmShhKustnKVr0lJv2ihAStIWY
         oC5EN5HBo751bZ+xiguCGBJISUX8p1mt5AsJihzbJF8fvY/BXB/WX3xwT/Sur1q2uRNz
         /gFSNjYti9J1c4fdUPk62Mgt4syJzcjTQu8TQfB9Oj6KdgvEHwJZvWtElGy7a1ekIJpk
         ZecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016601; x=1687608601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqHt/Go8RthQVhVjmmrUcvTjDhA8Lt3EQbNyl9cwF7Y=;
        b=OZfvNTQbrXLketKx1ci0czCxK05e1L5L4/QGg8dv2mnxtfFeG6VKZcPrDekH/UsGz7
         GZCxLplbF0vzIlwItCQfq7UP8lq4NK9tZt8N7r4K5W6qL8ZYuDCnPqdWJY3frJ5YNqZs
         SjgN58HBG1j6IFDT6Pe/kuRfQrAoVWsj3he5yjM3a5JN/hCYLEZxujKSiWPRY0YezYYn
         9KFCcu0KUnOHkj1YOnCR0Jzm8ncSWjCzRrqluNCJWeUoeZPqKnINoCWx+bykb58eCDHU
         acdlcEzp7F+PWpzAeJBA5AhxG/8ZRa6OEAATo4Kh3NJCy8gn7pWHVzki4SYCFTLdPYrc
         /7sQ==
X-Gm-Message-State: AC+VfDy838y6B25nvNdjPQDm6kLJcwuPLaFKhoQZuzCHr5XxCuNJkh3E
        o71ZSXPwnb2uqBd/P7AEx/JO5UiIuf68kg==
X-Google-Smtp-Source: ACHHUZ6MJNlxGAqqb96I+VPFic8OwNKvy5L6sJPUXDcV7pa2lWtzSibuhR2g6mx5IvFhMJdwJpXL3Q==
X-Received: by 2002:a17:907:3da9:b0:966:7a0a:28ae with SMTP id he41-20020a1709073da900b009667a0a28aemr1581658ejc.22.1685016601102;
        Thu, 25 May 2023 05:10:01 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id d5-20020a170906640500b0094ef923a6ccsm765216ejm.219.2023.05.25.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:10:00 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/5] soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
Date:   Thu, 25 May 2023 14:09:53 +0200
Message-Id: <20230525120956.3095317-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525120956.3095317-1-robimarko@gmail.com>
References: <20230525120956.3095317-1-robimarko@gmail.com>
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

