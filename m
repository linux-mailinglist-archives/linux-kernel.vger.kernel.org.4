Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E565A539
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiLaPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiLaPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:04:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5FF636A;
        Sat, 31 Dec 2022 07:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1672499042;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=WsIRV1TbJf8eCHpTVnn0dqwbjlhG8WH9NneJ5yoOHH0=;
    b=kNa+ZehnjsuQOZd+sf90EuqszQoY6esmi3tjB3MgaPIGq/m0cBZ3xC8S58ONtl8Zie
    4MgmkcgCwcXdgDRIYpbb30PpjWxzVcuM+JICCbzVTG77vCZipJTw/BkUnUDYD3xnonLg
    fZ8mLcChg9f/MRBPVC8GaA7vhROpOkEG/cgDEkz8FyXTOiOXBcEvfZRWLqNgrZxnjk/f
    7P8xm8d/35E42QdRWGo4NsXtRG4KeyCrWD+Y8BXJ47h9xhr9QCg0Fy5oKx+J7zwjr2Os
    YQ8KIgy2REu79RrQtPT1fJBPfkR/PCS6MpNhO+MZ9ta5BdY0pDOVrVqDuvgNx3IXKibr
    OXlA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1UnWvo/S/rRtv7EWu+6UqkpHFu65fxzM0xwfgg=="
X-RZG-CLASS-ID: mo00
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyBVF41cFo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 31 Dec 2022 16:04:01 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        quic_cang@quicinc.com, quic_xiaosenh@quicinc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH ] scsi: ufs: core: bsg: Fix sometimes-uninitialized warnings
Date:   Sat, 31 Dec 2022 16:03:43 +0100
Message-Id: <20221231150343.146274-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
Hi Martin,

This patch is to fix two compilation warnings introduced by my commit:
6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg").

Apologies for this.

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

