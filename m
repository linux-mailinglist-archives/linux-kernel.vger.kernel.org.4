Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DCE6FF1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbjEKMeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjEKMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:34:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6146A10F;
        Thu, 11 May 2023 05:34:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9EBF71FE91;
        Thu, 11 May 2023 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683808481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=83yvFZ5iIQbRFdlm2LdYEQOdrJZ+zypJQp4T17WtAcY=;
        b=cq5t3ADLmbRHetVLwL+ZtnNYPgqEVGy7WrBJZsI0DwR/doyLu8x4MjNibaN+2guhfHSLtX
        PoB6jMdFGJg+LnXetFib1emaEo+/TVfA6Na6NS6H06565ExRwhzXYf2liUkt3CD+3fJw9H
        iXFgSf8y/QLmAVADghGsj5z7xJi9aZk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC41F138FA;
        Thu, 11 May 2023 12:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7e1eNODgXGQjCAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 11 May 2023 12:34:40 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
Date:   Thu, 11 May 2023 14:34:32 +0200
Message-Id: <20230511123432.5793-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some callers of scsi_execute_cmd() (like e.g. sd_spinup_disk()) are
passing an uninitialized struct sshdr and don't look at the return
value of scsi_execute_cmd() before looking at the contents of that
struct.

This can result in false positives when looking for specific error
conditions.

In order to fix that let scsi_execute_cmd() zero sshdr->response_code,
resulting in scsi_sense_valid() returning false.

Cc: stable@vger.kernel.org
Fixes: 3949e2f04262 ("scsi: simplify scsi_execute_req_flags")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
I'm not aware of any real error having happened due to this problem,
but I thought it should be fixed anyway.
I _think_ 3949e2f04262 was introducing the problem, but I'm not 100%
sure it is really the commit to be blamed.
---
 drivers/scsi/scsi_lib.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b7c569a42aa4..923336620bff 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -209,11 +209,17 @@ int scsi_execute_cmd(struct scsi_device *sdev, const unsigned char *cmd,
 	struct scsi_cmnd *scmd;
 	int ret;
 
-	if (!args)
+	if (!args) {
 		args = &default_args;
-	else if (WARN_ON_ONCE(args->sense &&
-			      args->sense_len != SCSI_SENSE_BUFFERSIZE))
-		return -EINVAL;
+	} else {
+		/* Mark sense data to be invalid. */
+		if (args->sshdr)
+			args->sshdr->response_code = 0;
+
+		if (WARN_ON_ONCE(args->sense &&
+				 args->sense_len != SCSI_SENSE_BUFFERSIZE))
+			return -EINVAL;
+	}
 
 	req = scsi_alloc_request(sdev->request_queue, opf, args->req_flags);
 	if (IS_ERR(req))
-- 
2.35.3

