Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D285EF580
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiI2Mdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiI2Mdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:33:37 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF91559FE;
        Thu, 29 Sep 2022 05:33:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 129so1327015pgc.5;
        Thu, 29 Sep 2022 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2J8dEhSi4LoVFaaTjvQBUI0DFYA9A2JG/Zfec+eIbxg=;
        b=bKErUGltahBAoxoud23nWtqed2bGUwNz4MKypA7BMv/noAxOXYQQeV6vkmMSwI5TDW
         XYCs64b6Swl4ARcHgtCb38nZ8e6UGSpwfqZCsaV40h9MWaFVJ6CT/sFSGtbri2ry2oOC
         Qschv+0chd6XnFFtyqCVlS/wfllaKWp72zAmD8/O8pf4HnDRCsOAQg4Px7ZKsusZ9ObE
         wVvvLXFrIY2WyrnOomyXmYynnqOfyjaNlamIstOdvju5NA8QbAkcm59znDusT6JJfNkE
         xuQzYRFnvfp846BkJ/jOXSWiRfwEi1PrF/4bzA1vqjdzz9brvAywLKMXVeGoHKjTXDU+
         X+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2J8dEhSi4LoVFaaTjvQBUI0DFYA9A2JG/Zfec+eIbxg=;
        b=EjJteMPq02S2jLPxpY3a0hKSpIIOG0tqTJS0VJt7G0NKtTvV6VYX59kWBFSZNKHTUx
         mt6AZPO3S6rSM0gOLl50huIZjYLKhvKeNmC2ZeSSoFCaCgDMWzcUZ7OavKZdKgXbB4Aw
         4lK4UuorHUi8eZCLp5y07bdgN2RP0n0Kh7HnQS0DxGhcd/uJJ8jHVvo1xe+I2Id6QymD
         9jdUgwsQh0d0XF4lJWa67InBo9RfyodV+d4n7F10HhOrQYqUic1N19hqBEdHQJPHf1zj
         6FCa2qIZBu3tGrtXvc2FRyNfIklNTCwMJhK/5fwTQEjjkxshwHF2hnGOyo1QgAmuAY7g
         4d2w==
X-Gm-Message-State: ACrzQf1NMPSDtCvmAm9oC69tAw+54fbqb+ZYPTkVDuvfIH0S+iIuHzWc
        WnlINLNwknv7NOGcaurK41g=
X-Google-Smtp-Source: AMsMyM60fgcYUZ0WrPTTMg47tOKxMCuIKBctyiey7w2yfVg1R8EtNSdpJdb17T4x33liy1BRT8GDaw==
X-Received: by 2002:a65:5a4b:0:b0:43c:c168:b00b with SMTP id z11-20020a655a4b000000b0043cc168b00bmr2748383pgs.357.1664454815370;
        Thu, 29 Sep 2022 05:33:35 -0700 (PDT)
Received: from carrot.. (i220-109-170-101.s42.a014.ap.plala.or.jp. [220.109.170.101])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b00172cb8b97a8sm5873884plh.5.2022.09.29.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:33:34 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+fbb3e0b24e8dae5a16ee@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: replace WARN_ONs by nilfs_error for checkpoint acquisition failure
Date:   Thu, 29 Sep 2022 21:33:30 +0900
Message-Id: <20220929123330.19658-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000001a6b6705e9b3533d@google.com>
References: <0000000000001a6b6705e9b3533d@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If creation or finalization of a checkpoint fails due to anomalies
in the checkpoint metadata on disk, a kernel warning is generated.

This patch replaces the WARN_ONs by nilfs_error, so that a kernel,
booted with panic_on_warn, does not panic.  A nilfs_error is
appropriate here to handle the abnormal filesystem condition.

This also replaces the detected error codes with an I/O error so that
neither of the internal error codes is returned to callers.

Reported-by: syzbot+fbb3e0b24e8dae5a16ee@syzkaller.appspotmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 0afe0832c754..25c56ea779ea 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -875,9 +875,11 @@ static int nilfs_segctor_create_checkpoint(struct nilfs_sc_info *sci)
 		nilfs_mdt_mark_dirty(nilfs->ns_cpfile);
 		nilfs_cpfile_put_checkpoint(
 			nilfs->ns_cpfile, nilfs->ns_cno, bh_cp);
-	} else
-		WARN_ON(err == -EINVAL || err == -ENOENT);
-
+	} else if (err == -EINVAL || err == -ENOENT) {
+		nilfs_error(sci->sc_super,
+			    "checkpoint creation failed due to metadata corruption.");
+		err = -EIO;
+	}
 	return err;
 }
 
@@ -891,7 +893,11 @@ static int nilfs_segctor_fill_in_checkpoint(struct nilfs_sc_info *sci)
 	err = nilfs_cpfile_get_checkpoint(nilfs->ns_cpfile, nilfs->ns_cno, 0,
 					  &raw_cp, &bh_cp);
 	if (unlikely(err)) {
-		WARN_ON(err == -EINVAL || err == -ENOENT);
+		if (err == -EINVAL || err == -ENOENT) {
+			nilfs_error(sci->sc_super,
+				    "checkpoint finalization failed due to metadata corruption.");
+			err = -EIO;
+		}
 		goto failed_ibh;
 	}
 	raw_cp->cp_snapshot_list.ssl_next = 0;
-- 
2.34.1

