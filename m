Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B2C644F74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiLFXR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:17:23 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42742F41
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:17:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a14so11920665pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vbRaeuklEF43T7OpAaK1TLfMIWz7cNmPbZiH16DjEk=;
        b=RcfNgmVFnKB8u4Z10nfAYSiF9cW9vtwIUqMKJZBCkVHsHejK4CNP4ry8bejkhPODLX
         dztTcdBeS0CFH5anZgg6xaPMINIXLgJxeamBaKetRXAFZBdOghQurw29Afc71OBqIf9r
         0o0nH0fPYw9RhNSRaTlDQFa+nnNyViS67CDWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vbRaeuklEF43T7OpAaK1TLfMIWz7cNmPbZiH16DjEk=;
        b=DF053l1dFKWqlq1uvd8Lzw6q4vEvfnt71hacD+MVhHcZc4pnxCI50W9jDsm7tpRnn3
         M9exNArfc0UcieF6Lphj5ypxKKSR0c+jGdvB5j30anKvmHlP0fiX3ddiHHYmIIdg09+X
         VDhVYnQxYXaK9MNi9BZUV9usECrjoPUYnAadIH6/Fb1a/f2ZThdSrTajIN6q5TeQdSgu
         20/ETyJCGgZAHLMP7CZdihZxCFcpU9ZY4jkqvVmJjv/JXlufUu/tk54yC8j+QbkCNo4e
         y4Y0Mp/9mZrULkb+P1BV9F/8kzbn8J9+9KR54Fg2RoTp2dS8NlCJf9UDF6SNJjZ3V8gI
         JaSg==
X-Gm-Message-State: ANoB5pm2VHAcq4WUD2UBRJ/5LeO8+p8Rx/pMKxksewJeyrZ4GyhXvwDV
        CcW4ETuY2uDCQZx5rNEA0OByhA==
X-Google-Smtp-Source: AA0mqf70yq/wiSE63G+S5dvMbxwJzEtdGs7svgHjnyKixD6By2l7CJqbb/S9LNtBgDlXwJlqIzbBTA==
X-Received: by 2002:a63:d149:0:b0:478:dfd4:fc2b with SMTP id c9-20020a63d149000000b00478dfd4fc2bmr4745390pgj.234.1670368642119;
        Tue, 06 Dec 2022 15:17:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0017f36638010sm13058718pla.276.2022.12.06.15.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:17:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        syzbot+fda18eaa8c12534ccb3b@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        pepsipu <soopthegoop@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrii Nakryiko <andrii@kernel.org>, ast@kernel.org,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, jolsa@kernel.org,
        KP Singh <kpsingh@kernel.org>, martin.lau@linux.dev,
        Stanislav Fomichev <sdf@google.com>, song@kernel.org,
        Yonghong Song <yhs@fb.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        David Rientjes <rientjes@google.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] skbuff: Reallocate to ksize() in __build_skb_around()
Date:   Tue,  6 Dec 2022 15:17:14 -0800
Message-Id: <20221206231659.never.929-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2831; h=from:subject:message-id; bh=SEGHsTZp5rUk6+r1FvL0rwY8bYvfT9UgLniC3mssO5w=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjj81513DL6A5/30d+E/4ZlSiL3Nec8HQn2RQ2kFzs 0hZX4L+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY4/NeQAKCRCJcvTf3G3AJgEWEA CP3WJylXFSIh5ufMvAJQvK79bcfGQEV+CDUcSNcXTWdDEohBbp8tEFod5Nfj2l3fynK91HxFZsxogF kEnuK8O/7SyKs7X8L7bGXpX9pXLRMweVYccLF5Nwxh4ERV1DNDsQmjZH1uDF7SNi9blnULpHvzg34i Byw6v5p0mynHLS3alptN8Pw1n6DTuP2wYEVV8vkB1gcqBOJ6MRbcCbnshUxezF2lTqORLUeVAKvn1S HhI3U5ydjsp6VsIcFmzIau3s9l5lF+z2D/Hrb28myH81E9/ec8nEljNqB5nwlZHAupJnwLxlBhukCC ILfKn0kAdEZLXwhYqmxctrFDB5aNYK+lcNtF2RKXnZsy0Tr3q7ubILFHbQLBSvEKQ8QfpAvwH4Gby9 BS+ELN1eAQ6WQqraXDr/ox/ZzfOPEk3IjsSY2jJ3UcGtqjz7rE7UXCEaAxTO+CmY+eGit7U/Y1HinQ JwhD/C4H1lNNPpJilKLWGmqOLnOYKkDKGfKWdTmSFJa3sxIlzWz5RlTPRoXPmMamZINipZHKl8BjU+ Ee0qzhGS5qQ8uuefIru++zAjBvy3ww83P/5IaKBqSma+SQkucNI4OEa4nqnSAZGLIwfYXc4sit2pHB WMtK/l1bgCdHLPDCL8cHfNH7f64jUTfmdEtV/urQ91TRLv497uFJ/hH07ZUg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When build_skb() is passed a frag_size of 0, it means the buffer came
from kmalloc. In these cases, ksize() is used to find its actual size,
but since the allocation may not have been made to that size, actually
perform the krealloc() call so that all the associated buffer size
checking will be correctly notified. For example, syzkaller reported:

  BUG: KASAN: slab-out-of-bounds in __build_skb_around+0x235/0x340 net/core/skbuff.c:294
  Write of size 32 at addr ffff88802aa172c0 by task syz-executor413/5295

For bpf_prog_test_run_skb(), which uses a kmalloc()ed buffer passed to
build_skb().

Reported-by: syzbot+fda18eaa8c12534ccb3b@syzkaller.appspotmail.com
Link: https://groups.google.com/g/syzkaller-bugs/c/UnIKxTtU5-0/m/-wbXinkgAQAJ
Fixes: 38931d8989b5 ("mm: Make ksize() a reporting-only function")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: pepsipu <soopthegoop@gmail.com>
Cc: syzbot+fda18eaa8c12534ccb3b@syzkaller.appspotmail.com
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: kasan-dev <kasan-dev@googlegroups.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: ast@kernel.org
Cc: bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hao Luo <haoluo@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: jolsa@kernel.org
Cc: KP Singh <kpsingh@kernel.org>
Cc: martin.lau@linux.dev
Cc: Stanislav Fomichev <sdf@google.com>
Cc: song@kernel.org
Cc: Yonghong Song <yhs@fb.com>
Cc: netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/core/skbuff.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1d9719e72f9d..b55d061ed8b4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -274,7 +274,23 @@ static void __build_skb_around(struct sk_buff *skb, void *data,
 			       unsigned int frag_size)
 {
 	struct skb_shared_info *shinfo;
-	unsigned int size = frag_size ? : ksize(data);
+	unsigned int size = frag_size;
+
+	/* When frag_size == 0, the buffer came from kmalloc, so we
+	 * must find its true allocation size (and grow it to match).
+	 */
+	if (unlikely(size == 0)) {
+		void *resized;
+
+		size = ksize(data);
+		/* krealloc() will immediate return "data" when
+		 * "ksize(data)" is requested: it is the existing upper
+		 * bounds. As a result, GFP_ATOMIC will be ignored.
+		 */
+		resized = krealloc(data, size, GFP_ATOMIC);
+		if (WARN_ON(resized != data))
+			data = resized;
+	}
 
 	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-- 
2.34.1

