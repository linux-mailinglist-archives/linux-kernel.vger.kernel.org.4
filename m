Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3076CEE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjC2QFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjC2QEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:04:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397E5BA8;
        Wed, 29 Mar 2023 09:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40210B8236E;
        Wed, 29 Mar 2023 16:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38526C433D2;
        Wed, 29 Mar 2023 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105729;
        bh=lx3TrAbltwvzH4QW9sL8P4Gy/TS4hD3+w3Gd7oM5RoU=;
        h=From:To:Cc:Subject:Date:From;
        b=qw/hYqwLX8TRyklLaIXKUOwMpPUwE92/w392jCAT7LU9H3p2s1Hy95GHWq4BPWWp0
         spIsY99rGY3SSLSZjj5ACIOD2qxvfcIPeGWgBP+AFF/W/NFN4vm6ELc5bE4OrLUjc9
         WbiLVrxCKcf8Hwtay4hfIWu+KdU8goiMeKRoeD69D+UfK9n8kGUcKdvZB0Zo+27EqK
         sV9WvgMvsdWt0PPq4eDgM0hc0kUC0R9SVgDwZm4lphgrIu1a3GoMwNyd11KrFUvTAJ
         kEZNpIo+M0kI7POj95RBM754pW7tZIxG6OqhIM2wa7uMNqGRJx4/qUxzfJlj18+60Q
         YvLMe0mmsTmlA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/4 v2] rcu/nocb: Shrinker related boring fixes
Date:   Wed, 29 Mar 2023 18:01:59 +0200
Message-Id: <20230329160203.191380-1-frederic@kernel.org>
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

Changes since v1 (https://lore.kernel.org/lkml/20230322194456.2331527-1-frederic@kernel.org/):

* Use mutex_trylock() to avoid inverted dependency chain against
  allocations.

* WARN if an rdp is part of nocb mask but is not offloaded

Tested through shrinker debugfs interface.

Frederic Weisbecker (4):
  rcu/nocb: Protect lazy shrinker against concurrent (de-)offloading
  rcu/nocb: Fix shrinker race against callback enqueuer
  rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from shrinker
  rcu/nocb: Make shrinker to iterate only NOCB CPUs

 kernel/rcu/tree_nocb.h | 52 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

-- 
2.34.1

