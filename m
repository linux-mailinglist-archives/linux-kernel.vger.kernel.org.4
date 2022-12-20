Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2DD652940
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiLTW6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiLTW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:58:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377CB1F2F1;
        Tue, 20 Dec 2022 14:58:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAE67B81A01;
        Tue, 20 Dec 2022 22:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271BCC433EF;
        Tue, 20 Dec 2022 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671577079;
        bh=8+lijh8xkYJmCW+tgcGnoiFR5gOK2W4q0pc0yUXBS2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdjsc4KMNZycrNr4Kh6u0XxZnE8UVFNrAgQlXeYr8IUtudF+K9G8k53HrZSorZdqN
         d3gWl1tbuO8jWghgJbxNR2XuRaMx1Ts7FMznRo/hZG8TKbKHAsjG6SNGjUcEwETUCU
         x1jiEC3ptSHNdHFryr3BXldur0+N1fbUmJTTatKPqbXwx9vha14pA3FPy4NHExQJoM
         Q+xO9UdirY2zcEp8SCn5kS4Ggzyawo5fn7S7B1zi528meJur9GibenGyikCu+GKvG7
         IvJBf8g3tpHOW0bRKGFBzgrUjVmiI85tZ3wJevcEvxLRXETqfIaNbg21LU8BwcV1to
         5Kyk4J44Y8Qnw==
Date:   Tue, 20 Dec 2022 23:57:56 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221220225756.GB26563@lothringen>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:01:30PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-20 13:29, Joel Fernandes wrote:
> > 
> 
> > I do want to finish my memory barrier studies of SRCU over the holidays since I have been deep in the hole with that already. Back to the post flip memory barrier here since I think now even that might not be needed…
> 
> I strongly suspect the memory barrier after flip is useless for the same
> reasons I mentioned explaining why the barrier before the flip is useless.
> 
> However, we need to double-check that we have memory barriers at the
> beginning and end of synchronize_srcu, and between load of "unlock" counters
> and load of "lock" counters.
> 
> Where is the barrier at the beginning of synchronize_srcu ?

rcu_seq_snap() ?

> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
