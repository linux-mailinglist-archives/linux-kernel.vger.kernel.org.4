Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6E06EF8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjDZQ7q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 12:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDZQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:59:44 -0400
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B36181;
        Wed, 26 Apr 2023 09:59:42 -0700 (PDT)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E1862222955;
        Wed, 26 Apr 2023 18:59:40 +0200 (CEST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id CD11E222952;
        Wed, 26 Apr 2023 18:59:40 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Wed, 26 Apr 2023 18:59:40 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        ulf hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCHv2] mmc: block: ensure error propagation for non-blk
Thread-Topic: [PATCHv2] mmc: block: ensure error propagation for non-blk
Thread-Index: Adl4YDcDMdbKHG5US4mGcFynSXDFNA==
Date:   Wed, 26 Apr 2023 16:59:39 +0000
Message-ID: <59c17ada35664b818b7bd83752119b2d@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27590.001
X-TMASE-Result: 10--6.524900-10.000000
X-TMASE-MatchedRID: 3BVF1Ao4uhpA+YmEQEhsujz6L+U/pejx1QQ6Jx/fflZnyL8x0tKlOyBd
        4OOd72kg5CeSbCAu+8ORoepQgi+s8uo7bV31UxoOxi///JpaHQO061diBteN18C5DTEMxpeQfiq
        1gj2xET856WD6kuo88Qt0liPmj9l9Q9tg+p38ZonOvXpg7ONnXX0tCKdnhB58HOI0tZ7A+B36C0
        ePs7A07SQvY0ueKrc1lspbK0dWqiL/efc0W4tuSQGBboIsOzFJFlT9HO1o+gY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: a066c7b2-77ab-4c42-a230-bc7981e0c34f-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requests to the mmc layer usually come through a block device IO.
The exceptions are the ioctl interface, RPMB chardev ioctl
and debugfs, which issue their own blk_mq requests through
blk_execute_rq and do not query the BLK_STS error but the
mmcblk-internal drv_op_result. This patch ensures that drv_op_result
defaults to an error and has to be overwritten by the operation
to be considered successful.

The behavior leads to a bug where the request never propagates
the error, e.g. by directly erroring out at mmc_blk_mq_issue_rq if
mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
can never see an error (BLK_STS_IOERR, but drv_op_result is unchanged)
and thus may assume that their call executed successfully when it did not.

While always checking the blk_execute_rq return value would be
advised, let's eliminate the error by always setting
drv_op_result as -EIO to be overwritten on success (or other error)

Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
v2: Adopted Adrians suggestions to set the error before calling
	and rewrote commit message
 drivers/mmc/core/block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672ab90c4b2d..0ff294f07465 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -266,6 +266,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_mq_free_request(req);
@@ -653,6 +654,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(req, false);
@@ -724,6 +726,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	}
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = n;
 	blk_execute_rq(req, false);
@@ -2808,6 +2811,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(req, false);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
@@ -2846,6 +2850,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 		goto out_free;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(req, false);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

