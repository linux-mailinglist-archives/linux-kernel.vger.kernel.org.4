Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD57241C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbjFFMLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjFFMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:11:19 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D010E2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:10:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b0371a51cfso21043365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053451; x=1688645451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0PSyQeXC7Iz/P3YpxIMlG3+vOjTAssvVZqtnA/BFhw=;
        b=2YvtQkhtruPyaU6tyIiOFVtpwOKVajkps/SV+rmgxl5WcQGFxK06oATnOVAhefKsb/
         /+tX6arfJ/Za9QYTa80Ei6E11onSKYS7FIz7iInWoRFPOWEY5aPsmfcRL0zuObD3kAq0
         teU/b922dsyZ//kQGYgXVvkHMSBnz3ieADNsR8xmAE0B3/N50Bl+vA1z7orEKcxD09Na
         bdbw4y7eF6C+HCfUimAIszfp3GX30HXWkqD/lwSejlJbb9AM/4g8brT1EpgR9qNhnEbM
         IypWkQ/P7yNKwLZhGySBmvzzhXMm7ZZFnsb2tJniozWmxdNQhN6ba8XMv52XGQjbrdS9
         De3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053451; x=1688645451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0PSyQeXC7Iz/P3YpxIMlG3+vOjTAssvVZqtnA/BFhw=;
        b=eYIaFcQQL0RmDGhZxBlrnqAsiL+eUVfRTFMt4MhC8qSxaRpJYsAgApM9q5s9TQhMRp
         WrzcVmsQfNj04Vwr6ZYmtKZKwWYHukf/NJbSOMOQkja0GcPvjMDyrKUnTXMyz75f5d/u
         vTIBP6nkbITta04hjtxt7eTlZxfLTHvnkefK1XqUwmK+06l9nhWs6ZuB7TFEupojsi9G
         uJE73hx0GHgTQI0LebVUf1S2sqU8otBDLzvOF0NrT/T1aS0+G4dOeNaXDT5C4MgMcwus
         K16ocnOUy8DZG4iT1FOcATgmLVo8DL+iORl5BgTZ/0b8WE9o9WkxfvbnoBbwoRqQ7XWy
         frCw==
X-Gm-Message-State: AC+VfDw+1yyjmV0UIMu+Iw/sP3mZGrR6t2CE3bKOIkO31KVsgR0PstuV
        gBMdhfIMnc/Cg5i7rKmdRRs3dKar0IzB
X-Google-Smtp-Source: ACHHUZ4x7W0FDltSlEvI3muVSMQ0fdaK5g12vYIpYYXAKI4ob4o42ABzQjjOpYbLtirWzKE/HT0Jn0tZ7kY+
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a17:902:d483:b0:1ae:485e:d192 with SMTP id
 c3-20020a170902d48300b001ae485ed192mr629661plg.8.1686053451002; Tue, 06 Jun
 2023 05:10:51 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:49 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-14-mshavit@google.com>
Subject: [PATCH v2 13/18] iommu/arm-smmu-v3-sva: Add check when enabling sva
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
2.41.0.rc0.172.g3f132b7071-goog

