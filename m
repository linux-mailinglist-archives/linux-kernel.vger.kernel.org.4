Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6569ECA9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBVCC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBVCCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:02:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77930B2F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E646D6122F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAC1C433EF;
        Wed, 22 Feb 2023 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677031339;
        bh=wvHMIa+ob9baKmyFh8pKNyZ/gO7n0npNY5fD6niPVQw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=B+mUTw590Bx+O4gxAAqE7Ec/bZmOouS3PADlJKykXWAduCx3YsHMRxGqu3jHK7NQm
         tZ/8PnGgKAca+zknoAHjpXdcQxVxsEU8ZbbQWFbbNvVTo/wy1FtFvqsxutQbShrXpE
         ZoI3CdG0xSuxp7UqrBEbCmcVsPCwCPihwQy8Gyhf1Jyq5PC+NItn9XUIUQrw4lHfvD
         EymkdwSpLtTaT/yIigX6X1c6fH+z21MStM/bCXRlQvOoODG1AnkurD8ITvUP/M4t9X
         dN+GjzsSqGTnwevBCPuqOhFNCbwvk/6Cpn3tX9ToPVz8Vom155ulhmr5wouikXNtxz
         53TwcJZ/pU29g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EB21D5C10B5; Tue, 21 Feb 2023 18:02:18 -0800 (PST)
Date:   Tue, 21 Feb 2023 18:02:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [GIT PULL] x86 NMI diagnostics for v6.3
Message-ID: <20230222020218.GA1345108@paulmck-ThinkPad-P17-Gen-1>
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

Hello, Linus,

Please pull the x86 NMI diagnostics series from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nmi.2023.02.14a
  # HEAD: x86/nmi: Print reasons why backtrace NMIs are ignored (2023-01-19 15:55:12 -0800)

This is of course not normally something that would come up through the
-rcu tree, but these have Ingo Molnar's Reviewed-by tag.

----------------------------------------------------------------
NMI diagnostics for v6.3

Add diagnostics to the x86 NMI handler to help detect NMI-handler bugs
on the one hand and failing hardware on the other.

----------------------------------------------------------------
Paul E. McKenney (2):
      x86/nmi: Accumulate NMI-progress evidence in exc_nmi()
      x86/nmi: Print reasons why backtrace NMIs are ignored

 arch/x86/kernel/nmi.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nmi.h   |   8 ++++
 lib/Kconfig.debug     |  11 +++++
 lib/nmi_backtrace.c   |   2 +
 4 files changed, 128 insertions(+), 1 deletion(-)
