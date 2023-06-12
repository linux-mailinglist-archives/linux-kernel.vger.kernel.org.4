Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E34072C897
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbjFLOcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbjFLObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68112D7E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33D2260920
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9284C433EF;
        Mon, 12 Jun 2023 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686580222;
        bh=MULwLNbFf3P1vN4nmtQUTBxaihoJbd7UWOxYI11wmx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjP8Lhz9BhM1lrnsJQWL7UYsSnRPW89FswppbZCu7oLXhUrW8IZWzlIGESgT5NVrb
         IAiPqzM+0apZaByh7t99Tbi+vRFAhM5C3kK1aaKSq34EFzTtWxY+YreS1F5QhmN/q9
         mD8cHY6dmKyoXT9JxWuI222RT7PhUcg1YEXq39J9n/uJuuhe6dVMDoDlR/TH/YB/br
         rLa03eGo7+t5bqDIAhCru2JidV/x16ET6R2fR7i9xSoG/DBpn02szUGGeoDAr2i98k
         xGUplOrStwRk25dR6Xw/m/N7JgMAgL6r0J8SKzHblwFjmuLQZKYAVtN57k6K08eMKe
         573+KY51eTzYA==
Date:   Mon, 12 Jun 2023 16:30:13 +0200
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
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v7 19/21] timer: Implement the hierarchical pull model
Message-ID: <ZIcr9Y5yTpJxzF-h@2a01cb0980221ec3a67fd23915238df5.ipv6.abo.wanadoo.fr>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-20-anna-maria@linutronix.de>
 <ZICMBw-Fo-nzqGXb@2a01cb0980007dab8d6b2773c13fd2df.ipv6.abo.wanadoo.fr>
 <46bb6830-660-f9ff-db1c-f67d680ea8c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46bb6830-660-f9ff-db1c-f67d680ea8c@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Jun 12, 2023 at 02:29:25PM +0200, Anna-Maria Behnsen a écrit :
> On Wed, 7 Jun 2023, Frederic Weisbecker wrote:
> Right. It will never stop the propagation - but the condition could be
> fulfilled when call site is tmigr_inactive_up(). My proposal for expanding
> the comment is the following:
> 
> 	/*
> 	 * Walking the hierarchy is required in any case when a
> 	 * remote expiry was done before. This ensures to not lose
> 	 * already queued events in non active groups (see section
> 	 * "Required event and timerqueue update after remote
> 	 * expiry" in documentation at the top).
> 	 *
> 	 * The two call sites which are executed without a remote expiry
> 	 * before, are not prevented from propagating changes through
> 	 * the hierarchy by the return:
> 	 *  - When entering this path by tmigr_new_timer(), evt->ignore
> 	 *    is never set.
> 	 *  - tmigr_inactive_up() takes care of propagation by itself
> 	 *    and ignores return value. But an immediate return is
> 	 *    required because nothing has to be done in this level as
> 	 *    event could be ignored.
> 	 */

Yes, very good!

Thanks.
