Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB696E56B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDRBmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDRBlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:41:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621416EBD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 188-20020a2504c5000000b00b8f6f5dca5dso8197857ybe.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782073; x=1684374073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+WSpIn3NUEIdVcNWDxlTZBL9IhEMs5qHwjDTSF5QyA=;
        b=gnEAvtWYbBPrlRDvmMhwWHAU4VOPAZNhzEbReBa4tJPpc5X3cQyQnOkcj+IZxU+jtd
         Q+YCDhkPu6ZImWiqrO7KC2hZnhfm/LoPf2Qk+B0v/m+gmZs6ydm6J9MF3xNYweVlnDD8
         kzJrv+qZegriRdHZmr6G27dsKx70i7W4bP34J1/ZwAQen87rca+5p+yPyWMoLaX9Dau9
         nVVsiKpQ1gJzqgxY8b3BMTPSECOFqN5iCxmNf5WcJMJVHe+OKuTEuYOpIO0xE/kXViUv
         CKddSMZuirEzlq3i+5fDaLh4bYaIBJcIpoMpmtH8zmyBRsHn6nqpB1ZlzCdIk6aTFlgp
         Gt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782073; x=1684374073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+WSpIn3NUEIdVcNWDxlTZBL9IhEMs5qHwjDTSF5QyA=;
        b=PgHZJomjTqVBKxl9P8viDVYy1RVNc1wmmzf0WJrmmd2ZjXXGQ9Y5/EaBM+Gg7PJPze
         824rWdUImBbGFBI38bki0utX6GyHtyPorAVc1xpftHvD6cowOp1EAqKyNuVPR+Ft0Nf5
         9X2okA6rZvpykAn0kzckSx/7HqJq5GgG4dISvOIuJa/hty5w3J6tWZBtujc2/epyk+pD
         WIaLklE6GqCHvzrCfgHfo+uV/CkYJ4gCc9D94fgGD5mvCmyRa1DJQa2nO6WI84A3oVF+
         F9vKihFPM7IWqPCF3DfKTtsZRCuBJg3CLbIVxPl71j0UD2mbXi1K1/CknMdHvbpVh0rP
         yfAg==
X-Gm-Message-State: AAQBX9cLZWuPDUAXdoo0ywAzQANVL0az8+GCenmaDx7YZ9fby2hVCwx5
        EBiPki2rZ3a8ZdsYg7HrHkl9i1qGeMs=
X-Google-Smtp-Source: AKy350ZEiZ4KiwaDQvoDBVRd0pyWtBmDHMYqWI/Cx2Am4cudHmQsbbtrl8pLWWl9gfM9hNxwPXm0gu6TXWo=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a25:cfcc:0:b0:b78:1b26:a642 with SMTP id
 f195-20020a25cfcc000000b00b781b26a642mr8808364ybg.1.1681782073411; Mon, 17
 Apr 2023 18:41:13 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:10 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-11-drosen@google.com>
Subject: [RFC PATCH v3 10/37] fuse-bpf: Don't support export_operations
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the future, we may choose to support these, but it poses some
challenges. In order to create a disconnected dentry/inode, we'll need
to encode the mountpoint and bpf into the file_handle, which means we'd
need a stable representation of them. This also won't hold up to cases
where the bpf is not stateless. One possibility is registering bpf
programs and mounts in a specific order, so they can be assigned
consistent ids we can use in the file_handle. We can defer to the lower
filesystem for the lower inode's representation in the file_handle.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b71e8758fab5..fe80984f099a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1107,6 +1107,14 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	nodeid = get_fuse_inode(inode)->nodeid;
 	generation = inode->i_generation;
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO: Does it make sense to support this in some cases? */
+	if (!nodeid && get_fuse_inode(inode)->backing_inode) {
+		*max_len = 0;
+		return FILEID_INVALID;
+	}
+#endif
+
 	fh[0] = (u32)(nodeid >> 32);
 	fh[1] = (u32)(nodeid & 0xffffffff);
 	fh[2] = generation;
-- 
2.40.0.634.g4ca3ef3211-goog

