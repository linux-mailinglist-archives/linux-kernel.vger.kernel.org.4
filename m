Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F2749D05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGFNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjGFNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:08:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D6510F5;
        Thu,  6 Jul 2023 06:08:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b890e2b9b7so2908975ad.3;
        Thu, 06 Jul 2023 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688648901; x=1691240901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=513dHm8kTOIuqgQPIHpSSVm+ip4pXPZmBl8EhEBgnNM=;
        b=lVRUYcxp1q1CO3zXBljcWb5fZEQtOxBlDoQZQPAvV2+QnQHO72aiByKy7Nc9AoYESa
         1m9SkuYqdVzU534GPBL3reNPowlidbTDZieEGjcsc63ogpK/JXjZQX3EVvwI6wB4+d1H
         U53DCTuJWAoyMqDzJUWIwiTFLo38iSRFHf7hhgyD+C7098/BtkxzFxAmF6F6e7gXyNOQ
         yaius+c6dnFKdXpxktGWdeiYByq/7Ig4WvtP7Ip1C1Hg8f8LMeLn/Z/LWNRc4PFdF9y+
         K6R53gDehU/RCUZs3f3yHbevtwtuy53PLEOvaK62qkrCCxOMHnid8+/PXKOqvzN1oH0t
         Rd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648901; x=1691240901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=513dHm8kTOIuqgQPIHpSSVm+ip4pXPZmBl8EhEBgnNM=;
        b=fzAQF+6bIXTYxRa2a3DIflktH67frm7E+JnN7HguybXToOkb8PyoBTxSKJ2p7u+FtN
         PYN52NOGnvpCV9DC4z+0JIGpXdY+mFz3su1xlXPw2R43PKyHXQX+3U+EyEVgUXer1E9e
         kvvQesatS4UN1fhHpbiFixUAWW55aB4RPAzaifnh7WBQgeD0QdPmHxklffMJnIU0WI6p
         0VYvqFokAKFlh0UoA1bFCkMhdNqrEDV6sSA6u0VUw4jM0HUeIHXw5iWOR6jBKCFrEc9f
         oY+X3GtuURoUxyCxZaC2tokSSRL+nfbs6K+7NZRdQK1W5FLM6UYwa5/nIcG7jielG18w
         nWUQ==
X-Gm-Message-State: ABy/qLbQeqgl6NEqFPhVHFjl7NrPie2LwG1vWAp8JFsT4o557X1ychen
        2b5LoMmHq1/XHy2uDTLlNw==
X-Google-Smtp-Source: APBJJlH6eTLecuVTEfGC9Yd2AFb4gtrnG8N3bmkxwsVVUI+5rjy8IFcLzpTEOkfEXuZyffFdw249og==
X-Received: by 2002:a17:902:aa89:b0:1b8:7d0d:5ac5 with SMTP id d9-20020a170902aa8900b001b87d0d5ac5mr1040500plr.50.1688648900925;
        Thu, 06 Jul 2023 06:08:20 -0700 (PDT)
Received: from linux.. ([164.92.112.87])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001a2104d706fsm1391063plb.225.2023.07.06.06.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:08:20 -0700 (PDT)
From:   Kaiyu Zhang <squirrel.prog@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaiyu Zhang <squirrel.prog@gmail.com>
Subject: [PATCH] gro: check returned skb of napi_frags_skb() against NULL
Date:   Thu,  6 Jul 2023 13:08:00 +0000
Message-Id: <20230706130800.85963-1-squirrel.prog@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some rogue network adapter and their driver pass bad skbs to GRO.
napi_frags_skb() detects this, drops these bad skbs, and return NULL
to napi_gro_frags(), which does not check returned skb against NULL
and access it. This results in a kernel crash.

A better approach to address these bad skbs would be to issue some
warnings and drop them, which napi_frags_skb() already does, and
move on without crashing the kernel.

Signed-off-by: Kaiyu Zhang <squirrel.prog@gmail.com>
---
 net/core/gro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 0759277dc..18d92016b 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -731,6 +731,9 @@ gro_result_t napi_gro_frags(struct napi_struct *napi)
 	gro_result_t ret;
 	struct sk_buff *skb = napi_frags_skb(napi);
 
+	if (unlikely(!skb))
+		return GRO_CONSUMED;
+
 	trace_napi_gro_frags_entry(skb);
 
 	ret = napi_frags_finish(napi, skb, dev_gro_receive(napi, skb));
-- 
2.34.1

