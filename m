Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD50A5FBA14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiJKSDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJKSCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C4269198
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a18so6105180qko.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0y+DmjJhTq9monYJaUr4qwh4aRYR5iDLKa+yKUX59E=;
        b=irIdIFBl2ehbWbpq+w2qg+L5notVUkLMqwnI/fnXUI+vv4U+5vNVd7k0yjp/EDNZXA
         u6N3i/Gl2hq5hyg7WFsi2P9IEBC7llVQ089FaXhnGCzyGCRRSJNTjwonk2ABGnje5UtS
         IEfDrEIayfWCrL8i/DiXv8ifXoFjkBPS88LUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0y+DmjJhTq9monYJaUr4qwh4aRYR5iDLKa+yKUX59E=;
        b=mZxx/9Qs7DtfWc3D2pSFpQ3lbi0GNT83XRPhTkU+zEmiOkQIz4ZYxHLxUcTNWU+5yS
         vhzu95Zhw0PXMgALc+YAC9leVhxoidDERFaEugPg6DWBeI8181LYRxC5mFq4TmCTdb4V
         wB1gTEetGqcecDh198IBhd93rDjN8fJI2ObQDTRuOufosstFEC4AAU7jG7lJoHnlyDCG
         9xm8US6qwXCjikwKNjgvC8emZ+kg5FnYyaiXNYQmrKm73K5RMB2WK7e+ep4JAoSXC9xz
         Wod7ktsvmoD2i97Ls5a0aXCxndCzHZXhd3lLMpip4O+Kl6izjLoVWt7WS+FPipiiWU1y
         TRvA==
X-Gm-Message-State: ACrzQf13FOOvhoMLH/35bs6EUB2Lot/rlYBiR3VXED0KRu7TmU/E+/tC
        65ItP+U15EciE4UEe8+/GU1b0w==
X-Google-Smtp-Source: AMsMyM7hnN8IlnHhSERMzjYvPOFqcwoe0X5Tz/ptPbXWucNDzvsSp3/KKI5+UZWMNj0N/KDlIhWTGQ==
X-Received: by 2002:a05:620a:1507:b0:6ec:eedd:aa57 with SMTP id i7-20020a05620a150700b006eceeddaa57mr8041254qkk.704.1665511338331;
        Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 12/13] rxrpc: Use call_rcu_flush() instead of call_rcu()
Date:   Tue, 11 Oct 2022 18:01:41 +0000
Message-Id: <20221011180142.2742289-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.38.0.rc1.362.ged0d419d3c-goog

