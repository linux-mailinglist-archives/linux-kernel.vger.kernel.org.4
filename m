Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4CD723308
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjFEWQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjFEWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717510B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD06562B4C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 22:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F86C433EF;
        Mon,  5 Jun 2023 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686003383;
        bh=WVGdFDvKNz9o0nDSSbiXtPP3pwqKvj5fwhy7WCAwqsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuIxGYJwXI3jO5VWQZminZPOdmYJmtywgAGDVctJnc9rwDAMtZPjtHnlsuAtZoA3R
         PtNOUYurq4Z+C0wbcfw30lchccWv9CL/1sBsOek7BDPjxXK83vOHs4URK2iR3Exifk
         m8kv2VgpT4eZnBKu+Ij2k4bv6cHklOa7fEqURCLgszBBr1BtSlxxEm5SbYxEtOOZjl
         xMctHR3t7qagKfDzRa1TRWjQUHBt21HqE3lCTPqbql1+ycLXPl4tiKB1L5TkCdRqtW
         P6jKacFg8kecBXmF/Vb0U44TZa9+872KXkxZi5HClJV3p3b6OW84lC71N1j8EA56LF
         JbNdreTB9F2sw==
Date:   Tue, 6 Jun 2023 00:16:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v6 08/21] workqueue: Use global variant for add_timer()
Message-ID: <ZH5etHqrsRkEG241@localhost.localdomain>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-9-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510072817.116056-9-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 10, 2023 at 09:28:04AM +0200, Anna-Maria Behnsen a écrit :
> The implementation of the NOHZ pull at expiry model will change the timer
> bases per CPU. Timers, that have to expire on a specific CPU, require the
> TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
> dropped. This is required for call sites which use the timer alternately as
> pinned and not pinned timer like workqueues do.
> 
> Therefore use add_timer_global() to make sure TIMER_PINNED flag is dropped.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
