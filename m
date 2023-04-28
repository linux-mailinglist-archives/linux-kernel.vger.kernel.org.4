Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA97B6F2164
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjD1XsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347091AbjD1XsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A7D5BAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90EED60E93
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B9CC433D2;
        Fri, 28 Apr 2023 23:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682725628;
        bh=R5vn2ZgdnPfmCjY37PzWzk8rZPbh5zWmOOaRiO9280E=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=a59f2r2YAmrSaA2nUjozRUiwjqqIZoWWf93NShGnXPGNZLmgOKd6clkLcbJqBI9lP
         jWJqq8/kLswsCpsxuTje9qcuBCCVyE5ZyrYKnBh5VNVRLS5ZGOJuaNSkS+ayzeLlP6
         drd73vOstaYzeDLS6x0ozNmRjKLvWQASFDUMGPY2btMEdtdzn8kHP6/hSLNnIWCCms
         XZN6U9ZD5wjgFF8V0YWn4fQv9xMwzjSi2m90iVVzJPQFQnwxVzmm4mOFXxRw6HeyQc
         P9ZbVAdeoA3a6ylrfaD9GgC8MEP1Vqjs+5xCNIHJmWZThwTz9WkL3wsLJKtIENBOi3
         kKMb+ZqHV7XBg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7FB4115404E8; Fri, 28 Apr 2023 16:47:07 -0700 (PDT)
Date:   Fri, 28 Apr 2023 16:47:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH workqueues] Further upgrade queue_work_on() comment
Message-ID: <ae548f82-fd4e-490e-889a-3307b9a2c531@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current queue_work_on() docbook comment says that the caller must
ensure that the specified CPU can't go away, and further says that the
penalty for failing to nail down the specified CPU is that the workqueue
handler might find itself executing on some other CPU.  This is true
as far as it goes, but fails to note what happens if the specified CPU
never was online.  Therefore, further expand this comment to say that
specifying a CPU that was never online will result in a splat.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Tejun Heo <tj@kernel.org>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..2dd3308edc01 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1537,6 +1537,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
  * We queue the work to a specific CPU, the caller must ensure it
  * can't go away.  Callers that fail to ensure that the specified
  * CPU cannot go away will execute on a randomly chosen CPU.
+ * But note well that callers specifying a CPU that never has been
+ * online will get a splat.
  *
  * Return: %false if @work was already on a queue, %true otherwise.
  */
