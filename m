Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AE737BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjFUGpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjFUGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:44:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260B2112
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc7267224adso10882628276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329861; x=1689921861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8az5zJDH0ESFjwiqnExbJyBaF+tF0BTQf7Bxk21/Xo=;
        b=MmssWY+3YFktxIF/WA4KOY5DVa4UBDzQVE2mTxNFaVyKAMTQcPmzrUyKnRow1u5/1i
         0meUrWB+7qdjGxGk/BZXzmzb1pQ53nSbLZW7KEXzmJ1wTWPeYpDaHRWw5MR6gg5fRS/t
         ku0AYHWl3On0+y1JE0YaBf7Aeap5dO2iKcztXzsyi5LQbiU3nBTbOOBGFhj+kVO1nPS/
         L1ltlHWhVDA8Qr/1MoVmRNWP3cN11BDGjlQjTXU+uttVYyoXzTzGdapoPcBYaZqSXJL0
         P6GwQQiyXHV7CzI5aqwk/8XCza5dBcBmpLoo5ytAswHLv7lm0GTilChwtaq7QlU0zcFb
         bo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329861; x=1689921861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8az5zJDH0ESFjwiqnExbJyBaF+tF0BTQf7Bxk21/Xo=;
        b=daZGyYb/OLJiyxJkNjW3gKexX752r6/FAkASZygWU3wLmUSk4q0p6kwsxz32bZpIyH
         uvMvL+uP02nGF3ikYyXkTr3ghy0H+eEO/XMUh038ZY0ANC979352nGkAwhF9i3qqcO0l
         6oDOaqmXkdo6/gDqTxsQh49W38c4Yco0tHaVsuJLW/5+ybl+hYipUtB+vrbZTcVjrFY3
         mpIqYJYhR90heXt0k29vpsvcZPADHwIhdU/tK6Vt7nR3uKIcGdVS5HS7rCnE9vm1ytrc
         zCRhgHEUdpiYzF+/fG9dOb2ujAFV50xSw0tFgJjPLRoXnjnKYrRUXYQWdQeuobdDhysR
         4Rnw==
X-Gm-Message-State: AC+VfDzShRkFrVXtmQwJ4+FCS3Rd63bGicmUJ9PleoM+GsXXazN7hUww
        q83ZwgQv95DjGVBhqk7NcZdmYE1JlqT/
X-Google-Smtp-Source: ACHHUZ7mhXQYdCxoNYKF5SfDVv2FuZ4r9FDAvWLFLi6rVg6yhDNcK8dk0uoxOmNJIbocwU2FBeocvwwAg5dq
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a05:6902:92:b0:bc4:a660:528f with SMTP id
 h18-20020a056902009200b00bc4a660528fmr3348263ybs.5.1687329861096; Tue, 20 Jun
 2023 23:44:21 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:37:20 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-9-mshavit@google.com>
Subject: [PATCH v4 08/13] iommu/arm-smmu-v3: Add helper for atc invalidation
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
index 65e2dfd28b7d8..0a5e875abda86 100644
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

