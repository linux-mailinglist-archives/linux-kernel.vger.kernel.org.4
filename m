Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855FC6AE9E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCGR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCGR2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:28:22 -0500
Received: from mail-ed1-x564.google.com (mail-ed1-x564.google.com [IPv6:2a00:1450:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D568F708
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:23:25 -0800 (PST)
Received: by mail-ed1-x564.google.com with SMTP id ay14so51634063edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1678209804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0WrihSvBZy5nZ9MfM7JnuWMa4vHo4ZuK5g7GbSWl8w=;
        b=QyFVmVNWgQEDjQOwJ5z2t57JuZSPwGXQwbbHhXq+E7dtKGjZB1wcmBE0w2p+E5eWLZ
         uVEpNcY22q6qjkxnzFM+T8TSlS2JRJyhLZvsJ/Y2PcHLBoinWWWhi16WXg386q2vCxlM
         Z2RDB3wdh3XY7m5yCehb6D5kPsH+9fQbFoyrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0WrihSvBZy5nZ9MfM7JnuWMa4vHo4ZuK5g7GbSWl8w=;
        b=1bqW6OlOX/UO/okVoEncqX+6rsUhiHJf5+WWO0orhXLbv1qXHGIVWBDOApyUuiMC5j
         OL11cCOOBRyojIN2OCzgIIE5O+zQXM4Quj09myw7xOPRGrWV3BJ6EBrL6MMxvMEsH9zZ
         agwRkOU87WtT7aQuxYJGxvOam0BrolT21dur7ZHQBtJnxnLULQ227SOxONKQhJx4+Y2q
         sPJxDDbuJn+ZuOYmMFQCcXIYB9kyzyeV+gBQf35moTslTvnukW8xI589lmW4wWJsZexE
         ecE7VzwEpz3xT6EpyNqyLR6N9vt6iVtMfb8QELEpOQqkgYhp3WoRjIhyBZNqOePrbIYM
         xRxw==
X-Gm-Message-State: AO0yUKUwY+905n4oPQVd2vd1h/LxfkxqbY1455OpDjjwGVP594/ndj0H
        tGTY5/+ulLRNBylHMtg8/I0Sr1FkHaCB/7nHzogMNXOSP0WG
X-Google-Smtp-Source: AK7set9dCAkVNVTJDe9iqtEHgWr837pBL4Nir8S+55ZCqRaNxELi0AqPVIEshb54d5MzztjqM16qns0BAAm5
X-Received: by 2002:a17:906:af18:b0:8aa:c155:9233 with SMTP id lx24-20020a170906af1800b008aac1559233mr14825247ejb.26.1678209804282;
        Tue, 07 Mar 2023 09:23:24 -0800 (PST)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id ho36-20020a1709070ea400b008e061d46f76sm3197935ejc.134.2023.03.07.09.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:23:24 -0800 (PST)
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
Subject: [PATCH] xsk: Add missing overflow check in xdp_umem_reg
Date:   Tue,  7 Mar 2023 18:23:06 +0100
Message-Id: <20230307172306.786657-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of chunks can overflow u32. Make sure to return -EINVAL on
overflow.

Fixes: bbff2f321a86 ("xsk: new descriptor addressing scheme")
Signed-off-by: Kal Conley <kal.conley@dectris.com>
---
 net/xdp/xdp_umem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 4681e8e8ad94..f1aa79018ce8 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -150,10 +150,11 @@ static int xdp_umem_account_pages(struct xdp_umem *umem)
 
 static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 {
-	u32 npgs_rem, chunk_size = mr->chunk_size, headroom = mr->headroom;
+	u32 chunk_size = mr->chunk_size, headroom = mr->headroom;
 	bool unaligned_chunks = mr->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
-	u64 npgs, addr = mr->addr, size = mr->len;
-	unsigned int chunks, chunks_rem;
+	u64 addr = mr->addr, size = mr->len;
+	u64 chunks, npgs;
+	u32 chunks_rem, npgs_rem;
 	int err;
 
 	if (chunk_size < XDP_UMEM_MIN_CHUNK_SIZE || chunk_size > PAGE_SIZE) {
@@ -188,8 +189,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	if (npgs > U32_MAX)
 		return -EINVAL;
 
-	chunks = (unsigned int)div_u64_rem(size, chunk_size, &chunks_rem);
-	if (chunks == 0)
+	chunks = div_u64_rem(size, chunk_size, &chunks_rem);
+	if (chunks == 0 || chunks > U32_MAX)
 		return -EINVAL;
 
 	if (!unaligned_chunks && chunks_rem)
@@ -201,7 +202,7 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 	umem->size = size;
 	umem->headroom = headroom;
 	umem->chunk_size = chunk_size;
-	umem->chunks = chunks;
+	umem->chunks = (u32)chunks;
 	umem->npgs = (u32)npgs;
 	umem->pgs = NULL;
 	umem->user = NULL;
-- 
2.39.2

