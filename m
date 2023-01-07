Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65456611FC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 23:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjAGWLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 17:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAGWLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 17:11:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD053DBC7;
        Sat,  7 Jan 2023 14:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 939E3B80184;
        Sat,  7 Jan 2023 22:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1EAC433EF;
        Sat,  7 Jan 2023 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673129497;
        bh=M+/EBt/sWdGB+tEfsnFShXEaSccBFX+MO9MGYX+lhHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qi5HlktYw3sPrJ+4CuJjHoa1SHWvcckTnYmtXlnS9Jxfvf4ZC0pvU7KqQAHlH6dDI
         eLmMb6OGiGDvQAkkVwm95V8MuF6BA+yxtcmh5baiWNqc8lgAgkOix/lro5+KE8lu5i
         y660iRBnpRVDRHK4QlRkRJx1GRGjn+lJEmfoC/6Ls6KtkCTIAIENxFi9cJ1YmXitQ/
         SwR2Cnppeo6MSx57jpAvh9IuS5I4cL3NVAfRcSva7F+fpgXb7/pfWFAUny9QCgb436
         XSJb5LPbo56vJz3miq+er1WcuSIEdTZ6yAsvdsd3iqraEwrX96zs+IdenODcncsIi9
         HciIXMkBsq/pQ==
Date:   Sat, 7 Jan 2023 23:11:34 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, Zqiang <qiang1.zhang@intel.com>,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Message-ID: <Y7nuFrJ3gjNzXmCz@lothringen>
References: <20221221201634.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <344A2A3B-628E-467C-BBDF-11C3AB63D432@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <344A2A3B-628E-467C-BBDF-11C3AB63D432@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 07:01:28PM -0500, Joel Fernandes wrote:
> (lost html content)

I can't find a place where the exp grace period sends an IPI to
CPUs slow to report a QS. But anyway you really need the tick to poll
periodically on the CPU to chase a quiescent state.

Now arguably it's probably only useful when CONFIG_PREEMPT_COUNT=y
and rcu_exp_handler() has interrupted a preempt-disabled or bh-disabled
section. Although rcu_exp_handler() sets TIF_RESCHED, which is handled
by preempt_enable() and local_bh_enable() when CONFIG_PREEMPT=y.
So probably it's only useful when CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n
(and there is also PREEMPT_DYNAMIC to consider).

If CONFIG_PREEMPT_COUNT=n, the tick can only report idle and user
as QS, but those are already reported explicitly on ct_kernel_exit() ->
rcu_preempt_deferred_qs().

Thanks.


