Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5FD60E42B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiJZPJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiJZPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:09:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6B2200
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666796964; x=1698332964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xRbBHi5E+N2qU/Z+c5NfZHEpwCKk1QOB5B18pjThjKE=;
  b=QmeLlV4MhkNOzGy6Uj26VA187RwSJHPE0qEAZHjWlwpkDFgeFTph0DCJ
   JV9YB6QEyKzLdNY814xoavjc4li/j+TlnhuVk5WJboG46PmU64dpWCXHo
   c9g8SHKrUCIUiCza6ueBpraA9KqNjcpOhRY0idhtjNCZTu4CAQXPKyLqX
   zbS52c9EaOGojFW5u8uvpkkd9HxLBM/kOsfjaFOW0L6EeHsuL7ri6D7uo
   6A200kvsSIGkSvivYsraqEA5NkJx9UmHwljxVD2RNyvrWxd5GNpbj+DWE
   YSQcXqwrsayMLVSiKRnwDgnjH29bRLJOt6RinO9Zga+ouBlXQPkT7d4Ql
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="372178709"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="372178709"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:09:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961252466"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="961252466"
Received: from briansim-mobl.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.29.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:09:01 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
Date:   Wed, 26 Oct 2022 17:08:38 +0200
Message-Id: <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666796792.git.sebastien.boeuf@intel.com>
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

Implement resume operation for vdpa_sim devices, so vhost-vdpa will
offer that backend feature and userspace can effectively resume the
device.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..84fee8bb2929 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -357,6 +357,11 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
+	if (!vdpasim->running) {
+		vdpasim->pending_kick = true;
+		return;
+	}
+
 	if (vq->ready)
 		schedule_work(&vdpasim->work);
 }
@@ -527,6 +532,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 	return 0;
 }
 
+static int vdpasim_resume(struct vdpa_device *vdpa)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	int i;
+
+	spin_lock(&vdpasim->lock);
+	vdpasim->running = true;
+
+	if (vdpasim->pending_kick) {
+		/* Process pending descriptors */
+		for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
+			vdpasim_kick_vq(vdpa, i);
+
+		vdpasim->pending_kick = false;
+	}
+
+	spin_unlock(&vdpasim->lock);
+
+	return 0;
+}
+
 static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -717,6 +743,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_status             = vdpasim_set_status,
 	.reset			= vdpasim_reset,
 	.suspend		= vdpasim_suspend,
+	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
@@ -750,6 +777,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_status             = vdpasim_set_status,
 	.reset			= vdpasim_reset,
 	.suspend		= vdpasim_suspend,
+	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 0e78737dcc16..a745605589e2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -67,6 +67,7 @@ struct vdpasim {
 	u64 features;
 	u32 groups;
 	bool running;
+	bool pending_kick;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
 };
-- 
2.34.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 5 208 026.16 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

