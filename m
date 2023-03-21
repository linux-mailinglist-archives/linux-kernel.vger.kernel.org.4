Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2546C2693
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCUAy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCUAyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:54:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5234302
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7842BB811B6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3514FC433EF;
        Tue, 21 Mar 2023 00:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360080;
        bh=4JKVUVfr/KNdEQUvnPVvHIbWzbq0CTskvJ11UMzP1zk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=SS+vRjrmXAV1hpfsfT9lLngvpeXKeFOvSuiC3bKETimZRUz8dpy35ZrMoc3E3FYap
         vl6iu4rk2w+RJtxcGJ0gm/hp0u1PUL2HG1lyPR0bwIDrw7Qh/m8zRpFrsHXNCBeRJZ
         uj8ArxD718lkSBFIPTT37Ni+a+4fLCZ+0fUDmiHr9MjT9i+13/ZwdVqgxDcRG23FjL
         IvuH4NDmsH0EANc5Qa5TbZqEeD/6dHaj1XcQcdvmd+7KZJK9aFokwV+zMMtBu6kae3
         NTwGMIlmhbmBVVN9v1kMRFrwnwvT6lqOpQT5hrFPvVNaMBTAlthc8KH+IsQoAKZ3JA
         kiru3KdME7a5w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B8FE61540395; Mon, 20 Mar 2023 17:54:39 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:54:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, rostedt@goodmis.org, jgross@suse.com,
        mingo@kernel.org, peterz@infradead.org, corbet@lwn.net
Subject: [PATCH RFC smp] Remove diagnostics and adjust config for CSD lock
 diagnostics
Message-ID: <0c368b66-71b2-442f-a8f7-e6decc4be2d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series removes CSD-lock diagnostics that were once very useful
but which have not seen much action since.  It also adjusts Kconfig and
kernel-boot-parameter setup.

1.	locking/csd_lock: Add Kconfig option for csd_debug default.

2.	locking/csd_lock: Remove added data from CSD lock debugging.

3.	locking/csd_lock: Remove per-CPU data indirection from CSD
	lock debugging.

4.	kernel/smp: Make csdlock_debug= resettable.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |   17 -
 b/Documentation/admin-guide/kernel-parameters.txt |    6 
 b/kernel/smp.c                                    |    2 
 b/lib/Kconfig.debug                               |    9 
 kernel/smp.c                                      |  260 ++--------------------
 5 files changed, 47 insertions(+), 247 deletions(-)
