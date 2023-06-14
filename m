Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C762B73041C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbjFNPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244938AbjFNPpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:45:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BB2683
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:45:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc7267224adso1730537276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757510; x=1689349510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=vp6Nlsbz0oC9g4ftIwLdhomK6sQnklY1ZxeEkHnIXfEXrOB32EsbD/Sxec0iRhhQHg
         FG7D8M3PpWeaM8iqTIew0USWOhnUT0FjBe9eXnTTSV/LhmO3ZmKELA9cij4LrrquyyEX
         xN4kZsa+CrEDpQ+9SCj337Iz/uwRx2q05yM0XfIncqMYOokbXzbVERwKppl5BO38z5eP
         hHmqL5KhrByMtgmNr4kVUihXIw6qeRCfAOy3kJEM2Xe0aOvPnzQXKdDIUXJE6sDAuRHp
         s5nPeYy80N984gbWZ3p5ANSaT8JevwNNBkebJ7ua9ynBAmNYrnU+pSstx30pek9GSY+/
         b8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757510; x=1689349510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=JyN8genmUSaSv4q9wszvI207vt3KSvlZi3CYd8+pKAJfJHcT+NM5ED+MiOt0XV/jZA
         +jlrOPSz72ddh6Nk6J4biVsW3Wk2Cocu3AmeEwvGKWXsT4Kwyfua6phHh1g8gRXjo793
         UWFxVoWgJEttps+G0B7Wz6lpBP3mZpQQSGw0I1zLmW6igGoeUBBFVRyNAoW12KsSD3TA
         BI62yqmJ2hu/NdAwcPmKkjFdeMpCIWJHvCBRIAEj5DFoftef+LMNXdn7HTcjkyeJltp0
         CWDk1vf8Gn/Q58Qj2Wf6Z6vNdjylyb9yxZG+E8tLkQ4Umjx4pD0QrFfcNKpFCKwZ0JWq
         wHGg==
X-Gm-Message-State: AC+VfDyxZBqag7BhPSVm7r7zZ1mh8r6V9c0VJS9WT1iQhXWIs/n6nUGs
        wCsKFn4Kjg1ge95Z9yuNCn8hh0at7lWw
X-Google-Smtp-Source: ACHHUZ54OC1oThkrdI5m1JIqCvJD/OCLMDFClBfZ1oOPcGRnJCDeBJWfnhAFwtQXg3YtdduEf0o8Lo03wyNZ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1185:b0:ba8:381b:f764 with SMTP
 id m5-20020a056902118500b00ba8381bf764mr888385ybu.3.1686757510234; Wed, 14
 Jun 2023 08:45:10 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:42:05 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-14-mshavit@google.com>
Subject: [PATCH v3 13/13] iommu/arm-smmu-v3-sva: Add check when enabling sva
From:   Michael Shavit <mshavit@google.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SVA domains can only be attached when the master's STEs have a stage 1
domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index b615a85e6a54e..e2a91f20f0906 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -499,9 +499,15 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 	int ret;
 
 	mutex_lock(&sva_lock);
+
+	if (!master->s1_cfg) {
+		ret = -EBUSY;
+		goto unlock;
+	}
 	ret = arm_smmu_master_sva_enable_iopf(master);
 	if (!ret)
 		master->sva_enabled = true;
+unlock:
 	mutex_unlock(&sva_lock);
 
 	return ret;
-- 
2.41.0.162.gfafddb0af9-goog

