Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574971F6B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjFAXkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjFAXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FEE136;
        Thu,  1 Jun 2023 16:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6EE646B3;
        Thu,  1 Jun 2023 23:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA09C433EF;
        Thu,  1 Jun 2023 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685662789;
        bh=3jR6coTEIcQtDZcNzSMSFv+M4QM62RvBoRRP0rTVqDY=;
        h=Date:From:To:Cc:Subject:From;
        b=fwc7Tv0DaRLNwBp0LIrrU8Ot+TZ8GxkknFOtF7HdZbG2BM2+QkEHGkrNQAhjeqfKC
         95COu5tIu/DBAA9fFFzhQzVZG0gZBic5SJzHbJJIGGUGSyuDRZQfJgSRWRjOjahJtL
         v5QQVcdPfunXzlsLY0XhxNr9yg0W2SMHZO6Me3den1nsWJWcablV46r1Wh+rSqhM+3
         8OT+OgEPDdJf+Dy37ih6KM1QJ75q7NnSQj42MVexWoBqIWxH48DlgR1d5Q/IEw6Q0R
         MhBTJXdyGFnICpULkSxMc/POPCMFpRJJCCMErrRmjGRxyZN2/B3A8B6qNtral0teVk
         s7p9MKckvfIVw==
Date:   Thu, 1 Jun 2023 17:40:41 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] scsi: lpfc: Avoid -Wstringop-overflow warning
Message-ID: <ZHkseX6TiFahvxJA@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent any potential integer wrapping issue, and avoid a
-Wstringop-overflow warning by using the check_mul_overflow() helper.

drivers/scsi/lpfc/lpfc.h:
837:#define LPFC_RAS_MIN_BUFF_POST_SIZE (256 * 1024)

drivers/scsi/lpfc/lpfc_debugfs.c:
2266 size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;

this can wrap to negative if cfg_ras_fwlog_buffsize is large
enough. And even when in practice this is not possible (due to
phba->cfg_ras_fwlog_buffsize never being larger than 4[1]), the
compiler is legitimately warning us about potentially buggy code.

Fix the following warning seen under GCC-13:
In function ‘lpfc_debugfs_ras_log_data’,
    inlined from ‘lpfc_debugfs_ras_log_open’ at drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: ‘memcpy’ specified bound between 18446744071562067968 and 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
 2210 |                         memcpy(buffer + copied, dmabuf->virt,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2211 |                                size - copied - 1);
      |                                ~~~~~~~~~~~~~~~~~~

Link: https://github.com/KSPP/linux/issues/305
Link: https://lore.kernel.org/linux-hardening/CABPRKS8zyzrbsWt4B5fp7kMowAZFiMLKg5kW26uELpg1cDKY3A@mail.gmail.com/ [1]
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use check_mul_overflow() helper (Kees).

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZHZq7AV9Q2WG1xRB@work/

 drivers/scsi/lpfc/lpfc_debugfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index bdf34af4ef36..7f9b221e7c34 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -2259,11 +2259,15 @@ lpfc_debugfs_ras_log_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	spin_unlock_irq(&phba->hbalock);
-	debug = kmalloc(sizeof(*debug), GFP_KERNEL);
+
+	if (check_mul_overflow(LPFC_RAS_MIN_BUFF_POST_SIZE,
+			       phba->cfg_ras_fwlog_buffsize, &size))
+		goto out;
+
+	debug = kzalloc(sizeof(*debug), GFP_KERNEL);
 	if (!debug)
 		goto out;
 
-	size = LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;
 	debug->buffer = vmalloc(size);
 	if (!debug->buffer)
 		goto free_debug;
-- 
2.34.1

