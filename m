Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185575B7D55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIMXHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIMXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:07:47 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1CF6E888
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:07:45 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id z128-20020a676586000000b00398b3b1457cso308599vsb.16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=nQIPAqtSgyJ/LHof5ggHUlg0YR/i7dEWTiUZqzvgn8s=;
        b=r39QugdHbnvu6UBNDFOeYIgOZv+KRMsRAszRZrgG2Uh7MHuqGKm8GdYVygbetKozou
         yHu9Z1R+N652uNKZHNmPNxnoehVS18xeKrpISfehyuC/tjduCdokNoyYyOspp2Ebl1JB
         Qsn4nQNyVSbPpZ4m9qEZzSfkB5rmGrKxfI8uJpXePrM5Tb9qSlOkoHhzitYN2rGx4L01
         A0yH+OdMQ0dxmeI9ijhJtFFUijZBivI0uMoDCVtX5oioG39AN6MX67ladm2OefYPeGcx
         HGGgwQ9HUI6SYtrPu591oIf6aHCO9lgB39yYvLG7OLP3QHdkOXCK3KvxrmFG7SWZkw5b
         eptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=nQIPAqtSgyJ/LHof5ggHUlg0YR/i7dEWTiUZqzvgn8s=;
        b=fRGShRDWo5Ko/7Z0go2xjBwPeLhzFlAmqp98MUJ0jiiKyOkragAGWpGi8+iB6w+BuO
         Hz+q0knnADM83Se+L6HBtrzr9oXaw8seYKWhuEYUdxGXuzPiH1enngMjY37Q6D2m4/lT
         gdfD2H4zngSG8h7HcOwSAE7cMVorGFnh3+iaEYriu3q74hjVUrc0NRaogbZIJ7WOnVlk
         /u2yACyY6/itQFKSm1QbQ0rFfeNNfat+F0Bl84AmF1wgBYSPC9hya0ZcIfs6pDdyLBWj
         Mmf8lA3LKLv3WFaeXHs4cR7jING+TnRu8yuF89hvOGqDha7yopTC1HlOqxeEg2etSZSw
         KraQ==
X-Gm-Message-State: ACgBeo00xfEXE1zCutlglGPnb4kQFNcK0j62c9d0T6oy7ZPSkmRlDWE1
        +5Nlk9OjCaABSBAiz8DVggK+cw2sBQ==
X-Google-Smtp-Source: AA6agR7gin9Q9ggEELh11q577gqRI3VqclYGFLam1G26ejizXnicJDQSt0YMtQ28PzsDauQfHw2oY6IVJg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a67:c983:0:b0:398:2c7:b3bd with SMTP id
 y3-20020a67c983000000b0039802c7b3bdmr11658783vsk.57.1663110464805; Tue, 13
 Sep 2022 16:07:44 -0700 (PDT)
Date:   Tue, 13 Sep 2022 16:07:38 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913230739.228313-1-nhuck@google.com>
Subject: [PATCH] openvswitch: Change the return type for vport_ops.send
 function hook to int
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usages of the vport_ops struct have the .send field set to
dev_queue_xmit or internal_dev_recv.  Since most usages are set to
dev_queue_xmit, the function hook should match the signature of
dev_queue_xmit.

The only call to vport_ops->send() is in net/openvswitch/vport.c and it
throws away the return value.

This mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 net/openvswitch/vport-internal_dev.c | 2 +-
 net/openvswitch/vport.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 35f42c9821c2..74c88a6baa43 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -190,7 +190,7 @@ static void internal_dev_destroy(struct vport *vport)
 	rtnl_unlock();
 }
 
-static netdev_tx_t internal_dev_recv(struct sk_buff *skb)
+static int internal_dev_recv(struct sk_buff *skb)
 {
 	struct net_device *netdev = skb->dev;
 
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index 7d276f60c000..6ff45e8a0868 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -132,7 +132,7 @@ struct vport_ops {
 	int (*set_options)(struct vport *, struct nlattr *);
 	int (*get_options)(const struct vport *, struct sk_buff *);
 
-	netdev_tx_t (*send) (struct sk_buff *skb);
+	int (*send)(struct sk_buff *skb);
 	struct module *owner;
 	struct list_head list;
 };
-- 
2.37.2.789.g6183377224-goog

