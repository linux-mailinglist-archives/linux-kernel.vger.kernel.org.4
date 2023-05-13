Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91347701ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjEMXYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 19:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjEMXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:24:43 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE62705;
        Sat, 13 May 2023 16:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1684020274;
        bh=CHEQ/YBaCbARXpS/TDfKCrfT8E2waxS1oKfjBt76EYY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=LAQ64O6M3yLJXUitiXEcLQn6vSNtQ8jlB0y9kgnXB80DQAQeaFwxVi/fipXLNvq5Q
         36t9iwVmoKx1SCPunJV8rabwJ0MIiAd4Cz4Uq60na1VME0u4D6Q6IYW5g/krRyPr25
         MWeWBWjJK6eufGZyLRcdHrkMQmRQn2i3YZ3BLX7I=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3DA441287A4F;
        Sat, 13 May 2023 19:24:34 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Pwx2-8NFW_C6; Sat, 13 May 2023 19:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1684020268;
        bh=CHEQ/YBaCbARXpS/TDfKCrfT8E2waxS1oKfjBt76EYY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=BCj4xvN+DITc/lcqO15/TZ21+5XoYz2RbsPX4FYGM/+XnR6fZ5lknhY2c7W/ewhmu
         s8UNOPcv2myYCTrhpKPsf0azQJZzWmBkV0nuoqcCaT8VR4f33XUecnhh43rbSCJ1o2
         krFiMc4VZBlOT+jooXnkWrycgvHz2PpjJlgwg5U8=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ED1A3128799E;
        Sat, 13 May 2023 19:24:27 -0400 (EDT)
Message-ID: <8742c73168b7be3fb8dd841e57656bcbc4fa2e06.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.4-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 13 May 2023 19:24:24 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single small fix for the UFS driver to fix a power management failure.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Keoseong Park (1):
      scsi: ufs: core: Fix I/O hang that occurs when BKOPS fails in W-LUN suspend

And the diffstat:

 drivers/ufs/core/ufshcd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 17d7bb875fee..45fd374fe56c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9459,8 +9459,16 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 			 * that performance might be impacted.
 			 */
 			ret = ufshcd_urgent_bkops(hba);
-			if (ret)
+			if (ret) {
+				/*
+				 * If return err in suspend flow, IO will hang.
+				 * Trigger error handler and break suspend for
+				 * error recovery.
+				 */
+				ufshcd_force_error_recovery(hba);
+				ret = -EBUSY;
 				goto enable_scaling;
+			}
 		} else {
 			/* make sure that auto bkops is disabled */
 			ufshcd_disable_auto_bkops(hba);

