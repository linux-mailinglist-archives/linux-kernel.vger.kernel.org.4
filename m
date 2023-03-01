Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA76A7777
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCAXCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAXCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:02:53 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A43AD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:02:51 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id o15so57973608edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 15:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XJP053NiZ4KnJ6Pi3NUYoPOODRnV+q3TPUtWMOWJYI=;
        b=V55FsJkTncVZ6bts8JuBPHQ30bHCP6ps7yXO0v74Sy/pquFqpcsp2im6BaEKLEQflA
         /4f8C+keg1WzUc5F+u60u2dlVGVPn3cePWgen5BOChFhBxi9yz+BDYHNx/bvXy1CsgT2
         7DzCXs3jAiHAAv285clgdM8Rf12dQyQ2o1XZZ/MzaDYnBGtXNG8LuM0cAS9fkz2ipPYW
         zs22Qb4MKfA9y4i69ww/deAjWcXTu02x47hQYYacw0Hkk/EDL8PpXvdWy1g7owWOgeg0
         xDHmukWE25rXFNT1Ah4dWiEI/+xPxc0hU+dPwxzj8Q51J3WhHPyUpM/19lOyhKYuxbUf
         PMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XJP053NiZ4KnJ6Pi3NUYoPOODRnV+q3TPUtWMOWJYI=;
        b=166GfAw78r8etKuIJFZU4+aFCYfhJKPY7xUEUGCdh6pO/LapHp2Pr6Uw+XxdMuu8Al
         nw5cOu2E8CFULPT/hHU5YB0/S5hh+06HRlZXbOLQy3Bj/b6V5yQ7gE6HqNImQX+ySWHw
         pCb/6tXwRR4mMsT6GamNcfDA2xQ51ejHgsgc87lFwTh/th0iTs+XTj0rW6DYuRWZhJib
         1LssC5IrNVrqIJNieewVOL9h/jlaqXHC94ugLKkGQl2/Qr7b1uKukqep6tLnVtDcLGHY
         OsTw8JcBNWZ2Dxqev0nuTwPdfd+DJpYEfqdCa5K+0S8rzH0wCMOdcvtfVwI1msph7eHt
         +qlg==
X-Gm-Message-State: AO0yUKWFnoJzzFlhqcuCg8ybLJdcCei8sZnVf4BcS0EaWG82XTQe7+NJ
        gL86aCc47wN/NBMVsnHBwWU=
X-Google-Smtp-Source: AK7set8Hd8jexKxakClAOkq73hKu6G5eQHBov3QuTxgt4E3mXXwhRCvR1Vm8Pkt0PXhcFeArYPd/Yg==
X-Received: by 2002:a17:906:9601:b0:8dd:76d5:a82 with SMTP id s1-20020a170906960100b008dd76d50a82mr8460613ejx.47.1677711769885;
        Wed, 01 Mar 2023 15:02:49 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id lc8-20020a170906f90800b008d57e796dcbsm6287488ejb.25.2023.03.01.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 15:02:49 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Thu, 02 Mar 2023 00:02:46 +0100
Subject: [PATCH] fs/jfs: avoid usage of list iterator after loop in
 lmPostGC()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-fs-jfs-avoid-iter-after-loop-v1-1-1742e06efc62@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJXZ/2MC/x2NwQqDMBBEf0X23IUkWir9ldLDqpu6pU1kV6Qg/
 nsTDzMwzPBmB2MVNrg3OyhvYpJTCf7SwDhTejHKVDIEF1rXOo/R8F1EW5YJZWVFitU/OS/YB/I
 37wJfux4KYiBjHJTSOFfIl6xMa7EoR/mdv4/ncfwBstItCYcAAAA=
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677711769; l=4595;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=7Wlg05+jupBpzbW2jRTCioY6miUDosmbF/uQR63a0hY=;
 b=QT3xJNEi/L2lmdViF8a4/BimZ2JfTg4BEvJ4Uk8GwpINiQDi6MMVFF8MddBJKB1nfLt2VmBOcTMu
 dUeu7D9QA37ewpxOKGJMVJCBFF0+8/PIJiUoT2AF+19wcTLdVecD
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the list_for_each_entry_safe() iteration never breaks, 'tblk' would
contain an invalid pointer past the iterator loop. To ensure 'tblk' is
always valid, we only set it if the correct element was found. That
allows adding a BUG_ON in case the code works incorrectly, exposing
currently undetectable potential bugs.

