Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95F72D7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjFMDKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbjFMDJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:09:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4642110
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:07:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-651e298be3fso5458807b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686625616; x=1689217616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OeAqNdzPM4zuhihaPfn7sB9x1cVzXTGTHDzi2og3MQ=;
        b=nGlkrZ/33SxVRpJOvfIIqm7wpqLmP6Mnf5EwsbDbxN8lfSATOlAtU4xvfj5ZotoYpg
         ZJ9uiJ1P8OllGT27Jh95GjTNouOD73j29jkt7LB9jMrIAwKtnXmGS4WWn3ztj+554E1l
         XwtsEqIQxMbzGcoVY1gV+VchCzL9uafnGiwKlyfCdFhiAMoO9903q3mHtvlrK0NdoSHt
         dDwGYkuWdM5WcI8g7dCX3ShkS8sG/GV6jInATV6TOOUSxPU9kgF4qFh1/yKrtLNVO2Lk
         ynaddUFFHstMU0xoxqFGQkLMYCxfncOIEvJnUBza1OvlMdJpUbnG3a2S+bNPttbVnY1e
         Eghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686625616; x=1689217616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OeAqNdzPM4zuhihaPfn7sB9x1cVzXTGTHDzi2og3MQ=;
        b=TQjcmK51ZLXk+gNUDnTtu2eEUEbHALQdWfAtVCYnG99bhAfxwW5eQkQr8bOrQCsRUg
         ETSygStmEKvddncw24WHIsdWZ86iNwRqauaY+GO7HQP1HYrIwndONdLdwQkU2xWgYH4/
         jSkOfl/jdYgP/KJ9gPl1ez+X2hsjjTq9AA3btw1YlgsWvkd/wDncTVkYqn+zyU5uxY6W
         eXxsPVsbK9H5u12ZGW+C5hpxwyaOpowq0RBNiBcYPX6cJkkXrZJvpOKMs7RrYI3nsVAu
         cRItEURelZOHwQHXO1/7hGNrDMcstWvHjYQwtgrw6SLm7uAZrhU7fQUDM+0gem+Wa17L
         n7Qw==
X-Gm-Message-State: AC+VfDyHBafyF7+7pk56JafdYe5A1oUl7wp/psWkd3HpVwRLDfSA2SfE
        5St3oPgMflV7vPlL6C5gs0lzL/7H/DtD+w==
X-Google-Smtp-Source: ACHHUZ6K2RVfBHF4XbKXgWLqSIs5w4D5IUjF+1h+c2TaEnJRO7T1ZcZB3Xqwt2q3ImQevqOktJU/Xw==
X-Received: by 2002:a05:6a00:1a11:b0:643:59cd:6cad with SMTP id g17-20020a056a001a1100b0064359cd6cadmr13916138pfv.24.1686625616038;
        Mon, 12 Jun 2023 20:06:56 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.112])
        by smtp.gmail.com with ESMTPSA id x12-20020a62fb0c000000b0063b675f01a5sm7807191pfm.11.2023.06.12.20.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 20:06:55 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] gfs2: Fix possible data races in gfs2_show_options()
Date:   Tue, 13 Jun 2023 11:06:37 +0800
Message-Id: <20230613030637.2934730-1-islituo@gmail.com>
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

Some fields such as gt_logd_secs of the struct gfs2_tune are accessed 
without holding the lock gt_spin in gfs2_show_options():

  val = sdp->sd_tune.gt_logd_secs;
  if (val != 30)
    seq_printf(s, ",commit=%d", val);

And thus can cause data races when gfs2_show_options() and other functions
such as gfs2_reconfigure() are concurrently executed:

  spin_lock(&gt->gt_spin);
  gt->gt_logd_secs = newargs->ar_commit;

To fix these possible data races, the lock sdp->sd_tune.gt_spin is 
acquired before accessing the fields of gfs2_tune and released after these
accesses.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a84bf6444bba..671adf38fe03 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1059,6 +1059,7 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	}
 	if (args->ar_discard)
 		seq_puts(s, ",discard");
+	spin_lock(&sdp->sd_tune.gt_spin);
 	val = sdp->sd_tune.gt_logd_secs;
 	if (val != 30)
 		seq_printf(s, ",commit=%d", val);
@@ -1070,6 +1071,7 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	val = sdp->sd_tune.gt_quota_quantum;
 	if (val != 60)
 		seq_printf(s, ",quota_quantum=%d", val);
+	spin_unlock(&sdp->sd_tune.gt_spin);
 	if (args->ar_statfs_percent)
 		seq_printf(s, ",statfs_percent=%d", args->ar_statfs_percent);
 	if (args->ar_errors != GFS2_ERRORS_DEFAULT) {
-- 
2.34.1

