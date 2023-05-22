Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B251570BE91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjEVMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjEVMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00063C5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684759269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g9y4gjNLxaDEH24wDgPXKc3Vz5FcUbglHfFP6OwJ8o8=;
        b=B5vTademYdeEEpbPHgwPUXuefm580w9iwqCddTXZKp8Ogcowi/vd413QCffMeklSzs1anu
        VKeCO2kuwf8MWo+xFvkSPHA3m5kSql7y1VstycVBUxA12BXrcWCNTu4Ts0Dv6B4L7Xazme
        rkcooKGG5d375Y3xX5z0h+9A909570Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ndmXYb45M_OiFI3ev6VYjA-1; Mon, 22 May 2023 08:30:18 -0400
X-MC-Unique: ndmXYb45M_OiFI3ev6VYjA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75788e0b1d3so468074185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758618; x=1687350618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9y4gjNLxaDEH24wDgPXKc3Vz5FcUbglHfFP6OwJ8o8=;
        b=PNN8H+JiwPf+66KW2GOBpy+jWhB8IhYqFLvIZKXRgNHoid/ztqq5ditMwpXAD8FgaY
         75jgkxDLse9YMEqbHEGLnZ3NYL8gjxv+RrBfhfroPtxy6FX5EdaIkPfr8y0VAsgv/pwp
         IQAmKxi4Q+sqJitJvcIqqKuFwp9EkWhQaZCj+HNUoTUmBngCBtL0FQg/vUMh3m/rgvW1
         9BpUUQ1iURJDRI3SZK3/HGvSvoVcETGyFYnZbYop4jrFyvcOvfj/UY7HarYkG/Zsebtn
         Io7r+uF8Ux1H5NN73/2EaNlbQGoG6EgsJJxlk6KBkVXsaeysItt5ILd1QAwzI+VPxJ6L
         KY4g==
X-Gm-Message-State: AC+VfDzRk/Q/xvWB3IcIOE4qkwyxwKgjB/pZiOHnHOkj+EzJImKtzW4E
        6ArRinXGYbzfHwDrsp7rcVWHcwbAJBVi5UKgOqiz2tu26/ajh3TT/BP0vr4weZp+Vfx0K+E4pNy
        TYg4XE02hzcaka7qW2tnSUP+L
X-Received: by 2002:a05:620a:a05:b0:75b:23a0:e7cc with SMTP id i5-20020a05620a0a0500b0075b23a0e7ccmr452020qka.45.1684758618194;
        Mon, 22 May 2023 05:30:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UrjSsJpTeaszPdkFwHOjVAMcErGGwfWpKAhK1T9BLt1EUApD/wnEnOkzOo2gzy/Phl2q3lw==
X-Received: by 2002:a05:620a:a05:b0:75b:23a0:e7cc with SMTP id i5-20020a05620a0a0500b0075b23a0e7ccmr451993qka.45.1684758617966;
        Mon, 22 May 2023 05:30:17 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n26-20020a05620a153a00b0075785052e97sm1670399qkk.95.2023.05.22.05.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:30:17 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, le.ma@amd.com, lijo.lazar@amd.com,
        tao.zhou1@amd.com, shiwu.zhang@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove unused variable num_xcc
Date:   Mon, 22 May 2023 08:30:13 -0400
Message-Id: <20230522123013.1065975-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:2138:13: error: variable
  ‘num_xcc’ set but not used [-Werror=unused-but-set-variable]
 2138 |         int num_xcc;
      |             ^~~~~~~

This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5cfb3adb3b3..63718cf02aa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2135,9 +2135,6 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v9_4_3_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int num_xcc;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
-- 
2.27.0

