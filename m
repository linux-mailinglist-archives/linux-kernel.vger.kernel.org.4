Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B1F72D675
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbjFMAeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFMAeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:34:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B1D13E;
        Mon, 12 Jun 2023 17:34:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77b210292c5so32400339f.1;
        Mon, 12 Jun 2023 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686616447; x=1689208447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZyJW6d4bROLzUBlQENsOphZCVnHp3HjRNgKHqO3CTA=;
        b=plyiZsTwLOCz5jJaWXoCQyBlO8UjThua51T0gwTk++Yy3YxMemPc9mBETyZL3KnoN5
         ZtH7AYEQMHXhnxfxoAFdXlNGNfocRpOPZ0VJ7ksSDEJlfO/u1eAfNtgaT/woLXeXukf4
         b1x541aR9H/w8R8wFxlWsscgmXNwYO/yo7+bxL1GnVla4Aw5HLLeYFZZBAwmTY3hqyR2
         BZRf7PTHpa+Sc2uydd0YRAgsuTK9WX+GxPeS9gwP9jfpPKKPjJo58vFG1zWge6Yw6luX
         sszMnumkqYDq7ED9Zhb0/RRVy4nXpBgKKDTPjjMgaoGQwebk4HHpuqLXC4J4EFJjNERA
         IxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686616447; x=1689208447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZyJW6d4bROLzUBlQENsOphZCVnHp3HjRNgKHqO3CTA=;
        b=U1ghphAO/KDjdWL9V/2r++ZzX0KuARUz6Y+9NvbdKUPUEmg6WjPtHS44Er6mnnlFAH
         zcFzE2ARwq+EqCasIceWpV0cZygoHXvIHBJIbJcW/nFH6jgGrVNgj+Etv0U/DMbGHFRp
         9RIa9ooC/hOjudHBZc9Q7HRuMiglmVUjni8fAVOM6JY7jEPEqH1lIDSaOFU+8iKJUHTL
         S8rYZ5K9l8Ggsz/tsr3QHJknT8Jf8EDfOPi826aj+addOsJR+T9KBg31bhgGI407qIUL
         SKdkVIUDO9ISBizXC0rieSxxaKBp+cN+70ajc7MpbQMGnAu5tQ+wLtx6CCQAHb2Le9yh
         liMA==
X-Gm-Message-State: AC+VfDzUMXJCmUAjVRCAL4Bbjj3jZ3cZhEMcCzZWf6L6AtWACYhGAwR0
        XKD+on2RFF4AicW0vmm9YZw=
X-Google-Smtp-Source: ACHHUZ5nWGpcSmeIrHIFjUJkjgZR4nOixtAXzLoekNMP0wOxE0qS/8tnIAMblPmXtXFL1R9IhTaEGA==
X-Received: by 2002:a5e:c64d:0:b0:777:b464:6ff9 with SMTP id s13-20020a5ec64d000000b00777b4646ff9mr8858679ioo.21.1686616447193;
        Mon, 12 Jun 2023 17:34:07 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id h14-20020a0566380f0e00b0041cea93e589sm3049909jas.152.2023.06.12.17.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 17:34:06 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] mac80211: Replace strlcpy with strscpy
Date:   Tue, 13 Jun 2023 00:34:04 +0000
Message-ID: <20230613003404.3538524-1-azeemshaikh38@gmail.com>
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

Direct replacement is safe here since LOCAL_ASSIGN is only used by
TRACE macros and the return values are ignored.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 net/mac80211/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index db0d0132c58c..c51c6e3feac9 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -17,7 +17,7 @@
 
 #define MAXNAME		32
 #define LOCAL_ENTRY	__array(char, wiphy_name, 32)
-#define LOCAL_ASSIGN	strlcpy(__entry->wiphy_name, wiphy_name(local->hw.wiphy), MAXNAME)
+#define LOCAL_ASSIGN	strscpy(__entry->wiphy_name, wiphy_name(local->hw.wiphy), MAXNAME)
 #define LOCAL_PR_FMT	"%s"
 #define LOCAL_PR_ARG	__entry->wiphy_name
 
-- 
2.41.0.162.gfafddb0af9-goog


