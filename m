Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1435EB7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiI0C3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiI0C31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:29:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C4AB4D8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:29:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so8773217pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HkG5DDzOTjCT+STCoSnaLb6sU8To/yLBmMx+e5BAYr4=;
        b=l30XfCY9tFyykLEHQUXZXzs+C9ThZtl5dRyE1N5osCy57G9qi8PsyotFwEV7Q3EpO2
         a6oez/kXWoVi5on7ipYsOIBKZxqjG0mmF4eIxwBHSY2x6K1EnWWhYzUUvn07s+M5UF0z
         iXXvL2W2m/QO1oq7pvuZqG7TLR2CA1/KoFpTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HkG5DDzOTjCT+STCoSnaLb6sU8To/yLBmMx+e5BAYr4=;
        b=alsk6jbcltNtY7YBCIGvgKVn69p4bTcnhtY7dyeu1OJNupoBB1UJiix2X4c1gnlDlg
         wJdlQgva03hA9Dc0vbNN05XPaI6mnQFVkE1odng+UIFIHh390Zqs6YpN+gJqcveP2xoe
         HffceLt6wlERZDMRDWK+l753/HhOHSEsa4DydP8apreas6flOf6SsuACL8mBaL2TQkyM
         Bbwbf7/QSqY8yB8K3eah9glpa5drIiUscpnn1NXgXnV9aBLif8xkd3DNorg58Q+OdQiC
         t0nWcjrMw4WzNs5FsNZqqSZkBizwVgkb379gAYe/21QUOoobMahjtmL5YxtC+VaO683R
         //vg==
X-Gm-Message-State: ACrzQf0j0Kd/hIBseT7VmBf55aad39IBVePLhQb8Cyd5TZ9H8QWMFAuK
        YhZvllQ1+k/dkFTn+PGlc6DO5w==
X-Google-Smtp-Source: AMsMyM4xJPjTZPujx7xMCWGZbF9BnM9hvgko7haE0v+9a5Wrvi1kCxrMKe0GWEcmA3LQ2oAq7dwnbg==
X-Received: by 2002:a17:902:db12:b0:178:1f91:74e6 with SMTP id m18-20020a170902db1200b001781f9174e6mr25393937plx.100.1664245765635;
        Mon, 26 Sep 2022 19:29:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a3b0e00b002009db534d1sm162794pjc.24.2022.09.26.19.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:29:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] wifi: nl80211: Split memcpy() of struct nl80211_wowlan_tcp_data_token flexible array
Date:   Mon, 26 Sep 2022 19:29:23 -0700
Message-Id: <20220927022923.1956205-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; h=from:subject; bh=JH3nHmX97RrKwbrYnh+CkGDW8T/FyqjEp+7uXQKUIY4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjMmACR0B3zP+7TGPHd2I2yN+GXV+Fdp/seF7yyoWT qNxfGkWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzJgAgAKCRCJcvTf3G3AJosfD/ wP7GvxgVeGTAOiAl1tDUS/8VQ+Pc/tLzsp1DqjvxHY6zV598jUyMDm5eLmvfl55V6W72r2t8PnoOTX X/q6VLlK0tJI8ryPD6wTLPjAIzQhxailq94i0IRNnm8bGbt7Ykq9T385zTbORgRPjSe5fnXksldmfM fJNPhqduy6yAXz/4juijaEZ+tpuZkEgGQzNafIAz30SyqLme/0gQqH9LedN11YWtJOFoomEeD+oWz+ obu86NOHsaKxUXEIv3F1wEe5tXvEpcsHxMq6xFOnp02r3SkgwcF1ypEld0gBgtU52S0ym2hPjm1SsY 2YA2P6wEqQcBkrgr/N4dAiMBpy3CXXjZ16WQUETA/x9X45IdFAhCKYbHhnMIY2W5/peZKWmNlZ7ulM 2phamcmzOM2FFs/e+cy0ASSarJK3uw6c1ZBk93uOXkOufz8/50J0QmXddKriDvpewAlAbA5AgA3iUp OYh+Fxw4ig9KZYovtkm7URcwcJlzR7rNoclWkSNClRWvlfcGJbB8SY6+aq83tsuiuFZ+CtZxg7Mg43 VNXi3lvRLDSNqMfDN+3EUIu/3g0rB/f8+1mR8xj6dtPMlW5/+ji5uR31yShYyoQoY9f6GQ8bcDF3Qg 2PhaANaBZMU5PDkBync0nlFu960PTrV/e6FTakuOJ4ezc4obRf3xiTyy0ErA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To work around a misbehavior of the compiler's ability to see into
composite flexible array structs (as detailed in the coming memcpy()
hardening series[1]), split the memcpy() of the header and the payload
so no false positive run-time overflow warning will be generated.

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: - fix typo leading "+" (Gustavo)
v1: https://lore.kernel.org/lkml/20220927003903.1941873-1-keescook@chromium.org
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2705e3ee8fc4..169e3ec33466 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13171,7 +13171,9 @@ static int nl80211_parse_wowlan_tcp(struct cfg80211_registered_device *rdev,
 	       wake_mask_size);
 	if (tok) {
 		cfg->tokens_size = tokens_size;
-		memcpy(&cfg->payload_tok, tok, sizeof(*tok) + tokens_size);
+		cfg->payload_tok = *tok;
+		memcpy(cfg->payload_tok.token_stream, tok->token_stream,
+		       tokens_size);
 	}
 
 	trig->tcp = cfg;
-- 
2.34.1

