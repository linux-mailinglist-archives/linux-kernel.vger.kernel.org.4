Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDCD6DC4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDJI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDJI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:59:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50C30D1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:59:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q2so9030545pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681117169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueHlf63HU9JRFKSuWrERCIbxEHTEvzXB14p8A02eQpo=;
        b=CbC7kM3gDgrsz/8uuOl3IsHCOrSEg1QePC6wsHtePGDcEdppy/6fDvhBkRWD7aQrkh
         CMFzel33HYF9q1bIlal4ejP5H1RyYVC9Xu0BKNsfvPU2sD+GBAOmEBDE4fZVIUY3tNqH
         NIqNcSjZdloqdwwU2sVwX+ECL34OQPaO3MAlUJh5j5gY7dcz+t6DMxHgX8neu25sDUgh
         Ij8G8mRN050YaUJ4v3SPVOUvp2KPOV2c1enYRJhrl+B2txm/l/XJQRxvkXdRhlBQGc/9
         Trzi+X+9jKajfI61tHtWXNNXFvFKoW2a94Yz6ATFO5vXeBsHloPIYg8lD+Bct6LTkHKn
         XCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueHlf63HU9JRFKSuWrERCIbxEHTEvzXB14p8A02eQpo=;
        b=O9ONARxFeyLf/dSU0IQYAjdLtXLFm3CKtf7f53m63EOunhvi+KfM/Jk9Kyxv8hAed7
         m6xRnocSLvfrB1i0gcSlePqKd7S0BSBgH4S08UNC1Hrkh+4cCXzucUH2ajNdfXGGWRpR
         nCEmdGUNKIFT+RlzgoqU+EEZfiYxGbBuKcdndx+PVjmTZhfn8CYycUiLXZQgfRvEUBiw
         fCyhD7GoIrmDhRzW+LDXZ59SCWu6U+CSQDO/fwcpFKuYYG1Wl+IplH+KbG5xdPNQBjYO
         Ml/cMgs3KZdvTm0SGrP/xQmAwm81h5tZ5hNOvL91kIRaKBQRCRQ5tXGAHKeM/95Owo8o
         5l/A==
X-Gm-Message-State: AAQBX9cyuodyZZ929uq1X6Ng6QhPrHcGOBJrW0SwmQ9vzFgxP1EVvODV
        qU8h1Zxw5GHtOkY73rDvlb+DXw==
X-Google-Smtp-Source: AKy350Yo1QN1keYMBG5X4wrxjlA7RdV5x6e9ubtteeY2QslDbmfBLvvkwOiZQJX6rEtxB2KABWGVvw==
X-Received: by 2002:a05:6a20:6707:b0:dd:f44a:2717 with SMTP id q7-20020a056a20670700b000ddf44a2717mr10980029pzh.8.1681117169277;
        Mon, 10 Apr 2023 01:59:29 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0058bacd6c4e8sm7279526pfm.207.2023.04.10.01.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 01:59:28 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH v3 1/2] bpf/btf: Fix is_int_ptr()
Date:   Mon, 10 Apr 2023 16:59:07 +0800
Message-Id: <20230410085908.98493-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230410085908.98493-1-zhoufeng.zf@bytedance.com>
References: <20230410085908.98493-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When tracing a kernel function with arg type is u32*, btf_ctx_access()
would report error: arg2 type INT is not a struct.

The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
in tracing programs") added support for int pointer, but don't skip
modifiers before checking it's type. This patch fixes it.

Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/btf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 593c45a294d0..5abd8dfa6b70 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5910,12 +5910,8 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 
 static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 {
-	/* t comes in already as a pointer */
-	t = btf_type_by_id(btf, t->type);
-
-	/* allow const */
-	if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
-		t = btf_type_by_id(btf, t->type);
+	/* skip modifiers */
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
 
 	return btf_type_is_int(t);
 }
-- 
2.20.1

