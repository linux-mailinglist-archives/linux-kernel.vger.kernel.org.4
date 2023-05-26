Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5671232D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbjEZJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjEZJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:16:02 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E41187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:15:57 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230526091555epoutp02c8186ec6d0b7986d77a0e08b8cb54eda~ipsA6sj2p0744107441epoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:15:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230526091555epoutp02c8186ec6d0b7986d77a0e08b8cb54eda~ipsA6sj2p0744107441epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685092555;
        bh=KiuNjEyMTnlfXTs8k2nqD47WBbkFhr1t4Hcw141BwbM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fuffEKg9OIgdedJlZDZaS6aGpdyorDZ1aQ2bcyyb4Z8Of1iGaI/TSUDDWka2SXQ9V
         nAUxlB5NzGI63pQKTISqjnPYzsgCOcdtjdk4PWkkVTYSeRsTaEkJCDiw1DK3i9P7L+
         80uc7Qhm/DowEE90b9hOQmxZm3Y6MNHdPahYwQb0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230526091554epcas5p116cc33ca357b2def769f70ab4aee5c4c~ipsAcImJX1544915449epcas5p1m;
        Fri, 26 May 2023 09:15:54 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QSK5z4WZFz4x9Q6; Fri, 26 May
        2023 09:15:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.77.04567.7C870746; Fri, 26 May 2023 18:15:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b~iplm6wvig1774017740epcas5p1R;
        Fri, 26 May 2023 09:08:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230526090834epsmtrp17497256b0d3cdd16044b134bb6dba317~iplm6DMH22034220342epsmtrp1a;
        Fri, 26 May 2023 09:08:34 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-14-647078c7691c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.B9.28392.21770746; Fri, 26 May 2023 18:08:34 +0900 (KST)
Received: from samsung.203.241.132.34 (unknown [109.105.118.54]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230526090833epsmtip23a0cf97de47337044e6bc855aad75e49~ipllwxT2O1678816788epsmtip2T;
        Fri, 26 May 2023 09:08:33 +0000 (GMT)
From:   "min15.li" <min15.li@samsung.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        "min15.li" <min15.li@samsung.com>
Subject: [PATCH v2] nvme: fix miss command type check
Date:   Fri, 26 May 2023 17:06:56 +0000
Message-Id: <20230526170656.55303-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmpu7xioIUg0t7FS1W3+1ns7hx/B2z
        xdzXl1gsVq4+ymQx6dA1RovLu+awWcxf9pTdYvmqDiaLda/fs1icnfCB1eLGuqssDtwe5+9t
        ZPG4fLbUY9OqTjaPzUvqPXbfbGDz6NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZL299Zy6YLlnx9P4PpgbGZaJdjJwc
        EgImEjd2nGfqYuTiEBLYzSixp3EWO0hCSOATo8SFE7UQic+MEo9X3WWC6dh79z4jRGIXo8TD
        tQ/ZIJyvjBLH97Uwg1SxCahLHPh4FGgUB4eIgIvEqU0qIGFmgVSJ723bwDYIC5hKfFu9hRHE
        ZhFQlZi4vh8szitgKbF26R12iGXyEvsPnmWGiAtKnJz5hAVijrxE89bZzCB7JQT+skv8e94H
        1eAicX3WS0YIW1ji1fEtUHEpiZf9bWD3SAgUS7z8EQYRrpHY/e021GPWEtvWr2MCKWEW0JRY
        v0sfIiwrMfXUOiaItXwSvb+fQJXzSuyYB2MrSfy9cA5qq4TE4v0PWSFsD4ldMxawQgI0VuL5
        22/sExjlZyH5ZhaSb2YhbF7AyLyKUTK1oDg3PbXYtMAwL7UcHq3J+bmbGMHpVMtzB+PdBx/0
        DjEycTAeYpTgYFYS4d2Qk58ixJuSWFmVWpQfX1Sak1p8iNEUGMQTmaVEk/OBCT2vJN7QxNLA
        xMzMzMTS2MxQSZxX3fZkspBAemJJanZqakFqEUwfEwenVANTZ0dM+5TKfXZL+vuXaIt5nu0P
        jjIKmic+s2HprrLPi4QOWW43bJDpmPU/ZKfRGdMPqueVFy3ftK9JY3tT5+oNMWbLev2VVwaG
        3vebYyB/++fG4EM3P9vlZ9T+O9ka9WP6eafqh/1Hu1quiXzYmNz438J6ksHlC4ufrijtzL0n
        suVeT8BzpnYxRs6y7CsPL2pd2jL5ynfjBaINa39t0jD7W6isXS6YqPAs1/33It0Un8iO+PR8
        6/o3J0++uNPiYy093+jmqV3HS2Ma5jtpCsqW17/532hj+TJ4gfaZSKMHhhG3D/ytmZMgmN30
        OEhYSTjk5dNQX8s5d4z7XgUpuWdMl/CNK44TMr12fpMLo4ASS3FGoqEWc1FxIgAf6SdTMAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK5QeUGKwZFVBhar7/azWdw4/o7Z
        Yu7rSywWK1cfZbKYdOgao8XlXXPYLOYve8pusXxVB5PFutfvWSzOTvjAanFj3VUWB26P8/c2
        snhcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bLW9+ZC6ZL
        Vjy9/4OpgXGZaBcjJ4eEgInE3rv3GbsYuTiEBHYwSqw+/JoRIiEhcX7eLzYIW1hi5b/n7BBF
        nxklFn55wQ6SYBNQlzjw8SiQzcEhIuAlceB4PkiYWSBd4vyePywgtrCAqcS31VvAZrIIqEpM
        XN8P1sorYCmxdukddoj58hL7D55lhogLSpyc+YQFYo68RPPW2cwTGPlmIUnNQpJawMi0ilEy
        taA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOLi1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeDTn5
        KUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwTV7sLK60
        QWX+cpl0EWY+CxnvTz7O++7xr/lR2nBc6Z77zp8Kvn/tKj1dqutXrzsx0fpdpJDxq4dnLvht
        vPrFr35af4T3jXM3LPYv2ZG+/27C/ps6qX2Fkrfl9HhZ173hWhjQlfJG3/hRgGCc3turpyvs
        H/fzXFM3frzzW/+Pr5VpQQn2u2etXf0/7neWy+oVdrYmx7tbttpPawt+clzjW7rDZi3hT8L7
        E/sm8j1d/2CulpnnwoI1+R+iw/s0VqtsWap7XHQS16Mr/4s3Npwse8163FnUYg7/kvTSTf06
        k5I2sdxsXbFS5uil1UE/5wX/4eF9tupS+WUP2zjTnn2TzR5+vrlF9eP5pmWfbKt+1yixFGck
        GmoxFxUnAgAdp/qS3QIAAA==
X-CMS-MailID: 20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b
References: <CGME20230526090834epcas5p197a90228102b26759f9b957c50d3bb6b@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/nvme/host/core.c       | 4 +++-
 drivers/nvme/host/ioctl.c      | 2 +-
 drivers/nvme/host/nvme.h       | 2 +-
 drivers/nvme/target/passthru.c | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f0cbb77b249..c6cba1cc101c 100644
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
@@ -1132,6 +1132,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
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

