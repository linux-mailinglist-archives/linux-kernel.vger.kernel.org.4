Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4A6DDB86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDKNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDKNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:01:37 -0400
Received: from mail-ed1-x564.google.com (mail-ed1-x564.google.com [IPv6:2a00:1450:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF24C07
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:01:09 -0700 (PDT)
Received: by mail-ed1-x564.google.com with SMTP id 4fb4d7f45d1cf-50489b16e6aso1871880a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681218042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uro36Q9BxlPEIVH/KwpgPssMY18occbtTX2ic8QxRG4=;
        b=UutsbkIucpDckiULFPkgVrSIzAcICeJRe1UxOAL+rkNvLGByoI71hUK4yIN4MIcafb
         QHnKPy8ug7tUQU28mnS0fHazLKG9js/2nB7nt1grd0Qrzt+rzoMOxpB4yMX6GfPgv5ve
         KRM/6UCRGmx5hmw1WsoboL7v/2OU/FXHNK0I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uro36Q9BxlPEIVH/KwpgPssMY18occbtTX2ic8QxRG4=;
        b=J/ijmaW0q6WprbJ+OoDy8WEiP9YEjLuFyvv12CO1yN3I0gR9+IgEua6kfnMB6kO3iW
         nNFxkitCKutEgch7v9FfGOnzKkGxObxqbuc4uHKGZ8tM679M7rGTJZiTHuoL7kGMmg9P
         1ZIezX3CkSJq4tpIOEHg2ajFXPphzUPHXG5y3coQA7XAeYrkFAtwgHU+KZiGYIR43mMI
         G/Gk05Urodim9OEp1bdm8ftEI/0jx5fXWMHpqgD23/vtKacrRcq5C3uAjd8TU1xy7CyE
         xiglhyZ5l+CMrRiuOOuWQ2id+FtIsf5fBOFm8n/fh5ewTrlSQPLHOHp5EPyqj9D6rk/l
         qORw==
X-Gm-Message-State: AAQBX9ebbM5crSkFLGHqQX1tWXlIpcWbRYJBCxIbfDcs2Wv2a60iWvEW
        ewij757Gszm8d1z6eOJ58401NDqk1bALSC1i1XrlQXww0DDx
X-Google-Smtp-Source: AKy350ZncdrI3ZnMCD8zGcpJXYP6eBz0cUcf6rYABJiQtZbbScQg/7m7aQGJ/2rH9+EXIA+BDpC5PXlEPoes
X-Received: by 2002:aa7:d3da:0:b0:504:b324:9eb6 with SMTP id o26-20020aa7d3da000000b00504b3249eb6mr4004684edr.29.1681218042329;
        Tue, 11 Apr 2023 06:00:42 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id xa10-20020a170906fd8a00b0094c9be3f56esm2457608ejb.166.2023.04.11.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:00:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] xsk: Elide base_addr comparison in xp_unaligned_validate_desc
Date:   Tue, 11 Apr 2023 15:00:25 +0200
Message-Id: <20230411130025.19704-1-kal.conley@dectris.com>
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
 net/xdp/xsk_queue.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 66c6f57c9c44..dea4f378327d 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -153,16 +153,12 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
-	u64 addr, base_addr;
-
-	base_addr = xp_unaligned_extract_addr(desc->addr);
-	addr = xp_unaligned_add_offset_to_addr(desc->addr);
+	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr);
 
 	if (desc->len > pool->chunk_size)
 		return false;
 
-	if (base_addr >= pool->addrs_cnt || addr >= pool->addrs_cnt ||
-	    addr + desc->len > pool->addrs_cnt ||
+	if (addr >= pool->addrs_cnt || addr + desc->len > pool->addrs_cnt ||
 	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
 		return false;
 
-- 
2.39.2

