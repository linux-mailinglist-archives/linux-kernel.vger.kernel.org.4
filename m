Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD14773FA85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjF0Kwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjF0Kwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:52:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62F1FCD;
        Tue, 27 Jun 2023 03:52:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-54fbcfe65caso3607955a12.1;
        Tue, 27 Jun 2023 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687863149; x=1690455149;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXy027s4adq0cU6fuQ+J597YxZqomWINTiTZUGu3KY4=;
        b=TCS+b6sZbVqj1tmPVSZv4BKYe/Dj6hOGbE2KA299WZXchBxY3vdeECxynr6jmap1N5
         fHG5zGdkaLjbw8GIP1nyrDiFnlz12Yp4JAb9BdlchmfIFm94y/qmBTvlKa7aNJ5b694b
         WSWktNAIooUrNibkGEnYl8TU5vfe6vzIfCKsOXWLOB+jNPsnx6JhOffrB7zptS2D4aJF
         fvLe/CCeriPTyClb57X8b35zu4K1F61arqlDhWEhZM/Fqu4sMbZI1k0fiU1kQ7XUB7Wd
         30nF7wjM9CqtsqoUi4uxdSAiYCjLc8sRxQ8JgrTJjQuhdiJ1D6i/jes/subsBNoSu5Y+
         fPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863149; x=1690455149;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXy027s4adq0cU6fuQ+J597YxZqomWINTiTZUGu3KY4=;
        b=a6kvXWHFFZPgxUz20THJ3CGCNT3PVhQzKrWNU0S1E8Gem0LjbMlQrrIcZJBuLL2jcj
         GnMjZz6OEzF7zUoielavzE9BQNMbKxbWr8xDO6OkM3LAhpMeuo6bAktBB3VioJDWQk94
         ULGiyanTssIcNASD8W/d7BhS/2gPtub84D0CWnWZrLAspm2LYwOJyq0lNKUGtkstSCV6
         5nygKuQ1M8xackJjm0iYkapPbI4EZZQx4YwWlsL2vzkO+H0e19JMPPQktdZMqrGI9/Rt
         wOos2+LCz1IPd2y8HwS7dCN8nAKy1dWFJ8drGRdxIqJnQIAyfU5peRl6VO5JbSIxbTew
         Y7bw==
X-Gm-Message-State: AC+VfDwrvfkWZ68cKJtPCIWXBzS7OcXZ+DPlNN9/t6K4DanFmzUIMrPR
        GGp7t9pa8Orv/YkhiKBCWtI=
X-Google-Smtp-Source: ACHHUZ74GgSWauhoRo6kSFqMlgbmn+KovrrebGJ1lEhNvFZMDcb0Os3lJW0f4Jd9y3VOwz2J/RKp7Q==
X-Received: by 2002:a17:90a:a47:b0:262:d1b8:5d43 with SMTP id o65-20020a17090a0a4700b00262d1b85d43mr11067919pjo.22.1687863148896;
        Tue, 27 Jun 2023 03:52:28 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b00262d6ac0140sm5392485pjb.9.2023.06.27.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:52:28 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] net/802/garp: fix potential deadlock on &app->lock
Date:   Tue, 27 Jun 2023 10:52:09 +0000
Message-Id: <20230627105209.15163-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &app->lock is also acquired by the timer garp_join_timer() which
which executes under soft-irq context, code executing under process
context should disable irq before acquiring the lock, otherwise
deadlock could happen if the process context hold the lock then
preempt by the interruption.

garp_pdu_rcv() is one such function that acquires &app->lock, but I
am not sure whether it is called with irq disable outside thus the
patch could be false.

Possible deadlock scenario:
garp_pdu_rcv()
    -> spin_lock(&app->lock)
        <timer interrupt>
        -> garp_join_timer()
        -> spin_lock(&app->lock)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave(),
or it should be fixed with spin_lock_bh() if it is a real bug? I am
not very sure.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/802/garp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/802/garp.c b/net/802/garp.c
index ab24b21fbb49..acc6f2f847a6 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -515,6 +515,7 @@ static void garp_pdu_rcv(const struct stp_proto *proto, struct sk_buff *skb,
 	struct garp_port *port;
 	struct garp_applicant *app;
 	const struct garp_pdu_hdr *gp;
+	unsigned long flags;
 
 	port = rcu_dereference(dev->garp_port);
 	if (!port)
@@ -530,14 +531,14 @@ static void garp_pdu_rcv(const struct stp_proto *proto, struct sk_buff *skb,
 		goto err;
 	skb_pull(skb, sizeof(*gp));
 
-	spin_lock(&app->lock);
+	spin_lock_irqsave(&app->lock, flags);
 	while (skb->len > 0) {
 		if (garp_pdu_parse_msg(app, skb) < 0)
 			break;
 		if (garp_pdu_parse_end_mark(skb) < 0)
 			break;
 	}
-	spin_unlock(&app->lock);
+	spin_unlock_irqrestore(&app->lock, flags);
 err:
 	kfree_skb(skb);
 }
-- 
2.17.1

