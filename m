Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F46B0AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCHONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjCHONL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB668ABF8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678284693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=m81gFkR2y1XD7ZSB1IHW7cdgZ+75l9heGqDR7NPaKd4=;
        b=Ss13AnDnjQpHBSwXG+gGs4fD3AcaMUzMikIZ9IRRmu4ZCwp1H5IVJGiHrUvCByddJfW1A3
        CRlt5qRzOBKR6OCHgZAF3Pq3Y/0p33usQuUpVd7nSZWj26oPmbnZY6Y8Mg0AepULWi5mKH
        RcPvRQtPFsERSyKmdcrM3vn9QpV1yRo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-OKjgDrh3NUOnlgU19nYimA-1; Wed, 08 Mar 2023 09:11:25 -0500
X-MC-Unique: OKjgDrh3NUOnlgU19nYimA-1
Received: by mail-qk1-f199.google.com with SMTP id z23-20020a376517000000b00731b7a45b7fso9486934qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m81gFkR2y1XD7ZSB1IHW7cdgZ+75l9heGqDR7NPaKd4=;
        b=1sSnmUopaCrMTlE2+Ei4C+hS0k596x/r1+16PfgE7uzcc5TyhLoW7cGVctBoUA9+1h
         GzMOSHIwcvoje4KsaY1qqhv/CFnshsdoLLTVB6XAGgNB5+wPW0OFseM8UUyIuMPSfj1Z
         YkkZdIjxQimEUYYXNlpIg9jo6iuQeEoK+FSMXKk3piR0XqCdaB8lyx8REsjeQigqMMhD
         sNiK4nEJJQomSwIj2XMrp0jn5D60khBVu7wadca2r1dGg0y2CVW8b+tckQkhb6bIUxyf
         TcLr6PoX1nQIZqsFywfowp6ots9QasyedpYZlr+/dR48C0I33yi2ssKufJaeWcl3kAr5
         3ehQ==
X-Gm-Message-State: AO0yUKWvdhiOUln7Hvz5ONAYJJafydAow+TNd2DjHyOk88iJNVzAXV32
        uCZqU2PTOobMbdsTlXmYNOwN1wSqusK7hlGV+xwxRUKNMPHURLVQo7TO4EMx5HTRVqhI0lwgxhB
        pT975VrE0kFV1vWNuQhobIg+j
X-Received: by 2002:a05:6214:202d:b0:572:6ed8:e494 with SMTP id 13-20020a056214202d00b005726ed8e494mr36527165qvf.18.1678284684064;
        Wed, 08 Mar 2023 06:11:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/PozfFJrQLJrJyxgwp36xRY3RsiKsiNwx4ETYM7tgGHq8Lwp8dvr5WLBt6+Jo4Oiup/CBkQg==
X-Received: by 2002:a05:6214:202d:b0:572:6ed8:e494 with SMTP id 13-20020a056214202d00b005726ed8e494mr36527115qvf.18.1678284683835;
        Wed, 08 Mar 2023 06:11:23 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q79-20020a374352000000b0073b27323c6dsm11187764qka.136.2023.03.08.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:11:23 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, wenjing.liu@amd.com, qingqing.zhuo@amd.com,
        Jun.Lei@amd.com, mghaddar@amd.com, candice.li@amd.com,
        aric.cyr@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove unused variable available
Date:   Wed,  8 Mar 2023 09:10:57 -0500
Message-Id: <20230308141057.2010361-1-trix@redhat.com>
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

With gcc and W=1, there is this error
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_dpia_bw.c:297:13: error:
  variable ‘available’ set but not used [-Werror=unused-but-set-variable]
  297 |         int available = 0;
      |             ^~~~~~~~~

Since available is unused, remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c   | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index f14217cc16fd..2f0311c42f90 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -294,7 +294,6 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
 	int bw_needed = 0;
-	int available = 0;
 	int estimated = 0;
 	int host_router_total_estimated_bw = 0;
 
@@ -373,20 +372,13 @@ void dpia_handle_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t res
 
 		// 1. If due to unplug of other sink
 		if (estimated == host_router_total_estimated_bw) {
-
 			// First update the estimated & max_bw fields
 			if (link->dpia_bw_alloc_config.estimated_bw < estimated) {
-				available = estimated - link->dpia_bw_alloc_config.estimated_bw;
 				link->dpia_bw_alloc_config.estimated_bw = estimated;
 			}
 		}
 		// 2. If due to realloc bw btw 2 dpia due to plug OR realloc unused Bw
 		else {
-
-			// We took from another unplugged/problematic sink to give to us
-			if (link->dpia_bw_alloc_config.estimated_bw < estimated)
-				available = estimated - link->dpia_bw_alloc_config.estimated_bw;
-
 			// We lost estimated bw usually due to plug event of other dpia
 			link->dpia_bw_alloc_config.estimated_bw = estimated;
 		}
-- 
2.27.0

