Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06B730417
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbjFNPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244844AbjFNPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:44:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DEC2964
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:44:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56fffdea2d0so11289977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757471; x=1689349471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=omVhI9NBPuwnuDBL2dAuwy0d7VVlvqTslf6ohlhvBoo=;
        b=jMlnk/MKenoGoe+vncInH3bNLbjsOY0Xrv5py/yEVhJC0Voa9L6CSXUuAVOi6fmYCJ
         Tgf0uByedAMjl4kDugva5Z7ex59EM1z4IazeM7oUL8ziiQDhW3iZaQ0JG9Qm40ngiaZL
         +M5Dg5le9q5NHjjTl7k9QZk59/KC3EuCDrBCsL0bF4lycPrvzpsN0P/LhUKYz/tUyV0x
         isJj8aPRjzh8meDpJOrtJNeFlx8yvD55tCSLvcLBEnDtcXfsEbJZtuB1BwtuBcopqymr
         /Rvz8IKzzGTFog5Cr0gOu/QV8fyEzYweTi1tUgmgmlB4M3eES0bWGS4bsAPec9Qi8ALG
         4M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757471; x=1689349471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omVhI9NBPuwnuDBL2dAuwy0d7VVlvqTslf6ohlhvBoo=;
        b=Bh3Gb5S7qzj0H97bclROhZb9eLtQupad0t3DkCAoXb/OQacU/locz5zauFM5fFzyXb
         COwG0Mj7RZYcAjaM3jArmjDJWiYWmds4jWsqlTNoROJ7rtQ84QfhDk6ZgLy6J3sYrDIU
         Hg23lZQgoRIgGrx6UVCbHWfehRzHWfgAB4LTO41QIaZLQmVgDDht+oePqqHl9SikqCuX
         5bFUeZM97LjR6E0BObvBumpIN3h9EYtbahvfFQt+Kn66/585FVMkt0WkNEuUvygMlHx8
         AOIe34lB9BHFrK8HqC5KzdlvQoACmKmIdYE8wYfFGlIwVMWpeGvZO+NiwrWERAt+JCFF
         9w9g==
X-Gm-Message-State: AC+VfDy8oqcEk02luulnnK9hnclvERiSsfLcJlhjN69rAdftv565u7ZV
        FYbBn47Phzh+WMubDuRfYE6GrehjPW7W
X-Google-Smtp-Source: ACHHUZ6qWrQixYgUn/5HtahtJSL3blxJF6JctRnT69qFj5a4lL50PstwAlMR8K47HQ216a2/pWujMLt858mE
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a81:4426:0:b0:568:c4ea:ce66 with SMTP id
 r38-20020a814426000000b00568c4eace66mr971778ywa.5.1686757470875; Wed, 14 Jun
 2023 08:44:30 -0700 (PDT)
Date:   Wed, 14 Jun 2023 23:42:00 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-9-mshavit@google.com>
Subject: [PATCH v3 08/13] iommu/arm-smmu-v3: Add helper for atc invalidation
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

This will be used to invalidate ATC entries made on an SSID for a master
when detaching a domain with pasid.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v1->v2: Make use of arm_smmu_atc_inv_cmd_set_ssid
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 70580ba7065dc..176013bb974b8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1784,13 +1784,15 @@ arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master_ssid(struct arm_smmu_master *master,
+					int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, &cmd);
+	arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
@@ -1800,6 +1802,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+{
+	return arm_smmu_atc_inv_master_ssid(master, 0);
+}
+
 /*
  * If ssid is non-zero, issue atc invalidations with the given ssid instead of
  * the one the domain is attached to. This is used by SVA since it's pasid
-- 
2.41.0.162.gfafddb0af9-goog

