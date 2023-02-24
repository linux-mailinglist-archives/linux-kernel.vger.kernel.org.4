Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0128D6A1F54
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBXQHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBXQHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6D63561
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677254807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TKs0bRG7rEN7pThC3p/s4RKGz/X8aopanB/27YkVrjU=;
        b=SldccJB1iKB40+0ibuypjdSgwq8Fs7oFo18lpIbmiT2mA+otXQdbpODoBSQatOKmAyrIeQ
        NGzl1x+nT7x3UPOSZLJcrAE79gUyQ4hUFontKKca5t8ogtbD0lypITfQehsIFKKph2aHP1
        tTx1CO7wpEo1Xsmz8yqYAt6ecAQu0dc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-opPfgzPKPEi2qdsqqMCVyg-1; Fri, 24 Feb 2023 11:06:46 -0500
X-MC-Unique: opPfgzPKPEi2qdsqqMCVyg-1
Received: by mail-qk1-f198.google.com with SMTP id bk15-20020a05620a1a0f00b00741d6880f38so6635270qkb.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKs0bRG7rEN7pThC3p/s4RKGz/X8aopanB/27YkVrjU=;
        b=YtalWO6O0nmf7Kvcj11Ru5vp+jb8xbJB7CwmlVQhErHa+fSpF1AKHa9a1s+nix3ROD
         +RQ8RKhQAR425MerYxuIHOrfHV6GW6m5weJ8qRBsw+qBjqfP3fuCnyTItRNCCkZYGqk5
         JmNSIErg9VvUhLfYUzG0REXrSeXcSTJMwDqoPc60DoByAHUrc3hW1nFZD7VvGGlht9Wz
         qLKo00I1uBxJ38uZi/nqQ8edRNMFpwbPcOI6W4ZCo2+Yup5H4K+cNFaoj0j0F6j66+3B
         PTfpB3Q5TMVVTCWH49OkF43FBcfL7Gtd29eW5ryAlTL/vjgg6TUzIjtYGKoVDmA8N231
         SPbw==
X-Gm-Message-State: AO0yUKUPt5P3iH63uhUIZTeyGMOXFlJpC402D2YJyxX7um3/jLykOb5J
        LZ8ydOL3JkAQir055regupPcn1MRg2DTRW7vwtcrOLoOttOEDZ56eIMPK8osjLQOwX/PRcllN2R
        7w7cCqI2kHyT7vX29885ZDG92
X-Received: by 2002:a05:622a:60e:b0:3b8:5199:f84a with SMTP id z14-20020a05622a060e00b003b85199f84amr11227824qta.3.1677254804932;
        Fri, 24 Feb 2023 08:06:44 -0800 (PST)
X-Google-Smtp-Source: AK7set/BbyOhn673eNw5A4CgDrYH1j6eDXQFM1WSMGga1HaaL2RQuav6Tbu6lPtvadwRfbvNxh+ATg==
X-Received: by 2002:a05:622a:60e:b0:3b8:5199:f84a with SMTP id z14-20020a05622a060e00b003b85199f84amr11227786qta.3.1677254804649;
        Fri, 24 Feb 2023 08:06:44 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a24-20020ac87218000000b003bfa66b7484sm6184056qtp.35.2023.02.24.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 08:06:44 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        tao.zhou1@amd.com, Hawking.Zhang@amd.com, candice.li@amd.com,
        Stanley.Yang@amd.com, YiPeng.Chai@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove unused variable channel_index
Date:   Fri, 24 Feb 2023 11:06:40 -0500
Message-Id: <20230224160640.1577429-1-trix@redhat.com>
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
drivers/gpu/drm/amd/amdgpu/umc_v8_10.c:437:37: error: variable ‘channel_index’
  set but not used [-Werror=unused-but-set-variable]
  437 |         uint32_t eccinfo_table_idx, channel_index;
      |                                     ^~~~~~~~~~~~~

channel_index is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 66158219f791..3f051dec56e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -434,7 +434,7 @@ static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
 					uint32_t umc_inst,
 					uint32_t node_inst)
 {
-	uint32_t eccinfo_table_idx, channel_index;
+	uint32_t eccinfo_table_idx;
 	uint64_t mc_umc_status, err_addr;
 
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -443,11 +443,6 @@ static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
 				  adev->umc.channel_inst_num +
 				  umc_inst * adev->umc.channel_inst_num +
 				  ch_inst;
-	channel_index =
-		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
-						  adev->umc.channel_inst_num +
-						  umc_inst * adev->umc.channel_inst_num +
-						  ch_inst];
 
 	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 
-- 
2.27.0

