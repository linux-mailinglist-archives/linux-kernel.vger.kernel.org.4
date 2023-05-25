Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321E7117DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbjEYUIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjEYUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BBB2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685045284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pscghevf+cSG52ERcGqww4er3grbyjpAV659C+ZtVu8=;
        b=aySUPW3khLTGmyjYvAWH6G9DK8/t7+YSouEfXNDB0oxez9fHFSoDEypOSCZK9vtbFlsixi
        2qS9oo6ViHeTaHg1LyEvc2Bo9rG+GTH8VXNBA6L7l53U6x37HnEuVxOwrjWRCnSceYnj9g
        KfC9gVl3hupehc/VtOflsKqgMEmvhuE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_rkvqrGPOz-f9udm2MDBHQ-1; Thu, 25 May 2023 16:08:03 -0400
X-MC-Unique: _rkvqrGPOz-f9udm2MDBHQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-626047242b9so329476d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045282; x=1687637282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pscghevf+cSG52ERcGqww4er3grbyjpAV659C+ZtVu8=;
        b=hHL7xuV++09kffx1uc2ToecNjjxixfVX2KxMpmKuqiouxSjnIRBetZ9X7Zr4AEeqDU
         JUvWyNyVcQN/7MhGVuzFbt+7dTEk0z4MCr++uWko96v77cDxKvdViz/4W/i4AVx4ni/f
         5AGwf0mPSexwLgldIMy26qiRkn4rAkdSvWUIIqq868k54HB7nKP3WfPPIID36kXTNy3m
         lSvmMbEojY2E+THvWjX2MOF7LqW7b1LkYfkV71o9aS5Y78UPo5QvkNbdC+wd3VWLh0RE
         PTG3bW4opRlBk52R1iV0MMy6q4klfBoW1oZIA9GY7OQWfehju8n5iP4rX5matlhvIcIU
         thFQ==
X-Gm-Message-State: AC+VfDxCnl2Fw8oGiY7gk5Qf6Ph52SO/PfpkTY+cwE+dcvT7Tw6mZPHf
        HAao+2LW754dKLN5QULyM8mjaSzBQhA8q991i8boOG84vYm1RrfGLrSo+3KHwyoYKslWDuYHEVo
        TyENDSDl+tsSnzfAnKpEVriff
X-Received: by 2002:ad4:5cce:0:b0:625:aa48:def6 with SMTP id iu14-20020ad45cce000000b00625aa48def6mr2958790qvb.54.1685045282646;
        Thu, 25 May 2023 13:08:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LtC1076E/oGoBe45eqDKHdSLnAL80iwqLeHY19bYNAJnnZix57WmgzgioKtImTkWVm13Drg==
X-Received: by 2002:ad4:5cce:0:b0:625:aa48:def6 with SMTP id iu14-20020ad45cce000000b00625aa48def6mr2958758qvb.54.1685045282407;
        Thu, 25 May 2023 13:08:02 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id lw1-20020a05621457c100b005ef81cc63ccsm649736qvb.117.2023.05.25.13.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 13:08:01 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: remove unused function get_reserved_sdma_queues_bitmap
Date:   Thu, 25 May 2023 16:07:59 -0400
Message-Id: <20230525200759.3214525-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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

clang with W=1 reports
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:122:24: error:
  unused function 'get_reserved_sdma_queues_bitmap' [-Werror,-Wunused-function]
static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
                       ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 493b4b66f180..2fbd0a96424f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -119,11 +119,6 @@ unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
 		dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
 }
 
-static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
-{
-	return dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap;
-}
-
 static void init_sdma_bitmaps(struct device_queue_manager *dqm)
 {
 	bitmap_zero(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES);
-- 
2.27.0

