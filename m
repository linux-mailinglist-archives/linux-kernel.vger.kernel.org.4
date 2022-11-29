Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65A63B768
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiK2Brc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiK2BrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:47:24 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E542F49
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669686443; x=1701222443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cOMinmP7YwLoFZtj6w7noAJ/JiJuR8Y8SegQlnLGlQs=;
  b=WI+xdAMFokhtvEceetlMLtkQG8vrfS7A3KDT9CYLckKdaHG8Jn6zEkWZ
   GfXpvsa1hwFz2qU1bVdBdmOCkSQwBywPDSh9EooFThb+wvhJuKOYeBE/s
   mN/zO70ILHmD9UvZnBYY0/wOtg0DrEpN1RPvlgFRVw3Ww9FnCarYGPTJt
   pZA2gOae8WgpJLtRUC+IfQs5fWU4NvhkSu4TNaSDbO0pQkq8lplOezqg6
   DmN34FXpbyEqqCFJhhrUCHC9eC/h0lkM4paW22MwSvjA7BOGquZ8rwely
   +HX3h80zeCUwy3gydp5/0F82JYXFzulgj41SxToBE7TjCyGlkqtUVSTQp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="315024945"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="315024945"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 17:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="768260495"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="768260495"
Received: from leirao-pc.bj.intel.com ([10.238.156.101])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2022 17:47:21 -0800
From:   Lei Rao <lei.rao@intel.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lei Rao <lei.rao@intel.com>
Subject: [PATCH] nvme: clear the prp2 field of the nvme command.
Date:   Tue, 29 Nov 2022 09:47:11 +0800
Message-Id: <20221129014711.91305-1-lei.rao@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
field is garbage data. According to nvme spec, the prp2 is reserved if
the data transfer does not cross a memory page boundary. Writing a
reserved coded value into a controller property field produces undefined
results, so it needs to be cleared in nvme_setup_rw().

Signed-off-by: Lei Rao <lei.rao@intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da55ce45ac70..332367b66fbe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -891,6 +891,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.reftag = 0;
 	cmnd->rw.apptag = 0;
 	cmnd->rw.appmask = 0;
+	cmnd->rw.dptr.prp2 = 0;
 
 	if (ns->ms) {
 		/*
-- 
2.34.1

