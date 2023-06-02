Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D5720C6A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 01:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjFBXwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 19:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFBXwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 19:52:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53AA180;
        Fri,  2 Jun 2023 16:52:16 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39a53c7648fso2314683b6e.1;
        Fri, 02 Jun 2023 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685749936; x=1688341936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvpQLmsg+2AwEtsmXbyoNbXHbk3YOPzOD4ZGOKEAPR8=;
        b=VWX6Ld/NtkwxxHt07O8v022y7ONasYfNbUqsWEuVaXGnTDkXILxd3Rep7iZ4GsyGdD
         h2BbpT+hV0nx5Mbm5tU+V7Aed7w1Pf4DLVRIEP5QINwnXPxvut1PYkNuN70kglpFV6H1
         /du5eJZ6woPmdCRLKyREDygUSl2WWURblDEx27xW6ugysypyJD4Bp0QEJ4JamrHmz8vu
         1oWQxWKldD8cfEI0Z2TXsszACvLXtyoBxfXRkO6FfFzFIFia/Xc0s3mx/Pu7hoeEh0sG
         MExs7Me53/Br/IF3HlLcswwXHspZNTin5NshbzCXmFrvwD2u3nOJeitQz+5lmtfFK8wS
         iZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685749936; x=1688341936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvpQLmsg+2AwEtsmXbyoNbXHbk3YOPzOD4ZGOKEAPR8=;
        b=hAAWpK3HqnRr8i/gCTr5iuoThV57hz3Mn7z+Zt0+uejocVmp8O/Y8p3+bpEqbCpq3/
         9XLRxtnwUDdduA76Fgl4pcw55oOWwy24rD9vUCYzhpItn5L/9q1JEmljg+qC8HeyhOrf
         ilFFjCOuF02If/poLIL4ugyvWpTOf1OZDtH4HRfL6iMMtY3hH2qAQ/NvK3E99XibPQHe
         7odzEQZS+6TzUGDt2H5KQKAr8zgW3dQOlRGGWSCwtSeHCrXYzu4gw3bHN0aArMeQhE9G
         x9TuqSLGabIroHlVOD1GjWbdDtUiXyn7c2oLb7HFyXh3L+XhlwfTfLO07YR00TNOOBQ2
         d4xA==
X-Gm-Message-State: AC+VfDxXjsGQqk9MxJ8IdQ+8jngaEauuaujP3fRmt4JSX1ZXQnJDP+IQ
        u6ypkIQqpi04nFQMQi25wfI=
X-Google-Smtp-Source: ACHHUZ6BXtEG1GLm0QEJqvB6bBiYJJpF2v2p4CqaVyfV6lUXq2Jq9XjqMXOfMqJ9Gh/Lp755az2tOQ==
X-Received: by 2002:a54:4604:0:b0:398:af5:a18a with SMTP id p4-20020a544604000000b003980af5a18amr1320889oip.59.1685749936034;
        Fri, 02 Jun 2023 16:52:16 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-82-61.dynamic-ip.hinet.net. [36.228.82.61])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001b061dcdb6bsm1916070pll.28.2023.06.02.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 16:52:15 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: sched: wrap tc_skip_wrapper with CONFIG_RETPOLINE
Date:   Sat,  3 Jun 2023 07:52:09 +0800
Message-Id: <20230602235210.91262-1-minhuadotchen@gmail.com>
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

This patch fixes the following sparse warning:

net/sched/sch_api.c:2305:1: sparse: warning: symbol 'tc_skip_wrapper' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 net/sched/sch_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 014209b1dd58..9ea51812b9cf 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2302,7 +2302,9 @@ static struct pernet_operations psched_net_ops = {
 	.exit = psched_net_exit,
 };
 
+#if IS_ENABLED(CONFIG_RETPOLINE)
 DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
+#endif
 
 static int __init pktsched_init(void)
 {
-- 
2.34.1

