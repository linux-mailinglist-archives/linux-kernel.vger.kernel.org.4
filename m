Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99253661A82
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbjAHWle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjAHWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:41:22 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341DFF584;
        Sun,  8 Jan 2023 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673217670;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=PbYONqe9jh9eXb5CBIRUMjVZLfLvI+aokxWTZGr6DLs=;
    b=UpONrLUnz6UQk+vYZDTzw6eH7OigL8+WTM4hJDKJyAMDH7eU0NGeJi3h1MKXfGLX/w
    dCerFM1GImw+ZdodJw80sIQdqe4hDM6eXEm3um0b8n2E1q001wefXozTPHbQ7hYvAGD8
    asiLhK+qOxUrrS7CxcUvpgxQ7BPSFXSG1hHS3BLRkNjoh0WKgtMoC4yHo5K6kDqjXQh3
    Rt05AFYkAzPQwz0+ScciqivQqGakriFTy6btrIIH6twNVSa18TUw3yyBs2jkuGLBiZIV
    mEV3X0FZLQFrI4zJc9f5aW9IpLCwVxwPXo5VHafOEtv7AVJreMFoMxHn2Ki06ObPeQ1+
    dWyQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1UnWvo/SqbTSXcQZxAZvLxWc5msS6txu0oUh"
X-RZG-CLASS-ID: mo01
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id 905423z08MfAAe9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 8 Jan 2023 23:41:10 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        quic_cang@quicinc.com, quic_xiaosenh@quicinc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] scsi: ufs: core: bsg: Fix sometimes-uninitialized warnings
Date:   Sun,  8 Jan 2023 23:40:55 +0100
Message-Id: <20230108224057.354438-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108224057.354438-1-beanhuo@iokpp.de>
References: <20230108224057.354438-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Compilation complains that two possible variables are used without
initialization:

drivers/ufs/core/ufs_bsg.c:112:6: warning: variable 'sg_cnt' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
drivers/ufs/core/ufs_bsg.c:112:6: warning: variable 'sg_list' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Fix both warnings by adding initialization with sg_cnt = 0, sg_list = NULL.

Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Signed-off-by: Bean Huo <beanhuo@micron.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Xiaosen He <quic_xiaosenh@quicinc.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/ufs/core/ufs_bsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
2.25.1

