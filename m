Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4B662ECD3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 05:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiKREWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 23:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240937AbiKREV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 23:21:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5B87A66
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:21:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g10so3518566plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qim7psr6z8bosgDJRr3cI7ZwHqx7o7Lgluf38w3Bl4=;
        b=WlsCnLzG79oJ51eFf09JHlJ6OHsOGT1QogLgLYTheoyY0iENw3r9UFMm3TSNBbCPRM
         icLoL//EVewsNrFWqgPxtcp5xSiWRr0yRIDDy26i6TPG1Eg1/WlqvEp32x+dZKai5yDG
         tGa8NcYhogrQqZ+mUBIYDV3qHmv7oiDBZLmg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Qim7psr6z8bosgDJRr3cI7ZwHqx7o7Lgluf38w3Bl4=;
        b=G86BFizOkdoeuziubiYCetbrFHwEx4Q6D5s4h6CCNfDEyGxnx1o56qaLvDmqzjpdnI
         mpSIGoOcc9x4asNM51ZkLfXXx+7MIIZzMMJbKA/gM+vPgTMo579fbvGt32R5HxkTlCtU
         tpKFVyaT5aPmICKANWdRJZz7C3+ICoat9Wb7Mp9+EA9DFRUPxlxh4BZJ/e6ScQD6whPh
         QWXJu1W771uNVHeElG/ub9TECetsDVjgSJqapJc4F2qAApLOwBjRfmIjARD0lnkja8Jq
         qWPeVrgnKY0kug09npuFA9WZtnJttxvMsJ065zOhuuL1urNH3nhZLxiyOSzoTcWAXLQ7
         rebg==
X-Gm-Message-State: ANoB5pnmaOaJ5Icjds1p4/D/8sHEidBkMoLbmY4tG6o3s7I5gI0hHwwB
        TdGZhi0DTXBdxJoSEyDev/n+Av1fWN8gCQ==
X-Google-Smtp-Source: AA0mqf7hHKPx+Uh781MQFlo9oPO4uTiCz8D7w3ry5eEW6RDV4JVGveojjjUVH5mLrbAVw5yDrvYRoQ==
X-Received: by 2002:a17:902:f08a:b0:176:a6fb:801a with SMTP id p10-20020a170902f08a00b00176a6fb801amr5833696pla.97.1668745315609;
        Thu, 17 Nov 2022 20:21:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b00168dadc7354sm2355047pln.78.2022.11.17.20.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:21:55 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ipv4/fib: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Date:   Thu, 17 Nov 2022 20:21:52 -0800
Message-Id: <20221118042142.never.400-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; h=from:subject:message-id; bh=fFZ7BsSh6I+lvLxvLX9AR5VAcfq0y3IDjOCczrsHj6E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdwhgXbx04oa27BZVboxhNu5hfZbzkLHTbQj10nRn 0wq7qU6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3cIYAAKCRCJcvTf3G3AJoFED/ 0dF3JkzVUseze5YyF+MX7fMxnfUfNmFHOo6CclirkpyXjw6vhQOeNAQFumERISpJ+kxvRpBTP1kE1M MgaIdDuFcFA0VBGcS+8bgRDbagW1SAzRPLFSb7JGm8IYeKyBLi4CRfoX/qLrz6+rrrqGOZuhRaEwpd o8oZFEAFw1s1DNvHpLn0BhAf6ulpdqnbNfiqVXAjjlRZRTNIDEqMe4Upa8Z+Ywj+DDtF8qhLgyMik4 7fuMGR0fpS5jURfwxsqztTlwWEzw5d32j5BxobQ2uzVn6GPiiQFK245kMdFvnYcgohce6poXTIOnYE +TO+b4FODBFRCWouG54VGIvLNRccM27ntQ9tWRPnj6xAI0Vk7Be0gn7k0X5hcmJhGSpeY6Rg4szr7x /c9udCAjOSK4XrsbGFA3Ubtc5Txg3CagE7mr1rTTROCrOawwUz4s2tHalljy8roYLQa4fYGP4WLsUP 00nrEI8zpHsncjIZn7piaGNzmpp6V5/NOtBDKsFFinbDksbwRQzHZlETsH5WzhvPOVC+AsCUBSGuCk XVCqGFPYOcAbGx/srr90xRHOv1O7m4RoN6n2zePZFy0fHt7o5uPLs96sNwrqvppu9vt2xn/5p+dI2U esu+A6exiTLxMuKOw+Bbtx4qZyvesZvP0Xo7JVm33DuQiQpkxXltsFG+Otkw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace zero-length array with flexible-array member in struct key_vector.

This results in no differences in binary output.

[1] https://github.com/KSPP/linux/issues/78

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/ipv4/fib_trie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 452ff177e4da..c88bf856c443 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -126,7 +126,7 @@ struct key_vector {
 		/* This list pointer if valid if (pos | bits) == 0 (LEAF) */
 		struct hlist_head leaf;
 		/* This array is valid if (pos | bits) > 0 (TNODE) */
-		struct key_vector __rcu *tnode[0];
+		DECLARE_FLEX_ARRAY(struct key_vector __rcu *, tnode);
 	};
 };
 
-- 
2.34.1

