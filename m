Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E8B630823
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 01:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiKSAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 19:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiKSApo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 19:45:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B1DAD0E;
        Fri, 18 Nov 2022 15:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F19B8248E;
        Fri, 18 Nov 2022 23:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D67C433C1;
        Fri, 18 Nov 2022 23:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668815290;
        bh=V6o1820BomTbYwPBPVjRJZa37GdSnz96MLHX9Zwoc3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBIzxcJR6aLIxyVUmvLdDSGGutCg/6lET7G/314fgO3kvLNmmF8kKssti9L7Fol2F
         X17ZYJcubbxZvm7nAGmAJ1n0ElFvafZUOmFBXtAquLbYodrSwzncW+SR4q0zI4/xsn
         EzoZZb2RAJ6CAVBAD0sYcblNDKCIpBw4eJ16FLgBecV9ZNJqZD2DeLJBXuhacHlTeW
         o8UI0rd4BgJ6a4J4QXcvVWhc+bXDU3lNuWVxnJKt32gD54K6GI3NvGqJTnEzsxGgJQ
         mpPdXqLwHyYtigG2PEvXMsTp5mpcPC/mMQL/7/smpB53PMJXRI7/nRGOi52pdmdDvn
         qB5irgaJNHK6w==
Date:   Fri, 18 Nov 2022 17:47:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2][next] scsi: qla2xxx: Use struct_size() in code related
 to struct ct_sns_gpnft_rsp
Message-ID: <9bd4775fe9c88b33c3194f841a2ec2f559d58032.1668814746.git.gustavoars@kernel.org>
References: <cover.1668814746.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668814746.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size() over open-coded versions of idiom:

sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count

where count is the max number of items the flexible array is supposed to
contain.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/qla2xxx/qla_gs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 69d3bc795f90..27e1df56b0fb 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -4072,9 +4072,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 		}
 		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
 
-		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
-			(vha->hw->max_fibre_devices *
-			    sizeof(struct ct_sns_gpn_ft_data));
+		rspsz = struct_size((struct ct_sns_gpnft_rsp *)0, entries,
+				vha->hw->max_fibre_devices);
 
 		sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
 								rspsz,
-- 
2.34.1

