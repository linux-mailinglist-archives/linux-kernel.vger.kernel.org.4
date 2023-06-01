Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654237190B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjFACth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFACtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:49:35 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F197
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:49:10 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6af6f49e41cso411660a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685587750; x=1688179750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxLmPWSnGEJp9jYQrAzo0Lj6e0Kr/zNbCeEBhHwKB60=;
        b=hu/4HijiVBPYn82So3d2DaA499ZATcXicSwjIkrBMNR0Lk2sKY9WB21AprHj8KQXKG
         9E+2/YML/Kq6o1Mpkh+HBCl3vYvL6//hOEI+tayubuF11vdspkFlo7nHzy0CTkWhTSmG
         jAj5eQeYbPbM/bnoCAfzwfENSQjaloxM1xrGdpE/jRra48tNV7z1TvoH/rgXqsB85yIF
         +hLtls15XjMRLXhZiVLh5XY/1Hd7PTd1PhN8F2bDoszjgoHY+snJBzB+ntsXGF4cwHF5
         HrvflSqIjJJ+fAy/TLGxHYvGWLTOHsFxwqCng7tGo65geJYLjdXIYx9jv5N7VLE5NZXS
         vAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587750; x=1688179750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxLmPWSnGEJp9jYQrAzo0Lj6e0Kr/zNbCeEBhHwKB60=;
        b=A1qIjTrbQFQOJxmCp0nYpuUG68ex59pd/wwZ1Sy59yXa7CKOmR7E3br427B6mipKms
         PMZtxnuE9+kuYaWmp+hejNbIlP0FuR5d6tN/bJ9yR8BKRGV8JUO51szxxLeaFmO5GiAW
         WxHNxAX7rWokOFTbC7WMJ8KqNLuJMfTbHdWU9j0ywd6YlaHz3NNi+PeMXLr9o54oZD68
         BR/Jlph8VQVv0DMS0AQphYrJotYvhyHUmDG3Z4BRj0+sqWwyOP0+EYkb5AfhX4P7xx3T
         hANXSHC8KBphLvh4mjV7ea9EYPBkTBd7vyarwjpYCFfgbd0mBVji2kGOFUuIit/Pj6Ov
         Eh5A==
X-Gm-Message-State: AC+VfDyfuNTGBGoVDw0V9tCom4AGyRRBvgndpHooNnDh7J1IS12HrPl/
        6va48k46LOdcY2AXJNphIOyh8w==
X-Google-Smtp-Source: ACHHUZ4hGZuAkPLf2CHpFCdNg5z7eUawxXSFiEr8KIx8HvRyXkXOk9OZG3ApdnVSdfBM+swzkXqi2w==
X-Received: by 2002:a05:6830:3a1a:b0:6af:7143:3b3c with SMTP id di26-20020a0568303a1a00b006af71433b3cmr4665495otb.9.1685587749871;
        Wed, 31 May 2023 19:49:09 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id e10-20020a62ee0a000000b0064d5b82f987sm4076564pfi.140.2023.05.31.19.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 19:49:09 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next] bpf: getsockopt hook to get optval without checking kernel retval
Date:   Thu,  1 Jun 2023 10:49:00 +0800
Message-Id: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Remove the judgment on retval and pass bpf ctx by default. The
advantage of this is that it is more flexible. Bpf getsockopt can
support the new optname without using the module to call the
nf_register_sockopt to register.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..ebad5442d8bb 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1896,30 +1896,21 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (max_optlen < 0)
 		return max_optlen;
 
-	if (!retval) {
-		/* If kernel getsockopt finished successfully,
-		 * copy whatever was returned to the user back
-		 * into our temporary buffer. Set optlen to the
-		 * one that kernel returned as well to let
-		 * BPF programs inspect the value.
-		 */
-
-		if (get_user(ctx.optlen, optlen)) {
-			ret = -EFAULT;
-			goto out;
-		}
+	if (get_user(ctx.optlen, optlen)) {
+		ret = -EFAULT;
+		goto out;
+	}
 
-		if (ctx.optlen < 0) {
-			ret = -EFAULT;
-			goto out;
-		}
-		orig_optlen = ctx.optlen;
+	if (ctx.optlen < 0) {
+		ret = -EFAULT;
+		goto out;
+	}
+	orig_optlen = ctx.optlen;
 
-		if (copy_from_user(ctx.optval, optval,
-				   min(ctx.optlen, max_optlen)) != 0) {
-			ret = -EFAULT;
-			goto out;
-		}
+	if (copy_from_user(ctx.optval, optval,
+				min(ctx.optlen, max_optlen)) != 0) {
+		ret = -EFAULT;
+		goto out;
 	}
 
 	lock_sock(sk);
-- 
2.20.1

