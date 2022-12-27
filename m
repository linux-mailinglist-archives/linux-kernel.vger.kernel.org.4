Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55645656CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiL0QDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiL0QCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:02:51 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A60EA9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:02:49 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1672156966;
        bh=gxt7wUGYdqW5dnnuQ+NaxVEhN/M72u1992lthLjmCpQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EiXUPHGFDmtPI7cJe3auCz78QEZVKKF7TJace5j4pwj6zMPPa/GLrAThg8QRf45cb
         CRiY80s8+sLJ68Ia20SlXixIMUM3zT613FRFkUsFCDPdOkxURh1dpVKZVBIdgs0WV6
         /f+FEcehsMWpRxT0eX3prW9HW6suMy5Mn2qVygQ4=
Date:   Tue, 27 Dec 2022 16:01:02 +0000
Subject: [PATCH v2 6/8] objtool: optimize layout of struct symbol
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221216-objtool-memory-v2-6-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1672156865; l=1055;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gxt7wUGYdqW5dnnuQ+NaxVEhN/M72u1992lthLjmCpQ=;
 b=Xsvfu2//FCigo7nfKlub7bHkejf0HGMpbq3HbjfGca8mWRf746ZswAaDkqiJvr95RiP3HIyPAfT+
 BjLuHeGpBnQGqMsq+1ETS/WYtzPaT8s4r8ITG7PGAXEO+6sixRQ4
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

Reduce the size of struct symbol on x86_64 from 208 to 200 bytes.
This structure is allocated a lot and never freed.

This reduces maximum memory usage while processing vmlinux.o from
2919716 KB to 2917988 KB (-0.5%) on my notebooks "localmodconfig".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/objtool/include/objtool/elf.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 2b5becad5a0a..f41573ff1f8b 100644
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

-- 
2.39.0
