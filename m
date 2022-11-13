Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40899626F20
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiKMLIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:08:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B935D12AEF;
        Sun, 13 Nov 2022 03:08:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73125B80B0F;
        Sun, 13 Nov 2022 11:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BF8C433D6;
        Sun, 13 Nov 2022 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668337696;
        bh=re3T4qFodcsJuMPwETQhskz43bkLtjh3Ym+f/Ko/oGk=;
        h=From:To:Cc:Subject:Date:From;
        b=cOC9F/lfceBb0KeiKCPD7XGlxzx3sDugJtIrfFYWpRaWqP+D7HMNORxPlX4eT3qUg
         bjU2jv7I2RBncgentGE0x4YYfrNIErG6gZCIEfCurpH5lORSYn2YvrF08zIAzFRJNI
         YluL/ter1QMz1P9EOWd4A6tyshVCWK4QYrtNaoOcXaHxDoYAiU8frmKYTDG0OPfeur
         qcY0xdvmgOuW9jLbey3xFF7nRD2T3IAUWImVsMh58CZFK84FjaGpksbBZojo7s3jWi
         0zPuMG5NMjmJzECzwTA7DevbhgGccMH5U100YiD0wD0KfkMOE+PH1vgoAyKNfbC9EF
         dStaIisntTzXg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] linux/init.h: include <linux/build_bug.h> and <linux/stringify.h>
Date:   Sun, 13 Nov 2022 20:08:02 +0900
Message-Id: <20221113110802.3760705-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y, the following code
fails to build:

  ---------------->8----------------
  #include <linux/init.h>

  int foo(void) { return 0; }
  core_initcall(foo);
  ---------------->8----------------

Include <linux/build_bug.h> for static_assert() and <linux/stringify.h>
for __stringify().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/init.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/init.h b/include/linux/init.h
index 077d7f93b402..29f7157670a5 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_INIT_H
 #define _LINUX_INIT_H
 
+#include <linux/build_bug.h>
 #include <linux/compiler.h>
+#include <linux/stringify.h>
 #include <linux/types.h>
 
 /* Built-in __init functions needn't be compiled with retpoline */
-- 
2.34.1