Additionally, Linus proposed to avoid any use of the list iterator
variable after the loop, in the attempt to move the list iterator
variable declaration into the marcro to avoid any potential misuse after
the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
I've found this code path looking at the output of the
use_after_iter.cocci script. From an outsider perspective it's difficult
for me to judge if the condition '!(tblk->flag & tblkGC_COMMIT)' is
guaranteed to be true for at least one entry in the list.

If not then the access 'tblk->bp->l_wqnext' in line 887 will not work
with a valid 'tblk' entry.

For now I've replaced the iterator variable with 'iter' and only set the
'tblk' (used after the iteration), in the break case where it is
guaranteed to be correct.

I'm happy to get some input on this and open for any suggestion.
---
 fs/jfs/jfs_logmgr.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 695415cbfe98..e3ca0bb6dbd5 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -804,7 +804,7 @@ static void lmPostGC(struct lbuf * bp)
 	unsigned long flags;
 	struct jfs_log *log = bp->l_log;
 	struct logpage *lp;
-	struct tblock *tblk, *temp;
+	struct tblock *tblk = NULL, *iter, *temp;
 
 	//LOGGC_LOCK(log);
 	spin_lock_irqsave(&log->gclock, flags);
@@ -814,54 +814,56 @@ static void lmPostGC(struct lbuf * bp)
 	 * remove/wakeup transactions from commit queue who were
 	 * group committed with the current log page
 	 */
-	list_for_each_entry_safe(tblk, temp, &log->cqueue, cqueue) {
-		if (!(tblk->flag & tblkGC_COMMIT))
+	list_for_each_entry_safe(iter, temp, &log->cqueue, cqueue) {
+		if (!(iter->flag & tblkGC_COMMIT)) {
+			tblk = iter;
 			break;
+		}
 		/* if transaction was marked GC_COMMIT then
 		 * it has been shipped in the current pageout
 		 * and made it to disk - it is committed.
 		 */
 
 		if (bp->l_flag & lbmERROR)
-			tblk->flag |= tblkGC_ERROR;
+			iter->flag |= tblkGC_ERROR;
 
 		/* remove it from the commit queue */
-		list_del(&tblk->cqueue);
-		tblk->flag &= ~tblkGC_QUEUE;
+		list_del(&iter->cqueue);
+		iter->flag &= ~tblkGC_QUEUE;
 
-		if (tblk == log->flush_tblk) {
+		if (iter == log->flush_tblk) {
 			/* we can stop flushing the log now */
 			clear_bit(log_FLUSH, &log->flag);
 			log->flush_tblk = NULL;
 		}
 
-		jfs_info("lmPostGC: tblk = 0x%p, flag = 0x%x", tblk,
-			 tblk->flag);
+		jfs_info("lmPostGC: tblk = 0x%p, flag = 0x%x", iter,
+			 iter->flag);
 
-		if (!(tblk->xflag & COMMIT_FORCE))
+		if (!(iter->xflag & COMMIT_FORCE))
 			/*
-			 * Hand tblk over to lazy commit thread
+			 * Hand iter over to lazy commit thread
 			 */
-			txLazyUnlock(tblk);
+			txLazyUnlock(iter);
 		else {
 			/* state transition: COMMIT -> COMMITTED */
-			tblk->flag |= tblkGC_COMMITTED;
+			iter->flag |= tblkGC_COMMITTED;
 
-			if (tblk->flag & tblkGC_READY)
+			if (iter->flag & tblkGC_READY)
 				log->gcrtc--;
 
-			LOGGC_WAKEUP(tblk);
+			LOGGC_WAKEUP(iter);
 		}
 
 		/* was page full before pageout ?
 		 * (and this is the last tblk bound with the page)
 		 */
-		if (tblk->flag & tblkGC_FREE)
+		if (iter->flag & tblkGC_FREE)
 			lbmFree(bp);
 		/* did page become full after pageout ?
 		 * (and this is the last tblk bound with the page)
 		 */
-		else if (tblk->flag & tblkGC_EOP) {
+		else if (iter->flag & tblkGC_EOP) {
 			/* finalize the page */
 			lp = (struct logpage *) bp->l_ldata;
 			bp->l_ceor = bp->l_eor;
@@ -880,6 +882,7 @@ static void lmPostGC(struct lbuf * bp)
 	 * select the latest ready transaction as new group leader and
 	 * wake her up to lead her group.
 	 */
+	BUG_ON(!tblk);
 	if ((!list_empty(&log->cqueue)) &&
 	    ((log->gcrtc > 0) || (tblk->bp->l_wqnext != NULL) ||
 	     test_bit(log_FLUSH, &log->flag) || jfs_tlocks_low))

---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230301-fs-jfs-avoid-iter-after-loop-82a17102e548

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

