Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7FE6BD0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCPNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCPNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD81E5D8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678972989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lOSbCq91ofT9YXvZbpEo/wG2mXE51QVka7uRfgSRss4=;
        b=IVwhfbkcCEMj2i2GxxK0WVJywawaLZuGT9bGYGgxq33rnxlGYgT54ZY6msoeI3US5WdDgX
        MaG+c45/XoUxLGFbhuHTuHmoSPkXMptR070Hxk11Iw/mFm0XW9hJWnSc2jQ1Rs5KgjpCK4
        Vh1GXviH5SgX5UjZUIRHn/0RPDX7+Ag=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-qv-HNiXFNYe0Q9iudK98XA-1; Thu, 16 Mar 2023 09:23:08 -0400
X-MC-Unique: qv-HNiXFNYe0Q9iudK98XA-1
Received: by mail-qv1-f69.google.com with SMTP id r4-20020ad44044000000b005ad0ce58902so1043607qvp.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOSbCq91ofT9YXvZbpEo/wG2mXE51QVka7uRfgSRss4=;
        b=Du6UAgkkd4x1ZzAwOZ8FKY7tFSDmMR1Gg8s2IXzCxOQh5gIxlIVM4D/ByMMuQ2w3GF
         HekllHFIQOTAe+ZQw+TynDCFrQRShdS9F1RzfwU00JXOUj/PF7x8FtlNf93L8aoGYuJ8
         zg+wjSDBIaRmx44mpE4B3cOSGfswkXLDJFn2jRK9DIuxm+YOb4gPzFqq/3rBU9xmv8EL
         mRcf79BYPOgwPj06g8Dg0K50D8MHrBJqq4t3Y8etAPzsbHJcsy9dv6arQATE6Gb28v2P
         R5hIOlsrYOfc7j07na8fwAoDTWvW7eBRVl8FP20woL2UmLD9voMPju3KQknBKTXuqZKv
         XZKg==
X-Gm-Message-State: AO0yUKWUvkcdaviTTReDf4Dxy6hrZUEtLAYmLnvLV8bYpcPM8jtFOvE0
        ujC0PmWMY29RSfX9ILP5y8HCr04GBOhK5nYj9q8hb590lekfA+l3epd+nWx8Zagt+ZZQfxuDQMf
        Xg4GW7xzkveaSeLse6g5ORgnw
X-Received: by 2002:ad4:5aee:0:b0:56e:ab08:670d with SMTP id c14-20020ad45aee000000b0056eab08670dmr32716489qvh.42.1678972988195;
        Thu, 16 Mar 2023 06:23:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set9dA/70KxjQEA+7BPyUihfyAvubVJ/nAiMbXTzj0PTIRAeQbYujxRy3jSIUcu6bo4xiaMqL1g==
X-Received: by 2002:ad4:5aee:0:b0:56e:ab08:670d with SMTP id c14-20020ad45aee000000b0056eab08670dmr32716450qvh.42.1678972987917;
        Thu, 16 Mar 2023 06:23:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g187-20020a37b6c4000000b00743592b4745sm5803599qkf.109.2023.03.16.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:23:07 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        michael.riesch@wolfvision.net, s.hauer@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/rockchip: vop2: fix uninitialized variable possible_crtcs
Date:   Thu, 16 Mar 2023 09:23:02 -0400
Message-Id: <20230316132302.531724-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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

clang reportes this error
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2322:8: error:
  variable 'possible_crtcs' is used uninitialized whenever 'if'
  condition is false [-Werror,-Wsometimes-uninitialized]
                        if (vp) {
                            ^~
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2336:36: note:
  uninitialized use occurs here
                ret = vop2_plane_init(vop2, win, possible_crtcs);
                                                 ^~~~~~~~~~~~~~
drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2322:4:
  note: remove the 'if' if its condition is always true
                        if (vp) {
                        ^~~~~~~~

The else-statement changes the win->type to OVERLAY without setting the
possible_crtcs variable.  Rework the block, initialize possible_crtcs to
0 to remove the else-statement.  Split the else-if-statement out to its
own if-statement so the OVERLAY check will catch when the win-type has
been changed.

Fixes: 368419a2d429 ("drm/rockchip: vop2: initialize possible_crtcs properly")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 03ca32cd2050..fce992c3506f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2301,7 +2301,7 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 	nvp = 0;
 	for (i = 0; i < vop2->registered_num_wins; i++) {
 		struct vop2_win *win = &vop2->win[i];
-		u32 possible_crtcs;
+		u32 possible_crtcs = 0;
 
 		if (vop2->data->soc_id == 3566) {
 			/*
@@ -2327,12 +2327,11 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 				/* change the unused primary window to overlay window */
 				win->type = DRM_PLANE_TYPE_OVERLAY;
 			}
-		} else if (win->type == DRM_PLANE_TYPE_OVERLAY) {
-			possible_crtcs = (1 << nvps) - 1;
-		} else {
-			possible_crtcs = 0;
 		}
 
+		if (win->type == DRM_PLANE_TYPE_OVERLAY)
+			possible_crtcs = (1 << nvps) - 1;
+
 		ret = vop2_plane_init(vop2, win, possible_crtcs);
 		if (ret) {
 			drm_err(vop2->drm, "failed to init plane %s: %d\n",
-- 
2.27.0

