Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106A6615D9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjAHOjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFC7651
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673188736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8nmF6yGQPc7csrjOj7kKwdzfOlPcQjGza6hQEjZq+L8=;
        b=NYmnbTvNDd2qa25qaeVBnnIRm5nLvaaewhL/FeIOEKOTJ1MRluyWNd1qRwMGOiQ3J8ZHxj
        7pVTQy36ep6yiXGyrXY3iBglOcZnEZgJ7v8BhllxmLZB7RZ1gPjMu6Q/7LnljIZG7tdNTj
        HlhnAFZJSfNVk4cbkBxUob0QGzifdzU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-XzQYg2FOOou13p2SikDjiQ-1; Sun, 08 Jan 2023 09:38:54 -0500
X-MC-Unique: XzQYg2FOOou13p2SikDjiQ-1
Received: by mail-qk1-f198.google.com with SMTP id r6-20020a05620a298600b007025c3760d4so4773076qkp.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 06:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nmF6yGQPc7csrjOj7kKwdzfOlPcQjGza6hQEjZq+L8=;
        b=YQWCbpfMMQcNbhudHoEwfQExgZYHxC6ZZI5J1CBgAolqc2t0h0mEeXo5zS6qRRdOQ0
         RqD6S1HEvgvDIx54VDoWv89/WZY5tLeX7NxDgrjn/VLn3sgNquBeOmhaeZVWyRLJ+H7T
         n1iM++ZtSVkGnUkjhlfFMqaAuyP6TdSNi2zjiP6PgNhRtllX7Hd/gncRZLwEYP1Nq+pX
         XZfs2CtDWWqH6ury6ejVdLnf8heF/DZX6XESRwAAN2Vt9jn5U0rjpVvAg7O8fI1pyIMi
         ji3yKXUG8x/nfxHSyQXiaTu5GrSVfy42HoP4KryTUBY0fd1QwcmaoiITSmqe18bElzyj
         NoRw==
X-Gm-Message-State: AFqh2kr7dGhaEe9SBg4uFqUG5PplzB614Uhc3fEjfILzBrdeIW9sSWO0
        C+fIFrWXzl3nNlPYGuzqrHhHqV9PeRlRdrKRgBuaiy4I5DpoC7nR2Vb2P1hY4Sre0meQ/v+5p9V
        kyyMClzys8/TMCKFO4sM31nhU
X-Received: by 2002:a05:622a:181e:b0:3a5:ed7:1644 with SMTP id t30-20020a05622a181e00b003a50ed71644mr114338852qtc.45.1673188734216;
        Sun, 08 Jan 2023 06:38:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsKAHGfagVXu0UGthHdTUi8lf8mpUA43lYoZ63p/qHcdByb7YZnxyYzllZilXvP41HZfOJ4Yw==
X-Received: by 2002:a05:622a:181e:b0:3a5:ed7:1644 with SMTP id t30-20020a05622a181e00b003a50ed71644mr114338832qtc.45.1673188734004;
        Sun, 08 Jan 2023 06:38:54 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y4-20020ac87c84000000b0039a55f78792sm3273434qtv.89.2023.01.08.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 06:38:53 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
        ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com, khalasa@piap.pl,
        wsa+renesas@sang-engineering.com, yuancan@huawei.com,
        tglx@linutronix.de, 42.hyeyoo@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: ena: initialize dim_sample
Date:   Sun,  8 Jan 2023 09:38:43 -0500
Message-Id: <20230108143843.2987732-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang static analysis reports this problem
drivers/net/ethernet/amazon/ena/ena_netdev.c:1821:2: warning: Passed-by-value struct
  argument contains uninitialized data (e.g., field: 'comp_ctr') [core.CallAndMessage]
        net_dim(&ena_napi->dim, dim_sample);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

net_dim can call dim_calc_stats() which uses the comp_ctr element,
so it must be initialized.

Fixes: 282faf61a053 ("net: ena: switch to dim algorithm for rx adaptive interrupt moderation")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index e8ad5ea31aff..938184465eae 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1805,7 +1805,7 @@ static void ena_dim_work(struct work_struct *w)
 
 static void ena_adjust_adaptive_rx_intr_moderation(struct ena_napi *ena_napi)
 {
-	struct dim_sample dim_sample;
+	struct dim_sample dim_sample = {};
 	struct ena_ring *rx_ring = ena_napi->rx_ring;
 
 	if (!rx_ring->per_napi_packets)
-- 
2.27.0

