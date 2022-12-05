Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AD642C23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiLEPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiLEPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:43:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40F82AE6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90D41611B1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDF3C43470;
        Mon,  5 Dec 2022 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670254994;
        bh=6Jkpcbz2+lmt6R4sfmgb60TXELGrckoMvdie+pxdwac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvm7ORve90+o4kTA1XNBtbQdrwhckcIgIoClFecJWIeYppqGWyvah0WcQ+l6b+sVS
         efMvtMmYTp+9b7y6wiKelnxhk31t+K76aaD2OMDfLhefoLXIqH3SydbTpMFrZfGTiP
         t9h7MSobO05sroySfBt7PLuQwjqk/kfiazMN2oHBLOqUP1mvef1rVJB/BczYnVenXi
         uDaHcAqnMiEXElohAZexTTlrEZ11ne3l82hNzi2tbgvz7AImYD+5rusoD+t8MnwC4U
         Qfoo1pwrjg6Jp1ok+yOb/x6Jzmurbkj/Dz61cLHxuqdvnOv5bJsDu9dn7CIbgr9qCB
         w0sDtVe5Z0H3Q==
From:   Will Deacon <will@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: kprobes: Fix bugs in kprobes for arm64
Date:   Mon,  5 Dec 2022 15:43:04 +0000
Message-Id: <167025000853.271112.9111364887989842067.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <166994750386.439920.1754385804350980158.stgit@devnote3>
References: <166994750386.439920.1754385804350980158.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 11:18:23 +0900, Masami Hiramatsu (Google) wrote:
> Here is the 2nd version of the kprobe bugfixes on arm64. The previous
> series is here;
> 
> https://lore.kernel.org/all/166990553243.253128.13594802750635478633.stgit@devnote3/T/#u
> 
> The first one is a critical issue, which will cause a kernel crach
> easily with lockdep[1/3]. Others are minor issues and rare cases.
> The [2/3] let do_page_fault() fixup the page fault in kprobes user
> handler, and [3/3] is more like code cleanup and returns
> DBG_HOOK_ERROR if it can not handle kprobe's BRK (but that
> should not happen.)
> 
> [...]

Applied to arm64 (for-next/kprobes), thanks!

[1/3] arm64: Prohibit instrumentation on arch_stack_walk()
      https://git.kernel.org/arm64/c/0fbcd8abf337
[2/3] arm64: kprobes: Let arch do_page_fault() fix up page fault in user handler
      https://git.kernel.org/arm64/c/30a421552373
[3/3] arm64: kprobes: Return DBG_HOOK_ERROR if kprobes can not handle a BRK
      https://git.kernel.org/arm64/c/3b84efc066f8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
