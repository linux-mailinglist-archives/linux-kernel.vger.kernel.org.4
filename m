Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB78974C4EE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjGIPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGIPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:13:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C24B9;
        Sun,  9 Jul 2023 08:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F1960BEB;
        Sun,  9 Jul 2023 15:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5901EC433CB;
        Sun,  9 Jul 2023 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915580;
        bh=oyJMKpX+tRVslhuKNrHjM4kIgy+eIZlE7fR7+clRX28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mChc1bevbOxg2tfP00ebnrapHQmR+7bRCGQgJvV5RGfrLrA9klyBuECQHswZ+5Wl0
         GGgc8prXRW8O00MaXoOOHt82yJhyyML+KZakSYylV7Y/BqjqRnCk/kc8sf7kZuN0lq
         eetZiXGL97TiYc41695yyJsBI6czRjlv6b9lyc5Wam5Or+WdDsuCsZulTuGQgziZFA
         jes0qMutM4CC8ca8ZPE2D2iaPPR+0z2tCMzkzRIuxftciId5BEEDRAy8sq898gHeZL
         FKuJ9R7s2ohnUYUGqKEtgzxWcvhHSIVDTHI4mryIRtd2I3oXsmOzr8E+KtvJog/ZWI
         gCUUE2rzkghHw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kui-Feng Lee <thinker.li@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 02/26] bpf: Print a warning only if writing to unprivileged_bpf_disabled.
Date:   Sun,  9 Jul 2023 11:12:31 -0400
Message-Id: <20230709151255.512931-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151255.512931-1-sashal@kernel.org>
References: <20230709151255.512931-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kui-Feng Lee <thinker.li@gmail.com>

[ Upstream commit fedf99200ab086c42a572fca1d7266b06cdc3e3f ]

Only print the warning message if you are writing to
"/proc/sys/kernel/unprivileged_bpf_disabled".

The kernel may print an annoying warning when you read
"/proc/sys/kernel/unprivileged_bpf_disabled" saying

  WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible
  via Spectre v2 BHB attacks!

However, this message is only meaningful when the feature is
disabled or enabled.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20230502181418.308479-1-kuifeng@meta.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f1c8733f76b83..5524fcf6fb2a4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5394,7 +5394,8 @@ static int bpf_unpriv_handler(struct ctl_table *table, int write,
 		*(int *)table->data = unpriv_enable;
 	}
 
-	unpriv_ebpf_notify(unpriv_enable);
+	if (write)
+		unpriv_ebpf_notify(unpriv_enable);
 
 	return ret;
 }
-- 
2.39.2

