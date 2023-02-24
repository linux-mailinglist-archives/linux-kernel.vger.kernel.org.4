Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDEB6A1FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBXQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBXQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893476A7B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677257125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=13svcAbhKsbNR6lcnWL8PecfM86J5HXpB/wTf6k/HJg=;
        b=f+DR6jFhaf67jhNig1RYv+Bq/sbFKD/Chy8vdUgbfD0y3DB+uoKs5KlqbFpwp6gjsc/g2T
        Jqe6mW6IOtzyj69UGag6+RJvEFNGMMhqgaIVbFw8qrOBDN8Qd4sA/l0ckwL4HG83DuxTG3
        JaObMBOrDiPeg7xGpXnAXRo3j5DrBms=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-Yl1xVWA3PcikbfSEqSGoiA-1; Fri, 24 Feb 2023 11:45:24 -0500
X-MC-Unique: Yl1xVWA3PcikbfSEqSGoiA-1
Received: by mail-qt1-f200.google.com with SMTP id cr14-20020a05622a428e00b003b82d873b38so7185017qtb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13svcAbhKsbNR6lcnWL8PecfM86J5HXpB/wTf6k/HJg=;
        b=5wKaE77JXb50qbxJodFmZVHsG+U38CZ0zyaX2qZ2+uYpT2lXZUDYlec3vCvQpmeAbA
         xJ0MIX5ySl8k+d5M80FZ+bLpqxer9WRyhNX6FZqnv4+Djs7P61FbGIqCkZGwT70lJpuZ
         oOqsg2VBw+BXGDD8H08O8bf91SQ0flJj7EorV0h1MqF5cq7GtGLD6chkZ12rVPWkUFqV
         w/4GCtT9pSLoVSbgvIkMGyWGixHlUF3YWbirJB+TPQB/EXBxrNjyQyMVjrgwbI0flcf3
         E69Mfc/mytXaLlFj6ghSozg5dX3544G9gR5ORE9+ekoDthCAIiRVlQ9EiSedt/r2+3mm
         6GCQ==
X-Gm-Message-State: AO0yUKWiT8JeGVU877xkQKgj+fIgIcO2Q3VFcyNPaCCB3jstzi0QW3on
        8plTsO1YNJySyv1FWzZ7TNE3UaY43FIeVsux66TfDGz3mmlpHO7Ane+uHzwfWxNeLKvf3WE4uKn
        WE/Ghton8WGzDGGnDwyRW5B+J
X-Received: by 2002:ac8:5744:0:b0:3bd:dfe:9c1d with SMTP id 4-20020ac85744000000b003bd0dfe9c1dmr24611378qtx.59.1677257123552;
        Fri, 24 Feb 2023 08:45:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9ab3tb8sJ9dHB9BnRpA5KhvlL1jf3eeYsfFKZ/ZRG9txC27LuVJrseS7PPvfb60RIOXh+Tbw==
X-Received: by 2002:ac8:5744:0:b0:3bd:dfe:9c1d with SMTP id 4-20020ac85744000000b003bd0dfe9c1dmr24611334qtx.59.1677257123231;
        Fri, 24 Feb 2023 08:45:23 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id oq21-20020a05620a611500b0074235fc7a69sm5506113qkn.68.2023.02.24.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 08:45:22 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        ruijing.dong@amd.com, Jane.Jian@amd.com, James.Zhu@amd.com,
        tao.zhou1@amd.com, sonny.jiang@amd.com, leo.liu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove unused variable ring
Date:   Fri, 24 Feb 2023 11:45:19 -0500
Message-Id: <20230224164519.2757173-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

building with gcc and W=1 reports
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:81:29: error: variable
  ‘ring’ set but not used [-Werror=unused-but-set-variable]
   81 |         struct amdgpu_ring *ring;
      |                             ^~~~

ring is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 213b43670f23..023a1fffa6a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -78,12 +78,10 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
 		for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-			ring = &adev->vcn.inst[i].ring_enc[0];
 			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
 				adev->vcn.harvest_config |= 1 << i;
 				dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", i);
-- 
2.27.0

