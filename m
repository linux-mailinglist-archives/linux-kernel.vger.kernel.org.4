Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3908F65F62A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjAEVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjAEVrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1063D28
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672955201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RJxX8F2Oi9p4ox5AYCJudMMSN3aLdKu313AtW9TP9ck=;
        b=Sq+qngd9FJpOAuTyAeugbH/NwrQueo/+/RPHrJkwAAdSlLoQ3yQ3J4r/Yv94e7gpu8LOZD
        uWDy9a+31Mzbnr9a+9Q5Dfdt1AzTXkdmJETKVJtOk8MzqKExr+okrzQAWVd4t3WwnvYW9r
        bkHmwpkHX2u79tDLRr+pjVo2E+hlpcU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-geHfbkVwMjeHX3-uH_9bdg-1; Thu, 05 Jan 2023 16:46:39 -0500
X-MC-Unique: geHfbkVwMjeHX3-uH_9bdg-1
Received: by mail-qk1-f198.google.com with SMTP id r6-20020a05620a298600b007025c3760d4so25777479qkp.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJxX8F2Oi9p4ox5AYCJudMMSN3aLdKu313AtW9TP9ck=;
        b=eG6pO/eacjhwF8VtzT6HSbLHPqtNkqsALtieCvhxBUT451WDiqVLQF6NFNW+IyU7nB
         sP2kQGQsxUooILJ1BhCEq61VDcaBIu/texZ3C3NiPpbHDURElnuKPH5DVeROnPxY8KX3
         6djzRs7zbvw3VbKxXSp61xO6H+iqwVvfBQk12Wu+j5gCzR8/fK07fdMdb7QkGQtY+lTv
         31LQMOlQq2woWzkJFyQqTfkouUVykhbyNzRXHAZ8y9VE+Xs6YPgFjvG/EUET/b455nfG
         1k6X7kqe1h556oT7nN+mhDmukqvGCU6LfwGs1YCEibB0mRFUNnETu636rV9l0qowhDdy
         uPnA==
X-Gm-Message-State: AFqh2kpXWUMWsarwBhfqt2b9Unxetgq5lhl1XHTeqei9vuY/+pUqvQG1
        hG9IohkvSz9DidP8GcppcVP7/MKsX6XfvsKL46eSVnL6XnJ0rqgHrqGbMFU17GertPfrZRhnXIY
        EqMz0Ku9LSJMWeOMBewwcf3YY
X-Received: by 2002:a05:622a:4d98:b0:3a5:24ac:a175 with SMTP id ff24-20020a05622a4d9800b003a524aca175mr79247734qtb.56.1672955199436;
        Thu, 05 Jan 2023 13:46:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtOxlIpJae+yvLp/3VsoqW8D9MXFVzcQIHBPniSyIwWqQ9/WnS8U1M90QS9GG96j49U3uDZDA==
X-Received: by 2002:a05:622a:4d98:b0:3a5:24ac:a175 with SMTP id ff24-20020a05622a4d9800b003a524aca175mr79247709qtb.56.1672955199240;
        Thu, 05 Jan 2023 13:46:39 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bq22-20020a05622a1c1600b0039c7b9522ecsm22189237qtb.35.2023.01.05.13.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:46:38 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, beanhuo@micron.com,
        Arthur.Simchaev@wdc.com, stanley.chu@mediatek.com,
        j-young.choi@samsung.com, peter.wang@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: ufs: core: initialize sg_cnt, sg_list
Date:   Thu,  5 Jan 2023 16:46:35 -0500
Message-Id: <20230105214635.874609-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang build fails with
drivers/ufs/core/ufs_bsg.c:107:6: error: variable 'sg_cnt' is used
  uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (dir != DMA_NONE) {
            ^~~~~~~~~~~~~~~
Similar for sg_list.

This is not an error because ufshcd_advanced_rpmb_req_handler() does a
similar check, but that check can be reduced if sg_list is initialized to NULL.
Initialize sg_cnt to silence its error.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/ufs/core/ufs_bsg.c | 4 ++--
 drivers/ufs/core/ufshcd.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 0044029bcf7b..0d38e7fa34cc 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -70,9 +70,9 @@ static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba, struct bsg_job *j
 	struct ufs_rpmb_reply *rpmb_reply = job->reply;
 	struct bsg_buffer *payload = NULL;
 	enum dma_data_direction dir;
-	struct scatterlist *sg_list;
+	struct scatterlist *sg_list = NULL;
 	int rpmb_req_type;
-	int sg_cnt;
+	int sg_cnt = 0;
 	int ret;
 	int data_len;
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index da81eafc19d5..6ed728885650 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7051,7 +7051,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	/* Copy EHS, starting with byte32, immediately after the CDB package */
 	memcpy(lrbp->ucd_req_ptr + 1, req_ehs, sizeof(*req_ehs));
 
-	if (dir != DMA_NONE && sg_list)
+	if (sg_list)
 		ufshcd_sgl_to_prdt(hba, lrbp, sg_cnt, sg_list);
 
 	memset(lrbp->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
-- 
2.27.0

