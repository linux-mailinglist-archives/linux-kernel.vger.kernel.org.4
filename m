Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490206E950E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDTMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjDTMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BCAEC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681995045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xsQvRozmWeIRuvplx2jp/MlGECW+YgJPFwvCRk8nfu8=;
        b=NFhKj0axLm9cUTttTu+n4hwa2zr9cj9X2Yc1NlTuA2H1rzHU7K5ecKLqd5ceoGYqOtl8iq
        ALFn3FskuQH8Cq7IDrGQFx+1flVmioPhnwNzQzIIQOFmlygs/cuyD7tqPAX2+VIshSO/77
        wmOxlSZTn/NGo9OmAtRYVxyhO4trkyU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-u-pQQXQdNxKiXHkHc6E9Tg-1; Thu, 20 Apr 2023 08:50:44 -0400
X-MC-Unique: u-pQQXQdNxKiXHkHc6E9Tg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74de74a90e7so92536385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681995044; x=1684587044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsQvRozmWeIRuvplx2jp/MlGECW+YgJPFwvCRk8nfu8=;
        b=Enw4AljQ3BAhxO/0BgxVL6SkUk/umtJFbsai994oslr5QleO92btevkKs6e60fWEo7
         1zNUneDtUL5DnUD7yxfRIRW3kKvtH7KST+mnWr8jMdu53XiKAOPhDUNKRL3Lpr0OOpwV
         +n7fDrmi10Kf4U0kdpiz28/Qpb/5yf/nok7xJROa9kNDvLphZr85yfFIe4WG25Y2CgFH
         rp4rZ++pfJTkP3WnZxdO4F5o4O8kJkA45u/EVG74+uvz7pXDtgkoKJyNv9iAA3yx4sQj
         nJ29/V1nw9Bt4ziftxl7N056JvEKPEomjCHnWWNKrqpU3KvN8jIqhi+8wYuMLFM/b5OV
         wqyg==
X-Gm-Message-State: AAQBX9dTGljv2FvTYCZM47uY4mQbkz/Jq/bUzefpigwspDmOkWzTHYhc
        W1CLJlqlHWUuHiGr/kOQ1Iw8PDOFP3zDHF21Dib0akQuRzVR+dUn34jRdtvhb0TnFCzegRXv2gY
        S43eTvoZdL+IuD3BL2zc2vXKJoN+T0eQH
X-Received: by 2002:ac8:5f49:0:b0:3e4:903:4edf with SMTP id y9-20020ac85f49000000b003e409034edfmr2115983qta.28.1681995044044;
        Thu, 20 Apr 2023 05:50:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zn5JjxfeNmN+oopT6R4QxoWNRkSkOdM8ztyXAXN/ssVJaVH1kKT7/bxxMUsLpD6hBvIPWCMQ==
X-Received: by 2002:ac8:5f49:0:b0:3e4:903:4edf with SMTP id y9-20020ac85f49000000b003e409034edfmr2115947qta.28.1681995043783;
        Thu, 20 Apr 2023 05:50:43 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z26-20020ac87cba000000b003eb136bec50sm453716qtv.66.2023.04.20.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:50:43 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     brking@us.ibm.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: ipr: remove several unused variables
Date:   Thu, 20 Apr 2023 08:50:35 -0400
Message-Id: <20230420125035.3888188-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/scsi/ipr.c: In function ‘ipr_init_res_entry’:
drivers/scsi/ipr.c:1104:22: error: variable ‘proto’
  set but not used [-Werror=unused-but-set-variable]
 1104 |         unsigned int proto;
      |                      ^~~~~
drivers/scsi/ipr.c: In function ‘ipr_update_res_entry’:
drivers/scsi/ipr.c:1261:22: error: variable ‘proto’
  set but not used [-Werror=unused-but-set-variable]
 1261 |         unsigned int proto;
      |                      ^~~~~
drivers/scsi/ipr.c: In function ‘ipr_change_queue_depth’:
drivers/scsi/ipr.c:4417:36: error: variable ‘res’
  set but not used [-Werror=unused-but-set-variable]
 4417 |         struct ipr_resource_entry *res;
      |                                    ^~~

These variables are not used, so remove them.
The lock around res is not needed so remove that.
Which makes ioa_cfg and lock_flags unneeded so remove them.

Fixes: 65a15d6560df ("scsi: ipr: Remove SATA support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/ipr.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index d81189ba8773..4e13797b2a4a 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -1101,7 +1101,6 @@ static void ipr_init_res_entry(struct ipr_resource_entry *res,
 			       struct ipr_config_table_entry_wrapper *cfgtew)
 {
 	int found = 0;
-	unsigned int proto;
 	struct ipr_ioa_cfg *ioa_cfg = res->ioa_cfg;
 	struct ipr_resource_entry *gscsi_res = NULL;
 
@@ -1114,7 +1113,6 @@ static void ipr_init_res_entry(struct ipr_resource_entry *res,
 	res->sdev = NULL;
 
 	if (ioa_cfg->sis64) {
-		proto = cfgtew->u.cfgte64->proto;
 		res->flags = be16_to_cpu(cfgtew->u.cfgte64->flags);
 		res->res_flags = be16_to_cpu(cfgtew->u.cfgte64->res_flags);
 		res->qmodel = IPR_QUEUEING_MODEL64(res);
@@ -1160,7 +1158,6 @@ static void ipr_init_res_entry(struct ipr_resource_entry *res,
 			set_bit(res->target, ioa_cfg->target_ids);
 		}
 	} else {
-		proto = cfgtew->u.cfgte->proto;
 		res->qmodel = IPR_QUEUEING_MODEL(res);
 		res->flags = cfgtew->u.cfgte->flags;
 		if (res->flags & IPR_IS_IOA_RESOURCE)
@@ -1258,7 +1255,6 @@ static void ipr_update_res_entry(struct ipr_resource_entry *res,
 				 struct ipr_config_table_entry_wrapper *cfgtew)
 {
 	char buffer[IPR_MAX_RES_PATH_LENGTH];
-	unsigned int proto;
 	int new_path = 0;
 
 	if (res->ioa_cfg->sis64) {
@@ -1270,7 +1266,6 @@ static void ipr_update_res_entry(struct ipr_resource_entry *res,
 			sizeof(struct ipr_std_inq_data));
 
 		res->qmodel = IPR_QUEUEING_MODEL64(res);
-		proto = cfgtew->u.cfgte64->proto;
 		res->res_handle = cfgtew->u.cfgte64->res_handle;
 		res->dev_id = cfgtew->u.cfgte64->dev_id;
 
@@ -1299,7 +1294,6 @@ static void ipr_update_res_entry(struct ipr_resource_entry *res,
 			sizeof(struct ipr_std_inq_data));
 
 		res->qmodel = IPR_QUEUEING_MODEL(res);
-		proto = cfgtew->u.cfgte->proto;
 		res->res_handle = cfgtew->u.cfgte->res_handle;
 	}
 }
@@ -4413,14 +4407,6 @@ static int ipr_free_dump(struct ipr_ioa_cfg *ioa_cfg) { return 0; };
  **/
 static int ipr_change_queue_depth(struct scsi_device *sdev, int qdepth)
 {
-	struct ipr_ioa_cfg *ioa_cfg = (struct ipr_ioa_cfg *)sdev->host->hostdata;
-	struct ipr_resource_entry *res;
-	unsigned long lock_flags = 0;
-
-	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-	res = (struct ipr_resource_entry *)sdev->hostdata;
-	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-
 	scsi_change_queue_depth(sdev, qdepth);
 	return sdev->queue_depth;
 }
-- 
2.27.0

