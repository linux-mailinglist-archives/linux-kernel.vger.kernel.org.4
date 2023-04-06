Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28D6DA497
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbjDFVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDFVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:22:21 -0400
Received: from mail-ej1-x664.google.com (mail-ej1-x664.google.com [IPv6:2a00:1450:4864:20::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CD2A5C6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:22:18 -0700 (PDT)
Received: by mail-ej1-x664.google.com with SMTP id lj25so4457150ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680816137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsmzvC9OdqUOMKAkahmLy6MXdtOQelQ2/iP2u3yfnac=;
        b=CWWvjPEbXBcVtsdWmkz/LciVKz3v2BYdKEi9Z3/ykViVIjzx5L7+mZg9R/2cKVL3vj
         1LBuoSlmcimL0xAi7EhfZjHceF6OQhGQvTEIH8br40GQUg3T/FdNQBpat4WDZENbqfva
         NhKXMAn2QZQ3coJjXwtbm3e3oR1E7IxskIgNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsmzvC9OdqUOMKAkahmLy6MXdtOQelQ2/iP2u3yfnac=;
        b=nKMsGgxhSKZ+hANOs0ZuRRPeiHJpLW2Btd0wTXo2xrK/58WJH7UzfRlxgpziUyuJ+m
         CuyhDYnHqOlOI1k7HaKkc/39c2iGKVDrULkTzMs6Du21LdBB+qFyvX+YnyDkDVJy1Gl4
         Gkfhl5vr6PxchfNZL3wbCRhpqWJKSyDH8zwZDTg8oMuqXmZuCxO++QCFtHjEcUeaHh7q
         YzE7vesWT9285s+UnigI4GJXYwhhcKeixxkwAqt/jFPqLLTy3vSwTP8zyOF905wRvDea
         dSkwhCAz+r029QqF95q9GZEd21r9WSOjSMft4rcl9U5EqZq+iguSHHIHl1puSk9I5lyv
         LY0g==
X-Gm-Message-State: AAQBX9cfR6WPDsDK+9KINaUyOIdIsEfrXbiZXazf1swvnvnfcONPRY/d
        lmDCcwN29/tJpWo9E55e8i0tJgBsxmaTNTUPoZKRZiCAksdA
X-Google-Smtp-Source: AKy350byBFC1vM5pmpkaNxr0CP5celhBeQSbRUGflgaIoIwmchMQQ/DXb0AA8SwyU99rgwNlkOmXQbjOARBy
X-Received: by 2002:a17:906:585:b0:925:6bcb:4796 with SMTP id 5-20020a170906058500b009256bcb4796mr6565710ejn.38.1680816136943;
        Thu, 06 Apr 2023 14:22:16 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id gs37-20020a1709072d2500b0094964d26463sm186140ejc.25.2023.04.06.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:22:16 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] xsk: Elide base_addr comparison in xp_unaligned_validate_desc
Date:   Thu,  6 Apr 2023 23:21:36 +0200
Message-Id: <20230406212136.19716-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant (base_addr >= pool->addrs_cnt) comparison from the
conditional.

In particular, addr is computed as:

    addr = base_addr + offset

where base_addr and offset are stored as 48-bit and 16-bit unsigned
integers, respectively. The above sum cannot overflow u64 since
base_addr has a maximum value of 0x0000ffffffffffff and offset has a
maximum value of 0xffff (implying a maximum sum of 0x000100000000fffe).
Since overflow is impossible, it follows that addr >= base_addr.

Now if (base_addr >= pool->addrs_cnt), then clearly:

    addr >= base_addr
         >= pool->addrs_cnt

Thus, (base_addr >= pool->addrs_cnt) implies (addr >= pool->addrs_cnt).
Subsequently, the former comparison is unnecessary in the conditional
since for any boolean expressions A and B, (A || B) && (A -> B) is
equivalent to B.

Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 net/xdp/xsk_queue.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 66c6f57c9c44..016f3753180a 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -153,16 +153,14 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
-	u64 addr, base_addr;
-
-	base_addr = xp_unaligned_extract_addr(desc->addr);
-	addr = xp_unaligned_add_offset_to_addr(desc->addr);
+	u64 addr;
 
 	if (desc->len > pool->chunk_size)
 		return false;
 
-	if (base_addr >= pool->addrs_cnt || addr >= pool->addrs_cnt ||
-	    addr + desc->len > pool->addrs_cnt ||
+	addr = xp_unaligned_add_offset_to_addr(desc->addr);
+
+	if (addr >= pool->addrs_cnt || addr + desc->len > pool->addrs_cnt ||
 	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
 		return false;
 
-- 
2.39.2

