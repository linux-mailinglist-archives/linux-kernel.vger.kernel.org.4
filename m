Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2C656CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiL0QDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiL0QCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9991D73
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:49 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156966;
        bh=s5ecXOvEehEk53y4y2OsKyfg1cQWJRf01QzJ+Hcl4rk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bGIKGHdIZ/KqixZJ7Q5PHiVT7CjHcdMVbIheTEv+Mv16FdEi59VKqdEqVRutatzZX
         owjZJgDOzaBYLsH/rkR3ptyxR2QtPbdfp4v7o0Zuq36H4wJHDs4SoyAiry+EDq4okl
         oMP2i8+QIgJUvkdUWkNZZC7WBAkvXPrf1xB/inR4=
Date:   Tue, 27 Dec 2022 16:00:58 +0000
Subject: [PATCH v2 2/8] objtool: make struct check_options static
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-2-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=1353;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=s5ecXOvEehEk53y4y2OsKyfg1cQWJRf01QzJ+Hcl4rk=;
 b=h6yH1/xaYHrNAEVhKJ/pU5PXmhFBqfDVr6QKS8oRm+oyYvouX6nXqdoGXJ0rf3+iCugXF1ms329M
 0xIG269CD2SSQp5lQY4O91LF7o7iMBHHTRULpI014EJsmQVcwdRs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used outside of builtin-check.c.

Also remove the unused declaration from builtin.h .

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/builtin-check.c           | 2 +-
 tools/objtool/include/objtool/builtin.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index a4f39407bf59..7c175198d09f 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -65,7 +65,7 @@ static int parse_hacks(const struct option *opt, const char *str, int unset)
 	return found ? 0 : -1;
 }
 
-const struct option check_options[] = {
+static const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index fa45044e3863..2a108e648b7a 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -7,8 +7,6 @@
 
 #include <subcmd/parse-options.h>
 
-extern const struct option check_options[];
-
 struct opts {
 	/* actions: */
 	bool dump_orc;

-- 
2.39.0
