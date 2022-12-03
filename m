Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4825641893
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 20:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLCTYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 14:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLCTYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 14:24:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E3F1EC4F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 11:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D57D60C22
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628D0C433D6;
        Sat,  3 Dec 2022 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670095484;
        bh=JUp6B8Bo1nFz+tUHWLw2P8WpCd3uKHnoADRuuI+X24g=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=hgg23mqbXH7360ej/FyVq++Ia9E1H3Ihj8ZfHh/KisjKFCsGmCJ4Lp0j9xSmzHlwj
         Q/VjEFHNRNqgwlFooRbIDEb5HIPZxeSDJAxybaiYAlYPCUrOZQVUWL10JZaF/Yt91B
         WGxlKQ45Yz0n3T1Bp2Ep+lBra8X324+PQ2kPGOhApMri5AD8e2Eugi+FvKcGBUOi6F
         SyVWKw6e52Sap5XtNIStNZQEx3nVytPptcg26JM88ncO9fExDA+c/VFC5Iq5qZZvMw
         euqDJtEQFwXlLutHsh9kU2UUnYHZNbU3EZvrBTWy2SJeUXpqZbg5EdXZ+5szfaLFog
         wMXkKTDQMnXNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F406D5C03F8; Sat,  3 Dec 2022 11:24:43 -0800 (PST)
Date:   Sat, 3 Dec 2022 11:24:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, ebiederm@xmission.com,
        tglx@linutronix.de, bigeasy@linutronix.de, luto@kernel.org,
        Liam.Howlett@Oracle.com, fenghua.yu@intel.com, peterz@infradead.org
Subject: __put_task_struct() WARN_ON(!tsk->exit_state)?
Message-ID: <20221203192443.GA1270730@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PLING_QUERY,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

One of last night's rcutorture TREE03 runs triggered the
__put_task_struct() function's first WARN_ON() complaining that
the tasks's ->exit_state was zero.  This was on mainline merged
into RCU's "dev" branch.  There immediately follows a splat from
refcount_warn_saturate(), so there are two interlaced stack dumps.  :-/

What I do have seems to implicate rt_mutex priority boosting triggered
by RCU's prioritiy boosting.

Left to myself, my next steps are to try to reproduce this.  It happened
once in 150 hours of TREE03, so who knows?

But I figured I should check to see if anyone else is hitting this.

						Thanx, Paul
