Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF196A505D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB1BB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjB1BBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:01:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9D298EC;
        Mon, 27 Feb 2023 17:01:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42582B80DCF;
        Tue, 28 Feb 2023 01:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62809C4339B;
        Tue, 28 Feb 2023 01:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677546108;
        bh=v4B1NDUdQOLGsbvYBPpHqzJS0pYBcoIKrBcT+CToIbs=;
        h=From:To:Cc:Subject:Date:From;
        b=M3pV4PhLBSWvguLe7x+n82M1wqfZPxxFdiFo3LvFQ5DgBe6liDchMXXiltndHJHmG
         A0o3fSWxM7yX+jSpzTii4N3ly+b3pC3jvbWXUiMedKUcH0Jr4aBQJORR0zcSt1qvh5
         YC86dIaBV6JrBnhiQYVIv653Wr6TqIM2skzbib3UxstxCFAABw8ub7JWwLsEdLqpl5
         9Pu4klckjJRl/rJPk8hcPaL4zHd2lE+dfiU0NT0O15KwvC7we02lGPi5Vltf54giMk
         ial8cRkR938cQoG6ov+KMFZ/iG5Jw+YqMBtTymY0o8y/I1JR6/iQxD1vMsgM3kDJVY
         q6+KKMsoqSxRQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        ndesaulniers@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        joel@joelfernandes.org, quic_neeraju@quicinc.com, urezki@gmail.com,
        mhiramat@kernel.org
Subject: [PATCH] bootconfig: Change message if no bootconfig with CONFIG_BOOT_CONFIG_FORCE=y
Date:   Tue, 28 Feb 2023 10:01:42 +0900
Message-Id: <167754610254.318944.16848412476667893329.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Change no bootconfig data error message if user do not specify 'bootconfig'
option but CONFIG_BOOT_CONFIG_FORCE=y.
With CONFIG_BOOT_CONFIG_FORCE=y, the kernel proceeds bootconfig check even
if user does not specify 'bootconfig' option. So the current error message
is confusing. Let's show just an information message to notice skipping
the bootconfig in that case.

Fixes: b743852ccc1d ("Allow forcing unconditional bootconfig processing")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/CAMuHMdV9jJvE2y8gY5V_CxidUikCf5515QMZHzTA3rRGEOj6=w@mail.gmail.com/
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 init/main.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 4425d1783d5c..bb87b789c543 100644
--- a/init/main.c
+++ b/init/main.c
@@ -156,7 +156,7 @@ static char *extra_init_args;
 
 #ifdef CONFIG_BOOT_CONFIG
 /* Is bootconfig on command line? */
-static bool bootconfig_found = IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE);
+static bool bootconfig_found;
 static size_t initargs_offs;
 #else
 # define bootconfig_found false
@@ -429,7 +429,7 @@ static void __init setup_boot_config(void)
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
 			 bootconfig_params);
 
-	if (IS_ERR(err) || !bootconfig_found)
+	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
 		return;
 
 	/* parse_args() stops at the next param of '--' and returns an address */
@@ -437,7 +437,11 @@ static void __init setup_boot_config(void)
 		initargs_offs = err - tmp_cmdline;
 
 	if (!data) {
-		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
+		/* If user intended to use bootconfig, show an error level message */
+		if (bootconfig_found)
+			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
+		else
+			pr_info("No bootconfig data provided, so skipping bootconfig");
 		return;
 	}
 

