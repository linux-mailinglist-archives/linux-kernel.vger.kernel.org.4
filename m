Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDB95FDEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJMRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:22:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876F8DAC41;
        Thu, 13 Oct 2022 10:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEE29B81FCE;
        Thu, 13 Oct 2022 17:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B554C433B5;
        Thu, 13 Oct 2022 17:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665681772;
        bh=gdfb8mrhxraYX+PWhODJ6HX/FEuedWUikrZsc2mlm1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBh2tE3/kGmq3ERyz8Ad7GWL3ILAmVUPGu7GEFmEO7zSyV6ai61MxEIOWYN1l00Qp
         AA04DpDn4fDWV7wcPRkwPlL2TnU+d5faVPmJ/uxW1v/h0wYsTbnYtIxe0zy0VKybMq
         rPsaNqsibSAQWOoso3n+6VDfMlomavxJzp7+uwYBQugm5eZf+UKuP2slrw5R5yioKs
         GBvfjtQKKMr2Jzg1lLsni8QyeZeKYRyU/bppfiKKTTnWS11oqvcQ/TECB/KU8lNK7p
         86o4YQ81Hj6yeoNczmBZeLt4RTACpu9pABZVh5FuLD/nteIVIVIxWT+d0z7nETuKSs
         4o7RpvXbfXRVw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/3] srcu: Warn when NMI-unsafe API is used in NMI
Date:   Thu, 13 Oct 2022 19:22:42 +0200
Message-Id: <20221013172244.1099010-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013172244.1099010-1-frederic@kernel.org>
References: <20221013172244.1099010-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the NMI-unsafe reader API from within NMIs is very likely to be
buggy for three reasons:

1) NMIs aren't strictly re-entrant (a pending nested NMI will execute
   at the end of the current one) so it should be fine to use a
   non-atomic increment here. However breakpoints can still interrupt
   NMIs and if a breakpoint callback has a reader on that same ssp, a
   racy increment can happen.

2) If the only reader site for a given ssp is in an NMI, RCU is definetly
   a better choice over SRCU.

3) Because of the previous reason (2), an ssp having an SRCU read side
   critical section in an NMI is likely to have another one from a task
   context.

For all these reasons, warn if an nmi unsafe reader API is used from an
NMI.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c54142374793..8b7ef1031d89 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -642,6 +642,8 @@ static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU))
 		return;
+	/* NMI-unsafe use in NMI is a bad sign */
+	WARN_ON_ONCE(!nmi_safe && in_nmi());
 	sdp = raw_cpu_ptr(ssp->sda);
 	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
 	if (!old_nmi_safe_mask) {
-- 
2.25.1

