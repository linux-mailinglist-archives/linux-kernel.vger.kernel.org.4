Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C72665C54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAKNVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjAKNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:21:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240D218E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:21:00 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso17139872pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmgOdRVUegv5WHJ8eSwNmFwY2FXcfa6PK9olvC1ovyI=;
        b=lG6oeZaF0PFLqX55N5M6ijy7bxNkuRp+sjG3pXSCQ+38dx1qog1EiuDuIGG8Bkpnzk
         1NOKlEEhYeM3ND3DuWr0Cctawip7KfvQNGFcXBZWTXcNyMC/qUSwAqknX7Js/as9cN48
         4Oxe9+/wWYRjQfjyQbfcgigNdafc6bq6jGWcmZNQvDwOec8D3ybpgha6PrygO/W5UQ+q
         cnxd+azXBozS4AgtoXK7mBEsdSU3eNUWWjkW3QgvaE5+sZSkveC/5WJgpaGc1Pvn6r+s
         sIUvlS17kiRUcX9Dl1kdpS3IFvLev9mDlf0xn1QpoofF+3V0FPFr0qGXP6pCqJ46ZKg7
         LrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmgOdRVUegv5WHJ8eSwNmFwY2FXcfa6PK9olvC1ovyI=;
        b=P0cARtOFmloBqV12q7mzwo81vDznbfVnexyBGsCxocffd5B5xX/LRO6oITV3CmeH7p
         aJWT88W/o8PuwTbeQU7ELHuXnMqv9yyos+aRY66sAo/zATVfHgvooD5VTQi3XDMhfMzM
         myVW0Qu0Vsc6txxr2BwToxI+XAvGIdsNta+cKynvKp7gWTd06FX994y5ywjd58hRmgUf
         4A+6HxvHpci42BEL0BqIh8NFdwGlF734PIC+BgoFpFN1eqwX/4nNjPXwjdIvIGolxfTp
         QgUm3qV70ov/9fQJ/XqUPT0nq/1E2yYQC4yaBsmfJUdE3EN14msL/AXEgu9BnkE+yxnj
         cKig==
X-Gm-Message-State: AFqh2kowO7hjADv766XhC5uH4mx+/3EbDv3UUWflhA6bK4cnoFrGh8ib
        aHVkBmqeISD4RM8vhpfPWpk=
X-Google-Smtp-Source: AMrXdXv/23v54aUoposNWDGLK22TnxNVTvG2QhB1YciXyBkgiB5vppb/GIbpAO1dhpedh8Gmzxgv0w==
X-Received: by 2002:a17:902:eb85:b0:192:fc94:2839 with SMTP id q5-20020a170902eb8500b00192fc942839mr20084629plg.23.1673443259944;
        Wed, 11 Jan 2023 05:20:59 -0800 (PST)
Received: from vernon-pc.. ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709029a4400b00192aa53a7d5sm10175914plv.8.2023.01.11.05.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:20:59 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2] mm/mmap: fix comment of unmapped_area{_topdown}
Date:   Wed, 11 Jan 2023 21:20:36 +0800
Message-Id: <20230111132036.801404-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The low_limit of unmapped area information is inclusive, and the
hight_limit is not, so make symbol to be [ instead of (.

And replace hight_limit to high_limit.

Fixes: 3499a13168da ("mm/mmap: use maple tree for unmapped_area{_topdown}")
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---

Changes since v1:
 - replace hight_limit to high_limit.

v1: https://lore.kernel.org/linux-mm/20230110150320.1676299-1-vernon2gm@gmail.com/

 mm/mmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 87d929316d57..ddb68aa52105 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1554,8 +1554,8 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  * the correct alignment and offset, all from @info. Note: current->mm is used
  * for the search.
  *
- * @info: The unmapped area information including the range (low_limit -
- * hight_limit), the alignment offset and mask.
+ * @info: The unmapped area information including the range [low_limit -
+ * high_limit), the alignment offset and mask.
  *
  * Return: A memory address or -ENOMEM.
  */
@@ -1581,11 +1581,11 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)

 /**
  * unmapped_area_topdown() - Find an area between the low_limit and the
- * high_limit with * the correct alignment and offset at the highest available
+ * high_limit with the correct alignment and offset at the highest available
  * address, all from @info. Note: current->mm is used for the search.
  *
- * @info: The unmapped area information including the range (low_limit -
- * hight_limit), the alignment offset and mask.
+ * @info: The unmapped area information including the range [low_limit -
+ * high_limit), the alignment offset and mask.
  *
  * Return: A memory address or -ENOMEM.
  */
--
2.34.1

