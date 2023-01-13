Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB7C6697AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbjAMMqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbjAMMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:22 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D01ADA3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw16so40158609ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=n5fyYkdzH0FaufBTIPFRKPuo0z+AnNGqgMIwP1N9mikuhruiPj9WRKliJKtqkJNcSH
         jdCwrwklvxXlnybHa2UFVFEhVxo4yxnl8RG0yqtoK6PM/qUzfFALdh3BP1L2UPVBR9o/
         w6zxIZEnL5J2sKJYA0OPCfypQ0p9FVxHHUrz6Z1/JMdUq1spCP7LrSapSCEMuwGCHe8s
         HGX+lofy0D+Q+QodiXTM0nZKzf/sIpaOtXX8WkCVlMaYF2cEEk1uvCC20PCV1+9TJe7q
         9hzSbMatiM8L1ARpqUspUBtbv9iuXjfy6N1xV7yn0VoH1DnxioqTPvTQdYkdND7Ap/8M
         BVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=8NKTZL2AZq6R8WxXeglaitn5ZT9gAZs/uCzXsOxEwBiCZSJPnJ2a3fALr8S2c7n+Rp
         BFbvWIMziV01UXxq7kYw0WRguKnDoFvShlZBjZ8H09oP1/bhZ59JhCY9ws82tjzBGUtC
         pYY2dW7PjBz1xS7h5A/04frrzxAp5U9kr9iRVKY7sQOsJ1I5AXIfXyh7iev8I0O5/j0Y
         /7Dw8HtcF9DnK7t8bdnxOraUrNM9ajbg0vp5VL/+cIqmlMCoQ0/T5V60zIMCYliChSHj
         Blbm93fGkW2AEP3haNFdUnWtcTFXz+SguGKE2T2qHOgOwyGf5DEiimK+QqG3+vzLN5Nb
         S9sg==
X-Gm-Message-State: AFqh2krvRDyGeU74f0vtg2RSZ09KXbWoy4Q76TZLRP6+ouEiPT00Ylg5
        pJ+aX2f9/dEzgvkZ8YX1dZaz6w==
X-Google-Smtp-Source: AMrXdXu44yUl9NgFIBf8qhXToOixwyuyGJ/Lw4hHpgVpqAff1RfeVl1gcgrTKjFSUgjeQWYdT5EfWQ==
X-Received: by 2002:a17:906:3993:b0:844:de87:8684 with SMTP id h19-20020a170906399300b00844de878684mr78074081eje.46.1673613349021;
        Fri, 13 Jan 2023 04:35:49 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:48 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 8/8] drbd: drbd_insert_interval(): Clarify comment
Date:   Fri, 13 Jan 2023 13:35:38 +0100
Message-Id: <20230113123538.144276-9-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index b6aaf0d4d85b..873beda6de24 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -58,7 +58,7 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
  * drbd_contains_interval  -  check if a tree contains a given interval
  * @root:	red black tree root
  * @sector:	start sector of @interval
- * @interval:	may not be a valid pointer
+ * @interval:	may be an invalid pointer
  *
  * Returns if the tree contains the node @interval with start sector @start.
  * Does not dereference @interval until @interval is known to be a valid object
-- 
2.38.1

