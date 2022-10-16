Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214B8600141
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJPQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJPQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:47 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98A3CBC7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z30so5385093qkz.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEtsx5s7XOiwD9ITg4bkmVjdZ73X1TK7P0DFf+XigW8=;
        b=pOMzhiN56m8msun4IsqBgxhAdONJhpbswx/IqkVNkSzTeoZyLosoi3Vb7h3daV57N2
         tbMeo2SLUtbhULfjpnA/VGwusi+VwdrN9fM3xRm7qFybgF62fYRKEGDPgdni8VnOptlp
         3VpNZBINyx4R1NGkCDqif21jM8JelQbOO5AKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEtsx5s7XOiwD9ITg4bkmVjdZ73X1TK7P0DFf+XigW8=;
        b=MpW0/rUP0t/PDAcqVep/s2un8cQoHngxV3jzV+i8UMWVVjqP1J/FgKdcP86B8Ay0H7
         hc8BhPMCH6AFbuPfvQj6uO3+63p2QFDFzHh6wg2LhStkosxVs+CBWqjkfLuxbA1Z453+
         EIj8TR0tsejDNnTjw9dfzuENuKJUtX5+ouIGnAbhB08YWBP8wpEjdVwPIdo/421kRnpT
         vYWrbkbol1XRRxVO3Y8yaUfBoJTxH8dCpfo5sSeMOaqkXllm7U5bwi3Jlh3vihB2Pdzz
         CBQjzOf3wsSC7RRfsElrn60K3VZraVL2Hf5cIa7YWCOZhCDfa9yg04OmOoQPhzyjHaqQ
         eKpQ==
X-Gm-Message-State: ACrzQf0dnca4AthGc9pNlW+qRaoNvH5W3WuSnjsnc4JZur0QbReCQwhl
        +DoNJIr+r7kD4DppE9bVDJWUTg==
X-Google-Smtp-Source: AMsMyM6yGlhG1jMARZVapw8+tf5joMmfgRkmzBDiCtBUJkkPqdbBN7kTkDtgGznT9qezr0r1+nL2yQ==
X-Received: by 2002:a05:620a:28c1:b0:6ee:d4f1:21df with SMTP id l1-20020a05620a28c100b006eed4f121dfmr4953922qkp.724.1665937421930;
        Sun, 16 Oct 2022 09:23:41 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 12/13] rxrpc: Use call_rcu_flush() instead of call_rcu()
Date:   Sun, 16 Oct 2022 16:23:04 +0000
Message-Id: <20221016162305.2489629-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_rcu() changes to save power may cause slowness. Use the
call_rcu_flush() API instead which reverts to the old behavior.

We find this via inspection that the RCU callback does a wakeup of a
thread. This usually indicates that something is waiting on it. To be
safe, let us use call_rcu_flush() here instead.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/rxrpc/conn_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 22089e37e97f..fdcfb509cc44 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -253,7 +253,7 @@ void rxrpc_kill_connection(struct rxrpc_connection *conn)
 	 * must carry a ref on the connection to prevent us getting here whilst
 	 * it is queued or running.
 	 */
-	call_rcu(&conn->rcu, rxrpc_destroy_connection);
+	call_rcu_flush(&conn->rcu, rxrpc_destroy_connection);
 }
 
 /*
-- 
2.38.0.413.g74048e4d9e-goog

