Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1522737BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjFUGrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjFUGqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:46:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE631FC4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:45:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25e89d51bf2so2581661a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329902; x=1689921902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=t4HhyrUZx343POQssx8xWB3bNqEwvVz5axTthBdUwUeHP98YwM0/jOGBkI8RNJ6CfV
         q813TeRnvgUNnvQ5yy+drxSkGdqSae/ZdfJL2CLBJbfVgemKrHUzyxNImNn9WE4R5pN1
         QgALlayI2ddPtiW6CPlWgIpz9CmCsE/e1EJarXWy6qGQnc+hIy5agSCGPnJEUO2/Lcx0
         w31wnEnCEJrXmNRkg29aSfwTjpHDwxP6w/ngMobxEgWSJDGOmFnCq3Hf+OQierGh/m/V
         vjKc3DIyPkMR9sdzlVpuqyKBLwgRtHl253JAEGraYWPxylZDrHFJArJHYf6fcfRkfMfq
         s4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329902; x=1689921902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=GCKtJzarPQ3nonHalz0+J0b9efmwtlITGzAt09JU1Ja4BmKwmM/Lcp4uaR7vPIhr2N
         e7k9YOrYY2Tdpu8k7ICM4X35APA+BUrCP6CKgxHxTJAHG4qWcSHQrIdy8WQKnqKqQmg4
         TUoCLvGNNJTlniK/9KqXNTAgFozaR1L+zazEwswGq9f58g4GGr6U35Z5XxshsGTdzyMH
         akh2NmdnnyJaNmM25M6E9eLiI4QjUgP7OE6ypAxmNkodg8aTk99Kbt3V/2EVUbfKD9Rd
         b5nCsS02k56VZ3K79ynJhbiWnnXjV8FcW5sLIpD4PRYY2A30853rYUn2cIBUnkDGReS5
         pwfQ==
X-Gm-Message-State: AC+VfDwAr2r3LDkDU/dvcl+GmPHNtFbzcSpO6xebca/HobIPsO8uf8Gq
        R/xQ8juK0SKheN9LTuOMkNtR84lHZSMq
X-Google-Smtp-Source: ACHHUZ4sre6FKQd6JetGrp6VVOp9i7yh8bqwdCg0x/qqo75bj1C1/wd2ryfmXfIMYXHnMZ1hGUQI3eC1XGFb
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a17:90a:fa06:b0:25b:d689:72a4 with SMTP id
 cm6-20020a17090afa0600b0025bd68972a4mr1992026pjb.4.1687329901714; Tue, 20 Jun
 2023 23:45:01 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:25 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-14-mshavit@google.com>
Subject: [PATCH v4 13/13] iommu/arm-smmu-v3-sva: Add check when enabling sva
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

