Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D768760D074
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiJYPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiJYPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:23:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1221998A5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:21:42 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n7so11255998plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPoTu9GpF3r7JCGLoYLEXJRrWXzP036fJar0pcMsbUs=;
        b=OJ+JNHV3wkyvUa+VFpIWGkJAgUsruutAWy8nA4OikHySUZMhON/lKAQV2jEevO+N73
         BlsXjVUyTOBI4Wip/QpCWcFBhkM5KW9oe+lcoeMDxVa1G+dvDvDAMcgB7m+KJuIgKU1u
         knldjhoyXh+EyT0VyiuWGEj3bECUotQIEioSeUpun+7dbiYTZXxxsJKNFd6P/J9ZIwGX
         UJpVGtku3dcpUMQwE44auMweCygVFAWssDmpKWMLUFVB3jW3LoIhJQc5jY9Nzk3+jOPb
         HXZWt3DDReClW5oeIDFnhDHClDKu6c54mzJsJJsjfOBL/p6i3GiNEg+8Ul/zr/pgZCw2
         0Akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPoTu9GpF3r7JCGLoYLEXJRrWXzP036fJar0pcMsbUs=;
        b=Fspej20ncrdBWWWPAjNDAGjlsNU/GK8vpPo7QDgFMuDvwYtJ3bbJuLMJC5qMokJMVg
         VScbu4hkWeT8KsFWVVZT94Imwj5LG8tfspzr1r27wFOW9dBIN9O3S7/PJUau0BGySdt0
         V+7wfHvsBxVKlHhHNeFcpE+/Dem+uIHt13GORk8YeaKi6eMDIaQfIQtFRgoLfJQVr+yb
         PHDhan4+hu1AqNZyo8deLXV7C8OU+Y8FixBjaoBZyoiQ0UCfEa40iNzQL8QKw4lSeh23
         Kgnb6KLPII+BZlpFLVYWC8wV0cj76VYESeAM5j8uOHLtaYR+qbd3nQQpV+Xp/droZdQR
         R3vg==
X-Gm-Message-State: ACrzQf2YRVWxkKA4Sa7om5M0Isr24U+NOseNi6RIJWKCc0juBuiUwRRi
        S053wkcram762lS55ztsHaA=
X-Google-Smtp-Source: AMsMyM5KqM34tFEIZCaV2VzjvgyKT25/4pgbQ8lef3I/zzQE5Bg+nu+8iJZKiWDTEqUpSxw/vvqRMw==
X-Received: by 2002:a17:903:41ce:b0:182:a32f:4dde with SMTP id u14-20020a17090341ce00b00182a32f4ddemr38435859ple.47.1666711301774;
        Tue, 25 Oct 2022 08:21:41 -0700 (PDT)
Received: from localhost.localdomain (124244014158.ctinets.com. [124.244.14.158])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090311ce00b001754fa42065sm1356022plh.143.2022.10.25.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:21:41 -0700 (PDT)
From:   Hoi Pok Wu <wuhoipok@gmail.com>
To:     shaggy@kernel.org
Cc:     Hoi Pok Wu <wuhoipok@gmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] fs: jfs: fix shift-out-of-bounds in dbDiscardAG
Date:   Tue, 25 Oct 2022 23:20:45 +0800
Message-Id: <20221025152045.343650-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This should be applied to most URSAN bugs found recently by syzbot,
by guarding the dbMount. As syzbot feeding rubbish into the bmap
descriptor.

Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
---
V1->2: guarding the corrupted data structure from dbMount instead
 fs/jfs/jfs_dmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index e1cbfbb60303..765838578a72 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -198,6 +198,11 @@ int dbMount(struct inode *ipbmap)
 		goto err_release_metapage;
 	}
 
+	if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	for (i = 0; i < MAXAG; i++)
 		bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
 	bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
-- 
2.38.1

