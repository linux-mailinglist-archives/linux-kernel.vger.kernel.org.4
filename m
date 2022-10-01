Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293ED5F1D17
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJAO7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJAO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F839E691
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/3Usn0qxo83EKXGxCer0F1RKa2ZQEkOpzpL2CjOlas=;
        b=TbccEn55uWC+ntpweff5hG+jtLFR5T7RGH0r96/hB/sdkSt0g+yYCzOHqwQqKz/nXe2Cxu
        cGJXtivPtO3jz81FsBx7i0ngTyRjFgzIVJsf7FGJ6lmqO7s+eXEXAIXRvcwe/74FymPFuF
        MkvcRn+oDsvaETakw8gp+SUBpmL+CH0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-459-4RSpzVohOS2z3EFadAUrSw-1; Sat, 01 Oct 2022 10:58:38 -0400
X-MC-Unique: 4RSpzVohOS2z3EFadAUrSw-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so5594574eda.19
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=V/3Usn0qxo83EKXGxCer0F1RKa2ZQEkOpzpL2CjOlas=;
        b=8P2d3Ov7SUCVUTqEeA5+wsGzGgtttS4pJFlWN9ng2NKFkm9nhPyHTLiGTCl+wEzNKJ
         8Gzn1D0YvqTWI633yRjJ68qMXsMBbUv4VkIRvBuPGjPHVHNaHZcAaRAQzVyLqRu1uTbo
         nr+fgN8gjd+8yqJ2aeSA8EGmfzzqAKVesh19YaAeiSVwuTMNb4nwAWrWhIw0QDLMF9UB
         pjR+are5pnG4C0mYpp+ZRgspjU2vo9nMaWp7MblR4xBvowNUm7Qr3wyHFi3p1xZHqvok
         P/Ak54nXp+rUK6KgxA6giUhD6bMn5bl4A1/IMSJVhmtrR5Cop5NX4HsGdm4YQloYvh2K
         WBPg==
X-Gm-Message-State: ACrzQf2ZOjoTMqh+85Rahb0Qyvzb6V3dL2ssZoJNk2Zrw5VgGYpWus/C
        E4GUG3Y/mYFvZXqvEiwR3iCnp3qhqvqUotWTPTsTS4MUHWrlwcoQScYJshk+leNQ9I6IYkVt3Hy
        BIUXOA6niQl4ag/HgmxfiHLK9
X-Received: by 2002:a17:907:1b1c:b0:72f:9aac:ee41 with SMTP id mp28-20020a1709071b1c00b0072f9aacee41mr9815149ejc.56.1664636317150;
        Sat, 01 Oct 2022 07:58:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM46nLpKvPd5A48MwRU0YYtpmobTJ4KvgIEBc3OFsMZ1VMWEAONqeJWMYiLUogbRofwIWzwDfQ==
X-Received: by 2002:a17:907:1b1c:b0:72f:9aac:ee41 with SMTP id mp28-20020a1709071b1c00b0072f9aacee41mr9815139ejc.56.1664636316950;
        Sat, 01 Oct 2022 07:58:36 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906c01400b007803083a36asm2805616ejz.115.2022.10.01.07.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:36 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 8/9] drm/fsl-dcu: remove trailing return statements
Date:   Sat,  1 Oct 2022 16:58:01 +0200
Message-Id: <20221001145802.515916-9-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001145802.515916-1-dakr@redhat.com>
References: <20221001145802.515916-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the trailing return statements at the end of void functions.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c  | 1 -
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index c77df9b7893f..23687551c831 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -147,7 +147,6 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 		     DCU_THRESHOLD_OUT_BUF_LOW(BUF_MIN_VAL));
 
 	drm_dev_exit(idx);
-	return;
 }
 
 static const struct drm_crtc_helper_funcs fsl_dcu_drm_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
index b1305f0af9d5..b95dca47de3e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
@@ -174,7 +174,6 @@ static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
 
 out:
 	drm_dev_exit(idx);
-	return;
 }
 
 static const struct drm_plane_helper_funcs fsl_dcu_drm_plane_helper_funcs = {
-- 
2.37.3

