Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46E6D13EE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCaAQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCaAQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189ADD323
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680221534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fOkGCDSj8lCYrOV3T53RqMyXeDPosCHIFZ+HCuqViiM=;
        b=E+BYOXBpoBdbUNHQubXkHUeMF2NJjH/is9Z+380VdFFog76vkbys4n0RY/vXu6+hdSESVH
        s95EHquQKNVtRqRAWiM6GFppd8HzVEjJX+xl8f8m/mZULTBlQKEuEfdnd/5t+vY+bgI4yT
        Q84nOWHM2jLTj7BVyjIDo7n5Tvv18ks=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-5y5uvS8oNLqYINT3HvBYTg-1; Thu, 30 Mar 2023 20:12:12 -0400
X-MC-Unique: 5y5uvS8oNLqYINT3HvBYTg-1
Received: by mail-qk1-f198.google.com with SMTP id 195-20020a3705cc000000b00746a3ab9426so9676962qkf.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680221532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOkGCDSj8lCYrOV3T53RqMyXeDPosCHIFZ+HCuqViiM=;
        b=61FdvNcbPkD4riHgJTNNA6j487q+/3Le7kpgJmRfjADjS2ku25NXBvqJ0tZQvuqUnr
         5DtFwB2wiv97Baenb2t5Hq3hw3Jv1v7zM7e3NfVwEzZxApAVoXRKIRcmTWaCODeyIzVZ
         mOQn84e0rjKWX4epbfJHVFE+G01M+BuP6BdTDkJvza7isIMSN101ykkMhgOK0XxCsIG4
         U26Y/Z7iyyK6jNL38f4C+Hp6v4qobnY0j0ZJ+/h55mmEAUG78bKNe0AYqkuqLAReC5z0
         0z9wym30PCegAJz1wagJ757mXH1Ujg7gTLkZgEv4VDBJxF1XLCg+KlVCDX89Q4qT7f0w
         jv8g==
X-Gm-Message-State: AAQBX9cBigePHIZ25y+so8lGdhMe0SdkKghMA0UP0Z2RXEVGUw7e4/YM
        y7lMFVEAx3au75B7HMt9CqYWw9ovzkOdtpIWaHJwsvqpcP7sBx0RlMIPelMmnA365QZOcSrDx/x
        OGs7YnGrmzBNzhN4ETg6JZ1eR047xTqWm
X-Received: by 2002:ad4:5ccc:0:b0:5aa:fd43:1fcd with SMTP id iu12-20020ad45ccc000000b005aafd431fcdmr41762433qvb.42.1680221532170;
        Thu, 30 Mar 2023 17:12:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350bjRsivYicxZuXm5irkBw31aCOlUFuwEjWTIzCh6ugnPYhFkVi1a8AdrrculeonWtsS1vJHsQ==
X-Received: by 2002:ad4:5ccc:0:b0:5aa:fd43:1fcd with SMTP id iu12-20020ad45ccc000000b005aafd431fcdmr41762413qvb.42.1680221531952;
        Thu, 30 Mar 2023 17:12:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id ny8-20020a056214398800b005dd8b934584sm216973qvb.28.2023.03.30.17.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:12:11 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] bus: fsl-mc: remove unused free_count variable
Date:   Thu, 30 Mar 2023 20:12:08 -0400
Message-Id: <20230331001208.1846731-1-trix@redhat.com>
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
drivers/bus/fsl-mc/fsl-mc-allocator.c:560:6: error: variable
  'free_count' set but not used [-Werror,-Wunused-but-set-variable]
        int free_count = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index dced427ca8ba..f1351237a9d5 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -557,12 +557,9 @@ static void fsl_mc_cleanup_resource_pool(struct fsl_mc_device *mc_bus_dev,
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_resource_pool *res_pool =
 					&mc_bus->resource_pools[pool_type];
-	int free_count = 0;
 
-	list_for_each_entry_safe(resource, next, &res_pool->free_list, node) {
-		free_count++;
+	list_for_each_entry_safe(resource, next, &res_pool->free_list, node)
 		devm_kfree(&mc_bus_dev->dev, resource);
-	}
 }
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev)
-- 
2.27.0

