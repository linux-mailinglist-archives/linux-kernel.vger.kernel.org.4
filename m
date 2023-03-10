Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11C56B33A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCJBbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:31:53 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD3E10285D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:31:51 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h19so4242181qtk.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 17:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678411910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9ofmXvi+yoEOTwnWtynDgK6IduRelA0tIhKQl7CdJ0=;
        b=CJxs5Lm5QHQiquo4AjG5aaAVH5OhqI/2GaIz7xKhQCv5L93fTHuoAlZV9Gbitb2cfX
         CBMq+NiVL3zFSA3n2CND0pLPRYIoGwn3fq+ggxyeqaj5wyFyfZjExYDDIEQwgS/vQEEC
         0zhNVdHBKJDJB13tv1+mV7aosZqxR50uKMbNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678411910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9ofmXvi+yoEOTwnWtynDgK6IduRelA0tIhKQl7CdJ0=;
        b=ofS0rp45E3+LADiW2e6enrYUCSe9x/qh39Vg7N287rqJeFZRXWHFv7mGTVnARE5tm7
         b60g0LNrJN6rlVQEOnPoHV6MPBKW6tUhIQPvO33kVz/fO9QREruTCbv87xVccW4OM9lW
         LvdBhhlz+pIhklNhMZyvgMzOVil66X0diKpp3tCLlRXwl1C3hATaoFT9mXUPJ5/vEjkj
         jQalOa6rM20LoNppkL6cvTLNe9xwQoK9LZqPA/eZlRElZ3c5bk5B4DdJUG3x1ms2bsNe
         vuHaFyjaQo386uE0TSJvlrzthD4kgvvkYh0hZBhY8N2pYhRvPsFGuRgWScMCo+RZeBzA
         ilHA==
X-Gm-Message-State: AO0yUKXwln4Qw6BwtuCZHzfjA9URkCh8s+7mulkNRPkBP2VDXEbNW2rS
        1lDvhidz+E3rOGP2YFVmeevM+ajGDMNm34FT1rg=
X-Google-Smtp-Source: AK7set8CodEww+oJHx4uqK72YvDkSaUODFTaCcQVaKEOvvPIVqD7s5xth57+TKwSz+3SyIrjgQzrfg==
X-Received: by 2002:ac8:594f:0:b0:3b8:68ef:d538 with SMTP id 15-20020ac8594f000000b003b868efd538mr4968923qtz.52.1678411910365;
        Thu, 09 Mar 2023 17:31:50 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id o21-20020a374115000000b0071a02d712b0sm356522qka.99.2023.03.09.17.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:31:49 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-wpan@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        boqun.feng@gmail.com, paulmck@kernel.org, urezki@gmail.com
Subject: [PATCH] mac802154: Rename kfree_rcu() to kvfree_rcu_mightsleep()
Date:   Fri, 10 Mar 2023 01:31:44 +0000
Message-Id: <20230310013144.970964-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

The callers are holding a mutex so the context allows blocking. Hence
using the API with a single argument will be fine, but use its new name.

There is no functionality change with this patch.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Please Ack the patch but we can carry it through the RCU tree as well if
needed, as it is not a bug per-se and we are not dropping the old API before
the next release.

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
