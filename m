Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3C711F12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjEZFCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 01:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZFCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:02:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3770413A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:02:40 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230526050237epoutp040725896831717ce7ec4906c8498cf56b~imO2u0vAv1545615456epoutp04m
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:02:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230526050237epoutp040725896831717ce7ec4906c8498cf56b~imO2u0vAv1545615456epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685077357;
        bh=rXakpyPb/GV35DfEkX77EIELBqIH19M0ZUXqpU4HQ2A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Zwj6GXQ0jZoC82eWmDjE0z4XTRjvODymnjIhp3ybCqxcvTrz7icLTjDgz2RClJQzi
         wuY0T16ifgLLP9bwiNBpo3ikR0r9wKCZ2KeRFcWlsoHivqRT1c5/IzoAc01d3l9dmF
         1a9gv7HK/EpsObkXFAo2QryzcHqw3jfwlifMuwi4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230526050236epcas5p405661b10798bbd2a3ec9e2591a92ac61~imO2AZgMS2321023210epcas5p4n;
        Fri, 26 May 2023 05:02:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QSCTk6d5Jz4x9QL; Fri, 26 May
        2023 05:02:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.AB.04567.76D30746; Fri, 26 May 2023 14:02:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230526030614epcas5p4ca2cac6dc85dd8609b62e5802c06fb40~ikpPLgR6k1442314423epcas5p4U;
        Fri, 26 May 2023 03:06:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230526030614epsmtrp2de93601e17086a6f38625a680e280c08~ikpPKg9Zz1889718897epsmtrp2j;
        Fri, 26 May 2023 03:06:14 +0000 (GMT)
