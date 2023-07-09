Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577474C4FE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGIPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGIPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE2BA;
        Sun,  9 Jul 2023 08:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C5960BC5;
        Sun,  9 Jul 2023 15:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CC6C433CB;
        Sun,  9 Jul 2023 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915589;
        bh=KK4AJoIaLPPm3zQMlhPjAJ75YEDERv0cDA6Wgc4knj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8mShvPCZbz4DTjmX1S9WcK8PXiZrD/uQeGTJPgpmMgTXrtjaga4GjlrEd4gsITTO
         pG0jBnfqEvih+PoogS9mwIFXBHSC9MI7Fvl70k+HzAFEA2A6UHe2mhDHKrGdh/1ieU
         0wIQGGPj5mH3AstzFQzFd96tExMlOypcPUTiQ5tw1gZoZATq90F5Gqs+fb29ImbjvY
         lB5/W+xXSsC4Fx7Io1D/K1waUQNPKwDOUJREXQZ0HzFjUA5skBOCM8HJzVBmYWdWHE
         WEaPEaS2rtCdTkeamMlqKdlqCNp3IvA7Is+Kr3CNj9u95R/UkonXagk9M4p70mNaX7
         jQqS4tZBqFt4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        syzbot+8b2a08dfbd25fd933d75@syzkaller.appspotmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, daniel@iogearbox.net,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 07/26] bpf: drop unnecessary user-triggerable WARN_ONCE in verifierl log
Date:   Sun,  9 Jul 2023 11:12:36 -0400
Message-Id: <20230709151255.512931-7-sashal@kernel.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit cff36398bd4c7d322d424433db437f3c3391c491 ]

It's trivial for user to trigger "verifier log line truncated" warning,
as verifier has a fixed-sized buffer of 1024 bytes (as of now), and there are at
least two pieces of user-provided information that can be output through
this buffer, and both can be arbitrarily sized by user:
  - BTF names;
  - BTF.ext source code lines strings.

Verifier log buffer should be properly sized for typical verifier state
output. But it's sort-of expected that this buffer won't be long enough
in some circumstances. So let's drop the check. In any case code will
work correctly, at worst truncating a part of a single line output.

Reported-by: syzbot+8b2a08dfbd25fd933d75@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230516180409.3549088-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/log.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 046ddff37a76d..850494423530e 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -62,9 +62,6 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 
 	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
 
-	WARN_ONCE(n >= BPF_VERIFIER_TMP_LOG_SIZE - 1,
-		  "verifier log line truncated - local buffer too short\n");
-
 	if (log->level == BPF_LOG_KERNEL) {
 		bool newline = n > 0 && log->kbuf[n - 1] == '\n';
 
-- 
2.39.2

