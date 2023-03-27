Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C16CA6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjC0N6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjC0N6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:58:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722240C6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:58:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z19so8534939plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679925511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1Gx6hpiQ6E/pjxy2KWHAjzK7MQQtrVJ/I63KQY+/Xk=;
        b=ZbFzZrfKuMTr4Xjs+F6s/P1aqzpZRLiLKb1UFloK9qUMOGJ4j6ThaZbN9EmEt0q3Eu
         759dpj8EfjK2LipQgCZsKVUF3eNQYWsuAILal1YdT0dt8mtFHq2PsltxUxXuVF/DpFbW
         vre2zPxglWy/+uOrN7y3ds+dE15+RAjun8lWKudPz6DK9CROJBHo9MGZYwH4Xvko4yyv
         B4K1TTqlsnYhaNOtO5nScDjHPIOFhAHo3XPyT/SgfJz5jMkB0/6T3aS+g+ytZ/X+tR7G
         nvlqpiVsoe1PwxLa2pJyH26ljq0NCnyvtsp0osVqMJoLehJ/liUOp49Gf5F2VnCNm86b
         FuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679925511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1Gx6hpiQ6E/pjxy2KWHAjzK7MQQtrVJ/I63KQY+/Xk=;
        b=KVopKgiMw+oSfb8aDIKZZkOy8/D8XhSEh9nzDCVncOsjvVPUuHMOIIJdtTE++uccB8
         6bZJilQqzXnBROZt1lZMNcZy/RyWCaGxr2JfmO1yf3bbX89tekPg33SresTsXjmqaE8Q
         0y4MQVQhJNW06XVqzqCLe3TJBBM42V0u8UAqu2wpc/3oeAn5Gi2cipHMVmQtQtUiOfzF
         sldLNLjAgATFj35KaTVBnIteg2xDAEzKuYFbsPio7knJF5mqgPUJ70o1k3AHNT2tsjYK
         jKi2OTh4qMGv5PjtTJsEdCZtG3eRBeTwJElQec3aEr3kzdpF2FhAZ7GlU5qiDKBPbODP
         HQ1g==
X-Gm-Message-State: AAQBX9cEtOA3mUczY44Vi/ZHOgAYE46+cLSkHFsRg3F34nupb/BHb9qE
        27d2mYr51NrIYpBoHU+2UhM=
X-Google-Smtp-Source: AKy350Yvp2sDiWx+7IFe+pzISfF4KIfvlsaCIXeVDiEfPo49dfQC3b8yn9ct0NUPwT6496rPOkF3Jg==
X-Received: by 2002:a17:90b:4c8b:b0:23f:2c65:fab7 with SMTP id my11-20020a17090b4c8b00b0023f2c65fab7mr12857311pjb.42.1679925511466;
        Mon, 27 Mar 2023 06:58:31 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id ge13-20020a17090b0e0d00b0023fcece8067sm7388246pjb.2.2023.03.27.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:58:31 -0700 (PDT)
From:   Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: add radix_tree_preload_end in error case
Date:   Mon, 27 Mar 2023 22:58:00 +0900
Message-Id: <20230327135800.524-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent excessive increase in preemption count
add radix_tree_preload_end in retry

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/checkpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1e0164cde23d..72205a9437b5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -508,6 +508,7 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 	if (!e) {
 		if (!new) {
 			spin_unlock(&im->ino_lock);
+			radix_tree_preload_end();
 			goto retry;
 		}
 		e = new;
-- 
2.25.1

