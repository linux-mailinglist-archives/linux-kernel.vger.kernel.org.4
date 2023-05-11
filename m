Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731E06FEFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjEKKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjEKKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:20:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047126A78
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:20:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aae46e62e9so60574925ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683800406; x=1686392406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IdKaYTN4becysX4nA0PefiZtmiomrwgAAThVv5nuQg=;
        b=sX3ySwisJEvh87zusZ+O3SdXJ2JsGLpzbFc2myV8nmdaDwZABOsxfTJh7jpCggzhJe
         FbaVzUHxmwfY6K3ewbzytbVBCdD3Nt+d7E2+liLopJ9fBn3WgS9POt+w5wbCg9H0ndT2
         atXQq243nbpYY+5tK18ISlDvtNbpHCVFN/S7sPoqvvaI9eqAWhIj3XQnkX+NmJPHo05k
         f6wKisB0qEKT+bIeECoigo7g+TXepTs20kMB4inxuWYvUHqMrRhPLiv0dM3Wf65nS35P
         RmZd4DL/M7/vlLioGD3VWA0gcfHO1xLMk4UzX5rOzS47NQs/DXRlF+JeaWMRpuyEnbJ/
         3HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683800406; x=1686392406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IdKaYTN4becysX4nA0PefiZtmiomrwgAAThVv5nuQg=;
        b=JdPohbjmzdSC2oFuFaTTiHJc8QqGFCVdC9WjLGKhrY9rnynV6ZSctFZmiNqH5tB0hi
         gxmVUhVg2lSVaFlTfVWp5/JZtO/+qcpe9LdUO5VKF6ilLIwgXW2tx4r0Fyb5usuHcSUr
         +f++/fJk3Oe+ZVu75NjpR5t6MXtBRy8jUbViKoqvqKG4RSEznE5NrPQVwTwWMF1H9tJu
         WAKPW4QVzO03p6Yps69WiG2n/tFceBZZWjeBz2q9SjtrU7YxI3lWBf2jFD24/ZzETSMS
         TchJo/bvPJbRn714CzjWgcFgBTK3NJl61Ik+Wxk9PEAQm6CiaYp4tXu2s7njtrVlOUEV
         3qqw==
X-Gm-Message-State: AC+VfDxxyagAEMWvmAfz9xtVXzcj+XcwBrVS7rOsmTYyCgCY45Vcq+4q
        evo/JL7YoqjdfNTYdASlw6oonzx5folQ2ZbY
X-Google-Smtp-Source: ACHHUZ6JwOr+s4/XyMgloVPyWCUofPJM56cU77Ugo02HdW1uu1jUZtY9mC8r/waaT0D03klAicn6pw==
X-Received: by 2002:a17:902:dac2:b0:1ac:4d3e:1bf5 with SMTP id q2-20020a170902dac200b001ac4d3e1bf5mr26881570plx.23.1683800406432;
        Thu, 11 May 2023 03:20:06 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902a60b00b001ab1a737c8dsm5451110plq.285.2023.05.11.03.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:20:06 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <chunguang.xu@shopee.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: donot try to resubmit a canceled IO
Date:   Thu, 11 May 2023 18:20:03 +0800
Message-Id: <20230511102003.398070-1-chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "chunguang.xu" <chunguang.xu@shopee.com>

Now if NVMe over rdma and NVMe over TCP module detected
controller is INACTIVE on the IO timeout path, it will
try to call nvmf_complete_timed_out_request() to
terminated this IO. But nvme_complete_rq() will continue
to retry this IO, as the request_queue is quiescing at
this time, if the target cannot connected or the host
actively executes disconnect, it will cause this IO hang
in the hctx dispatch queue and cannot be processed,
resulting in hung task, the calltrace as followed:

[ 1575.570245] INFO: task kworker/u129:6:758 blocked for more than 966 seconds.
[ 1575.577829]       Tainted: G           OE     5.4.0-77-shopee-generic #86+5
[ 1575.585323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1575.593670] kworker/u129:6  D    0   758      2 0x80004000
[ 1575.593681] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[ 1575.593683] Call Trace:
[ 1575.593689]  __schedule+0x2ee/0x750
[ 1575.593691]  schedule+0x42/0xb0
[ 1575.593693]  io_schedule+0x16/0x40
[ 1575.593696]  do_read_cache_page+0x438/0x840
[ 1575.593698]  ? __switch_to_asm+0x40/0x70
[ 1575.593700]  ? file_fdatawait_range+0x30/0x30
[ 1575.593702]  read_cache_page+0x12/0x20
[ 1575.593704]  read_dev_sector+0x27/0xd0
[ 1575.593705]  read_lba+0xbd/0x220
[ 1575.593707]  ? kmem_cache_alloc_trace+0x1b0/0x240
[ 1575.593708]  efi_partition+0x1e0/0x700
[ 1575.593710]  ? vsnprintf+0x39e/0x4e0
[ 1575.593712]  ? snprintf+0x49/0x60
[ 1575.593714]  check_partition+0x154/0x250
[ 1575.593715]  rescan_partitions+0xae/0x280
[ 1575.593718]  bdev_disk_changed+0x5f/0x70
[ 1575.593719]  __blkdev_get+0x3e3/0x550
[ 1575.593720]  blkdev_get+0x3d/0x150
[ 1575.593722]  __device_add_disk+0x329/0x480
[ 1575.593723]  device_add_disk+0x13/0x20
[ 1575.593727]  nvme_mpath_set_live+0x125/0x130 [nvme_core]
[ 1575.593731]  nvme_mpath_add_disk+0x11e/0x130 [nvme_core]
[ 1575.593734]  nvme_validate_ns+0x6a8/0x9d0 [nvme_core]
[ 1575.593736]  ? __switch_to_asm+0x40/0x70
[ 1575.593739]  nvme_scan_work+0x1e0/0x350 [nvme_core]
[ 1575.593743]  process_one_work+0x1eb/0x3b0
[ 1575.593745]  worker_thread+0x4d/0x400
[ 1575.593747]  kthread+0x104/0x140
[ 1575.593748]  ? process_one_work+0x3b0/0x3b0
[ 1575.593750]  ? kthread_park+0x90/0x90
[ 1575.593751]  ret_from_fork+0x1f/0x40

This issue seems not fixed on lastes kernel, try to fix it here.

Signed-off-by: chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c    | 3 +++
 drivers/nvme/host/fabrics.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccb6eb1282f8..bf9273081595 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -349,6 +349,9 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+		return COMPLETE;
+
 	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
 		return AUTHENTICATE;
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..40a5d6659af0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -199,6 +199,7 @@ static inline void nvmf_complete_timed_out_request(struct request *rq)
 {
 	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
+		nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.25.1

