Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC96B74119D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjF1MsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjF1MrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:47:24 -0400
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [IPv6:2001:41d0:203:375::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C930F1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:46:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687956373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=31zIMtFISDxe0nf6R4yblT+SRwQAWnTU/Z0saBZBUxs=;
        b=wRvAfwCA0YHWDCD6pdg4Lx3RQ91lrPYkGuWE/r49pIRMNPOE4siZ5dvLnWteut/DezWkBz
        FuaMAQTI1+mRI1BcvOnXbvjtXdORy106/BMRYydqBwe6MBXikR79j2x/3lWDgLNRbYtKNF
        DfQ4mrt3IpxL8NBzeOn0+9yDlrTEjN8=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, ming.lei@redhat.com, hch@lst.de
Subject: [PATCH v3 0/3] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
Date:   Wed, 28 Jun 2023 20:45:43 +0800
Message-Id: <20230628124546.1056698-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Hello,

This patchset fix start_time_ns and alloc_time_ns for pre-allocated rq.

patch 1 and 2 is preparation that we ktime_get_ns() outside batched rq init
for batched requests start_time_ns setting.

patch 3 is the fix patch that we set alloc_time_ns and start_time_ns
to now when the pre-allocated rq is actually used.

v3:
 - Skip setting the alloc_time_ns and start_time_ns during pre-allocation,
   which is clearer, as suggested by Tejun.
 - [v2] https://lore.kernel.org/all/20230626050405.781253-1-chengming.zhou@linux.dev/

v2:
 - Let blk_mq_rq_ctx_init() receive start_time_ns for batched time setting.
 - Set alloc_time_ns and start_time_ns when the pre-allocated rq is actually
   used, as suggested by Tejun.
 - [v1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/

Chengming Zhou (3):
  blk-mq: always use __blk_mq_alloc_requests() to alloc and init rq
  blk-mq: ktime_get_ns() only once for batched requests init
  blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq

 block/blk-mq.c         | 94 ++++++++++++++++++++++++------------------
 include/linux/blk-mq.h |  6 +--
 2 files changed, 56 insertions(+), 44 deletions(-)

-- 
2.39.2

