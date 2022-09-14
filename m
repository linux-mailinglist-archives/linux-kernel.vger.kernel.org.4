Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C645B7F18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiINCtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINCtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:49:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE57765C;
        Tue, 13 Sep 2022 19:49:37 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so9409948oth.8;
        Tue, 13 Sep 2022 19:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XvoxIxNm6r324uzuQRoEB36eGqnqA+beuzCfqCOhNpc=;
        b=PMzYJcMM2PfeR12kcaegVo8a6pPn1FLQLdqtNRUjiHaGmKxqunE35dLvd62mWvPhjd
         KQgRUmFWjMclHiviBV7JD1tWqFFnLmGARbgfoqeKM5oS3E01hWNnG7MS37GtyBi88nfV
         hBBHxZPzeLKXvpdaZ0+JJPH44zaN38W0dCdY5QCYPK7byLfT+i5/uOPim3SRyCWTyEwI
         IeWdhVcN51cQpCIeedYXWWMfNhqX/rsOqXlD/RWlK8LsRPQ1oc4N6Qp7iVj/KrLFC0IG
         Zx0lWYfV9GGL5gwoI13Bf7FuMtdKbCUHz3QO58PjDQ/1pE53hcUES6omTeEsRikkHlkX
         14hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XvoxIxNm6r324uzuQRoEB36eGqnqA+beuzCfqCOhNpc=;
        b=DU+T+42o+ipbJRmNnQtXbEsmoS5iIeAVDgqxewZG2xMG9tv2nzUac+vbsG/xBSaiyK
         Y72Ds2CqZXy6Z+5GoDp4cBc8VxP+Yq5cVV/YiIr4gbQXu9oJEdk7aUu4Jz8XTp/XXQsa
         zL7ctxMXuuxCgDQJ1lq49D5LpLx90mb9Kp5d3hGvYQ2Vtv7kkKgtcoLH8sNv/B/uOnR+
         KByH9uqkru/5gW5rp82/25cI7CVXHlOKQ7igJrhLE/YfwYSAsxUPlvEiF3SpLjh7zqhw
         NJMdRajUqXW2TUWxKUUGFKOZ0HmQuu3Pd1Ov6JAz0n0jpE6aXSzFOGxxrkqKWRTWrGo+
         xjmw==
X-Gm-Message-State: ACgBeo0GyYJwP40qe7KJCvKoOu94Siob9iPWirp/10TZdP0LkD+3ddGE
        rgn0LUIwJv0qoK+xzj9dBIY=
X-Google-Smtp-Source: AA6agR7OyArx7cQ4MzbTReUrMVx+Jvh3sz9oHw/PoQaazd26ES6H/Ceg+IUAkd4oc76UwgiiGv8a5A==
X-Received: by 2002:a9d:400c:0:b0:656:4c5:ad86 with SMTP id m12-20020a9d400c000000b0065604c5ad86mr3456557ote.134.1663123776499;
        Tue, 13 Sep 2022 19:49:36 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:94e2:ccf7:1a63:3c59])
        by smtp.gmail.com with ESMTPSA id x14-20020a54400e000000b003436fa2c23bsm5794407oie.7.2022.09.13.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 19:49:36 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()
Date:   Tue, 13 Sep 2022 23:49:24 -0300
Message-Id: <20220914024924.695604-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8f394da36a36 ("scsi: qla2xxx: Drop TARGET_SCF_LOOKUP_LUN_FROM_TAG")
made the __qlt_24xx_handle_abts() function return early if
tcm_qla2xxx_find_cmd_by_tag() doesn't find a command, but it missed to
clean up the allocated memory for the management command in such a case.

Fixes: 8f394da36a36 ("scsi: qla2xxx: Drop TARGET_SCF_LOOKUP_LUN_FROM_TAG")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 62666df1a59e..4acff4e84b90 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -2151,8 +2151,10 @@ static int __qlt_24xx_handle_abts(struct scsi_qla_host *vha,
 
 	abort_cmd = ha->tgt.tgt_ops->find_cmd_by_tag(sess,
 				le32_to_cpu(abts->exchange_addr_to_abort));
-	if (!abort_cmd)
+	if (!abort_cmd) {
+		mempool_free(mcmd, qla_tgt_mgmt_cmd_mempool);
 		return -EIO;
+	}
 	mcmd->unpacked_lun = abort_cmd->se_cmd.orig_fe_lun;
 
 	if (abort_cmd->qpair) {
-- 
2.34.1

