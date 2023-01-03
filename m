Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B165BE70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjACKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjACKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:51:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B5FFC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672743105; x=1704279105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmnHqI3tKK38BSUrN2DgjBvLt72f0TuIKDBVQU/rvhw=;
  b=ddfmerVjrE7+0suayq7UkX2tHTfDp5ezOWMIB5e1Rye1oVg2/Q7+Uv1M
   k/Ja6KmucxqmJd1UheCeOHBnDGeG1Al4jXcUBxgZnbmBh2qK8DrpMOzJt
   YC5hm3WbPhIHXGfQd9lTK2/9Zt69CXnAvIvCzxOqk1ClEzIo6NILmdkbG
   Y3oNjACCZQKRGFYWIzOavOG90Vl04T0FhHSOo9F3d+/RapiWkA4AxiPa0
   nftFlUt6R3ei3B3VSOW1YrqgtdFuzPaa8Z4QA1dE8r/+cPYQRjaoNM3eh
   +pmFdPXyu07VUMy+Q84pucO2g2bnjVrxdO7ux26102vAsLQnQYh+HnHUX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301318478"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="301318478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604772731"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="604772731"
Received: from isobansk-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.24.246])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:43 -0800
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v6 4/4] vdpa_sim: Implement resume vdpa op
Date:   Tue,  3 Jan 2023 11:51:08 +0100
Message-Id: <15a4566826033c5dd9a2167e5cfb0ef4d90cea49.1672742878.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1672742878.git.sebastien.boeuf@intel.com>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
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
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 +++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..756a5db0109c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -357,6 +357,12 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
+	if (!vdpasim->running &&
+	    (vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		vdpasim->pending_kick = true;
+		return;
+	}
+
 	if (vq->ready)
 		schedule_work(&vdpasim->work);
 }
@@ -527,6 +533,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
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
@@ -717,6 +744,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_status             = vdpasim_set_status,
 	.reset			= vdpasim_reset,
 	.suspend		= vdpasim_suspend,
+	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
@@ -750,6 +778,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
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
2.37.2

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

