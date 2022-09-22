Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45F25E5BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiIVHDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIVHDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:03:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393C86FE5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:03:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u69so8281963pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=adSoTd5PQILGShOmRTNAIfVgMacNjNuPK+PXvMa0Rho=;
        b=wOJqueuYceR32fuDLq2HZXcUOa65vmlZE/GoKpKqAsp7BZUnOLQY8EGE2eHRJ4UUZe
         8xZjI8ijNKZYvTFOCt4xK4gk+I1325q+4XyBkmRsmKCtoNHI4vWxxkEb/0wRZdLkqdsf
         I0hKKgrBIEY1ra0scoTo3+k6bZ59mj2Yl+UYeey1BhFCrNx2j01zIhgR3ioKhPo/y5DJ
         DaiAEsLBsTU5NchXzZV570MwvSneEtRQDG3DpPFxaaqB6NDE1LoTvbV2ysWR/Q4iGl7B
         si/fZBFIQ4Z9Y3sh6sHlEda35fcN+oNzxRyhwpdkUH17vabcAPo0aL+kPVosqCus/rRv
         pP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=adSoTd5PQILGShOmRTNAIfVgMacNjNuPK+PXvMa0Rho=;
        b=h0IvMl28kcCug7rUYm2TYO0Lj5dV14+ES1OVBKYp3/4k6PtS+inhct9ImJKfcre3W0
         rZ7dLqC/pvIs9nA/PO+oAtRQiPC1KqQr++rKuqOOsLlyNcKR+5N+iPzEpou27Hjsck5u
         Hd2KW0ClB1ifncRfcAATK969dFcFvTM2cTWYN4qDqy4mQUbxbiSU/3EnwX2zcNBcM9HW
         SHTOn2w2z/ZpK4vSjLJB72oT3adirHW8KmrqSyykmJYKqO2G5/+kE0IjJy+xf8lzJ2GF
         600FxaPbDSBm1XpoFGx50MccoAWObWtt+DsShpc77eoZMO9dOZW9ubr/rdeIBVjpsojE
         0avw==
X-Gm-Message-State: ACrzQf3n26XCbN1j6nG8FEx9G7Ybvm23Ycl2waTV06j0pAW3ecVWJCPi
        2J9D4nDmbdU5GguHBzKUlhuBTA==
X-Google-Smtp-Source: AMsMyM4dsMNhGbjT52gg3WcT0DmdYa75Kh7e3iaEH1k2m7BW0t5KiPz3EphCk64xia7FPyORd8X72g==
X-Received: by 2002:a63:778d:0:b0:438:5c5b:f2ac with SMTP id s135-20020a63778d000000b004385c5bf2acmr1784706pgc.401.1663830209592;
        Thu, 22 Sep 2022 00:03:29 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001782751833bsm3184261plg.223.2022.09.22.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 00:03:29 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] nvmet-tcp: remove nvmet_tcp_finish_cmd
Date:   Thu, 22 Sep 2022 15:06:16 +0800
Message-Id: <20220922070616.41918-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single call-site of nvmet_tcp_finish_cmd(), this
becomes redundant. Remove nvmet_tcp_finish_cmd() and use the original
function body instead.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 98e17ea184d6..63d72b9cb28d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -164,7 +164,6 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
-static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
@@ -1177,7 +1176,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			queue->idx, cmd->req.cmd->common.command_id,
 			queue->pdu.cmd.hdr.type, le32_to_cpu(cmd->recv_ddgst),
 			le32_to_cpu(cmd->exp_ddgst));
-		nvmet_tcp_finish_cmd(cmd);
+		nvmet_req_uninit(&cmd->req);
+		nvmet_tcp_free_cmd_buffers(cmd);
 		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
 		goto out;
@@ -1406,12 +1406,6 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 }
 
-static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
-{
-	nvmet_req_uninit(&cmd->req);
-	nvmet_tcp_free_cmd_buffers(cmd);
-}
-
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
-- 
2.20.1

