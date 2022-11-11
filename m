Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F45624EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiKKAWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiKKAWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:22:32 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B6543872
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:22:31 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o7-20020a170902d4c700b001868cdac9adso2403983plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=n36J7s+0ilM0Tsn5slAdsXyaRWJfxWCAeT/6FWqeTp8=;
        b=TZiKdFTbv7ULH977/XXkoaKwCBWIUXcZgjj3kk67qk6G/7NTnWl7f9ErIfa3sgs6Iu
         PIE2j9lVQnRevVhSmgy5ghpMaowZSmo/JvV26NB/u5XUxIGVX2T3kGhGEB+GX40/BH+e
         dMm5i34zN0Ep9bgjqiptCmyqKJTPz98+Gc5Erv/2Hk0eC6sx/JrEjrvIb4L//JadZb+D
         yyrZCQmeoRcq14GM/aKC8IJAyy66Zz5B57Ex00OXo4YACUPRLXDVs9TboavE9uxTi60O
         H5HIhz1q4T4MEoC0qbI3gIAqHaqRVBYY+wU9Sv6jmDDDGplg8ezaO+Oydl1V1nV+l4ZE
         GG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n36J7s+0ilM0Tsn5slAdsXyaRWJfxWCAeT/6FWqeTp8=;
        b=voRodq6sa9ttDSJRgPNpQSFapiUVq5vKr4WaGL1Tz95QA2RSGxIIf9eHjmZY7PlzbM
         5hpKJ82Kv2d2v/LUixDSZn1oG2C2dxGufMyc67m8hHWuVZlUUfa6dGQLkaOMEmlZ8XxE
         8lahKnCF1XIZZZ3b81O/t/XyS3Rqm6co9OxWm5jXnx8pHszY/Iz8JvaDcXtwJcVjcbI8
         o3TOJEGHFOP258wbAZ1qQQQ9wyw44tav0aUt0mEYVYBixuj5E9NexuFLgX+sdMYf06lp
         3aPx+CfqCfg3gFhzKG5hhsaAMuEehd9yh0HvGvKjkNHkSdDRUw++LCH0ALrBltaXPcnj
         b70Q==
X-Gm-Message-State: ANoB5pmWYz6OvyRyUnS94hPBbkej7FhOaZdfsNcs48ZENNea9+yLeiHa
        KEznS43UH6qNjZBlZXWG0iFlZwpgT1U=
X-Google-Smtp-Source: AA0mqf59PK1ce8OQvm+mdu5I4wtiwB4LZ1gWqBvwwJnwlP7+YuZxp1WsB+ro/Om0CHqF+A4TMJj0VFzo6aE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dac4:b0:186:5f54:18cf with SMTP id
 q4-20020a170902dac400b001865f5418cfmr4884plx.141.1668126151578; Thu, 10 Nov
 2022 16:22:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Nov 2022 00:22:25 +0000
In-Reply-To: <20221111002225.2418386-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221111002225.2418386-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111002225.2418386-3-seanjc@google.com>
Subject: [PATCH 2/2] drm/i915/gvt: Unconditionally put reference to KVM when
 detaching vGPU
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

Always put the KVM reference when closing a vCPU device, as
intel_vgpu_open_device() succeeds if and only if the KVM pointer is
valid and a reference to KVM is acquired.  And if that doesn't hold true,
the call to kvm_page_track_unregister_notifier() a few lines earlier is
doomed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index e67d5267fde0..714221f9a131 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -714,15 +714,14 @@ static void intel_vgpu_close_device(struct vfio_device *vfio_dev)
 
 	kvm_page_track_unregister_notifier(vgpu->vfio_device.kvm,
 					   &vgpu->track_node);
+	kvm_put_kvm(vgpu->vfio_device.kvm);
+
 	kvmgt_protect_table_destroy(vgpu);
 	gvt_cache_destroy(vgpu);
 
 	intel_vgpu_release_msi_eventfd_ctx(vgpu);
 
 	vgpu->attached = false;
-
-	if (vgpu->vfio_device.kvm)
-		kvm_put_kvm(vgpu->vfio_device.kvm);
 }
 
 static u64 intel_vgpu_get_bar_addr(struct intel_vgpu *vgpu, int bar)
-- 
2.38.1.431.g37b22c650d-goog

