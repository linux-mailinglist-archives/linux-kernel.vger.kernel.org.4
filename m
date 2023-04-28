Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D026F1261
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbjD1HaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbjD1HaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:30:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C36E26A1;
        Fri, 28 Apr 2023 00:30:20 -0700 (PDT)
Date:   Fri, 28 Apr 2023 09:30:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682667018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tN4Is3StFqX6AUDx4ZBtDx5Nj+CllWKd/w/6il3hpyQ=;
        b=wqx15uW1RLL0CbZDoxYf5ZOThN2vIOeOq2pRMcep3M6h57EQBqS88obhqiWbiw88KViOj6
        VA9ReGQc1QdyFAU9Gnu0TvgpcXr2nJoMzLhf67lUeuOCdPETj+rrDQlY595Qk93t3RsRo1
        0LM7o3oy4fgT10huAydY8TmBduSwhpCojwWPdG+wd+jyUCw33XwLC//pPeuhftiFBfonp+
        22G7LfpOG5qABkwEuu2FEvauekWlNzGgu2IkD/WHuUCArEEroDybVQZHHhtotts8UvPDLO
        1/NqGZlcelpcpp6qqvob0aYwbCWiMEAyuHcRpq5iz2+gWeLztgzNKXOppRs9dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682667018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tN4Is3StFqX6AUDx4ZBtDx5Nj+CllWKd/w/6il3hpyQ=;
        b=CY/OuaBlaNjH98AS9nB9bbKmsmkIbHNhue8djrmt85kZjYTw4OyGfX3OLYI3jiKqaWeXOn
        oEy3cUiN/9aAPTCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Message-ID: <20230428073016.YfrIGGoN@linutronix.de>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <87pm7qxrg6.ffs@tglx>
 <19641ab0-ab6a-9af7-8c64-34030e187848@siemens.com>
 <871qk5782i.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qk5782i.fsf@kurt>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-27 15:45:09 [+0200], Kurt Kanzenbach wrote:
> > Are we aware of other concrete case where it bites? Even with just
> > "normal" contented spin_lock usage?
> 
> Well, some years ago I've observed a similar problem with ARM64
> spinlocks, cpu_relax() and retry loops (in the futex code). It also
> generated latency spikes up to 2-3ms. Back then, it was easily
> reproducible using stress-ng --ptrace 4.

That was fixed by
	https://patchwork.kernel.org/project/linux-arm-kernel/patch/1399528508-2806-1-git-send-email-arjun.kv@samsung.com

if my memory serves me well.

> Thanks,
> Kurt

Sebastian
