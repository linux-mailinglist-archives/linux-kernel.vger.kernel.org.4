Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496577118D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjEYVLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEYVLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E4195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685049048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tDnyD1Q+TvZD8RBnYsiyH5gRK/DXU5xMZC5lqC7VcXs=;
        b=hM/mnt9at0ZBdh2FYfiBBvq3A2fDl29aK8OMETJwzUsf1geE4dUZYAiygkmNBqi2ApusAO
        qfr7JZHuE6Fzqh3wtTlmVdhouh70dsK5M+Dli/NRnqPeFZUKGalzdlWifYTXb65/GBaixh
        /7Xkk9zbCcV13WmfuHaQ7c688YK4Lbo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-ycVHlukuNpqeefhVPIlUkQ-1; Thu, 25 May 2023 17:10:46 -0400
X-MC-Unique: ycVHlukuNpqeefhVPIlUkQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f68fd54e90so14203291cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685049046; x=1687641046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDnyD1Q+TvZD8RBnYsiyH5gRK/DXU5xMZC5lqC7VcXs=;
        b=ViQyeQ/Dv3iRM5fbfOEC6row8/oZyJIA0J3xfiSdQOUyyXw+xBnFXJ4PIz1e+DG2h8
         XjhhFjwdh6lthiviSROT7gK4Le0GosqYatENStP5RFGUIVLz6FR73IQ6zoVcRRXy/KWR
         5mJTPS3GTWNzDCnLNI/fHUVqnmJ4Y5+F2s1+QqxmkaX8HqT0kNM51EeAO20+9BK8CQ5k
         Gg0RaNGBFMNl7UG/R6oZ7ayiE8AxtYpW2rfvfO5hoPhfPWmDPjueiU2Vc28dGEGarz2X
         VG+tIzzGzSCvKd/emE2Hu5nNqcgQuCexYyeDXqiSeGBv6jOj2LMadq0A/TCFU6nCQ6Ay
         xWgg==
X-Gm-Message-State: AC+VfDzWFYZS46aA4LUyVvTT3Wp+z+qYR8O+zddETY0imzJ5W/tbsCcD
        mCwmXY4sn5XKOUJoT8BhkEp54FgbBPfSQDRIaN2iM3H3zmNVL4XJI0KZGlaO0KA67XW9RYAtd3Z
        u3XSf4BTSj2Pw0rzgOsOvkQmJ
X-Received: by 2002:ac8:5acf:0:b0:3e3:7e6f:423c with SMTP id d15-20020ac85acf000000b003e37e6f423cmr1017689qtd.34.1685049046280;
        Thu, 25 May 2023 14:10:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tZiuI8gD3Aif7n+Bf8DUaassrUnfxP6XFasaXNKtLHxyDyblw20JldsbFKRXFeXMklWQvIQ==
X-Received: by 2002:ac8:5acf:0:b0:3e3:7e6f:423c with SMTP id d15-20020ac85acf000000b003e37e6f423cmr1017674qtd.34.1685049046045;
        Thu, 25 May 2023 14:10:46 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id br5-20020a05622a1e0500b003ef5dc13bbbsm702340qtb.85.2023.05.25.14.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:10:45 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, gsamaiya@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/acr: remove unused variable loc
Date:   Thu, 25 May 2023 17:10:40 -0400
Message-Id: <20230525211040.3233982-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:221:21: error: variable
  ‘loc’ set but not used [-Werror=unused-but-set-variable]
  221 |                 u32 loc, sig, cnt, *meta;
      |                     ^~~
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
index f36a359d4531..bd104a030243 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
@@ -218,7 +218,7 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subdev *subdev,
 		const struct firmware *hsbl;
 		const struct nvfw_ls_hsbl_bin_hdr *hdr;
 		const struct nvfw_ls_hsbl_hdr *hshdr;
-		u32 loc, sig, cnt, *meta;
+		u32 sig, cnt, *meta;
 
 		ret = nvkm_firmware_load_name(subdev, path, "hs_bl_sig", ver, &hsbl);
 		if (ret)
@@ -227,7 +227,6 @@ nvkm_acr_lsfw_load_sig_image_desc_v2(struct nvkm_subdev *subdev,
 		hdr = nvfw_ls_hsbl_bin_hdr(subdev, hsbl->data);
 		hshdr = nvfw_ls_hsbl_hdr(subdev, hsbl->data + hdr->header_offset);
 		meta = (u32 *)(hsbl->data + hshdr->meta_data_offset);
-		loc = *(u32 *)(hsbl->data + hshdr->patch_loc);
 		sig = *(u32 *)(hsbl->data + hshdr->patch_sig);
 		cnt = *(u32 *)(hsbl->data + hshdr->num_sig);
 
-- 
2.27.0

