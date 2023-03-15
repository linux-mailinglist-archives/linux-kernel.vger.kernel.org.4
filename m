Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8AD6BB3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCONGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCONGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:06:42 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5116513B;
        Wed, 15 Mar 2023 06:06:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x8so1370024qvr.9;
        Wed, 15 Mar 2023 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678885601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UM1qnMowE0uNdW3tg+Y+I3PTVUNGL++ijHeg4n+VFiM=;
        b=pPfSn2mBEDva7M69BUhVtLmBDeST+/O4Q29knu/PNW+sJe5RCs1yvfkGspJK6dE86U
         vRvxQQvIgvUy4yvsxq9zZ/ntaExi88omHHSahpzH0fjPt6n8i0VGhTKnwRrRsxJuhgSE
         xwvq1O2mbv/LsyspxxVPvcBkzNeor/vWNm8YP0EX4i/uoQAXKkOdUtbkUSOUs38y9PSR
         NjeoYA3UQLKCx4PDXqFOTVcrV7mzhVTpJk8HUKzvsYyXPLoOJMBb2HoZtwK5QgmXw0zA
         3kyzLLYhZgugThJbuJptGvNd3DukNrPKG66QcpCTOfn70NuolqjsEGJdP8/6+c1UIFJ1
         f8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678885601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM1qnMowE0uNdW3tg+Y+I3PTVUNGL++ijHeg4n+VFiM=;
        b=XeJ1gaEAe5xwFRRCd2R4mIMEUb9GR78R8lKZ71vfGbkkXf+3bsC/5WTXyRr9oDX4lI
         RjMVHVFIzCyKW7S/ClpG4EOsdN7EFifCO0XT9+5+ZYtY6HoT/1eYV2Uq0m7sbY3U88F+
         Buu/1GHR/8Sm4lUuDweX1nKz79UGnSFpQVdQLTztdYAUsJlQCcmz7rdHCMGOsUMENuVR
         2xs5vpkibdCWWl79X1x5jRxIpJt2ulu8DBC2PMikG0/lP/MePU+2WXCRN7t91bq7UCnl
         YrRqU0YIjcuWyt+fl0gTgDY/XZXURZrffWe+9wgTPLuNmCC94zmEgM51ERKSiZfw///X
         9PhQ==
X-Gm-Message-State: AO0yUKWoscVXTvhAGNTwJUMItV8/Mq5u7PTjdmvPpxyHXRIEnH9u8wbZ
        +hPd8yqlg9QB7Px1Rho/6T4=
X-Google-Smtp-Source: AK7set8rpLIoSCTSclVq/8eckZS9Wl0geE+ggIaj2629elqH/e2ZSsU5kbrkV+oI5z0akeMgfzUJTA==
X-Received: by 2002:a05:622a:387:b0:3bf:c29b:678b with SMTP id j7-20020a05622a038700b003bfc29b678bmr33702278qtx.50.1678885601229;
        Wed, 15 Mar 2023 06:06:41 -0700 (PDT)
Received: from Slackware.localdomain ([191.96.227.151])
        by smtp.gmail.com with ESMTPSA id q2-20020ac84102000000b003b691385327sm3758652qtl.6.2023.03.15.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:06:40 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     masahiroy@kernel.org, nicolas@fjasle.eu
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Kbuild: Elevate sha1sum to sha256sum for atomic headers check
Date:   Wed, 15 Mar 2023 18:35:18 +0530
Message-Id: <20230315130518.4496-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thought it would be a good idea to use a elevated mechanism i.e sha256sum

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Kbuild | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Kbuild b/Kbuild
index 464b34a08f51..b74040346d76 100644
--- a/Kbuild
+++ b/Kbuild
@@ -45,14 +45,14 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file)

 # Check the manual modification of atomic headers

-quiet_cmd_check_sha1 = CHKSHA1 $<
-      cmd_check_sha1 = \
-	if ! command -v sha1sum >/dev/null; then \
-		echo "warning: cannot check the header due to sha1sum missing"; \
+quiet_cmd_check_sha256 = CHKSHA256 $<
+      cmd_check_sha256 = \
+	if ! command -v sha256sum >/dev/null; then \
+		echo "warning: cannot check the header due to sha256sum missing"; \
 		exit 0; \
 	fi; \
 	if [ "$$(sed -n '$$s:// ::p' $<)" != \
-	     "$$(sed '$$d' $< | sha1sum | sed 's/ .*//')" ]; then \
+	     "$$(sed '$$d' $< | sha256sum | sed 's/ .*//')" ]; then \
 		echo "error: $< has been modified." >&2; \
 		exit 1; \
 	fi; \
--
2.39.2

