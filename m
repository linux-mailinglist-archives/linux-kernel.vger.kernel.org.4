Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD92630821
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 01:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiKSApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 19:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiKSApZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 19:45:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C8D9B88;
        Fri, 18 Nov 2022 15:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50AA7B825A6;
        Fri, 18 Nov 2022 23:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17700C433C1;
        Fri, 18 Nov 2022 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668815246;
        bh=XihwsWyiavzhVTmCCaUHQYkuUf+CaFnN21aKdYIXar8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVLvZFVNR7rHcvbYuWk2IjlI/cpfz1iiyjTD0+2eaw6EHhqbW6MdRkCnCYdCtKlwS
         dwCkKmNYalqrgmln9eonH8/BAU3fDNvfT7z0Hzt7py4JSqrh3bnHrpgLo6reswibnH
         tISCTpcVwkKUKyWshudzZ9dvv47D0uD05qR0hKGXjwIJ1nx55LC2mNVcf6nqTvhMyL
         ECD5cpnLk3glAjZt7sHjCLg7FR8w75cwLAorze4WLNPKh+y4uiTdB1jflVllU5x2o4
         npYEn0hF/B5bYLa0o14PWysnyhBBy0aBf+yfae3usfPKN9AoLdfTGdd2nMbDDkws0y
         3D4Wd/spUdOFQ==
Date:   Fri, 18 Nov 2022 17:47:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] scsi: qla2xxx: Replace one-element array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <faa40e6b31ecc9387ad1644bb1957aa53d7c682f.1668814746.git.gustavoars@kernel.org>
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

Important to mention is that doing a build before/after this patch results
in no binary differences.

This help us make progress towards globally enabling
-fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/245
Link: https://github.com/KSPP/linux/issues/193
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/qla2xxx/qla_def.h | 4 ++--
 drivers/scsi/qla2xxx/qla_gs.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index a26a373be9da..1eea977ef426 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3151,12 +3151,12 @@ struct ct_sns_gpnft_rsp {
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
index 64ab070b8716..69d3bc795f90 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -4073,7 +4073,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
 
 		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
-			((vha->hw->max_fibre_devices - 1) *
+			(vha->hw->max_fibre_devices *
 			    sizeof(struct ct_sns_gpn_ft_data));
 
 		sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
-- 
2.34.1

