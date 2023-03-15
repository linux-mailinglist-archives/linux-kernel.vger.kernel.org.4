Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7B6BBBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCOSUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjCOSUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:20:16 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE62480E25
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:40 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c18so17223806qte.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhODMKtcWK0LfRf2wdwwZPjRN4HzxNzq88wVUem7HDw=;
        b=C+Y304uKNIZZWLzEXOsgwjwy501pin0efMM4+4pHeao5pW4Ygdkr844rvREG6JIZNj
         iHQD4/NBc1VPJlaADkXXuSvNj3OPEv50FU4eSIPGznLD+pOeiJxte4UfTehUiPjQx3Tp
         Y8vGh4AYquFTIee4Aqt2jKebubt+RqDwdAlr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhODMKtcWK0LfRf2wdwwZPjRN4HzxNzq88wVUem7HDw=;
        b=QRcl2/SvSeEOKgcYYb2Kfh0PFo/CayHpJsGKRGQb5M2zM0wf8bFL0y9cC4wNgFxwk+
         yGfKngJ1t5q96UqjhGYXHcthXrFBI6aPq1e0qUHa9CsDb7EJH2XkuJm5TyrjwiPV2znq
         w7cM71ymCSp22XeoKzeMTlNUvUF1ngZFTLXmOvqgIUgN0BKzKBJu4sW/rIw7vuS+ya65
         Uelrdybh2OC9Up3owEVfnnvM/nXBrzGSYaklgrz9dvU6FoF3uyYfCUHFfiCKTOAHy2vv
         sQqd0tPb885XDZwvO7AbOcH3UrexG+3YKK/ke7CtbdlkKEohjKy+hPkp5oL34gJimYeo
         Usww==
X-Gm-Message-State: AO0yUKUnoSoO2eL/9LlRvLiX2xkf87C04OpOeb77nmdGzozoeHDC3p5x
        HBI6dvXZJXXMEjD89LTcQEKQLg==
X-Google-Smtp-Source: AK7set9id951ANDWuQMZ3Xeb2X1Pp44qgjGiNyezCx7Uh/0zh+DU8u/Oy1K/eWo94y5Bmfiebi2Xng==
X-Received: by 2002:ac8:5dcd:0:b0:3d5:f1a2:13f7 with SMTP id e13-20020ac85dcd000000b003d5f1a213f7mr1412046qtx.12.1678904378370;
        Wed, 15 Mar 2023 11:19:38 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Devesh Sharma <devesh.s.sharma@oracle.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/14] RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:19:00 +0000
Message-Id: <20230315181902.4177819-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
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

The k[v]free_rcu() macro's single-argument form is deprecated.
Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
is to avoid accidental use of the single-argument forms, which can
introduce functionality bugs in atomic contexts and latency bugs in
non-atomic contexts.

There is no functionality change with this patch.

Link: https://lore.kernel.org/rcu/20230201150815.409582-1-urezki@gmail.com
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b10aa1580a64..ae3a100e18fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 
 	rxe_cleanup(mr);
-	kfree_rcu(mr);
+	kfree_rcu_mightsleep(mr);
 	return 0;
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

