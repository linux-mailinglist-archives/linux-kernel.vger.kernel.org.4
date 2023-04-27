Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306266EFED3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbjD0BPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbjD0BPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:15:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B81240C7;
        Wed, 26 Apr 2023 18:15:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a6670671e3so65766395ad.0;
        Wed, 26 Apr 2023 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682558131; x=1685150131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrhaHXbwFsAd0/GaXjow7H0L4+tY0cPhGmnifdoJQXg=;
        b=UHPmzD/Jv7A/n5d3rtYTtbcJMUMUlwDvrekWM3+ffCgmlYi440mf723O21x1cz+6bJ
         LMpmg4Nq7ivKgB6odqiW+Rp+s+PQy9DVqNpI0Lq4EHtDlgsyL2HGRyDH6GiF8Cd1xFSQ
         DuwwoJSBJz9pzwZFv1Oc7IR34uUZqEvT/WD1Y0UErcaAFXc9ojvtvOuxExoxJeB61UIt
         ySp5r5U2/F26BAQLK1xavfLN23IoEepEuXqxeuMNKXRVWjR2KhKAHmNnqfaJ76dCTCL+
         10qSEQmxSsvPC7T7dx1ddWXHR/vwVS5Hr++krWyiyDC33myHP+pGCcg/5IDZtzglHt14
         UXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682558131; x=1685150131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrhaHXbwFsAd0/GaXjow7H0L4+tY0cPhGmnifdoJQXg=;
        b=TLR60Pau3kElH+gEejiEA490FgFanIroBlOND1u1/CIe6sWRMMlc8vcURogzvgMPv+
         UaSq71WAJDvUt+8RC/TofVHwVDXzIWaOkomp20U9Hk2OXuQS1g2MZPuXeeMMmwXIznKe
         lPD//Cez/Rbcuhtw38CtU50NakgXSazB7LqvXxePZlu3buImIelCI/FLo4iBJmr+xK1+
         KjOEhbr3tZtoICopVRM0h4gwiW3h5GVjNOj/rLQ3982YVSNpbmr4NQ3i1eSmDBzRD/Zx
         f+WFozp1IWE925wXhvQSrFCZ7Or/Sx2Dv//RsGCCQ+X8Anjwi+1IpCQXrTlAlRhi68Cs
         RpXA==
X-Gm-Message-State: AAQBX9dT9eqkNPJz/jqQ/W2hXk9zhEbxNyNwU8aC2f+zVYYbAElfLxZA
        uvK/jDz4//aZU90hjK3Xyyo=
X-Google-Smtp-Source: AKy350YJnnwJ8AMq3qjbVGA9UWBD9MF61jok94+AcmNwDHcptxZnjHGng4hbZENAppFJ5LaJe1PNFQ==
X-Received: by 2002:a17:902:c411:b0:19b:dbf7:f9ca with SMTP id k17-20020a170902c41100b0019bdbf7f9camr27202077plk.0.1682558131253;
        Wed, 26 Apr 2023 18:15:31 -0700 (PDT)
Received: from carrot.. (i223-217-187-146.s42.a014.ap.plala.or.jp. [223.217.187.146])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b0019f3cc463absm10565352plt.0.2023.04.26.18.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 18:15:30 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: do not write dirty data after degenerating to read-only
Date:   Thu, 27 Apr 2023 10:15:26 +0900
Message-Id: <20230427011526.13457-1-konishi.ryusuke@gmail.com>
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

According to syzbot's report, mark_buffer_dirty() called from
nilfs_segctor_do_construct() outputs a warning with some patterns after
nilfs2 detects metadata corruption and degrades to read-only mode.

After such read-only degeneration, page cache data may be cleared
through nilfs_clear_dirty_page() which may also clear the uptodate
flag for their buffer heads.  However, even after the degeneration,
log writes are still performed by unmount processing etc., which
causes mark_buffer_dirty() to be called for buffer heads without the
"uptodate" flag and causes the warning.

Since any writes should not be done to a read-only file system in the
first place, this fixes the warning in mark_buffer_dirty() by letting
nilfs_segctor_do_construct() abort early if in read-only mode.

This also changes the retry check of nilfs_segctor_write_out() to
avoid unnecessary log write retries if it detects -EROFS that
nilfs_segctor_do_construct() returned.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=2af3bc9585be7f23f290
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
---
 fs/nilfs2/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 228659612c0d..ac949fd7603f 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2041,6 +2041,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int err;
 
+	if (sb_rdonly(sci->sc_super))
+		return -EROFS;
+
 	nilfs_sc_cstage_set(sci, NILFS_ST_INIT);
 	sci->sc_cno = nilfs->ns_cno;
 
@@ -2724,7 +2727,7 @@ static void nilfs_segctor_write_out(struct nilfs_sc_info *sci)
 
 		flush_work(&sci->sc_iput_work);
 
-	} while (ret && retrycount-- > 0);
+	} while (ret && ret != -EROFS && retrycount-- > 0);
 }
 
 /**
-- 
2.34.1

