Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E74733360
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbjFPOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:20:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B130D1;
        Fri, 16 Jun 2023 07:20:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8cc04c287so6514805e9.0;
        Fri, 16 Jun 2023 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686925211; x=1689517211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n+zCd171C8WV43Pb8fKtEBT7M8Z3ZhCd57gUNvYhvE=;
        b=eeXqpUVDzV+Mw7rLr2cyAx+rsaohyEDUCURUwby2so4enYHtlYBjTnDwSPfRk6/r8z
         v9teaBJ682YMiTwF1PuqjWDK0g+nBFdfJ5axDB/vFYsIk6Sn9kUyWJGuWyfRc/QNlFN9
         R1IdG5iWw46WB6Ca6+THP/kerTnH+3vyZDxZstxq+ISIBco63FXi1c5Y3q+9JCHiOWWw
         ReZWpTbFObecIA9wcdL9+TzghPhi5C0bADHF8TtUwkVtVRCHZaNGOIvWYICvAGE63SMh
         I+Y/bFEOHhuwvJNDd3Ht/ASiYnF3GZoAIqGNICeYLHHoW0IjvY6jSFKd7F1RYuviQNDN
         KLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686925211; x=1689517211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6n+zCd171C8WV43Pb8fKtEBT7M8Z3ZhCd57gUNvYhvE=;
        b=R2dgSC/O8fQYUhgoTFkjLjUmDHey38MB/1SbuCyJrajzvwuUYsEwyNd+lH0LLSvRaH
         OUVYYy0HvS3m6+iWfGlwjojFYTBkmQHmgoJDdUbI/ug9f0J48gYq4FPJ1s/n7cyZWukG
         ddBs9WK0u8OS30jnk2i7PO99YYwE5jyuhIl4JgsuP5Sz5oDGqwUIixSDXqZh8YCSs9zp
         PjNbMXKVmbeNHp6gRHYakvFIbHiq3diJ7Mk5QuDz4pHmKsniEkYX9PhVOjFJkM9iUTmE
         jKpCPDs5K+4PWI3pdF2wtaSaYYj7+UGVEG06AmlufXbNgRDOJyN4t1djM6yStemaHgOU
         /pPQ==
X-Gm-Message-State: AC+VfDyHKmY9dpzMEP7F1L/5J2yR3MfAD2Ol2lJ8cs+1ETU9Mb3TCyQD
        TCMH+9l/PxckVnGJHNnVok4=
X-Google-Smtp-Source: ACHHUZ76uljn5+k12odkTj+XuWoqO28oSLovWPZrDliLxUPuB2ilG33B0qBVNpEa9SmkG8qmYrEZow==
X-Received: by 2002:a7b:cd88:0:b0:3f8:fa2e:efc1 with SMTP id y8-20020a7bcd88000000b003f8fa2eefc1mr1009104wmj.15.1686925211164;
        Fri, 16 Jun 2023 07:20:11 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003f7eafe9d76sm2321608wmi.37.2023.06.16.07.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 07:20:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] f2fs: remove redundant assignment to variable err
Date:   Fri, 16 Jun 2023 15:20:09 +0100
Message-Id: <20230616142009.2332411-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The assignment to variable err is redundant since the code jumps to
label next and err is then re-assigned a new value on the call to
sanity_check_node_chain. Remove the assignment.

Cleans up clang scan build warning:
fs/f2fs/recovery.c:464:6: warning: Value stored to 'err' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/f2fs/recovery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f0cf1538389c..4e7d4ceeb084 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -460,10 +460,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 								quota_inode);
 			if (IS_ERR(entry)) {
 				err = PTR_ERR(entry);
-				if (err == -ENOENT) {
-					err = 0;
+				if (err == -ENOENT)
 					goto next;
-				}
 				f2fs_put_page(page, 1);
 				break;
 			}
-- 
2.39.2

