Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7507F6F9269
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjEFOFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEFOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:05:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014209EDB
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 07:05:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30639daee76so1855548f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683381946; x=1685973946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuEXCDxX9XAQkRyAGlh6/9QGDrlqvP94XzM0l6Y+8Jk=;
        b=gamggnXmqYSnjOTjLciqY80nYyWyus/obNDrZTtrdpVAr4Ko4M4yyA8Pg8TYO5oqEE
         1Zy8pKw/H+Ik6hYLwjEv3B8Pl3Z0UibhAurfvl+tlttfxQULwjkWb/VUQMF66hPhKZhF
         kA55rAQgPoYKbGbMVAO0YdxvZ2UhXApZJXoQFj5kxnAgXwpdvSOgXYFTF9rvSR9btRvh
         pw5q9tWZKm8s03kjqjigd6x1jeFPto3W76pb7OLq038QfF2YzPxKuQN2LENzRqiSzl2I
         ZUL80xpmzGTAM0gnuDetBnZKtPT6fqke/+EQ2gLiHYEgS+FPrP8T9zgauu1wQW4xtSHW
         58PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683381946; x=1685973946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuEXCDxX9XAQkRyAGlh6/9QGDrlqvP94XzM0l6Y+8Jk=;
        b=YUIw25wsIrqu9WVU5XEwv5PpyrsP873VlToeYCtGyCO0pPmew8dU1CXeEcnzuWgj7A
         u0jhIuq7KDMcqP/P0U7YkkLIWNhtaqPZmBDgr61yfw3uSfZVZfoZ7K7e1GLg44QOKWFr
         iK5qzeqUaCzznOwkj7vFWpv5P+TpI0G1XuJxNrK0BsPl3nmUnx6DfzZozYzTR0oWR2ir
         UUzYM6ANu4IiKP73hlY3f0aA74LMa5c03I+z8psQDtyfe2B206yYmZHcDxTUxolExSO/
         pu5tT5rTzj/zBgT7ieaHxd28KoGudkXsyJHlnIJY+zzgSIgt3RbWBOr0bvWrD6iz1Lo9
         o5nA==
X-Gm-Message-State: AC+VfDyPYSTNUr21l9kjMLTgfo+RYQ3i7lF6YaJ9bISJaukVgLOJEYVJ
        dqTD1y6PFkiUq9ac5SJtxk4=
X-Google-Smtp-Source: ACHHUZ4B81/e6wsHuW60PU0lrl/acdbNNOf+SI+D0uRKTPsa2HQTwwsVCLqvrubbgUZ8A2PvLUZDww==
X-Received: by 2002:a05:6000:104b:b0:2e4:eebe:aee3 with SMTP id c11-20020a056000104b00b002e4eebeaee3mr3047635wrx.60.1683381946277;
        Sat, 06 May 2023 07:05:46 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id q3-20020a1cf303000000b003f3157988f8sm10993650wmq.26.2023.05.06.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 07:05:45 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm/gup: add missing gup_must_unshare() check to gup_huge_pgd()
Date:   Sat,  6 May 2023 15:05:25 +0100
Message-Id: <cb971ac8dd315df97058ea69442ecc007b9a364a.1683381545.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
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

All other instances of gup_huge_pXd() perform the unshare check, so update
the PGD-specific function to do so as well.

While checking pgd_write() might seem unusual, this function already
performs such a check via pgd_access_permitted() so this is in line with
the existing implementation.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/gup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index ef43ffb3d1fe..78a5198e3212 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2898,6 +2898,11 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 		return 0;
 	}
 
+	if (!pgd_write(orig) && gup_must_unshare(NULL, flags, &folio->page)) {
+		gup_put_folio(folio, refs, flags);
+		return 0;
+	}
+
 	*nr += refs;
 	folio_set_referenced(folio);
 	return 1;
-- 
2.40.1

