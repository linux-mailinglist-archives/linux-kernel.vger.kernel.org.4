Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8D5FA7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJJWkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJJWkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:40:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162578BD6;
        Mon, 10 Oct 2022 15:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED40DB80E34;
        Mon, 10 Oct 2022 22:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245DDC433C1;
        Mon, 10 Oct 2022 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665441606;
        bh=0cKcSLCQOdzp5id98wc+RBwQs1pyzsIL5VN0NjeNlRo=;
        h=From:To:Cc:Subject:Date:From;
        b=UZ6SKJH0c7rUyzrJIAMr68lY07U3H1Xce7xvU/4A0IkDATfKZ9hf0X+CjDb1rIshZ
         GG2zP8XrMGiKnYDCh9L4JUyxMC1SG/Al51nirt/DQ8GcUgv4FoP/awVylCweFtfr/j
         TXg9sHq/9Tg+pymHCWPb9khANo+8QfLXU0Tt3nF8jX86kZOaZ4dFsrzgpqk1TIQtDf
         tdEfsbZcYZacG/js0747AFmumOa5tJ1tHNLF7Litek21wiVRq+cUtISjI5zwdmcRPh
         OWZwyo6gQK0aKpS6ky2zHIX3M87x/v/3Dyya5A4hYRX8GO5+WFKbl3nADFD9IWFKBN
         RTpmEEXj4lK0A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH 0/2] rcu/nocb fix and optimization
Date:   Tue, 11 Oct 2022 00:39:54 +0200
Message-Id: <20221010223956.1041247-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
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

I wanted to send this a few days ago but then I faced a TREE01 stall
(rcu_barrier() related). I just couldn't remember if it was before or
after these patches... But finally looking at the log, I found the
head which is e8c56bb5baa6969bf2d01b8619f22f5a71818497 (an old RCU:dev
head from more than a month ago, way before these patches). Phew!

Anyway I re-launched many times TREE01 on latest RCU:dev before and
after these patches, it has run both ways more than 600 hours without
any issue...

Frederic Weisbecker (2):
  rcu: Fix missing nocb gp wake on rcu_barrier()
  rcu/nocb: Spare bypass locking upon normal enqueue

 kernel/rcu/tree.c      |  6 ++++++
 kernel/rcu/tree.h      |  1 +
 kernel/rcu/tree_nocb.h | 11 +++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.25.1

