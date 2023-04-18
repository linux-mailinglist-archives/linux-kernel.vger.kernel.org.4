Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3886E67AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjDRO7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDRO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:59:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C101097
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:59:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso15868591pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ntu-edu-tw.20221208.gappssmtp.com; s=20221208; t=1681829964; x=1684421964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qad1ZUZF0CQIlvK+HlFxrD2cdBWI4w/iPj2biwBaNj4=;
        b=iF1pIUT3lqVkkqk+lMvTuSBTicSf24DktP7EeXpfy2xovX+cVlUHWOIWPfU9hIyr6D
         KmYCtiDSE56jEfyMBLad+cSqI9cSCVKP4JWhZRUtgO4hFHYL9Nwcq+n+EC7wF7Lw4Xhf
         7UVxeEWKwRUD5O+YmSWvAGZAR/EPW2zDOgJ9IZP9ckoY+O9Tv8HOJuR8wfQQTakY/1Sv
         f+HQNz3FjxzRlxeyNFNhVDxgjI/rO/dkYJu4Q5Lp1W6z1GE8A700MyAfKHJZOa1qeftt
         0c1qvz4qLKSAoxwEn3RbvSNV32M4c/fpsy7hsCs/6VTk438czP8QzpXCQIqCucUVTcjF
         4/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829964; x=1684421964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qad1ZUZF0CQIlvK+HlFxrD2cdBWI4w/iPj2biwBaNj4=;
        b=GEANHgERMfaTZAQ9BirGHN1C7obmXWe9k2N5lvpq+piCpk7NG1C4Q5nnRKSIqQB0kn
         I11NemtolHhNTNP5oQyqxd/iKD/R6XpUETbAU5i2VUp0VJIkMH3RqpcmNCjvSKNyfeeA
         BvExoV5CQvHODN7RT8/euTD/R3IQhb/y54wyOxXFbLlBe2rtrxxuWxPaqtZWjuBr4BWy
         8uI6aa/TIZKnBqgyooXSvylspJDAtncQCUFYtIHi2VRpN2KHp0PeuLKYpPKXAsbMdBoQ
         4A2OD6dfesZCQjWWATC0j1QCqZZVx1lC5eyihUXzcmZo9ENO33io8LUvz2G/ne2WuurR
         DOzg==
X-Gm-Message-State: AAQBX9fbI5wItlW6ZwzEEaO88rD8+Eo7l7JOEOxZImgWfhv7Z5XVdiwn
        B6I2KXxSeDp7ukRntQ9ZBzptG12bXQVy27LScHE=
X-Google-Smtp-Source: AKy350bX3wJssVLVbBZKTRKCZySSUf+tOeBsG6+Mv/YmgnmeW1jwCEKbBaTBazX0ixUEaKPzVBXU6A==
X-Received: by 2002:a05:6a20:d2c4:b0:f0:164b:fa52 with SMTP id ir4-20020a056a20d2c400b000f0164bfa52mr142319pzb.6.1681829963980;
        Tue, 18 Apr 2023 07:59:23 -0700 (PDT)
Received: from jack-ROG-Zephyrus-G14-GA401IV-GA401IV.. (114-44-13-239.dynamic-ip.hinet.net. [114.44.13.239])
        by smtp.googlemail.com with ESMTPSA id a12-20020a65418c000000b0051f17e4e1b2sm1501165pgq.68.2023.04.18.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:59:23 -0700 (PDT)
From:   Lin Chun Yeh <r09921093@g.ntu.edu.tw>
To:     linux-kernel@vger.kernel.org
Cc:     Lin Chun Yeh <r09921093@g.ntu.edu.tw>
Subject: [PATCH] include/linux/rbtree.h: move the declaration of c in rb_find_add()
Date:   Tue, 18 Apr 2023 22:57:12 +0800
Message-Id: <20230418145712.20620-1-r09921093@g.ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the declaration position of variable c in rb_find_add() to
maintain thedeclaration and used scope consistent with the c
variables, which have the same usage in rb_find() and
rb_find_first().

Signed-off-by: Lin Chun Yeh <r09921093@g.ntu.edu.tw>
---
 include/linux/rbtree.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index f7edca369..910c12382 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -225,11 +225,10 @@ rb_find_add(struct rb_node *node, struct rb_root *tree,
 {
 	struct rb_node **link = &tree->rb_node;
 	struct rb_node *parent = NULL;
-	int c;
 
 	while (*link) {
 		parent = *link;
-		c = cmp(node, parent);
+		int c = cmp(node, parent);
 
 		if (c < 0)
 			link = &parent->rb_left;
-- 
2.34.1

