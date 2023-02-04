Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9868A96C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjBDKRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjBDKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E996D07F;
        Sat,  4 Feb 2023 02:17:14 -0800 (PST)
Date:   Sat, 04 Feb 2023 10:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awbb/MDCUAceNOA9d0sBAdfLnnI1GG/4y/eewIgt/3I=;
        b=fALohyiyT+DmU56ggOn0WGaptOWDt9hm0fYI1T9dlLRg5E7WktIlxHZMLn7DE78vTmi90c
        zActyJwyQRHsFjX4X34tmlxAeNKdhrpBnyTNMR2Wz+lswl2aXwT+k+AySqgySV3Sg4gxca
        1In8QEtFonWEuE1txLJVZe1vgFWXOp1ul4GY+wApV+kAiGE5Iv9MAtFTE56p6pSbL9GRuC
        nB591b+52CUdbCY3pkOw+CPD0HyXO2vfabiOsWU7xUAApTnpC/gGYXEd+TdheP5QeW0TG8
        dXvW/r6H+JltKzyCEkVhso+FfLw1BWWd56TMMDr8Fy+pYmLKrI0Yfemu8vUG6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awbb/MDCUAceNOA9d0sBAdfLnnI1GG/4y/eewIgt/3I=;
        b=Rf351rwRPaIlUp2qqV+FW2kCP5PFkKlMu66ZkfbiaktqUOVK8F1f+l4SSAmCv9pI2aF3JN
        +E2jKKE7UtUMg8CA==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Optimize layout of struct symbol
Cc:     linux@weissschuh.net, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216-objtool-memory-v2-6-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-6-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167550583149.4906.16009814897021717355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     21a899f9fc78be6b289ee4627bccadf560930eb5
Gitweb:        https://git.kernel.org/tip/21a899f9fc78be6b289ee4627bccadf5609=
30eb5
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 27 Dec 2022 16:01:02=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 01 Feb 2023 09:15:24 -08:00

objtool: Optimize layout of struct symbol

Reduce the size of struct symbol on x86_64 from 208 to 200 bytes.
This structure is allocated a lot and never freed.

This reduces maximum memory usage while processing vmlinux.o from
2919716 KB to 2917988 KB (-0.5%) on my notebooks "localmodconfig".

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20221216-objtool-memory-v2-6-17968f85a464@wei=
ssschuh.net
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/elf.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 1c90f0a..ad0024d 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -50,12 +50,11 @@ struct symbol {
 	GElf_Sym sym;
 	struct section *sec;
 	char *name;
-	unsigned int idx;
-	unsigned char bind, type;
+	unsigned int idx, len;
 	unsigned long offset;
-	unsigned int len;
 	unsigned long __subtree_last;
 	struct symbol *pfunc, *cfunc, *alias;
+	unsigned char bind, type;
 	u8 uaccess_safe      : 1;
 	u8 static_call_tramp : 1;
 	u8 retpoline_thunk   : 1;
