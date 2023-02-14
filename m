Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B38695A50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBNHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjBNHIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:08:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1691F917;
        Mon, 13 Feb 2023 23:07:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE861B81C0A;
        Tue, 14 Feb 2023 07:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0DAC433A7;
        Tue, 14 Feb 2023 07:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358449;
        bh=nPbz5xOaaR7NDhO9DoSuJHej7ImmCT6qFtXYRUPe9iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbCTtkRPMFx4nrooNoGOfJ3srlkvjL8Q0JxwwQRhbw7JzTw4E1NOcM5votUGXjcOI
         bwNIVjqgBxHXFasgtTguxT+q1aIxc/mIWyCxPg++08GBZnfqopz3bkDonDMIpf4Ky9
         LmmejYIb2RbvOM7BgY+ZPOyErGEpT84i2NpQdf7XK4tjGwSwp3MPtl4eDCfgFp/0sU
         PCvytiHTDPIi7VsxHtMruoDNWWKI9PdaGlVl4DlIHdnjzm/hwestBwEfWhfAeSH1C4
         KmGJSiECze1iTyVfMoQ6R5LBQk+n9PkrMQAZBkTScLTVqvsxTvSumqYOrTmbP/39QF
         i1ONpamZqe3NQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: [PATCH v2 22/24] objtool: Include weak functions in 'global_noreturns' check
Date:   Mon, 13 Feb 2023 23:05:56 -0800
Message-Id: <85c4281eecd9388e7b3b21ef550119caa5305327.1676358308.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676358308.git.jpoimboe@kernel.org>
References: <cover.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a global __noreturn function prototype has a corresponding weak
function, it should also be __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ba07a8ebaf73..0a1cf867d9b2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -193,14 +193,14 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	if (!func)
 		return false;
 
-	if (func->bind == STB_WEAK)
-		return false;
-
-	if (func->bind == STB_GLOBAL)
+	if (func->bind == STB_GLOBAL || func->bind == STB_WEAK)
 		for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
 			if (!strcmp(func->name, global_noreturns[i]))
 				return true;
 
+	if (func->bind == STB_WEAK)
+		return false;
+
 	if (!func->len)
 		return false;
 
-- 
2.39.1

