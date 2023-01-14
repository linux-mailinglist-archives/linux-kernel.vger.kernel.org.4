Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3083F66A872
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjANByv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjANByr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:54:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9186CFF8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:54:46 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v23so24088655pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KUc5JrrEgEAQMR+uacJMHg3Y0KdkEVSfddBY4EelSU=;
        b=pYh5aapWlNYGi2AIwHdCGiQBs+8o/UIxz4QRV9NCxbXcX159Mpi9iMC9hnCYDkvoTy
         DXtxwWyzgJwbxuAXgsQ81AHj89saiLU95mUNQ1mIs/Pn5U7jcxkJJGVkjgb8CJAcuupy
         JXl+H5BgWTPvJ68NmjLv7tCpMmQis6ISkSxe+wm308fv4bfoOqgUHikogG3wHbBnIouN
         Ku2FiHRrwiq+nkwh283+ApmG5niZ9VS3sS6t60fbIuXXMFoFQ8lNEfFch/pPnXzHY9IB
         xioAi/DfW9RzdZXVFFxV+HLnzz1w6KZZD42sM8q4KCxAqVmsbMN3MipqUf1MCx3LdpFa
         W92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KUc5JrrEgEAQMR+uacJMHg3Y0KdkEVSfddBY4EelSU=;
        b=vw5CT40//OBJQZLUOs9wLMmEqPofvv28g55pJrpuQ0T2xbxwbTTX46MFVid1okMz6y
         FucY8/6jXLwDzKkcnb7Lwi7h5QQwTRAViTFEdiu1bqCV86VRcmkwXJbTGisX6JcxrRGd
         0aIs1hOf/ZKnCrQCB0hL7K48tgcsukjNRakzs8bHVomDpW4uPZ8kEbogrxuTkdRo4569
         bWfpwGRqbY2K9bOohhw31I0oIjaPKbyrvQ0N9elvApw0CEQVAVJA4aZzMTp+XJRAp2zb
         UPRFo8LZUhxwWPbXGAVjEra5XUc7syu2ZbSjIvMMU9DBcDZu/p+YCUQ7PUh/OAutW6Z9
         xO2A==
X-Gm-Message-State: AFqh2kr4S/kkjAG5or8DTlmPWXGDDzxP+Inlbi/JNWZ38vAOn2PIeYkD
        T6g4aclVzjrhFESJ3Z2aXmmYKGPlzYxs2ra5
X-Google-Smtp-Source: AMrXdXufjNASMfWxEUn8LZafdceOW19Mo9MoJdDhfu1pintXKLojiA5d/ydsUQxFmCJidyi3TAeUaA==
X-Received: by 2002:a17:902:db05:b0:194:751f:3e89 with SMTP id m5-20020a170902db0500b00194751f3e89mr3483782plx.63.1673661286141;
        Fri, 13 Jan 2023 17:54:46 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.142])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b0019251e959b1sm14781028plg.262.2023.01.13.17.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:54:45 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH resend] fs: ntfs3: Add check for mft_ni in mi_read()
Date:   Sat, 14 Jan 2023 09:54:41 +0800
Message-Id: <20230114015441.777119-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a previous commit 2681631c2973, the parameter ni of
attr_load_runs_vcn() can be NULL, and thus a NULL check is added.

However, in the same call stack, this variable is also dereferenced in
mi_read():

mi_read()
  ni_lock(mft_ni);
    attr_load_runs_vcn(mft_ni)
      if (ni) -> Add a check by previous commit (ni is mft_ni)
  ni_unlock(mft_ni);

Thus, to avoid possible null-pointer dereferences, mft_ni should be
also checked in mi_read().

These results are reported by a static tool designed by myself

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
---
 fs/ntfs3/record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index defce6a5c8e1..9c5f922543c2 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -144,13 +144,13 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	if (err != -ENOENT)
 		goto out;
 
-	if (rw_lock) {
+	if (rw_lock && mft_ni) {
 		ni_lock(mft_ni);
 		down_write(rw_lock);
 	}
 	err = attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, &mft_ni->file.run,
 				 vbo >> sbi->cluster_bits);
-	if (rw_lock) {
+	if (rw_lock && mft_ni) {
 		up_write(rw_lock);
 		ni_unlock(mft_ni);
 	}
-- 
2.34.1

