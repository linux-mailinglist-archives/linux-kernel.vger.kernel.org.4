Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F175E825C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiIWTH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiIWTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E23124C1C;
        Fri, 23 Sep 2022 12:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19DE86114C;
        Fri, 23 Sep 2022 19:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0662C433D6;
        Fri, 23 Sep 2022 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663960042;
        bh=7H8VpOjF/PEX4j/BXyfxiFyc4XiKNHwJzvMMej31jZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLJi8NGQanMCvftUQWlJfbezIx1RXhCBo4SDMmstuxEfaSe0WcUnZswts/34rZjDe
         zmtTVPtr8/uhzhqfBvwxuc2uvLI0E/FWfJRWuLcnggK1in+YUM/CPEUAkQV0nb2lph
         K31FuPDzG98rboZ6Gndt1Dxr/sGNupEZInWBn7H0NjtmiPk3F04VhEnJpI6XXwR9mz
         W+fJPFgmPVfOuPVHtUKjqLVA2xlcI7U/fl4gosyfHhrmPX7Q/N9EBKXqlDYgF8mfKn
         PvfbPtjj28UPPOs+OKdiw9gKa8TrxhS4ctxKuxLJbjFH1iwUTuJZzU2qaDrF4AaEug
         mi2s552EfTMbA==
Date:   Fri, 23 Sep 2022 13:07:19 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
 <YyjdiKC0YYUkI+AI@kbusch-mbp>
 <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
 <20220921164012.s7lvklp2qk6occcg@quack3>
 <20220923144303.fywkmgnkg6eken4x@quack3>
 <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does the following fix the observation? Rational being that there's no reason
to spin on the current wait state that is already under handling; let
subsequent clearings proceed to the next inevitable wait state immediately.

---
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 624fa7f118d1..47bf7882210b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -634,6 +634,13 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
 
 	*nr -= sub;
 
+	/*
+	 * Increase wake_index before updating wait_cnt, otherwise concurrent
+	 * callers can see valid wait_cnt in old waitqueue, which can cause
+	 * invalid wakeup on the old waitqueue.
+	 */
+	sbq_index_atomic_inc(&sbq->wake_index);
+
 	/*
 	 * When wait_cnt == 0, we have to be particularly careful as we are
 	 * responsible to reset wait_cnt regardless whether we've actually
@@ -660,13 +667,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
 	 * of atomic_set().
 	 */
 	smp_mb__before_atomic();
-
-	/*
-	 * Increase wake_index before updating wait_cnt, otherwise concurrent
-	 * callers can see valid wait_cnt in old waitqueue, which can cause
-	 * invalid wakeup on the old waitqueue.
-	 */
-	sbq_index_atomic_inc(&sbq->wake_index);
 	atomic_set(&ws->wait_cnt, wake_batch);
 
 	return ret || *nr;
--
