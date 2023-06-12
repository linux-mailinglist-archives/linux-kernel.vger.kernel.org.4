Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD472D12A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjFLUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbjFLUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7088558E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F4C620A0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EC9C433EF;
        Mon, 12 Jun 2023 20:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602980;
        bh=Ln5G/1ffsW20fUWdvDiNE8hPwJEGikakIk5ZGTSKIFc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Nhie0g5yP8nYWaTP5+geYzO6Y3nktaAoVJxkqp2GmMXA+jPx3+S8OYg9cMvQaMMY5
         WYuIhqN+oLt3k/hY4p18TS7krs9BPK44MIM4xnZrZJc+6de2dMl8vZcRrXBILL7b/k
         0xnUgwqp7LGO9lgvIxlku43gSv+MHkJ+wz0MsqvTVg2aJaNCKfVV0/Wn49n6D808I/
         C6OJLmJdywe/mu/mNTZFJruORFINRuVxoiNqNvFbUtjTXUnteD9ZnExvKmq9kId3t+
         ugh/2m8ny5wLM85/UPTu36FcK3SY8qoy8lHiJ4duV51wdb/JQo5KuMxjFNsyfcp+1R
         B2YKyp70F92dg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E87DCE09E7; Mon, 12 Jun 2023 13:49:40 -0700 (PDT)
Date:   Mon, 12 Jun 2023 13:49:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com
Subject: [PATCH csd-lock] Decrease console output from CSD-lock timeouts
Message-ID: <3ee27fe5-cbea-46b6-adb0-48c4dde92b4f@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains a couple of patches that reduce the console output
produced by CSD-lock timeouts.

1.	Reduce logging due to dump_stack of CSD waiters, courtesy of
	Imran Khan.

2.	Reduce NMI traffic from CSD waiters to CSD destination, courtesy
	of Imran Khan.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/smp.c |    3 ++-
 kernel/smp.c   |   10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)
