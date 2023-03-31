Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113E96D2991
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjCaUm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCaUm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620261E73E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680295335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dpVbBRCiJ4We7LHm9u8gIxfqs0WEGOfu+33bncRZNio=;
        b=afWq3NSjMXeKVS0CGaXpcBwopn2BL8lJYY4yZRhCjb4t7h5f5HjSvQOaYHHzhcI3hXSgaz
        ijt7ihsamRxaMPbWJoUi48gIozJH3D8CIk6edmbEd47kgqOLeoQBsy8+/gA+XYNRrY2K/a
        LSGhLfj+DWmBu4w5fi/wzFrkVtacHD4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-xuGmkheEPF2mnDDugclUEA-1; Fri, 31 Mar 2023 16:42:14 -0400
X-MC-Unique: xuGmkheEPF2mnDDugclUEA-1
Received: by mail-qv1-f72.google.com with SMTP id w2-20020a0cc242000000b00583d8e55181so10297674qvh.23
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680295333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpVbBRCiJ4We7LHm9u8gIxfqs0WEGOfu+33bncRZNio=;
        b=SsB7rZOcDewUPF04ryZFA9aZWtxIBrtmtsKBLR8UseIxJm5vdN9FnOUWJpcC9zz4Qo
         5wJ99BkZpXYB44PG19iDxPRIFlXfrETztRJSm2r7XBjl/fxznvro85XBowHcZWPmTlgB
         /tU26vPb70LLufGLxiS1KLPNcqh9SYUT/vyqa3AV++PYABEbymoS2D76F6PshJtadXqD
         LSBevkxON3ajB1OODJ20OEWU2UGrQv6Uc7X1FUb0GRFGiYS9wZmkn7p6hPpi/i1GhUeq
         fo83MHDxgjY3qPC2/NEkXOllJTqQyTC8iYvrpEDM2sWVTegLUF/agfwVf6NEh1pj/31p
         rYAA==
X-Gm-Message-State: AO0yUKUwtky+RBgiNu+nq1BQv/QOoYMCTeMKTuU7tofKmCfG/FrRy6BZ
        ruE5kSg18FFGMgkX5NaeH4VL7zmv9lFNEERRBDm95klmWg+oHkFuTjsFOMywToJbHT1/g9py6ll
        oQb+YUAWSNKX5+1ywRhk35R87
X-Received: by 2002:a05:622a:1d5:b0:3b8:6ae9:b107 with SMTP id t21-20020a05622a01d500b003b86ae9b107mr45596233qtw.17.1680295333574;
        Fri, 31 Mar 2023 13:42:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set/mIthcjf+qNMnYSZIwwm7EuAYx4smtbfumckwe21E1gR7bqyHXH49VRfud0h3afzJGf56gqA==
X-Received: by 2002:a05:622a:1d5:b0:3b8:6ae9:b107 with SMTP id t21-20020a05622a01d500b003b86ae9b107mr45596209qtw.17.1680295333331;
        Fri, 31 Mar 2023 13:42:13 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r194-20020a3744cb000000b007465ee178a3sm910309qka.96.2023.03.31.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:42:12 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, gsamaiya@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/acr: remove unused loc variable
Date:   Fri, 31 Mar 2023 16:42:09 -0400
Message-Id: <20230331204209.1863060-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c:221:7: error: variable
  'loc' set but not used [-Werror,-Wunused-but-set-variable]
                u32 loc, sig, cnt, *meta;
                    ^
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

