Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D247A68BFE6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBFOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjBFOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:19:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E65206BE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:19:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B6160EE0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683B9C433EF;
        Mon,  6 Feb 2023 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675693178;
        bh=a4NpdbPrw3WI3ONQoUEsW9MXLhNxjZUgmACOGtc6hBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBaujdg31yHMMyUP5n0tvcfECvvOYk14AfjJLmK71BGcxwLnBAQNL34KLS7iyze2e
         ErL+cco9HxLhfLmiK709/GqOOI+BdqTP9MUNU63AY5tAuz/TASsWu77teORPSaT7Av
         tMfBcLfs/qPuk1PpHL+WczG39mVpb8u84iKM40THIqVvJrzRg1mfyoMlQYGwWeg75I
         DedhxWjn3PtvNAH4SJiVGtU0H6irw5yio+nBnA5vSJ4oH1zCc7tgfNFGG8NDC0inVg
         +vd44ZEZzrz5rKfhyLz2kmf2rBs/YdRAGRjYU2jMJYMLy693rXsEDNaPLA1g2ytKeb
         xKPPOXaEYeuZQ==
Date:   Mon, 6 Feb 2023 23:19:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Message-Id: <20230206231934.7ccbf7bf1f31b404783b10f9@kernel.org>
In-Reply-To: <5DFB6E19-210E-4EA8-8D71-66FF4A787942@gmail.com>
References: <20230204210807.3930-1-namit@vmware.com>
        <5DFB6E19-210E-4EA8-8D71-66FF4A787942@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Feb 2023 09:49:56 +0200
Nadav Amit <nadav.amit@gmail.com> wrote:

> 
> 
> > On Feb 4, 2023, at 11:08 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
> > 
> > From: Nadav Amit <namit@vmware.com>
> > 
> > Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") broke
> > kprobes.  Setting a probe-point on 1 byte conditional jump can cause the
> > kernel to crash, as the branch target is not sign extended.
> > 
> > Fix by using s8 instead of char and use immediate.value instead of
> > immediate.bytes for consistency.
> 
> I guess I forgot to put a “Fixes” tag, since it is still not a real
> regression. (The bug was introduced in 6.2).
> 
> Still, this fix should not fall between the cracks… Please let me know
> whether v2 is needed with a “fixes” tag.

No problem, I added Fixed tag with my Ack :)

Thank you!

> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
