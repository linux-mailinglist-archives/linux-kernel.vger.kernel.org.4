Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F16DE7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDKXES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKXER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8149199D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F75762AA9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7979C433D2;
        Tue, 11 Apr 2023 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681254255;
        bh=CcQzzv/cLNqrvnmKPDrfU/4VZ9/4YNiP/gDgXxLe94A=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=AlKHLzQ8MZj9FA0JpXzDNQCqlnLtdOT4LZHOgFsjxCBbBck8rsD76rE/LuxJAUyMc
         fiFGaODr4o/onzwe38w5XDEhZjdSaDryU4gxm9c5HtMoJo1FTJmcBGEPb0BUP6f6Nc
         Dmxw+xwuYANZJKhCjMa0Q0s0pMtdUHl4ICK0OmvY5Cw+QTB5NMcmHnbNq/iEx+yiUy
         TqApKvvCDZhnrvMB/j3nio2lQX1Ld9ErlqxvhynxjhjnNmE2p1Ouhc+kR5EmSdGCCk
         PZaDEA39zolWH+RzhFL2cymMSOBz3qR6fJHwHBcBBzlU1O4kjb2qbXSFwYDkchci+P
         aSw4EVAvYpkBQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 385431540478; Tue, 11 Apr 2023 16:04:15 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:04:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        kasan-dev@googlegroups.com, elver@google.com, rdunlap@infradead.org
Subject: [GIT PULL] KCSAN changes for v6.4
Message-ID: <147f3556-8e34-4bc3-a6d9-b9528c4eb429@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the v6.4 merge window opens, please pull the latest KCSAN git
tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2023.04.04a
  # HEAD: 8dec88070d964bfeb4198f34cb5956d89dd1f557: kcsan: Avoid READ_ONCE() in read_instrumented_memory() (2023-03-11 12:28:07 -0800)

----------------------------------------------------------------
Kernel concurrency sanitizer (KCSAN) updates for v6.4

This update fixes kernel-doc warnings and also updates instrumentation
from READ_ONCE() to volatile in order to avoid unaligned load-acquire
instructions on arm64 in kernels built with LTO.

----------------------------------------------------------------
Marco Elver (1):
      kcsan: Avoid READ_ONCE() in read_instrumented_memory()

Randy Dunlap (1):
      instrumented.h: Fix all kernel-doc format warnings

 include/linux/instrumented.h | 63 ++++++++++++++++++--------------------------
 kernel/kcsan/core.c          | 17 +++++++++---
 2 files changed, 39 insertions(+), 41 deletions(-)
