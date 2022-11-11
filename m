Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE26F624EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiKKAWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKKAWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:22:31 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04E1F61E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:22:30 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y15-20020aa7804f000000b0056c9b4a58d3so1815404pfm.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qtct265AUs3mCRq4YXmCFT3mbV9fW5IFtDc5J2z2zs=;
        b=FBR88osY8fIlZLbRznAOCa2Xf7BHDJaHVBD3PLmB9KlLJqRyRDDLI3zyzsZcD0Rn5m
         5oCwjogt2zecTA7RiD9yeOlvc55mEqbD8BgDuCuDPhgkuTUGCTX+PZfFw8d63rpWQhSP
         4YkKHAyfDPUatmW5/skfXM0hFEJa+6kp7KfEuEWXg7E4DNB1ZzIThCPt1PM0BzD8Xdhq
         A/EPbIV3ybXi65UzJTKQ8T8FJMvIkmMoPVo3GTuq4UapPDYeRJRzaqoquBxRN2AYC9KA
         A/DU8ldikEieGp5BDIr3DGthufNFJEG9FQ/iYXTHPCiQh1sE8mL3YkDDK1B4aUDeO2MN
         Z8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qtct265AUs3mCRq4YXmCFT3mbV9fW5IFtDc5J2z2zs=;
        b=Q2GPEKqRyYfpm0CtV7yZGcd9IdtIepRJcLdbP83ANdJzwWXPEHV6MaobOQxqp/fVkf
         W+Kh3gFW16jIca69r94Et6po/u354iSYluEUDrUb/bwM6JmGkiS6l2b5ETu5ePNL5vvJ
         UqONifhGym6HGbEdWdmclA/zqCVQWsrXle3tlPxrRY49ZVabOIJmVJaUTBwyiEMceNqn
         MvG8F9A2uQf6YxDRapudwtdXECP/IkJEpDJf6sNmZYbX2f08/9kqCQ3Jv/xnOLFQ9ZBn
         g18EC20U5n+zE7iRtwlTnF7ohFVTIbHCCsqCAfe1PcTD+u5xUMe4o/EzVq/cMl6yBds7
         mzxQ==
X-Gm-Message-State: ACrzQf2N/tk4Q9QGjRfUXYyuTqZYEqrR4MrevgQjq3ar7KQsVTc1behQ
        l9yvh+WMk6IW6irFPmeBSWJ9S6COd1c=
X-Google-Smtp-Source: AMsMyM7iJ8xUv6oGaaWJB9TjFOHAMhWthcMv2slpXsAbeSOdSGcqg31xUyPwviIZlQaEysgjStUI+jeH2IM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:703:b0:56c:e37d:ec12 with SMTP id
 3-20020a056a00070300b0056ce37dec12mr4208245pfl.80.1668126149761; Thu, 10 Nov
 2022 16:22:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Nov 2022 00:22:24 +0000
In-Reply-To: <20221111002225.2418386-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221111002225.2418386-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111002225.2418386-2-seanjc@google.com>
Subject: [PATCH 1/2] drm/i915/gvt: Get reference to KVM iff attachment to VM
 is successful
From:   Sean Christopherson <seanjc@google.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get a reference to KVM if and only if a vGPU is successfully attached to
the VM to avoid leaking a reference if there's no available vGPU.  On
open_device() failure, vfio_device_open() doesn't invoke close_device().

Fixes: 421cfe6596f6 ("vfio: remove VFIO_GROUP_NOTIFY_SET_KVM")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 7a45e5360caf..e67d5267fde0 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -664,8 +664,6 @@ static int intel_vgpu_open_device(struct vfio_device *vfio_dev)
 		return -ESRCH;
 	}
 
-	kvm_get_kvm(vgpu->vfio_device.kvm);
-
 	if (__kvmgt_vgpu_exist(vgpu))
 		return -EEXIST;
 
@@ -676,6 +674,7 @@ static int intel_vgpu_open_device(struct vfio_device *vfio_dev)
 
 	vgpu->track_node.track_write = kvmgt_page_track_write;
 	vgpu->track_node.track_flush_slot = kvmgt_page_track_flush_slot;
+	kvm_get_kvm(vgpu->vfio_device.kvm);
 	kvm_page_track_register_notifier(vgpu->vfio_device.kvm,
 					 &vgpu->track_node);
 
-- 
2.38.1.431.g37b22c650d-goog

