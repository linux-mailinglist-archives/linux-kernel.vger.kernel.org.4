Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180D70CB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjEVUgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjEVUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7E19D;
        Mon, 22 May 2023 13:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30AFD62BD6;
        Mon, 22 May 2023 20:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD92C433D2;
        Mon, 22 May 2023 20:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684787752;
        bh=0nQ8xIPSPhBIr1gc3+npYhNke4IXHy+5EM39FqGHhHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvIIl7JwcJq1f1lT50bQTaPuLv0NZy78hJqb4UTvWapPNbd41FW80wvaW4pH0aAOo
         4TFqg8491i9Zl3rQRFtYXMLVrUEjAIN2Sus2yH0U8HOELjOAhTmZZlj6/RVSV3KFvt
         Xe9iqVfgcL67vJ4LphGTNfl2Ao1Ub0EQ7bS13b2S6nILe6dKwQjN4s3A5ifjdgD6B8
         HKSBErLqGZ2KGI5RO4zGnfoSCGGwg236gdTcm9UFy3mIkKjxjyKFjwyOA5VTnN1Ir6
         STLK7od7jNeP4m7FYg/VWUGu+uTiQw4V/Ub1n/8uiGlC7+KimKstqJvqYoDpmxE5EM
         cl8yPMWAoz3Ag==
From:   Jiri Olsa <jolsa@kernel.org>
To:     stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        John Fastabend <john.fastabend@gmail.com>, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 8/8] bpf: bpf_probe_read_kernel_str() has to return amount of data read on success
Date:   Mon, 22 May 2023 22:33:52 +0200
Message-Id: <20230522203352.738576-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522203352.738576-1-jolsa@kernel.org>
References: <20230522203352.738576-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

commit 02553b91da5deb63c8562b47529b09b734659af0 upstream.

During recent refactorings, bpf_probe_read_kernel_str() started returning 0 on
success, instead of amount of data successfully read. This majorly breaks
applications relying on bpf_probe_read_kernel_str() and bpf_probe_read_str()
and their results. Fix this by returning actual number of bytes read.

Fixes: 8d92db5c04d1 ("bpf: rework the compat kernel probe handling")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20200616050432.1902042-1-andriin@fb.com
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a46256f99229..c4c825dcdef8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -198,7 +198,7 @@ bpf_probe_read_kernel_str_common(void *dst, u32 size, const void *unsafe_ptr)
 	if (unlikely(ret < 0))
 		goto fail;
 
-	return 0;
+	return ret;
 fail:
 	memset(dst, 0, size);
 	return ret;
-- 
2.40.1

