Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE83370BF00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjEVNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjEVNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B6BE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684760462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5GS5iE0UNqVQ8KlXVjYhcfn3nzlvTGZU1mxp4La9+mc=;
        b=dbjOHJd5liBxQCpFsI+f4xxaKMoZDQDhIJ1N60NMWl4ZaKMOMO4ep9amarExGPhIyI/JqO
        pFpTeCZK0nDBDjqYnwwxjqrCoPdWFWE/Wkz6Rmwi/Vs9vEGMj7O7KlRmpbEtpcvdzrP0jl
        AcIoqtKRJAT1li5SRaqLXb9SRDDhHyc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-hjUBavM-Pd6Em1cgmBu_gQ-1; Mon, 22 May 2023 09:01:01 -0400
X-MC-Unique: hjUBavM-Pd6Em1cgmBu_gQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62397e86e32so62178206d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684760461; x=1687352461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GS5iE0UNqVQ8KlXVjYhcfn3nzlvTGZU1mxp4La9+mc=;
        b=JYINHXxKIaiymsMDhCUBzyKArtIK9hBOI+BQuAxd0+mcOcIbR/mL/SyN6jn+b0LDIm
         o03m02Q91zbnkMta3WWq6M6zKbIH6XO4GhHn6nwuaID79OaN4pDEBEH8WzoBGSsZjqvj
         IaW9Fyy6q8lBisi994IBHsdUDNnxDKi69mHfc/Nxh6Vm3s8Gi+MH0ng+XYYDrF8qXjqX
         xtNNQchICF/6FCy5JlvSytE3KUgyYD5tB0Ho7db90KD0Fu/CjGMIXexxNo5XWOb0KwtJ
         M1xsXABoz6/aDRBRr7NHOve49r41UfRg/nQwCtS6YuxN9UqRYeJZgU3oCVm6y/iPgWGU
         bdYQ==
X-Gm-Message-State: AC+VfDz93bnW7BCNib/5AhtVDkpo6XGaWhQp/BojDAyK26LTrOJ7k03D
        GRxBo1kutmTEhHlF1q2VwLMmiF1GGQYsmqjk7ZVRiRaIdmbRPJoJfYtn9CVUcGas9nkjvv5Cbbp
        V6pz8uFYoxz3KLaara2Ty2426
X-Received: by 2002:a05:6214:d4b:b0:616:5c8b:582 with SMTP id 11-20020a0562140d4b00b006165c8b0582mr21098472qvr.37.1684760460915;
        Mon, 22 May 2023 06:01:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63Whwh0WVrdsRNMd+E6lr3sa4LBlkXrJV87h21RAe+9pE/lhzvsvDrelDpNH940vcQ+EvwJw==
X-Received: by 2002:a05:6214:d4b:b0:616:5c8b:582 with SMTP id 11-20020a0562140d4b00b006165c8b0582mr21098447qvr.37.1684760460644;
        Mon, 22 May 2023 06:01:00 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u13-20020ae9c00d000000b0075783f6c2b4sm1678924qkk.128.2023.05.22.06.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 06:01:00 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, tao.zhou1@amd.com, le.ma@amd.com,
        Felix.Kuehling@amd.com, lijo.lazar@amd.com, Amber.Lin@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove unused variable mmhub_v1_8_mmea_cgtt_clk_cntl_reg
Date:   Mon, 22 May 2023 09:00:57 -0400
Message-Id: <20230522130057.1066607-1-trix@redhat.com>
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
drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:760:23: error:
  ‘mmhub_v1_8_mmea_cgtt_clk_cntl_reg’ defined but not used [-Werror=unused-const-variable=]
  760 | static const uint32_t mmhub_v1_8_mmea_cgtt_clk_cntl_reg[] = {
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 3648994724c2..00e7e5db7c28 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -757,14 +757,6 @@ static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
 		mmhub_v1_8_inst_query_ras_err_status(adev, i);
 }
 
-static const uint32_t mmhub_v1_8_mmea_cgtt_clk_cntl_reg[] = {
-	regMMEA0_CGTT_CLK_CTRL,
-	regMMEA1_CGTT_CLK_CTRL,
-	regMMEA2_CGTT_CLK_CTRL,
-	regMMEA3_CGTT_CLK_CTRL,
-	regMMEA4_CGTT_CLK_CTRL,
-};
-
 static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
 						 uint32_t mmhub_inst)
 {
-- 
2.27.0

