Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41B964F716
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLQCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQCoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:44:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7A07020E;
        Fri, 16 Dec 2022 18:44:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 305EA622C1;
        Sat, 17 Dec 2022 02:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E4DC433EF;
        Sat, 17 Dec 2022 02:44:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ll2LxqTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671245054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4eX39k5tQpTzSn7t7Lmh7418aD8frOFMckSb0RMt3lY=;
        b=Ll2LxqTk4CrilzrKT5cNm7vkUXWa9xrBCd2Q3YPn44vw7O6H8yQGev5O7O+xV0VSro2YHS
        AteWY8YqoYyl6b8SgDAJHbam+voeat3C59TF/SDw76hgSYVMOW10SbknfgW8uiCvG8O2Jh
        KFVXkKViEy2aO9IyGaQOcclromRsuhY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f8b6b386 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 17 Dec 2022 02:44:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: fcoe_ctlr: use unpredictable RNG
Date:   Fri, 16 Dec 2022 19:43:41 -0700
Message-Id: <20221217024341.808343-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prandom_*() functions are only suitable for testsuites that need
repeatable/seeded randomness. The rest of FCOE uses the proper
get_random_xx() functions, but this one use case was oddly left out. So
convert it to use get_random_u16().

Cc: Hannes Reinecke <hare@suse.de>
Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 3 +--
 include/scsi/libfcoe.h        | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 5c8d1ba3f8f3..1f60e2abd1a7 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -2224,7 +2224,7 @@ static void fcoe_ctlr_vn_restart(struct fcoe_ctlr *fip)
 	 */
 	port_id = fip->port_id;
 	if (fip->probe_tries)
-		port_id = prandom_u32_state(&fip->rnd_state) & 0xffff;
+		port_id = get_random_u16();
 	else if (!port_id)
 		port_id = fip->lp->wwpn & 0xffff;
 	if (!port_id || port_id == 0xffff)
@@ -2249,7 +2249,6 @@ static void fcoe_ctlr_vn_restart(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_vn_start(struct fcoe_ctlr *fip)
 {
 	fip->probe_tries = 0;
-	prandom_seed_state(&fip->rnd_state, fip->lp->wwpn);
 	fcoe_ctlr_vn_restart(fip);
 }
 
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index 279782156373..d275e2921cf9 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -92,7 +92,6 @@ enum fip_mode {
  * @recv_work:	   &work_struct for receiving FIP frames.
  * @fip_recv_list: list of received FIP frames.
  * @flogi_req:	   clone of FLOGI request sent
- * @rnd_state:	   state for pseudo-random number generator.
  * @port_id:	   proposed or selected local-port ID.
  * @user_mfs:	   configured maximum FC frame size, including FC header.
  * @flogi_oxid:    exchange ID of most recent fabric login.
@@ -133,7 +132,6 @@ struct fcoe_ctlr {
 	struct sk_buff_head fip_recv_list;
 	struct sk_buff *flogi_req;
 
-	struct rnd_state rnd_state;
 	u32 port_id;
 
 	u16 user_mfs;
-- 
2.39.0

