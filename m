Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E6A6F7705
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjEDUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjEDUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:31:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D518DCA;
        Thu,  4 May 2023 13:20:03 -0700 (PDT)
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683231558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ86TMvno5qeng6U0rCVgoMQaGJVwnTJIy9oD2h9Q1A=;
        b=BEE9oUQ/E2WZ1iOrhE5rFNn7EV5qH7DX8gPHCT11aJrUiXf3PxrF/5hqFdCeg9DOvCYFlm
        BKBTKhA9ABi4/TqM6rNfDfSRx2JGaBERFCwFZXC5kGnnvCap+TLx3LcNgMgq8Y/ymRxfUd
        vt7bOcG1QerPAeaEpEGYWq/74wVc0vaicLN8zg600580VpDNhhXjduFGMTxf1G9SYfq1jA
        Hpy//bDtkaLjtEuzlrhRaar6+4it0UgzSVtU+dp5u/PMBq5cYdcpNeVLK6yKGh3AzjHhrg
        6cuwfvo95TTjBjcUYQJqJ8TeIMe3+JhImTMO8FEFu0acu/GaiEdgNFW9rgvrEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683231558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQ86TMvno5qeng6U0rCVgoMQaGJVwnTJIy9oD2h9Q1A=;
        b=M4w+POcjZb2xIsQOBUzBJeslZ2v85/wkjHh+e8SvBtE9m4SbvpmFev6+6JmT61ROUnd4AX
        10NbKaqPaMOxfuBQ==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kbuild@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 1/1] scripts/tags.sh: Fix gtags generation for O= kernel builds
Date:   Thu,  4 May 2023 22:18:33 +0200
Message-Id: <20230504201833.202494-2-darwi@linutronix.de>
In-Reply-To: <20230504201833.202494-1-darwi@linutronix.de>
References: <20230504201833.202494-1-darwi@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gtags considers any file outside of its current working directory
"outside the source tree" and refuses to index it.

For O= kernel builds, scripts/tags.sh invokes gtags with the current
working directory set to ${O}. This leads to gtags ignoring the entire
kernel source and generating an empty index.

For O= builds, set gtags' working directory to the kernel source tree
and explicitly set its output path through parameters instead.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 scripts/tags.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index ea31640b2671..1a6db535503b 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -131,7 +131,14 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	# gtags refuses to index any file outside of the current working
+	# directory. For O= builds, set the current working directory to
+	# the kernel source tree and the output tags dir to ${O}.
+	suffixparams=
+	if [ -v O ]; then
+		suffixparams="-C $tree $O"
+	fi
+	all_target_sources | gtags -i -f - $suffixparams
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and
-- 
2.30.2

