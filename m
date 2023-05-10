Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916C86FE312
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjEJRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjEJRMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E093A93;
        Wed, 10 May 2023 10:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24B936369D;
        Wed, 10 May 2023 17:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8842FC4339B;
        Wed, 10 May 2023 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738751;
        bh=gr85dVwKcpocSLV0KAz9yZW75g5pZOlyjCjWTPb6YUI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=nVlYyaQ72QNzzjIguzJTVbRaeiPapJzfHqnASqyVsHPnaJfFigpbiAA9kVqAmKjjB
         IlKPDh7uhFclonTbt5pBc9mJtP5JH387PRyJ+tv+7Gc90E+LvE+39EF7c4aUS3h8tA
         WriZ4FSIOPYoL83ZDDDEo8oslyV35FUO8Vhwj4C+cfa9UpNT0nEFqATVK5BVNH+Lqq
         d/6IMkfsoJRwO1mxs1ApiSYp9s/kK/EtFIB0LrNaJnCDeNQLK82IZG3i4D9cz3PLsi
         Qi9aFdeF0TlkzWx27w8fV7RYMkCiCOsNZMzEaSBrhGMabNcw518YtfxXRkqSOJcgoW
         XekqSVK6AZaWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 32219CE126E; Wed, 10 May 2023 10:12:31 -0700 (PDT)
Date:   Wed, 10 May 2023 10:12:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/6] Torture-test updates for v6.5
Message-ID: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains torture-test and torture-test-scripting updates
for v6.5:

1.	Add long_hold to adjust lock-hold delays.

2.	Correct name of use_softirq module parameter.

3.	rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup(),
	courtesy of Qiuxu Zhuo.

4.	rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading
	rcuscale, courtesy of Qiuxu Zhuo.

5.	doc/rcutorture: Add description of rcutorture.stall_cpu_block,
	courtesy of Zqiang.

6.	Remove duplicated argument -enable-kvm for ppc64, courtesy of
	Zhouyi Zhou.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt                  |   12 
 b/kernel/locking/locktorture.c                                     |   51 +-
 b/kernel/rcu/rcuscale.c                                            |  194 +++++-----
 b/tools/testing/selftests/rcutorture/bin/functions.sh              |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot       |    2 
 kernel/rcu/rcuscale.c                                              |    5 
 7 files changed, 137 insertions(+), 131 deletions(-)
