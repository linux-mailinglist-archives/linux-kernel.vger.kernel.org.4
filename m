Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0E6A9918
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCCOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCCOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:07:29 -0500
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC6261514
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:07:25 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677852443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NW+2VZkkaD7maLaTQ+oM0QO1gb/Joyzx1JiHH9vMbMs=;
        b=A7qOVN8GzCG0y64sbACMvAruZPyZbnTWfLig7GfDOn4mls50y4J6EZ5ujyLHVQoxVA2+Bv
        Ss5S0mErDxJJXuMl8m5jhTtkstfvUzijg55NHZMxvPbSG4Q+289wwoSdeUaeXneDZ5zofZ
        ucmVc38uA+QGXN2ik/9qrRN+D9daMIE=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/gvt: Make use of idr_find and idr_for_each_entry in dmabuf
Date:   Fri,  3 Mar 2023 22:07:18 +0800
Message-Id: <20230303140718.25355-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the already existing IDR mechanism to simplify
and improve the dmabuf code.

Using 'vgpu.object_idr' directly instead of 'dmabuf_obj_list_head'
or 'dmabuf.list', because the dmabuf_obj can be found by 'idr_find'
or 'idr_for_each_entry'.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v1->v2:
	1.Use idr_find to get the target one and free it instead of free all dma objs.
	2.Revert the original code 'ret' related
	3.Add '&& !idr_is_empty()' like the original code '&& !list_empty()'

v1 link:
	https://lore.kernel.org/lkml/20230302115318.79487-1-cai.huoqing@linux.dev/

 drivers/gpu/drm/i915/gvt/dmabuf.c | 58 +++++++------------------------
 drivers/gpu/drm/i915/gvt/dmabuf.h |  1 -
 drivers/gpu/drm/i915/gvt/gvt.h    |  1 -
 drivers/gpu/drm/i915/gvt/vgpu.c   |  1 -
 4 files changed, 12 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 6834f9fe40cf..cf619b1ed3ad 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -133,21 +133,15 @@ static void dmabuf_gem_object_free(struct kref *kref)
 	struct intel_vgpu_dmabuf_obj *obj =
 		container_of(kref, struct intel_vgpu_dmabuf_obj, kref);
 	struct intel_vgpu *vgpu = obj->vgpu;
