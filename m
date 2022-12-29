Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCBE658995
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiL2F5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2F5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:57:43 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA312AD0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:57:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jl4so11761209plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/2uGQiOTz8I/VL2rJM81aDU4kLl+aAubzlAUzKvxzk=;
        b=V4CwmIbY7uLPe3BxfH497WsqqnRE56e7HY6Mki9NWmM9Ck04f2IfQY4amhe89dFO72
         VPCWnva3V+A6CyM3fUWlelwjxDeeSkjWnI2cjuiLu1mCouu1d8RgtJU0796CSVArsrvA
         w3vdpk578o4OQ386JeX+DpTFJWfLpmEXsGMEQfHGfKz5YU85hJ3Mc3gERXFuprXpOStG
         C3nmldiMxZLMCRO1e3WNGT9JL3Yf91V8ma756+vO5dGJ90gKX+ON0kAF+4tAeglw1Bbi
         /f1K6+wfOvFlujRWNonrnXilANA5zHx2i8Te9cKoFqsaZXS4Ki7NuDc3kYNgZsiN3/iC
         91vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/2uGQiOTz8I/VL2rJM81aDU4kLl+aAubzlAUzKvxzk=;
        b=lCOr2W3Qd7RH34ErfGxbC6o3ilqsTWs0alHFVoHY/IW7pSfbUnpot9Q4uJRfKadzZe
         9HcFIJMQsxqjJvBwbQtWzBzYw3hyPUScmGTTLdMCh6z27s1tlzZmlialDO3SNYlZFdil
         eVZEZlTtX/ezu2TVTAyB2uzlRiR88rGQyBBtgavXEbwDRkzpwF3pYpvv66NNWZOWY24D
         4YS/bWwH9O15YrZBct6EnwfxU78E2yxxhFDti3FSw3EWUy3y/66MvyoNL5L0gIC1KNtI
         d0bN9/Oq2Gga1BfcWskQs0YIiWT+ErIpOlUgU86U51/PlDkO3kPNcNnAIKNM7tRZINGR
         7JCg==
X-Gm-Message-State: AFqh2kr2hv/zqKZabFg77KRowrXqPJmN7kYngmT7GbB7LiM0NDrG1DmC
        JjXtwccjo2Rr+LJxVF7zzzuY2e1AEZk=
X-Google-Smtp-Source: AMrXdXvl92pxOFydJajxwkVB8vRXvV3Le0jKvF/8insp4lUzPqY2Z7OlWPHn8VABpeAJRJ8BGkui9g==
X-Received: by 2002:a05:6a20:4655:b0:aa:23f9:7314 with SMTP id eb21-20020a056a20465500b000aa23f97314mr28569919pzb.46.1672293460927;
        Wed, 28 Dec 2022 21:57:40 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e1c900b001927ebc40e2sm6440275pla.193.2022.12.28.21.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 21:57:40 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: [PATCH] scripts/tags.sh: Fix the Kconfig tags generation when using latest ctags
Date:   Thu, 29 Dec 2022 13:54:01 +0800
Message-Id: <20221229055401.855185-1-haokexin@gmail.com>
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
 scripts/tags.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index e137cf15aae9..c56b13ae3fdf 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -264,10 +264,12 @@ exuberant()
 	--$CTAGS_EXTRA=+fq --c-kinds=+px --fields=+iaS --langmap=c:+.h \
 	"${regex[@]}"
 
-	setup_regex exuberant kconfig
-	all_kconfigs | xargs $1 -a                              \
-	--langdef=kconfig --language-force=kconfig "${regex[@]}"
-
+	KCONFIG_ARGS=""
+	if ! $1 --list-languages | grep -iq kconfig; then
+		setup_regex exuberant kconfig
+		KCONFIG_ARGS="--langdef=kconfig --language-force=kconfig ${regex[@]}"
+	fi
+	all_kconfigs | xargs $1 -a $KCONFIG_ARGS
 }
 
 emacs()
-- 
2.38.1

