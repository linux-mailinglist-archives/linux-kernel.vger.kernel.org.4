Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9F2717D10
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjEaKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbjEaKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:18:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E0E58;
        Wed, 31 May 2023 03:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC8616395F;
        Wed, 31 May 2023 10:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BADC433EF;
        Wed, 31 May 2023 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528289;
        bh=fAqo46X9Mw2V2BkQzIfih4SUfDwqn3L8IoBC3xT459U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePLMv+jMZFPi3Hit+6vSJE2+ji1QEtu/1Aed674mJKNLlzome+1Jg43GPLnjJ2muu
         gSce7Q0YAsBablSP4vC2TV5+BD03NtbB8u5xHW++Ld80Q0yhYOnIw0zUqRIShaJkf9
         d7e5vOF4kABaMNpamGZ8EPOqUJkWg2Fvb2TLHizOgLe7IMQEiBK27isqZDXZF2vjky
         07zI8sNXooZAfWZb6TfrV4UVhOHGdcexmRnZPXv5530QkkzQFUcM939ZzZ+O8HV55g
         zRQttLupK1gTS2yKpzILZClL120vGPG+9wzLK4/rWUTpE7SGCIXwEzIqjj/3N/NlEv
         A5UthPlU6UryQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 8/9] rcu: Make segcblist flags test strict
Date:   Wed, 31 May 2023 12:17:35 +0200
Message-Id: <20230531101736.12981-9-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing several flags at once, make sure that all of them verify
the test. This will be necessary to check if an rdp is (de-)offloading.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 620ca48e782b..36245efdf800 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -70,7 +70,7 @@ static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
 static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
 					    int flags)
 {
-	return READ_ONCE(rsclp->flags) & flags;
+	return (READ_ONCE(rsclp->flags) & flags) == flags;
 }
 
 /*
-- 
2.40.1

