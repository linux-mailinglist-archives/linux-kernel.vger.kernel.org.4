Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC470D173
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjEWCkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjEWCka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:40:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC5CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:40:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso3327053b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684809629; x=1687401629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS9nTwBGX8qR14S3jVVw2sqVNUKYzEeG4IZM9AzTvVI=;
        b=FhsYx37F97Z7aOmK6PMZd0phvrQIdIeUdkA9tyyT6UK2zyQMTVMVcpQxZUCDo34etC
         EOdMjLNoj/xT4u7MLGIEox3EmjucpiXL95HEqcTqU8jwUZ6wb932I+kWKEz5nofIU2uD
         ovGKxz3lP8y5zfl7DIhsCpf+BJEPPkxYgfb77CJoFvfneDZmJB2gWjzuSXeLTupGgbvi
         /1+2zPdAgPyuq24vnAYdmF2mil0THD2W+j7/m9ewZinGF1z4ritDda3a2n2UqzKRYCr9
         lkJN4PEuXRmoj+NPCKukYpooeAHXYgh3CqL9nIRcaB+tvqe1iWurnjZvlO15xRhxVx0D
         xkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684809629; x=1687401629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZS9nTwBGX8qR14S3jVVw2sqVNUKYzEeG4IZM9AzTvVI=;
        b=Ew4iTm+auBtVrg9MlVeSr360/J/TyiF64Oz5FEODz+4KFe17o8IuNF4BebNagtQBdQ
         OsFkhB7bMyrPHhthz3QIVF2iyyz/QEy3pbcf4F7g5NHlaK3IB1JImmo0Ex4ldGOpmImj
         2XkNQX29nP47Zt24g40jWgqbuUbiOPiaIz7AGkZ6Rth+yDFeHOUGYjm1J9QAAJTT9Tdp
         Db94ex2XzWqBHCZMCi6IRfUIvtWNw7ltwWU9fLS7/B+nE/PZxxeuuTxWM1gTy0wFUiWl
         too3sdgC0f1hnDYBltRFjaPd52aPjJzr0kIX1VKieKr4m64x/RqNnrW2A/6fNDlV8vxF
         AT4w==
X-Gm-Message-State: AC+VfDy+QTGOnE/47N5pi0LWm0r+DYYCOSh8oRN4HFkdS3X4TijwA9rQ
        cWqOChq40Gs90mP6LGd22e4sRA==
X-Google-Smtp-Source: ACHHUZ7im0Q12gzpifMYiBFdNyJzAawhHOdl9gobq9kaBYydUFHdFuUQWjWnvNaupStyAh+ML8iPUw==
X-Received: by 2002:a05:6a20:394c:b0:100:15c4:23af with SMTP id r12-20020a056a20394c00b0010015c423afmr12713687pzg.60.1684809628835;
        Mon, 22 May 2023 19:40:28 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id c18-20020a17090abf1200b00250d908a771sm4616876pjs.50.2023.05.22.19.40.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 22 May 2023 19:40:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR
Date:   Tue, 23 May 2023 10:40:17 +0800
Message-Id: <20230523024017.24851-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root->ino_idr is supposed to be protected by kernfs_idr_lock, fix
it.

Fixes: 488dee96bb62 ("kernfs: allow creating kernfs objects with arbitrary uid/gid")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v2:
 - Open code the locking.

 fs/kernfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 45b6919903e6..5a1a4af9d3d2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -655,7 +655,9 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
+	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
+	spin_unlock(&kernfs_idr_lock);
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
-- 
2.11.0

