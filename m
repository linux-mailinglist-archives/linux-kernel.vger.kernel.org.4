Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9C602725
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJRIid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJRIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:38:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91769F773
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666082296; x=1697618296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PL0A8+uYcphH0sIJRwXwGnLqTPe3EEcbUoVnkmTTq0Q=;
  b=G2co5r0GCuLEe7+tygjD5t455Tjk+9n4WGRgvg0HGN3s6R7eXNB6Ic8f
   LE5Keykfo8lHhuuwi49RMlKzgrYavRuIB2LX3XFNsAJQjK4hPza9sCAGZ
   398qzHQ2nCb+PoKt2o6T1nywo6ndDScV9xdO+rxmzIUlJ379Sgct5G09X
   Fz22WBnQAYxs9dDaSOxeJ9712flzGnKdSMXoqOB6dpTd803hY4oWVT04G
   pYnfD4fdxeNNY48HOALmbLFKm4Att1mzcia0VOMeta5sxrupWE4W3RZjc
   XRYVpDOP2YgbhL9/xBDEPoq6rFHZgmHpmD1jL7WtLp8sM1pHf8Ye0ZelU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368069143"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="368069143"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:38:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753951155"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="753951155"
Received: from aboyhan-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.26.192])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:38:13 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v4 4/4] vdpa_sim: Implement resume vdpa op
Date:   Tue, 18 Oct 2022 10:37:27 +0200
Message-Id: <56c045ac70e44e7d80f3f9e901deae3d7485b2a1.1666082013.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666082013.git.sebastien.boeuf@intel.com>
References: <cover.1666082013.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..05e3802fb746 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -527,6 +527,18 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 	return 0;
 }
 
+static int vdpasim_resume(struct vdpa_device *vdpa)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	int i;
+
+	spin_lock(&vdpasim->lock);
+	vdpasim->running = true;
+	spin_unlock(&vdpasim->lock);
+
+	return 0;
+}
+
 static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -717,6 +729,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_status             = vdpasim_set_status,
 	.reset			= vdpasim_reset,
 	.suspend		= vdpasim_suspend,
+	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
@@ -750,6 +763,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_status             = vdpasim_set_status,
 	.reset			= vdpasim_reset,
 	.suspend		= vdpasim_suspend,
+	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
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

