Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8486060D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJTNBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:01:35 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552224A81F;
        Thu, 20 Oct 2022 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1666270893;
  x=1697806893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yo6MjNIJsfBLy9yLm4TRzVtf2ChkEovWkPmV7TU4lco=;
  b=XwSVqdy34S+YlO2GRtDLW1+5/2xsx/EWSG2ZRp1a+KA0vc3IVqmZ1u/u
   ThS2v1H2qD1/gaNUlWNm7I1PmHHXYoQHUXPqNeD1YGm9QatLlFoGgJ8xJ
   6lHxXUoRMcWplY0VuW2LgyHxXslC2+DoDEhmkkUAVHk/kk0qp8N52t97i
   vbJudE2bi4wnFNSRcBx++Siu4S1TVoTurvPdNmLd6i4y3g5dQd9AUjiz5
   6qVpKEp4d2zLxOjAtG5N9c6WUxtJ0kDfkO+t8p8uDIt4s2Uh6U2i/DSWh
   5+PBZjCkO+qFrThK1nob6LSx2ssTOje/ec6luzlYWGcqYg5UNvnfZl+Xw
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Avri Altman <Avri.Altman@wdc.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: core: Fix WRITE_ZEROES CQE handling
Date:   Thu, 20 Oct 2022 15:01:23 +0200
Message-ID: <20221020130123.4033218-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WRITE_ZEROES requests use TRIM, so mark them as needing to be issued
synchronously even when a CQE is being used.  Without this,
mmc_blk_mq_issue_rq() triggers a WARN_ON_ONCE() and fails the request
since we don't have any handling for issuing this asynchronously.

Fixes: f7b6fc327327 ("mmc: core: Support zeroout using TRIM for eMMC")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mmc/core/queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index fefaa901b50f..3661ba0bbc87 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -48,6 +48,7 @@ static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
 	case REQ_OP_DRV_OUT:
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
 		return MMC_ISSUE_SYNC;
 	case REQ_OP_FLUSH:
 		return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
-- 
2.28.0