-	struct list_head *pos;
 	struct intel_vgpu_dmabuf_obj *dmabuf_obj;
 
 	if (vgpu && test_bit(INTEL_VGPU_STATUS_ACTIVE, vgpu->status) &&
-	    !list_empty(&vgpu->dmabuf_obj_list_head)) {
-		list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-			dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
-			if (dmabuf_obj == obj) {
-				list_del(pos);
-				idr_remove(&vgpu->object_idr,
-					   dmabuf_obj->dmabuf_id);
-				kfree(dmabuf_obj->info);
-				kfree(dmabuf_obj);
-				break;
-			}
+	    !idr_is_empty(&vgpu->object_idr)) {
+		dmabuf_obj = idr_find(&vgpu->object_idr, obj->dmabuf_id);
+		if (dmabuf_obj) {
+			idr_remove(&vgpu->object_idr, obj->dmabuf_id);
+			kfree(dmabuf_obj->info);
+			kfree(dmabuf_obj);
 		}
 	} else {
 		/* Free the orphan dmabuf_objs here */
@@ -340,13 +334,12 @@ static struct intel_vgpu_dmabuf_obj *
 pick_dmabuf_by_info(struct intel_vgpu *vgpu,
 		    struct intel_vgpu_fb_info *latest_info)
 {
-	struct list_head *pos;
 	struct intel_vgpu_fb_info *fb_info;
 	struct intel_vgpu_dmabuf_obj *dmabuf_obj = NULL;
 	struct intel_vgpu_dmabuf_obj *ret = NULL;
+	int id;
 
-	list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
+	idr_for_each_entry(&vgpu->object_idr, dmabuf_obj, id) {
 		if (!dmabuf_obj->info)
 			continue;
 
@@ -366,24 +359,6 @@ pick_dmabuf_by_info(struct intel_vgpu *vgpu,
 	return ret;
 }
 
-static struct intel_vgpu_dmabuf_obj *
-pick_dmabuf_by_num(struct intel_vgpu *vgpu, u32 id)
-{
-	struct list_head *pos;
-	struct intel_vgpu_dmabuf_obj *dmabuf_obj = NULL;
-	struct intel_vgpu_dmabuf_obj *ret = NULL;
-
-	list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
-		if (dmabuf_obj->dmabuf_id == id) {
-			ret = dmabuf_obj;
-			break;
-		}
-	}
-
-	return ret;
-}
-
 static void update_fb_info(struct vfio_device_gfx_plane_info *gvt_dmabuf,
 		      struct intel_vgpu_fb_info *fb_info)
 {
@@ -477,11 +452,6 @@ int intel_vgpu_query_plane(struct intel_vgpu *vgpu, void *args)
 
 	update_fb_info(gfx_plane_info, &fb_info);
 
-	INIT_LIST_HEAD(&dmabuf_obj->list);
-	mutex_lock(&vgpu->dmabuf_lock);
-	list_add_tail(&dmabuf_obj->list, &vgpu->dmabuf_obj_list_head);
-	mutex_unlock(&vgpu->dmabuf_lock);
-
 	gvt_dbg_dpy("vgpu%d: %s new dmabuf_obj ref %d, id %d\n", vgpu->id,
 		    __func__, kref_read(&dmabuf_obj->kref), ret);
 
@@ -508,7 +478,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
 
 	mutex_lock(&vgpu->dmabuf_lock);
 
-	dmabuf_obj = pick_dmabuf_by_num(vgpu, dmabuf_id);
+	dmabuf_obj = idr_find(&vgpu->object_idr, dmabuf_id);
 	if (dmabuf_obj == NULL) {
 		gvt_vgpu_err("invalid dmabuf id:%d\n", dmabuf_id);
 		ret = -EINVAL;
@@ -570,23 +540,19 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
 
 void intel_vgpu_dmabuf_cleanup(struct intel_vgpu *vgpu)
 {
-	struct list_head *pos, *n;
 	struct intel_vgpu_dmabuf_obj *dmabuf_obj;
+	int id;
 
 	mutex_lock(&vgpu->dmabuf_lock);
-	list_for_each_safe(pos, n, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
+	idr_for_each_entry(&vgpu->object_idr, dmabuf_obj, id) {
 		dmabuf_obj->vgpu = NULL;
 
-		idr_remove(&vgpu->object_idr, dmabuf_obj->dmabuf_id);
-		list_del(pos);
-
+		idr_remove(&vgpu->object_idr, id);
 		/* dmabuf_obj might be freed in dmabuf_obj_put */
 		if (dmabuf_obj->initref) {
 			dmabuf_obj->initref = false;
 			dmabuf_obj_put(dmabuf_obj);
 		}
-
 	}
 	mutex_unlock(&vgpu->dmabuf_lock);
 }
diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.h b/drivers/gpu/drm/i915/gvt/dmabuf.h
index 3dcdb6570eda..93c0e00bdab9 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.h
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.h
@@ -57,7 +57,6 @@ struct intel_vgpu_dmabuf_obj {
 	__u32 dmabuf_id;
 	struct kref kref;
 	bool initref;
-	struct list_head list;
 };
 
 int intel_vgpu_query_plane(struct intel_vgpu *vgpu, void *args);
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 2d65800d8e93..1100c789f207 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -211,7 +211,6 @@ struct intel_vgpu {
 
 	struct dentry *debugfs;
 
-	struct list_head dmabuf_obj_list_head;
 	struct mutex dmabuf_lock;
 	struct idr object_idr;
 	struct intel_vgpu_vblank_timer vblank_timer;
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 08ad1bd651f1..0a511cfef067 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -329,7 +329,6 @@ int intel_gvt_create_vgpu(struct intel_vgpu *vgpu,
 	vgpu->sched_ctl.weight = conf->weight;
 	mutex_init(&vgpu->vgpu_lock);
 	mutex_init(&vgpu->dmabuf_lock);
-	INIT_LIST_HEAD(&vgpu->dmabuf_obj_list_head);
 	INIT_RADIX_TREE(&vgpu->page_track_tree, GFP_KERNEL);
 	idr_init_base(&vgpu->object_idr, 1);
 	intel_vgpu_init_cfg_space(vgpu, 1);
-- 
2.34.1

