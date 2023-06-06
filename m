Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527D17250B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjFFXVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbjFFXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B410C6;
        Tue,  6 Jun 2023 16:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F7A063903;
        Tue,  6 Jun 2023 23:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E641FC433D2;
        Tue,  6 Jun 2023 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686093690;
        bh=QLiV6Xl+X+ABZIsh3W9Glykjhx+2zH3dlEFevPn4GlE=;
        h=Date:From:To:Cc:Subject:From;
        b=mdy5/Q9UkOwGl/WyHJDdRLVVVKRXQkYQuKc/tfyTjUmReMC9esW2Y6QbZtAVgcVfc
         ymPAHmww9bdTqrF+hs4R8+PABccA4gvKrOXzz+CM2fs4p/OCQvsfSGQ7cCL1QBNwde
         Iwb2BLzElh0v/Ka9zpoq62zFuPAEEgRkRH73xpGdVQDcqYEZygoFpyNRHoMSqr6J6u
         9A+U1iy7x4UsSpwrg82QUKEYK+LV9eAaoMdRFQLldXMgzBYEfvCcxXx1hax5Trg9Ck
         lZCq2eOiVmirXEZHMXYIYeyY4785/VkFs5No2pEQhw+WT5VlBVcI8NX3SSv0T4kFhk
         DgzxnaWV5XGUg==
Date:   Tue, 6 Jun 2023 17:22:21 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nilesh Javali <njavali@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [RESEND][PATCH][next] Replace one-element array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <ZH+/rZ1R1cBjIxjS@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays as fake flex arrays are deprecated and we are moving
towards adopting C99 flexible-array members, instead. So, replace
one-element array declaration in struct ct_sns_gpnft_rsp, which is
ultimately being used inside a union:

drivers/scsi/qla2xxx/qla_def.h:
3240 struct ct_sns_gpnft_pkt {
3241         union {
3242                 struct ct_sns_req req;
3243                 struct ct_sns_gpnft_rsp rsp;
3244         } p;
3245 };

Refactor the rest of the code, accordingly.

This issue was found with the help of Coccinelle.

Link: https://github.com/KSPP/linux/issues/245
Link: https://github.com/KSPP/linux/issues/193
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h | 4 ++--
 drivers/scsi/qla2xxx/qla_gs.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 35009ce5246a..a9acdec003a3 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3174,12 +3174,12 @@ struct ct_sns_gpnft_rsp {
 		uint8_t vendor_unique;
 	};
 	/* Assume the largest number of targets for the union */
-	struct ct_sns_gpn_ft_data {
+	DECLARE_FLEX_ARRAY(struct ct_sns_gpn_ft_data {
 		u8 control_byte;
 		u8 port_id[3];
 		u32 reserved;
 		u8 port_name[8];
-	} entries[1];
+	}, entries);
 };
 
 /* CT command response */
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 4738f8935f7f..1cf9d200d563 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3776,8 +3776,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
 
 		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
-			((vha->hw->max_fibre_devices - 1) *
-			    sizeof(struct ct_sns_gpn_ft_data));
+			vha->hw->max_fibre_devices *
+			    sizeof(struct ct_sns_gpn_ft_data);
 
 		sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
 								rspsz,
-- 
2.34.1

