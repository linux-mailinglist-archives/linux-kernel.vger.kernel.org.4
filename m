Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D159C6D1015
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjC3Ufi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3Ufh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADB10FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680208490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eGkxwG96GrqLVw0TE58Wpxl+P5cmdIKahbzznaGzN4I=;
        b=U+/r2q9O8oRlWftuZ8B/W4SNyr0Bb5fWiKmen9uNETaRwDNZ4GsTn1tBdQAUQsIGuiba/u
        fsHiMk5HV3iK5ZoxjwiKFJOd7EHnxvxx/ouk7oRHkyTcc79Gi3Rl0YNcwExj2Jdo9Bxja5
        7oloun+UrSmb6g3exvHQYCQtIsc2io4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-uiVDvtgBPbCUTz8JOMibmQ-1; Thu, 30 Mar 2023 16:34:48 -0400
X-MC-Unique: uiVDvtgBPbCUTz8JOMibmQ-1
Received: by mail-qt1-f197.google.com with SMTP id h6-20020ac85846000000b003e3c23d562aso13236573qth.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGkxwG96GrqLVw0TE58Wpxl+P5cmdIKahbzznaGzN4I=;
        b=pQklrtzize0N/qiROk3qspN1gTMHGPi+KGKNQB3AH8FAsQvwo67muIc1xwIhoc5QY1
         Di7r2YbDkSKsYao+VjOO9jA1rnmqJVVAUs4pKL/xbGRrPk3MFqsXvNfnGhOkI01X9fch
         3Lnqw3jdY/ns8JUx7aDeJKL5Z2+y+7jgCuT5N3IriK2YC/4tmGhLPTzAPk9qkm0sE62R
         5SnuqTBs+1GTLiHsx46L7o61WJbVQonEb09QwMi9cK09S+0HmNrdxNJ72AD6eNxIJxD8
         yeJRi7VhWUC9agJT70JQDiJHajpstPcgPfQNFslEaKPDq5S9/vwXX40XujZ/ocHZlEaC
         v5HQ==
X-Gm-Message-State: AAQBX9eYYUD8DMEQpB+IkccirRIdh+BcluqvQosCSlh84BnOmWb568rF
        Y9Py+/a/tLfBoOfXMktFxBBth14CnfFjBPu4tu+LYrjFp/26T+e36IR16SnM1d89J++X+QKXRQS
        r9aOiklLo5VvtttLa4Te4Zv0I
X-Received: by 2002:ac8:584f:0:b0:3e1:6c7e:2ee0 with SMTP id h15-20020ac8584f000000b003e16c7e2ee0mr14242012qth.11.1680208488247;
        Thu, 30 Mar 2023 13:34:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1wvKlZbAtmYILYnVwfQgOtt39xMFyExjgnV3KppLGpi4BEL0uQtNYwb/Tvs8MCv4NdLJl4Q==
X-Received: by 2002:ac8:584f:0:b0:3e1:6c7e:2ee0 with SMTP id h15-20020ac8584f000000b003e16c7e2ee0mr14241984qth.11.1680208488012;
        Thu, 30 Mar 2023 13:34:48 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u17-20020ac87511000000b003e38f8d564fsm110512qtq.66.2023.03.30.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:34:47 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     skashyap@marvell.com, jhasan@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: qedf: remove unused num_handled variable
Date:   Thu, 30 Mar 2023 16:34:44 -0400
Message-Id: <20230330203444.1842425-1-trix@redhat.com>
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
drivers/scsi/qedf/qedf_main.c:2227:6: error: variable
  'num_handled' set but not used [-Werror,-Wunused-but-set-variable]
        int num_handled = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/qedf/qedf_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index e7f2560b9f7d..3b64de81ea0d 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -2224,7 +2224,6 @@ static bool qedf_process_completions(struct qedf_fastpath *fp)
 	u16 prod_idx;
 	struct fcoe_cqe *cqe;
 	struct qedf_io_work *io_work;
-	int num_handled = 0;
 	unsigned int cpu;
 	struct qedf_ioreq *io_req = NULL;
 	u16 xid;
@@ -2247,7 +2246,6 @@ static bool qedf_process_completions(struct qedf_fastpath *fp)
 
 	while (new_cqes) {
 		fp->completions++;
-		num_handled++;
 		cqe = &que->cq[que->cq_cons_idx];
 
 		comp_type = (cqe->cqe_data >> FCOE_CQE_CQE_TYPE_SHIFT) &
-- 
2.27.0

