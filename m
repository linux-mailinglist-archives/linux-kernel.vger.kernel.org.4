Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33FA5B56FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiILJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiILJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:13:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1A19029
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:13:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dv25so18576557ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=wqRYf4bK8HxWj4cxt1yNwL6L5/oKp/VpFBzV0pFAgGQ=;
        b=M4tWRBBBPLCYaai3uLuiAgw+/v2PaOHwbUi/Bulymrut37fFCMSA7XUyUjcOS/mi9m
         BGlNekLLEl9byZcSgEkklPka5784hs7XP+o8aOeFw4+SLwul0s5QHxjfpHXtgrUwoO2v
         tpHs8VtIs/mzwpCFxI14DvhWsMMmsqvrtFnpXPV8pV6XIX7Xf5E8PLMvULGRL7kbIoPT
         xlkG29RLOc8lrv3VoLfswT7S4nwrw/CkQA/rRHLAPvXsk1d3KTtk/mXRramhmGT9yyAn
         lb1vZshaiphPIEt76DpW9gTiAY5euG4KmXtZMn89DjhrKSbZ59qiZcuR1+GmZBRkM5Ki
         Wvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wqRYf4bK8HxWj4cxt1yNwL6L5/oKp/VpFBzV0pFAgGQ=;
        b=sXCXA6TwnijOI35r2rmYH911J8b7yc6xU+1UEQbK9Wb2kzrVig8coGJY8YmHczwFlp
         VTCi4c7/RNQip7+i2PToAqU6gYsJ8f7IDwAMvcnUM7C7OXVNcgnPplvm3rqtByBnbsKI
         o725KUusF5OGKdv19e2JqUFrM+s1BuXV+QeiiEBRTV5jH20XsDz6EjCM7D2TqcdL4+m1
         EZZPbToykackdvtRsXa4WpDMPy8ItK7LtB+cpyLFKET121pevFz/CDdxTf76Q+cL99aL
         90TD7H8dl75Y4IC+hlBbaKGo9hu9rnZstNZ8wUmwoEc6Tj8f7wH3kT1hYppQ9uCbIPdc
         XUfQ==
X-Gm-Message-State: ACgBeo2JWXtBgUQC+W+PGlOTj3wqHX7oIH+xoC2Jd2pzeuC7m2af+DpR
        yA/F9kElb8FKIdQClnaojob+cUnhMZk=
X-Google-Smtp-Source: AA6agR6pXVidZNH5wFFW0qKrPs8VY015BB7XMUgPJhOW3SS5DDjfJGmLpK79iSbnCl5zIjFHDFMmCQ==
X-Received: by 2002:a17:907:7e90:b0:77d:fecf:c243 with SMTP id qb16-20020a1709077e9000b0077dfecfc243mr2032412ejc.361.1662973987406;
        Mon, 12 Sep 2022 02:13:07 -0700 (PDT)
Received: from nlaptop.wireless.UGent.be (nata195.ugent.be. [157.193.240.195])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056402530600b004478be33bddsm5329689edb.15.2022.09.12.02.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 02:13:07 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     cluster-devel@redhat.com
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] gfs2: acquire sd_log_flush_lock in gfs2_trans_remove_revoke
Date:   Mon, 12 Sep 2022 11:13:05 +0200
Message-Id: <20220912091305.107797-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.37.3
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

gfs2_log_release_revokes states in its function documentation that
sdp->sd_log_flush_lock must be held. The operations on
sd_log_revokes_available are always protected under that lock. All
callers except gfs2_trans_remove_revoke hold the lock.
Acquire that lock in gfs2_trans_remove_revoke. The other callsites use a
read lock as well.

This bug was found using my experimental own-developed static analysis
tool, which reported the missing lock on v6.0-rc5. I manually verified
this bug report by doing code review as well. I compile tested and
runtime checked that the required lock is not held on a x86-64 config.
After applying this patch, my analyser no longer reports this
potential bug.

Fixes: 2129b4288852 ("gfs2: Per-revoke accounting in transactions")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 fs/gfs2/trans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 63fec11ef2ce..468e4da20a44 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -301,6 +301,7 @@ void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len)
 	struct gfs2_bufdata *bd, *tmp;
 	unsigned int n = len;
 
+	down_read(&sdp->sd_log_flush_lock);
 	gfs2_log_lock(sdp);
 	list_for_each_entry_safe(bd, tmp, &sdp->sd_log_revokes, bd_list) {
 		if ((bd->bd_blkno >= blkno) && (bd->bd_blkno < (blkno + len))) {
@@ -316,6 +317,7 @@ void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len)
 		}
 	}
 	gfs2_log_unlock(sdp);
+	up_read(&sdp->sd_log_flush_lock);
 }
 
 void gfs2_trans_free(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
-- 
2.37.3

