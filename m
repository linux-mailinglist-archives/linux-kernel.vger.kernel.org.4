Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1530472D4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjFLXXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFLXXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:23:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB93E6B;
        Mon, 12 Jun 2023 16:23:18 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77af28802c7so91892339f.1;
        Mon, 12 Jun 2023 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686612198; x=1689204198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxVyUY0dadSws9d1S/zE7Uf1J0Kd9LG7pWJtcUQbE5U=;
        b=l7zrUKkhBHjs07Y20WY28bXIbFYRxRmVByeXNT1FoOAcaH2hF87Pmye9lTtnd1LCXQ
         vr8F6/xf4hgNG99WU8q1wSdDTpDJh1Itk/A0xCvtdo8tsAa9Pz6TAaSn8Eg30j3r6nzP
         OgjaQfQ8KRP9kNlQuehcIgCAiWSjBOzcg+IYHJN7/El1Za01CG4b/I7GoURkuoziMVNY
         BtdNw41jZeew+f1JZt60uEHet+SlSQcfqVfTfTF4uQRwRsJI6ZAU7UW2ICTT1V+1yYKy
         YuHlMRZd+UHSP5xpgssX2rW0QAuQJzCOptjrlRpGjoPRyWlkvE3bvSY8lvFyIvE6ebNQ
         KTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686612198; x=1689204198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxVyUY0dadSws9d1S/zE7Uf1J0Kd9LG7pWJtcUQbE5U=;
        b=SZ3mijSlYLaALP0xloE3g9FQ2mQxl3XsHpaJzH4eXAV2q4CGJqWxhi+f1e0eOOfL1+
         2p+J1pvDjmAZC7EmFDUKdajb3V6lRhggwYFYdjZt1FxwEFAVgR/8iL2HlJOICciZC12G
         aIh8GnS7XqB0/RiSJifcpLgiZEMNTJiEGv38gzQ0pa+33Ow7ykseXM16wRNgW/zu9IUS
         edXRgDK9RV34XizjDGo6GEAopa/ovsWEJQ1E7Z9Jplx17ZjrDBuaxl8iKmsjDDboMpHH
         jkHlMmBTyBtauRsb6YWnXCPLE1HeiRr2Eg5HOSLIkchqrvULPsprwyk+3R9UDc/7Z5CI
         ZdAQ==
X-Gm-Message-State: AC+VfDx1uG1cqjNN0CSbNO7Iz/Cc63F7wDG2WeOieTbQC5FK9mpMnTuJ
        ULw51EvzXjypNrJll6kJ8Yg=
X-Google-Smtp-Source: ACHHUZ78gkSUJOE5H6qbc7XJeTrq7lUqGE/Oj6psX6SiVlRtTaSfcOciouo6J+BQ8MOrQ1OKichmxA==
X-Received: by 2002:a6b:7614:0:b0:777:91d5:c198 with SMTP id g20-20020a6b7614000000b0077791d5c198mr8178574iom.15.1686612198179;
        Mon, 12 Jun 2023 16:23:18 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id t8-20020a05663801e800b0041f4d47722csm3099563jaq.126.2023.06.12.16.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:23:17 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] cfg80211: cfg80211: strlcpy withreturn
Date:   Mon, 12 Jun 2023 23:23:01 +0000
Message-ID: <20230612232301.2572316-1-azeemshaikh38@gmail.com>
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


