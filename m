Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A063730057
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbjFNNq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbjFNNq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:46:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5545D2118;
        Wed, 14 Jun 2023 06:46:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-777a78739ccso374236139f.3;
        Wed, 14 Jun 2023 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686750367; x=1689342367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQY5/Z9V92asgUBqQZpuZOlLV7pXFKrCuP0E34yfs0w=;
        b=V4ahN5BL99HDOMgXDQGo0/tyx6nm9sWOfshsWhVthyRTSNZrfjK4M658jtS2RiHGus
         pIZSdvbKF8hDIHAI2cKQYbUM/Fav7dOixRf6F65xHPWd9B/egU92Qve8NHblaGLxlgLN
         7RxtK3F9/R2+uvf66wGBHpfzUTTESC3mj0Yhm5stSPgYhoiMSxm0NTEwruyezQ56xjWV
         EThigOax2hhtA8OzSNU3F/oZ0kcj1n+7IbNsqo+yTz2zC3kxO3jHegCSSI6T1fVF9U4M
         5bwzbHJI+45CBp+cNesnSPfEjWwKoFuhIY1S2CMD3SF45btXTAkAgwPkH5rQcMDHRQd0
         Y4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750367; x=1689342367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQY5/Z9V92asgUBqQZpuZOlLV7pXFKrCuP0E34yfs0w=;
        b=hclyDKQE4yKXQH4SgOpZUMegqhY/r4WfKd+hCevgUfAulp3SwKAxSwW63rcCXdv3E2
         9GhpSgiRsjSwRtgujv+RUmLNEq0fzj6xNE20Z9xKDIO6EnMOk9LnvRGg8eC2ezzacAA+
         ks2PRFsIOfpjsGEEisFw97uzk6NKfVu8SdPJi8mc+8w6ZPqAf3pbQsoG3xoOmnNeAnup
         NXmZQ6bmsVQ4BbkzfFF5PJgvr4cdPLyWhM9dLAIRzmAX7tAJZiO1iW4YiGABeF8D5UDN
         Z3X4u1mqmKy/D3LuYc5mIH893jH6Ov6o84gs+Zm4Frnp61sgzvvtl4lpwMG0A0ZPkZWD
         kSYg==
X-Gm-Message-State: AC+VfDxsXJhZXutqtqeCEwIcnDh8MxhmYY1rtQaC5uNcGCe6Gm/x7nH6
        WsCPOA7KgLn8HPhMIfMbQf8=
X-Google-Smtp-Source: ACHHUZ6jTKwwclu9yoql3y/RRuy36VHdIgQDbVqS33PxEzmA14MKgVLgpgLm9ZC+sGbXkm4sxDv11w==
X-Received: by 2002:a05:6e02:108:b0:33f:a995:31ab with SMTP id t8-20020a056e02010800b0033fa99531abmr13648127ilm.11.1686750366930;
        Wed, 14 Jun 2023 06:46:06 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id cu13-20020a05663848cd00b0040bb600eb81sm5021586jab.149.2023.06.14.06.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:46:06 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] wifi: cfg80211: replace strlcpy() with strlscpy()
Date:   Wed, 14 Jun 2023 13:45:52 +0000
Message-ID: <20230614134552.2108471-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since WIPHY_ASSIGN is only used by
TRACE macros and the return values are ignored.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v1: https://lore.kernel.org/all/20230612232301.2572316-1-azeemshaikh38@gmail.com/

Changes from v1 - updated patch title.

 net/wireless/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 716a1fa70069..a00da3ebfed5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -22,7 +22,7 @@
 
 #define MAXNAME		32
 #define WIPHY_ENTRY	__array(char, wiphy_name, 32)
-#define WIPHY_ASSIGN	strlcpy(__entry->wiphy_name, wiphy_name(wiphy), MAXNAME)
+#define WIPHY_ASSIGN	strscpy(__entry->wiphy_name, wiphy_name(wiphy), MAXNAME)
 #define WIPHY_PR_FMT	"%s"
 #define WIPHY_PR_ARG	__entry->wiphy_name
 
-- 
2.41.0.162.gfafddb0af9-goog


