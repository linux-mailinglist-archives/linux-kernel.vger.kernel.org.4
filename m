Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452077509A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjGLNdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGLNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D70910E2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689168779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0i3InOD4/QpHddyNR5vxwmI9uh0f61TZ6Eu8ertMv3o=;
        b=U8Y+vSc9tE4DMs0c2UdvqAJ9dhST/cFiS1w9zJush61FxiO/12z4IJ5PVumnSh2OmXuPIj
        pZ/Fpyjz3Gjfs7VbfBOJ5j3+6riHSZGkJfV3tPiNJowxc7OuWd4f+NshnnPzVXk2eQ2LBv
        LQw1jt09TJSVAbcoRSOyy+X90NNUjRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-fLVZVRMLMiOdyLSlbe9mpw-1; Wed, 12 Jul 2023 09:32:54 -0400
X-MC-Unique: fLVZVRMLMiOdyLSlbe9mpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A9FD8022EF;
        Wed, 12 Jul 2023 13:32:53 +0000 (UTC)
Received: from p1.luc.cera.cz.com (unknown [10.45.225.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE8092166B27;
        Wed, 12 Jul 2023 13:32:51 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Simon Horman <simon.horman@corigine.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Ma Yuying <yuma@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] i40e: Wait for pending VF reset in VF set callbacks
Date:   Wed, 12 Jul 2023 15:32:47 +0200
Message-ID: <20230712133247.588636-2-ivecera@redhat.com>
In-Reply-To: <20230712133247.588636-1-ivecera@redhat.com>
References: <20230712133247.588636-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 028daf80117376 ("i40e: Fix attach VF to VM issue") fixed
a race between i40e_ndo_set_vf_mac() and i40e_reset_vf() during
an attachment of VF device to VM. This issue is not related to
setting MAC address only but also VLAN assignment to particular
VF because the newer libvirt sets configured MAC address as well
as an optional VLAN. The same behavior is also for i40e's
.ndo_set_vf_rate and .ndo_set_vf_spoofchk where the callbacks
just check if the VF was initialized but not wait for the finish
of pending reset.

Reproducer:
[root@host ~]# virsh attach-interface guest hostdev --managed 0000:02:02.0 --mac 52:54:00:b4:aa:bb
error: Failed to attach interface
error: Cannot set interface MAC/vlanid to 52:54:00:b4:aa:bb/0 for ifname enp2s0f0 vf 0: Resource temporarily unavailable

Fix this issue by using i40e_check_vf_init_timeout() helper to check
whether a reset of particular VF was finished in i40e's
.ndo_set_vf_vlan, .ndo_set_vf_rate and .ndo_set_vf_spoofchk callbacks.

Tested-by: Ma Yuying <yuma@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c   | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index ad30f9e99db9..87207fc546b7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4466,13 +4466,11 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	}
 
 	vf = &pf->vf[vf_id];
-	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto error_pvid;
 	}
+	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	if (le16_to_cpu(vsi->info.pvid) == vlanprio)
 		/* duplicate request, so just return success */
@@ -4616,13 +4614,11 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	}
 
 	vf = &pf->vf[vf_id];
-	vsi = pf->vsi[vf->lan_vsi_idx];
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto error;
 	}
+	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	ret = i40e_set_bw_limit(vsi, vsi->seid, max_tx_rate);
 	if (ret)
@@ -4789,9 +4785,7 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
 	}
 
 	vf = &(pf->vf[vf_id]);
-	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
-			vf_id);
+	if (!i40e_check_vf_init_timeout(vf)) {
 		ret = -EAGAIN;
 		goto out;
 	}
-- 
2.41.0

