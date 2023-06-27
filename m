Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676B6740143
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjF0Qcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjF0QcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:32:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7DB30F1;
        Tue, 27 Jun 2023 09:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34FAB611DD;
        Tue, 27 Jun 2023 16:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53554C433C8;
        Tue, 27 Jun 2023 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687883531;
        bh=2XOJKw8mrpi06UFry4/LUM2tzNn7wRfcGUBNgfFSFmI=;
        h=From:To:Cc:Subject:Date:From;
        b=VqSjMt23XiELwozolSyczKHov0K7Jjhf10PnhFijN89uhd6LQZUFTqFf/tw814fs4
         6YuK7UbYt253RSOE3lxE1cRK4UBw/VK1PM0XENiDn8tts6IK3cQbbKG1OV1Ot1mJWo
         TtYusktLdpz9/N2zLAtdhfA3KAHUM0ZO+4UYSFt/CMzU8TX11XOlbQONG/RNrlI90u
         3P58NqaqyyH9/MLe1mgH52sxlQ1HDdM/OPdnOHt4aSAqGtoEJPiZDIXaf05QiMgAQl
         VUWWjF52RHicN5LWP55utWNGoTzPTcTylO0vE/Apn7oN9j/u7obGDaG0e53awAhayZ
         ph33Yz8qCRMXw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] modpost: define more R_ARM_* for old distributions
Date:   Wed, 28 Jun 2023 01:32:05 +0900
Message-Id: <20230627163205.2082246-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CentOS 7, the following build error occurs.

scripts/mod/modpost.c: In function 'addend_arm_rel':
scripts/mod/modpost.c:1312:7: error: 'R_ARM_MOVW_ABS_NC' undeclared (first use in this function); did you mean 'R_ARM_THM_ABS5'?
  case R_ARM_MOVW_ABS_NC:
       ^~~~~~~~~~~~~~~~~
       R_ARM_THM_ABS5
scripts/mod/modpost.c:1312:7: note: each undeclared identifier is reported only once for each function it appears in
scripts/mod/modpost.c:1313:7: error: 'R_ARM_MOVT_ABS' undeclared (first use in this function); did you mean 'R_ARM_THM_ABS5'?
  case R_ARM_MOVT_ABS:
       ^~~~~~~~~~~~~~
       R_ARM_THM_ABS5
scripts/mod/modpost.c:1326:7: error: 'R_ARM_THM_MOVW_ABS_NC' undeclared (first use in this function); did you mean 'R_ARM_THM_ABS5'?
  case R_ARM_THM_MOVW_ABS_NC:
       ^~~~~~~~~~~~~~~~~~~~~
       R_ARM_THM_ABS5
scripts/mod/modpost.c:1327:7: error: 'R_ARM_THM_MOVT_ABS' undeclared (first use in this function); did you mean 'R_ARM_THM_ABS5'?
  case R_ARM_THM_MOVT_ABS:
       ^~~~~~~~~~~~~~~~~~
       R_ARM_THM_ABS5

Fixes: 12ca2c67d742 ("modpost: detect section mismatch for R_ARM_{MOVW_ABS_NC,MOVT_ABS}")
Fixes: cd1824fb7a37 ("modpost: detect section mismatch for R_ARM_THM_{MOVW_ABS_NC,MOVT_ABS}")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 73f4f5588b67..603a4f9587a4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1286,6 +1286,23 @@ static int addend_386_rel(uint32_t *location, Elf_Rela *r)
 #ifndef	R_ARM_THM_JUMP24
 #define	R_ARM_THM_JUMP24	30
 #endif
+
+#ifndef R_ARM_MOVW_ABS_NC
+#define R_ARM_MOVW_ABS_NC	43
+#endif
+
+#ifndef R_ARM_MOVT_ABS
+#define R_ARM_MOVT_ABS		44
+#endif
+
+#ifndef R_ARM_THM_MOVW_ABS_NC
+#define R_ARM_THM_MOVW_ABS_NC	47
+#endif
+
+#ifndef R_ARM_THM_MOVT_ABS
+#define R_ARM_THM_MOVT_ABS	48
+#endif
+
 #ifndef	R_ARM_THM_JUMP19
 #define	R_ARM_THM_JUMP19	51
 #endif
-- 
2.39.2

