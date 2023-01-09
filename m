Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808B9661DBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 05:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjAIES6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 23:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbjAIESD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:18:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE9913CC1;
        Sun,  8 Jan 2023 20:07:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso8101355pjf.1;
        Sun, 08 Jan 2023 20:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1dRtWsumo/yVniZwGtVOWOo4PrFdIY0ez+rSdw2HD8=;
        b=iUfNZyOwEehq632FCl896MZKMg0nN3AsdSo60HeSZ+JqQh3Sa3+8jOl41aQg5eDoOQ
         MDqvPlsMCFJqEt0aq3xNELnrN6LbtyBFmjANC6HmV6WAd9q4WTw6yPTI7+Fi/WW7HQCj
         P2xZ7CUQxeIoK9kiul3pequXiovvHalZ0oCnjXK8d+K/KyslSHG/Mozfhkeioj0sBxJX
         AKYsf5Qa+Qsf2cplb9+nbrM0er/ROJXKWXTqvgAF4apHOz0OXFmamyS4YTatD4oRNaoR
         oSy2Lyxo4a2+vwVFkevzyB5pO72IamnZ7VhmSHe0DfSzacESEzqa+mTfmaq+fTkcbT7y
         n71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1dRtWsumo/yVniZwGtVOWOo4PrFdIY0ez+rSdw2HD8=;
        b=bq88U5Kn85HDPVgaBiKeFLnsYM2hRhbL68O+rnnUxwTNH7aIVlQbE7jusO6hj7Ny4J
         gNUh/MBjsg3VBJWi/JWlQCh4rCs3hbGUnj3TEwuK6dkl0yh/EVfv7lBfl96+InSBuiRX
         8MIBgQ7wTPvKlgnmxO+6OLbuQWVyUB50O5uiN+gHNNp57k6PLD3xqjLnmLDoAyXEcntG
         E8eSYoiUfQ/lCi4ec1XKTPmSzH50nn9J4sSRbdA2AnC+d5mEetkgXQgW/2zhxweuN4wC
         qnrE1Gg5pccegjXrHomZg7SWaMpz4rC7D6S2Xtkiaqte0s+JSypSlDATHKIGRVtj/WlP
         WLOg==
X-Gm-Message-State: AFqh2ko3PcQEIYnvJWy3DqVo6s4zoq0jCdDZsretfUuXpVywyocHVdqg
        DFksjxQNXpqvq7cz5+zcQEY=
X-Google-Smtp-Source: AMrXdXsyOP4Gl93J29wG/ZzoBme32MPsPyDGIGkstuQv4DR4EfVQxywOVj4Untbm1+rmaVeVNuNaag==
X-Received: by 2002:a17:902:d305:b0:192:b2b5:f6b9 with SMTP id b5-20020a170902d30500b00192b2b5f6b9mr34628233plc.50.1673237202791;
        Sun, 08 Jan 2023 20:06:42 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b0018b025d9a40sm4813277plg.256.2023.01.08.20.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 20:06:42 -0800 (PST)
From:   Quanfa Fu <quanfafu@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Quanfa Fu <quanfafu@gmail.com>
Subject: [PATCH v3] tracing/eprobe: no need to check for negative ret value for snprintf
Date:   Mon,  9 Jan 2023 12:06:25 +0800
Message-Id: <20230109040625.3259642-1-quanfafu@gmail.com>
X-Mailer: git-send-email 2.31.1
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

No need to check for negative return value from snprintf() as the
code does not return negative values.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>

-----
V2 -> V3: continue to use snprintf
V1 -> V2: memory allc uses kzalloc and replace snprintf with memcpy
---
 kernel/trace/trace_eprobe.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 352b65e2b910..594ac1d086aa 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -923,17 +923,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
 
 	p = ep->filter_str;
 	for (i = 0; i < argc; i++) {
-		ret = snprintf(p, len, "%s ", argv[i]);
-		if (ret < 0)
-			goto error;
-		if (ret > len) {
-			ret = -E2BIG;
-			goto error;
-		}
+		if (i)
+			ret = snprintf(p, len, " %s", argv[i]);
+		else
+			ret = snprintf(p, len, "%s", argv[i]);
 		p += ret;
 		len -= ret;
 	}
-	p[-1] = '\0';
 
 	/*
 	 * Ensure the filter string can be parsed correctly. Note, this
-- 
2.31.1

