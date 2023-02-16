Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFED699305
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBPLU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBPLUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:20:54 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737E3773C;
        Thu, 16 Feb 2023 03:20:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d8so1553876ljq.9;
        Thu, 16 Feb 2023 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jRg2Rlx26KH+CW0ykpKoKv+GUimANKcSEatd9J5pu0=;
        b=LrBnvnhmrP8bgAnOcCzs6L69/n7yBzd/y1l+NCHNNJn6zQ1AerO9JZiS9cgDykg5Ji
         GGgjEwPeLhmfSSRRVPw8Qql1F79z00J9raNLkmHyDIcHKVuwDi9sm1KnP7TOvJ/spUBn
         68Es7i6VnEnldAqXRugn3/RcgUE4kuqSAtP5wAVYTGeooPhKeONePuAbKVnHV1Xezltk
         i7PTItAyfeq1KwEKvujHclqa3OJRZuWJE7sNtBsyH80tGKVu34unr8tdnSDrxVO2n74M
         zCpex1wgapQ3rkBoYp1h13EwKSVFJKzzUK84og5qNWxoCRp8Mf/Av5kDkqxO4Klq92Dr
         c/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jRg2Rlx26KH+CW0ykpKoKv+GUimANKcSEatd9J5pu0=;
        b=F2+7NypdxJotOnir50lVyyKPt/wZBFXQUJ8SiNusmESk0ZE3Mrpn0PDBGNiubyaAfg
         +hXkY2SeipzDpUuk3WbdfXCTG6pRLL3bUAFYEVSVSSa3I+5VBxn6tl9ahyykl53sUfXo
         P+3eQSCN2GcR7QY/fVPLjuG51cvXNKsTVXtHSN5CebYLxZLMFqhbndkMT5aOdE1zsBb2
         skWbT2vZlk1sEZjNbKfc5zhShHT2YzO+WRbSeWwKMgGVzCTzMOdqCSFm8SONi0Mj4yHi
         aioYXl5wB0x/4sb4TcanhdL3NsLkNNo+V5r++BdbShgGKwRsCG4ebK7kd5S64gVwFgKy
         oSbw==
X-Gm-Message-State: AO0yUKUmLr3V1//65064blc1aa/qIF315OG4zXOpVAMh+/mOf49ZDNhZ
        YKZvGyFql5UBtbd+UtzWb6E=
X-Google-Smtp-Source: AK7set8aAmovod5C/WRa2N89gO++wHcgfsHBLhXtEZghUaQ9Q9KHMEOhOHqwt8uMGI1eIgyk2hwoxA==
X-Received: by 2002:a2e:a543:0:b0:293:4ff3:7f85 with SMTP id e3-20020a2ea543000000b002934ff37f85mr2027898ljn.22.1676546441003;
        Thu, 16 Feb 2023 03:20:41 -0800 (PST)
Received: from alsp.securitycode.ru ([2a02:2168:8a04:5600:ecbf:de16:f87d:956])
        by smtp.googlemail.com with ESMTPSA id h13-20020a05651c124d00b0028f7e86f522sm155488ljh.96.2023.02.16.03.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 03:20:38 -0800 (PST)
From:   Alexander Sapozhnikov <alsp705@gmail.com>
To:     Hannes Reinecke <hare@suse.com>
Cc:     Alexandr Sapozhnikov <alsp705@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] [PATCH] NULL check in ahc_handle_scsiint()
Date:   Thu, 16 Feb 2023 14:20:34 +0300
Message-Id: <20230216112034.104-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandr Sapozhnikov <alsp705@gmail.com>

After having been compared to NULL value at aic7xxx_core.c:1569, 
pointer 'scb' is passed as 2nd parameter in call to function 
'ahc_qinfifo_requeue_tail' at aic7xxx_core.c:1864, :1876, :1890, 
where it is dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/scsi/aic7xxx/aic7xxx_core.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index a396f04..6840729 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -1819,13 +1819,15 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 			tag = SCB_LIST_NULL;
 			if (ahc_sent_msg(ahc, AHCMSG_1B, ABORT_TASK, TRUE)
 			 || ahc_sent_msg(ahc, AHCMSG_1B, ABORT_TASK_SET, TRUE)) {
-				if (ahc->msgout_buf[ahc->msgout_index - 1]
-				 == ABORT_TASK)
-					tag = scb->hscb->tag;
-				ahc_print_path(ahc, scb);
-				printk("SCB %d - Abort%s Completed.\n",
+				if (scb) {
+					if (ahc->msgout_buf[ahc->msgout_index - 1]
+					== ABORT_TASK)
+						tag = scb->hscb->tag;
+					ahc_print_path(ahc, scb);
+					printk("SCB %d - Abort%s Completed.\n",
 				       scb->hscb->tag, tag == SCB_LIST_NULL ?
 				       "" : " Tag");
+				}
 				ahc_abort_scbs(ahc, target, channel,
 					       saved_lun, tag,
 					       ROLE_INITIATOR,
@@ -1861,7 +1863,8 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 				tinfo->curr.transport_version = 2;
 				tinfo->goal.transport_version = 2;
 				tinfo->goal.ppr_options = 0;
-				ahc_qinfifo_requeue_tail(ahc, scb);
+				if (scb)
+					ahc_qinfifo_requeue_tail(ahc, scb);
 				printerror = 0;
 			} else if (ahc_sent_msg(ahc, AHCMSG_EXT,
 						EXTENDED_WDTR, FALSE)) {
@@ -1873,7 +1876,8 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 					      MSG_EXT_WDTR_BUS_8_BIT,
 					      AHC_TRANS_CUR|AHC_TRANS_GOAL,
 					      /*paused*/TRUE);
-				ahc_qinfifo_requeue_tail(ahc, scb);
+				if (scb)
+					ahc_qinfifo_requeue_tail(ahc, scb);
 				printerror = 0;
 			} else if (ahc_sent_msg(ahc, AHCMSG_EXT,
 						EXTENDED_SDTR, FALSE)) {
@@ -1887,7 +1891,8 @@ ahc_handle_scsiint(struct ahc_softc *ahc, u_int intstat)
 						/*ppr_options*/0,
 						AHC_TRANS_CUR|AHC_TRANS_GOAL,
 						/*paused*/TRUE);
-				ahc_qinfifo_requeue_tail(ahc, scb);
+				if (scb)
+					ahc_qinfifo_requeue_tail(ahc, scb);
 				printerror = 0;
 			}
 		}
-- 
2.5.3

