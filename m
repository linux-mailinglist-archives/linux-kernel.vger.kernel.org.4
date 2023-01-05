Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8E65F68E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjAEWPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjAEWPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:15:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739AE67BF9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:15:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so3557005pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gsh4Qgz0dAZX19NkyGAdNILAtOkB8coB2LmFm1qOWdc=;
        b=oV/ftWoXv3dRTiE6dX1WBD6eNfMMqiCELaUuBnjdijiIdoiYax+ur+M02gXCd6s4yk
         6tTWQm2p6KjtpIjdMLUnJeDQNOG5cCb9JMVL/n0ZN/4qyOnnNXvLlqNIF7OsexeBaFfk
         Qb9sVm1R4H9FDfZGo3RVLTklAb49inuJOUdiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsh4Qgz0dAZX19NkyGAdNILAtOkB8coB2LmFm1qOWdc=;
        b=1K64qfutfMVzzHR8Xmuu8Lk7F1tVAgsw7JeINvQFhh9zuCO3vjqOGHMiEJ/a7EGQyk
         rjPgC3qv6MXucBpY3GTJZ40nbsun3do4kJcRgLK1fJjlsXU1ZjXzuFza51c6idTc7nQC
         fN/KvMGz2dXa/VaId3rm4gF8bmdnx5eQQtyLLCWoZXWR6vYNw636q3dA7TjYBo29FU8G
         q1oFeletfzkmYFM8GXTNEHSCLnskffLCm7A0XSOs+NhFBQEByBz26oVoEKpGph2/Ni3i
         DhLc5aVb1U2iTcNmg8D5y9wIOc7YNE/1cQFh6iEsegI/6fqV/PvcAyitQzf5vwhfkSlY
         CwGQ==
X-Gm-Message-State: AFqh2kpGj7KmfUpSOObWX956q6Crz05P4jkJDYuXwFylDesJ+ftEYdYX
        H9dm+pGkYA1PAMjIbBG9tOSlCQ==
X-Google-Smtp-Source: AMrXdXux4oWjJWim2VKtmkR/9QYi8fOUmvxp7vlXY4l+TZt19eWfsPAKmaCwaszvHrEZr4tLotPtMw==
X-Received: by 2002:a17:902:a5c1:b0:189:62fd:140e with SMTP id t1-20020a170902a5c100b0018962fd140emr53604813plq.29.1672956942951;
        Thu, 05 Jan 2023 14:15:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j9-20020a170902758900b00189c9f7fac1sm26604098pll.62.2023.01.05.14.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:15:42 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] net: ipv6: rpl_iptunnel: Replace 0-length arrays with flexible arrays
Date:   Thu,  5 Jan 2023 14:15:37 -0800
Message-Id: <20230105221533.never.711-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2310; h=from:subject:message-id; bh=3B/MOywRgENsLrzur8E2ezmoeoBZ65hD9wrNoefThRA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt0wI3l8J5ra3VVkkOUG6RTpzyYkw1RR7xoKFAzYa p0Tz86CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7dMCAAKCRCJcvTf3G3AJtwIEA CYkkz4J2J4QmdXbnf9Fo8pZkJLgIDDofSjQQ9NE1J99qMUqlm8WGrBlWXyM4o7ODi57/x0BtIE4fO9 HPrHoYVhIEGkJjAGu+cbZ8PgBGUiV5mEUMtE57mKb8MeK7ZsX9AW7ylG6p9rpVDUtWsZA8fl2Jv8XU SVi5k2/nJC0db2Te/FC7E2y5kL1eFElzP5ehag7rghhrE6U+wNcddOFyBSEsJNota3Nj77SdndPNyP dWB5P06hMy4m/b7yeL99T4fhVhLrV2COVyPmUkHZMnTqY0p86u6DFIhNQEDxkolFDRW6wzZm9ywEgT TosmoI0UEAZrMZ+SopFduZvo4rqIg7tXjzqtBcrcb0Rre1Kv+wVaFEJePRGOJThiXbTfJvx7fyULp8 qwqedHcengFduTM4ue5yNPgDJy7Qh7Sm+AhPlffpeyoyB1regG53jgHNKYvjN65/ddW/W1DVrxPPWP woTJ2ETuPrUCF7qf24ZOSl4T71Fuf0tFmUuaelJWUuXd3b7+0BoxPvCQyF4zS5awcaTt91NdV/U8Qf bDR4RH/3QxYveZKZGFqj9cq1+G/vuNb+9I2Qv4ooIIcL3HTmN56jCZ+t2rbx528HNBF8Tmu/jhMdmR kYdbWVz4h9hYNEAFf0RfvSmdObGWQe6DolgRLrFvUvkpTBYwhhT82rDt1G/A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct ipv6_rpl_sr_hdr's
"segments" union of 0-length arrays with flexible arrays. Detected with
GCC 13, using -fstrict-flex-arrays=3:

In function 'rpl_validate_srh',
    inlined from 'rpl_build_state' at ../net/ipv6/rpl_iptunnel.c:96:7:
../net/ipv6/rpl_iptunnel.c:60:28: warning: array subscript <unknown> is outside array bounds of 'struct in6_addr[0]' [-Warray-bounds=]
   60 |         if (ipv6_addr_type(&srh->rpl_segaddr[srh->segments_left - 1]) &
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../include/net/rpl.h:12,
                 from ../net/ipv6/rpl_iptunnel.c:13:
../include/uapi/linux/rpl.h: In function 'rpl_build_state':
../include/uapi/linux/rpl.h:40:33: note: while referencing 'addr'
   40 |                 struct in6_addr addr[0];
      |                                 ^~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/rpl.h | 4 ++--
 net/ipv6/rpl_iptunnel.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/rpl.h b/include/uapi/linux/rpl.h
index 708adddf9f13..7c8970e5b84b 100644
--- a/include/uapi/linux/rpl.h
+++ b/include/uapi/linux/rpl.h
@@ -37,8 +37,8 @@ struct ipv6_rpl_sr_hdr {
 #endif
 
 	union {
-		struct in6_addr addr[0];
-		__u8 data[0];
+		__DECLARE_FLEX_ARRAY(struct in6_addr, addr);
+		__DECLARE_FLEX_ARRAY(__u8, data);
 	} segments;
 } __attribute__((packed));
 
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index ff691d9f4a04..b1c028df686e 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -13,7 +13,7 @@
 #include <net/rpl.h>
 
 struct rpl_iptunnel_encap {
-	struct ipv6_rpl_sr_hdr srh[0];
+	DECLARE_FLEX_ARRAY(struct ipv6_rpl_sr_hdr, srh);
 };
 
 struct rpl_lwt {
-- 
2.34.1

