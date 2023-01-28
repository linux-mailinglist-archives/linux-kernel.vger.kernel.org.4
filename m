Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E53467F559
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 07:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjA1GzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 01:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjA1GzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 01:55:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA3B4681
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:55:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso10727261pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdTZykaJlINycbsfRMw850k42iDCS4wzNnw6eR157Ys=;
        b=UdrXettAE/3mFQKqjJcrvcIbitPAITwO0C6FjnRi2ayJwgA3laNzrI/vfVwjAA2JkZ
         hfXbeGUhO331jsCHDYF4Y93a3VYsVh4NflsCpT66b3Itq83AIr6HYf9MYEK+4aXVe8Iy
         /R0NviKPNxftCygyvbhJiO1TWUX7acj7Qr5htfEfn6ncxEP3nQ3h3pDamgUQkfAKu7N4
         YluDIremy8Y2/qzyprH6XB2tFHtx1g5TG6UMbMS670/0OLaQb0hdDoYl2ljZlnnZZban
         sIwWNcbOLwof6Pe2hTbV6chcBvFhNKEQBvXAvmJdTl8a2rEZ7zNeWeK2qouZj1XvVFZR
         iwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdTZykaJlINycbsfRMw850k42iDCS4wzNnw6eR157Ys=;
        b=rjVSUVzqK6Yrj0UGY6ehnKwYnnAx8NnyQsZAnD3b3DG2+DIIYni07bkc5siL3J66kB
         8NPd9QuwSu2DHSNbD3cRSc2UU/AOUXEe438aZCmunqh0o2tAToC6fOShbFj/ZWTEvCh+
         t5oJmeGvL1ulHE/xDA+lPiN2u7bWQf8h4hnM/wzCjWnWSpuERoLFNcJLOsZQpPTMldAi
         u2PmS2Uk+FlaLAPtRrdlEA65Zq9mNH+fKtAKvEz8pvJm2qaEzgNZe6hF0QahqJefYNlA
         jztzAC0XWp4kMPsJzNIAETahPrhnHXCUKJFLggWov9kv1FsSBm+d6TfZRUW7DxScZYre
         +7Xg==
X-Gm-Message-State: AFqh2kopGRIFJPKJMq0JoZUBIKLgMkVJIpaeVIre377V6strrWtEdzhC
        xidOqdGJI+/50cHGf/C3G3aB2yH8hbA=
X-Google-Smtp-Source: AMrXdXu35pmfDJ2VDIrt20ilvmLcTw1J9bvp0TgYaOCwxX6fVd/y/Prt9Jyd2MistYyRzcL0668G9g==
X-Received: by 2002:a17:902:ba85:b0:194:828d:62b0 with SMTP id k5-20020a170902ba8500b00194828d62b0mr32169801pls.48.1674888900128;
        Fri, 27 Jan 2023 22:55:00 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e5d100b001754fa42065sm3878848plf.143.2023.01.27.22.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 22:54:59 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Vipin Sharma <vipinsh@google.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3] scripts/tags.sh: Fix the Kconfig tags generation when using latest ctags
Date:   Sat, 28 Jan 2023 14:49:16 +0800
Message-Id: <20230128064916.912744-1-haokexin@gmail.com>
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
Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
v3: Add Reviewed-by from Cristian.

Hi Andrew,

The scripts/get_maintainer.pl can't tell me who own scripts/tags.sh, and
the v2 [1] has dangled in the list for almost one month without further
comment. So I am wondering if you could pick up this patch.

[1] https://lore.kernel.org/all/20221230025632.1053726-1-haokexin@gmail.com/

 scripts/tags.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 14d0209893e9..da4d404cd1f0 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -271,10 +271,12 @@ exuberant()
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

