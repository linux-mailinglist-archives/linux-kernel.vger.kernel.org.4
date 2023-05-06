Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9037E6F8D18
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjEFAOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjEFAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:14:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E6872A7;
        Fri,  5 May 2023 17:14:21 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a5a830238so22422717b3.3;
        Fri, 05 May 2023 17:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683332057; x=1685924057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a8CBrqerMNM81FeXTG90ZuWVi7X7KBRpVk7Q/RxZcE=;
        b=QhjGtAzf0ADf3+KrDmk9mQjw9nPdcAhwjvz4xh+zD3de2THUIkL3OjYsZo79XEfebT
         Idrl5lxK4nSXCpc1mofdUoGYlB3H3FjzQ//h0oqkDIjsld+N7LCUrs/BQRWjA9iQg2yg
         1u0IeCsI0RzeIH1iUBUgPmOpMt6IuKy9SXGDZg5C0d36yP88qoMCzDAEjxCnQjdEMeDY
         By51V4HQsI6ohorPzWJkR0+ttqg6aS6fG7GEkAkoN/hgLu2xf+lm1p6QzH+ZlTJCO5Sw
         +MwFHOglNvBmAvZH83fD9uJpzWX/LVmSkclD6wCJxWRENIuxqYCISXSuglviqDEXWCsk
         GaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683332057; x=1685924057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a8CBrqerMNM81FeXTG90ZuWVi7X7KBRpVk7Q/RxZcE=;
        b=Rn4qLGofT5J0ffx9Y85VyXx2dXJDTPai1oo+2/SHRHwRJQg8erMK9MttoqanknSMUl
         6IvqRG1m91+u5ZSWX4xVw+/MTyDhE+DJBm0a2nzMYZfZKGxHLPBBqBTdPcDYGNCoQFjQ
         /uYHJYfzXca+/EuuFTDJ0mvQRtHIFHvm6g3NL8/UvpeO3PqIE6GcKyx5MttATdqbnrCB
         cY4uUMJosww5TzNx0t0APbIUNkCtc1K4M4hOyq4NDLhcAYI4oY+ecXd8jypaBlRWELnT
         ZE8dRpDAut907ku9AZ++eu1X41PKGclRqwUalxCj63i+fWSSubtpavjJl9p2A5uRKpNu
         9+JQ==
X-Gm-Message-State: AC+VfDzAm8T6/A1oCo0giET3mmLgJLdO6IvDF1rz3+9wwvTuCUrL6Nzn
        +m6urDi1emwG5B4sfNSdvA==
X-Google-Smtp-Source: ACHHUZ54EIu4G49gJb3qgb0T3Wp3qUmqgY3HK/DSlLbhm+muU8Tgl7pNr2ncEsV5pApO+NFWrFpqbQ==
X-Received: by 2002:a0d:ddd7:0:b0:55a:4bd3:f73b with SMTP id g206-20020a0dddd7000000b0055a4bd3f73bmr4085086ywe.10.1683332056864;
        Fri, 05 May 2023 17:14:16 -0700 (PDT)
Received: from C02FL77VMD6R.attlocal.net ([2600:1700:d860:12b0:5c3e:e69d:d939:4053])
        by smtp.gmail.com with ESMTPSA id n82-20020a0dcb55000000b00559be540b56sm800536ywd.134.2023.05.05.17.14.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2023 17:14:16 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
X-Google-Original-From: Peilin Ye <peilin.ye@bytedance.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.r.fastabend@intel.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH net 3/6] net/sched: Reserve TC_H_INGRESS (TC_H_CLSACT) for ingress (clsact) Qdiscs
Date:   Fri,  5 May 2023 17:14:07 -0700
Message-Id: <9969180f9219ed18656d8f3c92e717f6eb398aa1.1683326865.git.peilin.ye@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <cover.1683326865.git.peilin.ye@bytedance.com>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
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

Currently it is possible to add e.g. an HTB Qdisc under ffff:fff1
(TC_H_INGRESS, TC_H_CLSACT):

  $ ip link add name ifb0 type ifb
  $ tc qdisc add dev ifb0 parent ffff:fff1 htb
  $ tc qdisc add dev ifb0 clsact
  Error: Exclusivity flag on, cannot modify.
  $ drgn
  ...
  >>> ifb0 = netdev_get_by_name(prog, "ifb0")
  >>> qdisc = ifb0.ingress_queue.qdisc_sleeping
  >>> print(qdisc.ops.id.string_().decode())
  htb
  >>> qdisc.flags.value_() # TCQ_F_INGRESS
  2

Only allow ingress and clsact Qdiscs under ffff:fff1.  Return -EINVAL
for everything else.  Make TCQ_F_INGRESS a static flag of ingress and
clsact Qdiscs.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
 net/sched/sch_api.c     | 7 ++++++-
 net/sched/sch_ingress.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index fdb8f429333d..383195955b7d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1252,7 +1252,12 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	sch->parent = parent;
 
 	if (handle == TC_H_INGRESS) {
-		sch->flags |= TCQ_F_INGRESS;
+		if (!(sch->flags & TCQ_F_INGRESS)) {
+			NL_SET_ERR_MSG(extack,
+				       "Specified parent ID is reserved for ingress and clsact Qdiscs");
+			err = -EINVAL;
+			goto err_out3;
+		}
 		handle = TC_H_MAKE(TC_H_INGRESS, 0);
 	} else {
 		if (handle == 0) {
diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
index 13218a1fe4a5..caea51e0d4e9 100644
--- a/net/sched/sch_ingress.c
+++ b/net/sched/sch_ingress.c
@@ -137,7 +137,7 @@ static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
 	.cl_ops			=	&ingress_class_ops,
 	.id			=	"ingress",
 	.priv_size		=	sizeof(struct ingress_sched_data),
-	.static_flags		=	TCQ_F_CPUSTATS,
+	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
 	.init			=	ingress_init,
 	.destroy		=	ingress_destroy,
 	.dump			=	ingress_dump,
@@ -275,7 +275,7 @@ static struct Qdisc_ops clsact_qdisc_ops __read_mostly = {
 	.cl_ops			=	&clsact_class_ops,
 	.id			=	"clsact",
 	.priv_size		=	sizeof(struct clsact_sched_data),
-	.static_flags		=	TCQ_F_CPUSTATS,
+	.static_flags		=	TCQ_F_INGRESS | TCQ_F_CPUSTATS,
 	.init			=	clsact_init,
 	.destroy		=	clsact_destroy,
 	.dump			=	ingress_dump,
-- 
2.20.1

