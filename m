Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066B56F9944
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjEGPWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjEGPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:22:17 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA125FF2
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:22:15 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id vgDDpvXaKGGqgvgDDpcwUC; Sun, 07 May 2023 17:22:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683472933;
        bh=I6v/9qwu418rPG9padWDpMt9k7O+xJOyw+vQEwDIKVg=;
        h=From:To:Cc:Subject:Date;
        b=Tpn1eTHPwGQl9t/TXXTEWoDe5wjOKWa8xl/XMUaM+LwitkS85U0d+eZzlY8KKD09N
         9DA5g46Xnc9+eMkIlzNgJD58rDem0bCSSW8MNQCzRd9wxKE/ZmgzInmO/q2nT1W8be
         LepW6wu2evBnCTkc/sQAu1veARRc518oMvhxgkQ1MF2gXm6WEla3sQtPXGl0jOU8v1
         kz8L3Fg6U8qeeqnUiX+ki23kF/tMqctwlRhKHZ5qVsjx2gbaKsPgpCiub2v/i2YKiU
         6QXnLksuf6U58Ye7a/ays6j4tMYk3eEiv1ScZjhVPu1Y59KhoLAwY3IfjauTjAm2rv
         bFebmCcTFH+xQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 May 2023 17:22:13 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: mpi3mr: Fix the type used for pointers to bitmap
Date:   Sun,  7 May 2023 17:22:10 +0200
Message-Id: <5ff41d1b0f1020c37a5efab9fd8df4244bd0fb5a.1683472897.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitmaps are "unsigned long[]", so better use "unsigned long *" instead of
a plain "void *" when dealing with pointers to bitmaps.

This is more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/mpi3mr/mpi3mr.h    | 2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index dfe6b87fe288..eaa5a508811e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1142,7 +1142,7 @@ struct mpi3mr_ioc {
 	struct mpi3mr_drv_cmd evtack_cmds[MPI3MR_NUM_EVTACKCMD];
 	void *devrem_bitmap;
 	u16 dev_handle_bitmap_bits;
-	void *removepend_bitmap;
+	unsigned long *removepend_bitmap;
 	struct list_head delayed_rmhs_list;
 	void *evtack_cmds_bitmap;
 	struct list_head delayed_evtack_cmds_list;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 075fa67e95ee..9b56d13821c6 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1134,7 +1134,7 @@ static int mpi3mr_issue_and_process_mur(struct mpi3mr_ioc *mrioc,
 static int
 mpi3mr_revalidate_factsdata(struct mpi3mr_ioc *mrioc)
 {
-	void *removepend_bitmap;
+	unsigned long *removepend_bitmap;
 
 	if (mrioc->facts.reply_sz > mrioc->reply_sz) {
 		ioc_err(mrioc,
-- 
2.34.1

