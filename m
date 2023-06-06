Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898B7241BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjFFMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjFFMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:10:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3371725
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:10:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb05f0e6ef9so8995233276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053415; x=1688645415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q0Iu14cVZzOpWwfTMTOhF5XX3kNov0fzYqifn+D0GY=;
        b=Qj9FF129nefazp7rsEoZgyUDmzsW8Dl4oEfnoMt+BCvxl+NTWVy4OR8Ok5LqOWKaUx
         OH7Ra2Dk8NTJ1kmkTIH+GHrVJ6MooFUGr5V25M/4AriM4Cz8/19OmBMafzikZWYs40Qm
         Fm13HyQurOg1VgQWnI/LXtDi8eOJhMzFYZLUgVv4ltWLJ/xFS52hTWzsa+AUMGoRw701
         UWMML1rZU2decc6dYLad29aIonKRI1Ygob0M9Vxe7Oe5pnNn9zl3Yxvx8/CaB3mrwLhR
         DUfVGLtQJ2r9UdgtgOlHuFp9zLZ1wVr8e0hzTvXgagApF3nwANZv4uRM+s4bJO8+8g/o
         gfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053415; x=1688645415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q0Iu14cVZzOpWwfTMTOhF5XX3kNov0fzYqifn+D0GY=;
        b=VYHCbEWVJpN5O6g+AMBckNDi9kEM0xIeZiUqumgl3m9mfeG3T/YfLukC0msH8RzCI9
         1He20qOrOF6x9C6P7zglF84buVXTLLYY670ns1dYGPrVRhiCiD6qVz2L2rAqfQTik5sM
         YkpptGtEAQ+QOL+JBSG0uM6ATeVr3c8dja0hV30rzHwmHXGa9IJoHD55yyYJUz/yfNK6
         NjBjbB/9/9J6BzaH9mo6TVR2eJGox1+2QuEM4QzSilnGIzAUxYa8mKdSm63AyCTCCjk+
         wSxUNoV6o9n6Pbg1eqpLJ45X5LR2XS9Z0Hr9b/fWly/PVdl0TpiQq5+yAtJeEr8jiuvt
         9syg==
X-Gm-Message-State: AC+VfDyuBa0TjFhPmKQSYFqvsJ6Q8al7l9nWaE3celAS1K/pKQuW5SSB
        TkQPWsd8V43XjFcvAzfKWFMaRuKKBP7c
X-Google-Smtp-Source: ACHHUZ7jK5Jjz1CVCGvoACxb+sx/xnsAJ9T0sjJSsJfmybQ9sFj4pmgNmu8oIVfJWJ4QZm4rznUCA24jkhkf
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a25:7d02:0:b0:ba8:1e72:2c88 with SMTP id
 y2-20020a257d02000000b00ba81e722c88mr941602ybc.13.1686053414834; Tue, 06 Jun
 2023 05:10:14 -0700 (PDT)
Date:   Tue,  6 Jun 2023 20:07:44 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-9-mshavit@google.com>
Subject: [PATCH v2 08/18] iommu/arm-smmu-v3: Add helper for atc invalidation
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
2.41.0.rc0.172.g3f132b7071-goog

