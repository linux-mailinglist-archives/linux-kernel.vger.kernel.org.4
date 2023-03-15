Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3353B6BBBED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjCOSUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjCOSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:52 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCAC8480F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d7so17152619qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CvInQkgrtFswN6a5J7y2T4rUDkhwlp0YkwDUjcLdMc=;
        b=KnGZSFdqJfe5cBkq4aueaxEmiLAtr5exCnajnLei2Srqi9rxmdUuZI63NoOHKdJ2+o
         zHIUImu4xXpy20R3uMo162yktC1I33Kf0ShmUAEpgNBOOhn4IjHGJR07QliUY+ctVwZQ
         HWm3wiihMoB3X4nUyfx7NPhrp6HpBq8pnQ1lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CvInQkgrtFswN6a5J7y2T4rUDkhwlp0YkwDUjcLdMc=;
        b=Hfm5Hw8tDTFpcFvlItCWOWZe9Ew9aBBMkxPo0/31HPCL7jbBAJRNvf4GWXg4DoBIIu
         9oZWIIwk++Lu5zVOJlI8dmLNWQjvGqGFjC7KQMrlIyWMtcHokOCi1rgqVq8wC3xbqxJ1
         aXz6qGTRJqXd8pVnpB/7c+0wlfd+4kXTNwct6gMtRhzxFAXMQM3GjIMqfZ1tenHm6Ujc
         Z3CCKQ8vDbBdpkUdRDOMLZRmJj4MKVs/uHUsH58Vm/IMLdy65gbi8csMzipqTQ1S06NH
         wUcQEHjQJ6r8crBvT+cEeGMJWJkpBhTO5xwvggAQvOiOnAG6Euc/AgwoDTfYuJb0oX1B
         oKhg==
X-Gm-Message-State: AO0yUKUrQrpiRnsP2EEOvXZGd68TlwhkE5sVuSYheM+a35DE19wzyvjJ
        NeWfvsAO6DuYujtfjKBVIjRIMA==
X-Google-Smtp-Source: AK7set9oYtHUFfrwlWQH2asNzIQYPCQs5mupkZKf2svsaI8b0gVoCB+qZF/+IC8hu7UCi4R1iYnkCg==
X-Received: by 2002:a05:622a:50c:b0:3d3:33bd:a29 with SMTP id l12-20020a05622a050c00b003d333bd0a29mr1523968qtx.16.1678904377358;
        Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Girault <david.girault@qorvo.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Aring <aahringo@redhat.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] mac802154: Rename kfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:59 +0000
Message-Id: <20230315181902.4177819-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

The callers are holding a mutex so the context allows blocking. Hence
using the API with a single argument will be fine, but use its new name.

There is no functionality change with this patch.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/mac802154/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 9b0933a185eb..5c191bedd72c 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -52,7 +52,7 @@ static int mac802154_scan_cleanup_locked(struct ieee802154_local *local,
 	request = rcu_replace_pointer(local->scan_req, NULL, 1);
 	if (!request)
 		return 0;
-	kfree_rcu(request);
+	kvfree_rcu_mightsleep(request);
 
 	/* Advertize first, while we know the devices cannot be removed */
 	if (aborted)
@@ -403,7 +403,7 @@ int mac802154_stop_beacons_locked(struct ieee802154_local *local,
 	request = rcu_replace_pointer(local->beacon_req, NULL, 1);
 	if (!request)
 		return 0;
-	kfree_rcu(request);
+	kvfree_rcu_mightsleep(request);
 
 	nl802154_beaconing_done(wpan_dev);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

