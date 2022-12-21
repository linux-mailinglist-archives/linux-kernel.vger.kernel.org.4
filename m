Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E1652A49
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLUAHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiLUAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:07:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477020379;
        Tue, 20 Dec 2022 16:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A29A61631;
        Wed, 21 Dec 2022 00:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E87C433EF;
        Wed, 21 Dec 2022 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671581238;
        bh=40/yi23Gx0orewr4vO98PtbOrrAReeIhFbqm5dfcTUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbCQzgtyTmmDubK8T6uZ5vmuJvVbrK1Jiz80I+9O43dxqz4PKSb4lnxCJSDlKArkA
         GQ3GTrR+wD49I86s+7OJ/sGLjgDJRsNRHKQghkzscRguAnPsBwiIUipmU0OKkvOOxH
         55oFuR/l2MNaBzW2Jud2gqfiWChb+O5DQXJi4JjpgCYzGiz2QAK/vo43eDmRwMihY6
         lVP+OqFI0c/o+6VM5qAvDfZqXSd0Dtp8ZjljU3Fot7SQhLNp3Tx8E++nIYpcy7Hazh
         8X31h/KU8Fk4vPxFnH5BPEfLkQtEtB6svuftb6chtS1Rm5UXy+BU+SqAuGF+kafnGT
         pskGn8ddFzxOA==
Date:   Wed, 21 Dec 2022 01:07:15 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221000715.GA27352@lothringen>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
 <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com>
 <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
 <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
 <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com>
 <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
 <CAEXW_YRqscm++0TP9bEnM0PQNLMe4cXFWAdRvHh2M5chERm+UA@mail.gmail.com>
 <35293ec4-40a1-cf6b-3bdd-0e3e30819c06@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35293ec4-40a1-cf6b-3bdd-0e3e30819c06@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 12:00:58PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-19 20:04, Joel Fernandes wrote:
> The main benefit I expect is improved performance of the grace period
> implementation in common cases where there are few or no readers present,
> especially on machines with many cpus.
> 
> It allows scanning both periods (0/1) for each cpu within the same pass,
> therefore loading both period's unlock counters sitting in the same cache
> line at once (improved locality), and then loading both period's lock
> counters, also sitting in the same cache line.
> 
> It also allows skipping the period flip entirely if there are no readers
> present, which is an -arguably- tiny performance improvement as well.

I would indeed expect performance improvement if there are no readers in the
active period/idx but if there are, it's a performance penalty due to the extra
scans.

So my mean questions are:

* Is the no-present-readers the most likely case? I guess it depends on the ssp.

* Does the SRCU update side deserve to be optimized with added code (because
  we are not debating about removing the flip, rather about adding a fast-path
  and keep the flip as a slow-path)
  
* The SRCU machinery is already quite complicated. Look how we little things lock
  ourselves in for days doing our exegesis of SRCU state machine. And halfway
  through it we are still debating some ordering. Is it worth adding a new path there?

Thanks.
