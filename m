Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2135165E253
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAEBMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAEBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:11:56 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B14203E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:11:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9so21109342pll.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 17:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ht7x/JA32K7BOLOoOLzoIZPJxTjgWhGENaRnGCDqrPM=;
        b=iCYXskBswzZwA1I3cPUbXMd+gv6aWEa2suiNDTr1QFxgMOCCJIxVgMKlfSFIWR6jtU
         dXJjIMMBz4lLRKpV4iPwGh/95LiCvnS2dtNzQNySNIU+M3ZAQFp79xn7XY32bAQNoUxr
         xpXTrWHrUzKZAodpjscgocR7IkxnYB09ISXPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ht7x/JA32K7BOLOoOLzoIZPJxTjgWhGENaRnGCDqrPM=;
        b=wT99OZpdD1hkUiemT1QZs0t1okc79f4Oh4dZp3hldYR++WlH1iDXM+ajp+4pDsiF+d
         Vhfwc7pthsFkrS7y44SIYzUSZzdtnOURJK/o6xH4aG6dE1Bz917NYaf0k4qPhcOZ21Qk
         b5BvHDSeEqj3Ij0c+QnHDVhGBf8HfC3IofvyIJt+Z6+XVbbmNO3mpUgsL+RoUr9kOi9i
         sa1rJ/bNPUeprfnE99/Kgr18XR6xoHB/+S+U3HjbBlTvYlZ712b5LW9EKBHEWPthk7iA
         aTCb0QQI4vOXHAlY/jqne1obW5XUArOlOYkO5pKxNeD0+rjGDpVa4PD9B/mGks0hKXvX
         PDhQ==
X-Gm-Message-State: AFqh2kr852aMhOTra5UkR/0EuG9Doq7j3BOhwX1k8UG8olC9nEhqQnnz
        fSbfUYmfMMyytZt7dD+W53cEWQ==
X-Google-Smtp-Source: AMrXdXvBcrv/YD0+53a1Ijp7JbYbDiPV+S/Wk092hz2lB2MNhlrnqyX0y8Cm7IBz5v8l4XS2R4RhdQ==
X-Received: by 2002:a17:902:b609:b0:192:4ed2:7509 with SMTP id b9-20020a170902b60900b001924ed27509mr52224202pls.15.1672881112114;
        Wed, 04 Jan 2023 17:11:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b0017ec1b1bf9fsm6059857plh.217.2023.01.04.17.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:11:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: mvumi: Replace 1-element arrays with flexible array members
Date:   Wed,  4 Jan 2023 17:11:50 -0800
Message-Id: <20230105011143.never.569-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; h=from:subject:message-id; bh=qz6T3MPmkcMRwGrKuMiso/QQxwBF2viOzcENWKH23bs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjtiPV0xDyI4a36t5rX10q4CK617DipQoGr1TFo1HQ Mzgi02yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7Yj1QAKCRCJcvTf3G3AJpmMD/ 0V8YarNdcntVZRODavlO1t39lW/PcZym1fSJ8pJB/DFiUksmgWnvHvx24jaZ4zsiCQ9GoBBXn7FmP0 2po+TnmCpTcHGa6Xz3qvNfOBOrOwmrAMrjjzFcEygUhDDJv6vcSwRD1xZn7nYG1pgcEvWfEuSl9QzT aBNfHvKj+PhJlPK1GsR4DIgT2YiPPkEFMhHvZmLHIGGn/52HJsLK7gm3eHpoHNTYTkai7XohoCEY2M qnxBwzZ9Yby5shnGTL1nTtmXu2omR77ztxB1n7/edJs3B2OkBgpXo9upTVSxWHaKhAaAOKz9OYdxVw vLmDyu5AUNmdNi/aLNlIQWonrHjgdNJML2JlAWV3mifTdPUAy8deLH3423XE7Gok8U6LK3O4979Tux kpeW57gYnljackwUBDlWkAJBVxh2BWd2/on8fYVqXuyC4WcLXUlIeecm33m32zzCZtmn3aw+S6kkVE CblsoMDAxG4Z79ZuizUy9/UcCl9ajbERnw5KGXe1VjT6cdffXKkveYxk2EAZFHRf7uq+qh8CMMvIEh HqC7VBxxaaASLuN5eSAOtbdyohTEwe3oxn1g3rhIt8IIsbveGxVFArJbIAExZ2Ef9O61HZHaCNi0H/ jAr5CvEGTlS/S19pxxjgGwHIhjrJU94V7tQQPw8utJvozxE+82xo9WDG278w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays (and multi-element arrays being treated as
dynamically sized) are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace one-element arrays with flexible-array member in struct
mvumi_msg_frame, struct mvumi_rsp_frame, and struct mvumi_hs_header,
adjusting the explicit sizing calculations at the same time.

This results in no functional differences in binary output. An explicit
add is now folded into the size calculation:

│       mov    0x1070(%r14),%eax
│ -     add    $0x4,%eax
│ -     movabs $0xfffffffdc,%rbx
│ +     movabs $0xfffffffe0,%rbx
│       add    %rax,%rbx

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/mvumi.c | 4 ++--
 drivers/scsi/mvumi.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index b3dcb8918618..60c65586f30e 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1841,7 +1841,7 @@ static enum mvumi_qc_result mvumi_send_command(struct mvumi_hba *mhba,
 	cmd->frame->request_id = mhba->io_seq++;
 	cmd->request_id = cmd->frame->request_id;
 	mhba->tag_cmd[cmd->frame->tag] = cmd;
-	frame_len = sizeof(*ib_frame) - 4 +
+	frame_len = sizeof(*ib_frame) +
 				ib_frame->sg_counts * sizeof(struct mvumi_sgl);
 	if (mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC) {
 		struct mvumi_dyn_list_entry *dle;
@@ -2387,7 +2387,7 @@ static int mvumi_io_attach(struct mvumi_hba *mhba)
 	struct Scsi_Host *host = mhba->shost;
 	struct scsi_device *sdev = NULL;
 	int ret;
-	unsigned int max_sg = (mhba->ib_max_size + 4 -
+	unsigned int max_sg = (mhba->ib_max_size -
 		sizeof(struct mvumi_msg_frame)) / sizeof(struct mvumi_sgl);
 
 	host->irq = mhba->pdev->irq;
diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
index a88c58787b68..1306a4abf19a 100644
--- a/drivers/scsi/mvumi.h
+++ b/drivers/scsi/mvumi.h
@@ -279,7 +279,7 @@ struct mvumi_msg_frame {
 	u16 request_id;
 	u16 reserved1;
 	u8 cdb[MAX_COMMAND_SIZE];
-	u32 payload[1];
+	u32 payload[];
 };
 
 /*
@@ -294,7 +294,7 @@ struct mvumi_rsp_frame {
 	u8 req_status;
 	u8 rsp_flag;	/* Indicates the type of Data_Payload.*/
 	u16 request_id;
-	u32 payload[1];
+	u32 payload[];
 };
 
 struct mvumi_ob_data {
@@ -380,7 +380,7 @@ struct mvumi_hs_header {
 	u8	page_code;
 	u8	checksum;
 	u16	frame_length;
-	u32	frame_content[1];
+	u32	frame_content[];
 };
 
 /*
-- 
2.34.1

