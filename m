Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107056C5525
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCVTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCVTpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37A305E0;
        Wed, 22 Mar 2023 12:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAA1C622AF;
        Wed, 22 Mar 2023 19:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F738C433D2;
        Wed, 22 Mar 2023 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514304;
        bh=PPkDyBVVf8w8v6mw+4XPEuSPjWp6kxHOeiuCNFfBI38=;
        h=From:To:Cc:Subject:Date:From;
        b=HcWR+Ff+mJbTZ0G5yBcSNlIGCRNjfC/0Kdp9cp8WdHWqAaJ0+an/R5Mac/g5WjFPe
         64t/xa4KeUdJXCUjljOBoY+UVPMUxa6hnVivDCaPu7dQhqJqJmrS7/w5unHOxNLru+
         yHhfD1P9UwrLQ/TKq/Sv1s2KisBn7BuCnLOgGajPxs3U2chDZD0Ss50H4EkHy18f97
         RnKts3CsAOUKPhwfJpFdDpGeM90QZpi76Q+9tN28DSdf25JMJwdhtFRhqJrCzIzss/
         Ax1YbFf7BIm4gDYd6y+rf/DCtnBc5GblaBCCKB+yVuh1OHoo0BN2tnOogNFoKFnP5X
         JZDCq6xpQVPeg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/4] rcu/nocb: Shrinker related boring fixes
Date:   Wed, 22 Mar 2023 20:44:52 +0100
Message-Id: <20230322194456.2331527-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a couple of boring fixes related to the shrinker.

1/4: is related to (de-)offloading so the issue only concerns rcutorture
     right now (which doesn't seem to test lazy so hardly possible to trigger).

2/4: fix ignored flush, making the shrinker more efficient but nothing
     critical.

3/4: optimization

4/4: optimization

As such none of these patches carry a "Fixes:" because none fix an actual
regression. Nothing worth backportng.

Frederic Weisbecker (4):
  rcu/nocb: Protect lazy shrinker against concurrent (de-)offloading
  rcu/nocb: Fix shrinker race against callback enqueuer
  rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from shrinker
  rcu/nocb: Make shrinker to iterate only NOCB CPUs

 kernel/rcu/tree_nocb.h | 43 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

-- 
2.34.1

