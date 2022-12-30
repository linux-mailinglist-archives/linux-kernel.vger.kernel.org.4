Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8F65944F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 04:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiL3DAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 22:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiL3DAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 22:00:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834E3F5A0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 19:00:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so20552876pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 19:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0uhFEXzMNDX1WYYp3dRuU60CaEFOmJXENlYiqSnj+4=;
        b=UefRgFQeLcsX5WpcpHu94Bhmw9cx/AUxKFnkhCJdOE+paITwYJngklO5Fwn/pulugJ
         PX8HZAGA1vo5OS9qFQS90EvncpovcUpIfg8J61iO1j2nMb6hVcj9KWGVgFCtuCG1A8KW
         adF+stmJC+QVzskNjmdMPKznIRaaLurMhbiZb0u0MCnmPLZkolHfDq/2xpvwdP9zeePi
         +WvBkf77xO1OqJLwvtfOkGJT4Vx2fzELHDocM4E9rEGJWVFw/BiLeS9sm2tkr3cLkXj1
         jBlIen+K4c42wt3XtFqD5bPcfTzqCMvzVpcshhXfa12xVKQQVJWY/JGQEMljrXCCaoFm
         cKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0uhFEXzMNDX1WYYp3dRuU60CaEFOmJXENlYiqSnj+4=;
        b=5ONi78P5V2vd3frbF2GELlkObLx6QL8piN9sjkZ14LgJUJ+oJnYnaP04I8fvoqx/0J
         ReMQYugoieQ9zyccUdvkzsPo7voMQ00hlf6SpiIwHpAYZLZ0CshA5Q9Bfk2DorXyIFIG
         dxG7gVwRTsrTXruZ41MGjRB65WWqJHswq0SOXq0uMJtME0Uxl9QCekX/YaskM0xuAcg7
         CU+tlkCTjfDH8hgb1Oo89z5ITu6m7gMI1Cp859/Shqymj9fWf5hmjzclsTMIcXvPdbzI
         vDenND9OZ8zO1cpiL1MypEmnZVx793WREmh8wg7pQeTaOha8eF9yDHWI8Q58h4hLEk0E
         5ejA==
X-Gm-Message-State: AFqh2kpbgc3A37+cqY6SN0Vu8vTdJqfynvf6punbJUwr7bNmxnr9lzPv
        sEPcKmBwwBZiDJiJ2xzcTnckSDewZ+Lx4g==
X-Google-Smtp-Source: AMrXdXt/grH2n5MRDbNKdHXQSS8+fCcmeJO83vmmNoc9rnDw9xk8EdWd9FwXZ56pb8vvwCwf+pWMZQ==
X-Received: by 2002:a17:902:d589:b0:189:7f28:43a7 with SMTP id k9-20020a170902d58900b001897f2843a7mr51655420plh.29.1672369206203;
        Thu, 29 Dec 2022 19:00:06 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b00190fb8f9e0asm13636682plx.249.2022.12.29.19.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 19:00:05 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vipin Sharma <vipinsh@google.com>
Subject: [PATCH v2] scripts/tags.sh: Fix the Kconfig tags generation when using latest ctags
Date:   Fri, 30 Dec 2022 10:56:32 +0800
Message-Id: <20221230025632.1053726-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig language has already been built-in in the latest ctags, so
it would error exit if we try to define it as an user-defined language
via '--langdef=kconfig'. This results that there is no Kconfig tags in
the final tag file. Fix this by skipping the user Kconfig definition for
the latest ctags.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Convert 'KCONFIG_ARGS' into array as suggested by Cristian.

 scripts/tags.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..84775f08260f 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -264,10 +264,12 @@ exuberant()
 	--$CTAGS_EXTRA=+fq --c-kinds=+px --fields=+iaS --langmap=c:+.h \
 	"${regex[@]}"
 
-	setup_regex exuberant kconfig
-	all_kconfigs | xargs $1 -a                              \
-	--langdef=kconfig --language-force=kconfig "${regex[@]}"
-
+	KCONFIG_ARGS=()
+	if ! $1 --list-languages | grep -iq kconfig; then
+		setup_regex exuberant kconfig
+		KCONFIG_ARGS=(--langdef=kconfig --language-force=kconfig "${regex[@]}")
+	fi
+	all_kconfigs | xargs $1 -a "${KCONFIG_ARGS[@]}"
 }
 
 emacs()
-- 
2.38.1

