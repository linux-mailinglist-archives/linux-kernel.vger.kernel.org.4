Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870E6EF4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjDZMvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbjDZMva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:51:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CAFC5;
        Wed, 26 Apr 2023 05:51:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1a5197f00e9so55868195ad.1;
        Wed, 26 Apr 2023 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682513489; x=1685105489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1j3F0OpF76SpxYThtNj3IKY/AvhZVNcDV9jDrQ2/v0=;
        b=U1DCE1A+6NyIIQvwAJ/YAu/ZghkILRqIpgWH/4zjhoySaVrGVy3IxoTAkZnYmZAIL5
         s6EnhyRDO2aKtQpfhqX6uKrOMhfOLF51VUvpjBwcBrX3Oa3DntM/hOLiBYgwnxcZK7q4
         hJopmjTnzWFXMuOGywRXPtsWLTN/C1WR/3QwSMHpkwOd0YWb1h0wflA10uhhovdjos5m
         ZGWEASKblmUwKqS2exe7yrndJP/pcF8STJFha+5bn6ANmJ67zSlVUvIvVTcn0wkh6j3B
         oQ0wdn8KLqpf8zg9xBGD/GDhGRn8MfH4zNDmVzmVJE9I1v83CQMfBn+2AVKAX1vP6xcO
         HAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682513489; x=1685105489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1j3F0OpF76SpxYThtNj3IKY/AvhZVNcDV9jDrQ2/v0=;
        b=f8Q/XC8MtBJnj7q8eVTcJ5lRej869l0hwkEfVc2W0Vjdsej0Dhwya1V1929cZo5UWE
         xgDiEiBxdidcjBOMS46rkvMt2zbHc/uUURS1Ll5OA4XhpqWCt3Lc8x4cDBuwIoYFoAQL
         ZaGwRCfDZTzchpiB/CoqVEsZuR5T5+pTqDBbRmxh2JXtuM0fvKf8320iT8+dv0ctXD15
         sO8ECBXAMacc6z+KcTxhfsQAs2zD0ZgjIcGim/grdC8D7EHog6PleZqINPhluq1RDmFa
         WK5BbpsXCct8TdugDz0GH/qhyR6nNLHqz3ukynoONbjX1m1GWBaGbLd5AEUMN/LpmhEP
         c8gQ==
X-Gm-Message-State: AAQBX9d8npsPzYbNyhuylGcO4IfaBD+OlhhvcTyUYX5jX2aQ0FtI6Jww
        GnF4i86qRSrhs578GmKNfgKZO5t/S485cXF9
X-Google-Smtp-Source: AKy350Z+fJVut/vQIvws9rspzIPJQTGXQ3x2TS2WA4qrvJNiBzekX8EpWEfwUm83DNaaIuDO1o3XLA==
X-Received: by 2002:a17:902:70c7:b0:1a5:dfd:d167 with SMTP id l7-20020a17090270c700b001a50dfdd167mr11583431plt.8.1682513489246;
        Wed, 26 Apr 2023 05:51:29 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b0019e5fc21663sm9935312plb.218.2023.04.26.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 05:51:28 -0700 (PDT)
From:   Genjian <zhanggenjian123@gmail.com>
X-Google-Original-From: Genjian <zhanggenjian@kylinos.cn>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanggenjian123@gmail.com, Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
Date:   Wed, 26 Apr 2023 20:49:48 +0800
Message-Id: <20230426124948.1072216-1-zhanggenjian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Genjian Zhang <zhanggenjian@kylinos.cn>

compiler error (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110):

{standard input}: Assembler messages:
{standard input}:171: Error: found '(', expected: ')'
{standard input}:171: Error: found '(', expected: ')'
{standard input}:171: Error: non-constant expression in ".if" statement
{standard input}:171: Error: junk at end of line, first unrecognized
character is `('

Preprocessor expand ___SYNC () macros.However,'if' will be wrongly
replaced by C code when PROFILE_ALL_BRANCHES is enabled and ___SYNC
is used in inline assembly.This leads to syntax errors in the code.
Compilers report a lot of errors like the above.
Move '.if' into quoted strings to fix it.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 arch/mips/include/asm/sync.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
index aabd097933fe..d9f5a87424e7 100644
--- a/arch/mips/include/asm/sync.h
+++ b/arch/mips/include/asm/sync.h
@@ -175,7 +175,7 @@
  */
 #ifdef CONFIG_CPU_HAS_SYNC
 # define ____SYNC(_type, _reason, _else)			\
-	.if	(( _type ) != -1) && ( _reason );		\
+	((_type) != -1) && (_reason);				\
 	.set	push;						\
 	.set	MIPS_ISA_LEVEL_RAW;				\
 	.rept	__SYNC_rpt(_type);				\
@@ -192,13 +192,15 @@
 /*
  * Preprocessor magic to expand macros used as arguments before we insert them
  * into assembly code.
+ * In addition,‘if’ can not be substituted when CONFIG_PROFILE_ALL_BRANCHES is
+ * enabled.
  */
 #ifdef __ASSEMBLY__
 # define ___SYNC(type, reason, else)				\
-	____SYNC(type, reason, else)
+	.if	____SYNC(type, reason, else)
 #else
 # define ___SYNC(type, reason, else)				\
-	__stringify(____SYNC(type, reason, else))
+	".if"	__stringify(____SYNC(type, reason, else))
 #endif
 
 #define __SYNC(type, reason)					\
-- 
2.25.1

