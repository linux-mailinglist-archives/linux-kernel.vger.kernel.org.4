Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400D86D2763
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjCaR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCaR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4E2368D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680285482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5O8+xHFKv06WCG7nCwq4CEs9To8ieEt1S6DRRcwc6+g=;
        b=Ppgrrez9sQ0Id5nDNVAaNRgNJlXVYzRQSO42cJo5tSXMHuJ5s3KhwOLZ2EPTwdug3Ky1fo
        Hl0ofLXD8EcuvaE9QBgPPB8CkAlja+k0NZPMYpGfAfw2u4+nK1sF03ua2YE5bq0kafEZO+
        aWRr3lNQ+rPxH0YHe/cNpQrIH9TJPB8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-DeuchucIMEqn2bGptDMfvA-1; Fri, 31 Mar 2023 13:58:01 -0400
X-MC-Unique: DeuchucIMEqn2bGptDMfvA-1
Received: by mail-qv1-f70.google.com with SMTP id v8-20020a0ccd88000000b005c1927d1609so10023015qvm.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O8+xHFKv06WCG7nCwq4CEs9To8ieEt1S6DRRcwc6+g=;
        b=I7rVGYAdClKFv9sCTROaJwcGFuf/G1WNs7UEZx3arTQ5pBY5Jl7mj1XJY1CKzCIyKG
         KOdeflSnaCg/QG3/L9b5rElKYl1Tw2PjzAJfe7wQcX/uT/yNmf512VejcWplYX+3QjZH
         106TByhb7nDeLH2E3XcPJ9eo//ENp9rM5m61fHfwUZ12Klqpq84RcTN7HDnHgYxsQaod
         ujN1iVaSFaiZRxBbtwNCdTFeBDZwJyclgdXGMlwZ/aYexgnIF0C4QJHxbRCaHawd+93d
         QumsBa+HwZFSAIHLezRmPcHo6pl5/BnpRtAz0L20qBnjLSCRwOjUOOUnOwFga8sPwBCj
         yVAw==
X-Gm-Message-State: AAQBX9ctJdyLW1DBkSGC1YrrbK1Q1d60nWehbXe++1AV0Ar5Jd77hzzu
        VbfItAz5kq5oklfaOzEMYiw1v4PBt66LEuY8LU5Zmx/IhJOm9uuwMowsDXgWzdbF/s6ToGZu06Y
        fEe7WyQ/Ap+dlR7wtGOjdhrbe
X-Received: by 2002:a05:6214:410f:b0:572:80ea:5fc7 with SMTP id kc15-20020a056214410f00b0057280ea5fc7mr42990027qvb.41.1680285480470;
        Fri, 31 Mar 2023 10:58:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAB+2E58L9cx7PfO4++k4UHX5C/oFrianAF5m/clXDQYWYq5EBw8/U5MgBdC3hhUE5TFzLHg==
X-Received: by 2002:a05:6214:410f:b0:572:80ea:5fc7 with SMTP id kc15-20020a056214410f00b0057280ea5fc7mr42989995qvb.41.1680285480233;
        Fri, 31 Mar 2023 10:58:00 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j10-20020a0cfd4a000000b005dd8b934578sm768480qvs.16.2023.03.31.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:57:59 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     njavali@marvell.com, mrangankar@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] [SCSI] qla4xxx: remove unused count variable
Date:   Fri, 31 Mar 2023 13:57:57 -0400
Message-Id: <20230331175757.1860780-1-trix@redhat.com>
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
drivers/scsi/qla4xxx/ql4_isr.c:475:11: error: variable
  'count' set but not used [-Werror,-Wunused-but-set-variable]
        uint32_t count = 0;
                 ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/qla4xxx/ql4_isr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_isr.c b/drivers/scsi/qla4xxx/ql4_isr.c
index 6f0e77dc2a34..cf52258ecdde 100644
--- a/drivers/scsi/qla4xxx/ql4_isr.c
+++ b/drivers/scsi/qla4xxx/ql4_isr.c
@@ -472,14 +472,12 @@ static void qla4xxx_mbox_status_entry(struct scsi_qla_host *ha,
  **/
 void qla4xxx_process_response_queue(struct scsi_qla_host *ha)
 {
-	uint32_t count = 0;
 	struct srb *srb = NULL;
 	struct status_entry *sts_entry;
 
 	/* Process all responses from response queue */
 	while ((ha->response_ptr->signature != RESPONSE_PROCESSED)) {
 		sts_entry = (struct status_entry *) ha->response_ptr;
-		count++;
 
 		/* Advance pointers for next entry */
 		if (ha->response_out == (RESPONSE_QUEUE_DEPTH - 1)) {
-- 
2.27.0