X-AuditID: b6c32a49-db3fe700000011d7-20-64703d67d10b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.EA.27706.52220746; Fri, 26 May 2023 12:06:13 +0900 (KST)
Received: from samsung.203.241.132.34 (unknown [109.105.118.54]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230526030612epsmtip2f128dc676da344e47e81a8d16b57b3c7~ikpN-ZZWV2165621656epsmtip2K;
        Fri, 26 May 2023 03:06:12 +0000 (GMT)
From:   "min15.li" <min15.li@samsung.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        "min15.li" <min15.li@samsung.com>
Subject: [PATCH] nvme: fix miss command type check
Date:   Fri, 26 May 2023 11:04:34 +0000
Message-Id: <20230526110434.17036-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmum66bUGKwbmdnBar7/azWdw4/o7Z
        Yu7rSywWK1cfZbKYdOgao8XlXXPYLOYve8pusXxVB5PFutfvWSzOTvjAanFj3VUWB26P8/c2
        snhcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMk3+3sxY0KFQ8vLGQrYFxlVQXIyeH
        hICJxP2Ls1m7GLk4hAR2M0q8v3mWDcL5xChx8cVDJpAqIYFvjBLHGuVhOrbOWMMCUbSXUWLB
        4c3sEM5XRom3h/cyglSxCahLHPh4FCjBwSEi4CJxapMKSJhZIFXie9s2dhBbWMBI4tOp/cwg
        NouAqsSCF+dZQGxeAUuJhX/fskMsk5fYf/AsM0RcUOLkzCcsEHPkJZq3zmYG2Ssh8JNdYvLd
        v1ANLhIbd++CsoUlXh3fAmVLSXx+t5cN5B4JgWKJlz/CIMI1Eru/3WaCsK0ltq1fxwRSwiyg
        KbF+lz5EWFZi6ql1TBBr+SR6fz+BKueV2DEPxlaS+HvhHCOELSGxeP9DVohNHhI376VDgjBW
        YvXXDuYJjPKzkDwzC8kzsxAWL2BkXsUomVpQnJueWmxaYJiXWg6P1eT83E2M4GSq5bmD8e6D
        D3qHGJk4GA8xSnAwK4nwbsjJTxHiTUmsrEotyo8vKs1JLT7EaAoM4YnMUqLJ+cB0nlcSb2hi
        aWBiZmZmYmlsZqgkzqtuezJZSCA9sSQ1OzW1ILUIpo+Jg1OqgWnN4m0bvFttv0295vPJwatv
        soNp4ZQVIemcNzTj8jnO/ds4zYg3VeFKi1xv0bPvFssk95x67/MtjuOUUSTjlqPxcze1n976
        2Piwpn3pIXu++EahPee5hd78eHnQcKrq1hfHyh/zXtzw+TTT7Lq1Vt9zVy3lCTq5RstvR8IM
        mXLB+I3TPoRu2pP6ZPGX9OClZm99RP/etH518tUE78kus5WWzY7MCBcTftMZ7svy55m30Z+A
        Pc/qt0wpnWDlG5L1ZMfVR1Vpf+1D+5ku7fg/9QW/c+4zZ1XT48y3NXSajV507NNT5fj3ySeJ
        fxvbBR+Loo8dC+966+tv+8QWXvdz5ilZ1zaLcIXD96xjNVJv2ncqsRRnJBpqMRcVJwIABFA3
        VC8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvK6qUkGKwf4H5har7/azWdw4/o7Z
        Yu7rSywWK1cfZbKYdOgao8XlXXPYLOYve8pusXxVB5PFutfvWSzOTvjAanFj3VUWB26P8/c2
        snhcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bJv9tZCxoU
        Kh7eWMjWwLhKqouRk0NCwERi64w1LF2MXBxCArsZJZr372KHSEhInJ/3iw3CFpZY+e85WFxI
        4DOjxJu3zCA2m4C6xIGPR4HiHBwiAl4SB47ng4SZBdIlzu/5wwJiCwsYSXw6tR+snEVAVWLB
        i/NgcV4BS4mFf99CrZKX2H/wLDNEXFDi5MwnLBBz5CWat85mnsDINwtJahaS1AJGplWMkqkF
        xbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGhraW5g3H7qg96hxiZOBgPMUpwMCuJ8G7IyU8R
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgUkog8lqVuUd
        OXGF/Wt/T4+/xd65TnO3anX5Bu5A69MpAdmb2F5+PNJmliJ8/9w3Vp6lDz8+u5d9afqmj79/
        v9OZXOcSvN830t48hjHi7oGcTUH1tRIztm3YnWbUUL9xyyTrL/1N8p/bjebpHz90JWfS5gP+
        i5+XOSdv3PnHkOHO7E13Zva+blP6wHe9aOariUx/5/x+KGzxeEbjeZ+rUhaSe9e8mHo944z6
        D//8S7OUyt03rwnsMDssuHtde2DCyik/3V+dKWU86By60CL8nFECh+wmPYt3XZFbbW4zbIhW
        MbuguXeFy9KTM47Hef1YW93nUXWt1WrJ1RNytY+CRNRbpy/OPclqVHLGc+Gtut2CSizFGYmG
        WsxFxYkAxKCmjdwCAAA=
X-CMS-MailID: 20230526030614epcas5p4ca2cac6dc85dd8609b62e5802c06fb40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526030614epcas5p4ca2cac6dc85dd8609b62e5802c06fb40
References: <CGME20230526030614epcas5p4ca2cac6dc85dd8609b62e5802c06fb40@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function nvme_passthru_end(),only the value of the command opcode is
checked, without checking the command type (IO command or Admin command).
When we send a Dataset Management command (The opcode of the Dataset
Management command is the same as the Set Feature command),kernel
thinks it is a set feature command, then sets the controller's keep
 alive interval, and calls nvme_keep_alive_work().

Signed-off-by: min15.li <min15.li@samsung.com>
---
 drivers/nvme/host/core.c       | 33 +++++++++++++++++----------------
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/passthru.c |  2 +-
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f0cbb77b249..fc2ad8584110 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1115,7 +1115,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1132,25 +1132,26 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
-
-	switch (cmd->common.opcode) {
-	case nvme_admin_set_features:
-		switch (le32_to_cpu(cmd->common.cdw10) & 0xFF) {
-		case NVME_FEAT_KATO:
-			/*
-			 * Keep alive commands interval on the host should be
-			 * updated when KATO is modified by Set Features
-			 * commands.
-			 */
-			if (!status)
-				nvme_update_keep_alive(ctrl, cmd);
+	if (!ns) {
+		switch (cmd->common.opcode) {
+		case nvme_admin_set_features:
+			switch (le32_to_cpu(cmd->common.cdw10) & 0xFF) {
+			case NVME_FEAT_KATO:
+				/*
+				 * Keep alive commands interval on the host should be
+				 * updated when KATO is modified by Set Features
+				 * commands.
+				 */
+				if (!status)
+					nvme_update_keep_alive(ctrl, cmd);
+				break;
+			default:
+				break;
+			}
 			break;
 		default:
 			break;
 		}
-		break;
-	default:
-		break;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 81c5c9e38477..f15e7330b75a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -254,7 +254,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2d4f59e0535..2dd52739236e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1077,7 +1077,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 511c980d538d..71a9c1cc57f5 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -243,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
-- 
2.34.1

