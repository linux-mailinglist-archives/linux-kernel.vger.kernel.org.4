Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC452682246
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjAaCiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAaCiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:38:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79D3754F;
        Mon, 30 Jan 2023 18:37:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09DF61231;
        Tue, 31 Jan 2023 02:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C00C433D2;
        Tue, 31 Jan 2023 02:37:38 +0000 (UTC)
Date:   Mon, 30 Jan 2023 21:37:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] trace: acquire buffer from temparary trace sequence
Message-ID: <20230130213735.72cdcee4@gandalf.local.home>
In-Reply-To: <e2735a3a-4a9b-8b3a-0671-b3f56187cbe2@quicinc.com>
References: <1675065249-23368-1-git-send-email-quic_linyyuan@quicinc.com>
        <28cd9aca-1945-ceed-2756-162132d576ef@quicinc.com>
        <20230130143041.713c4c7b@gandalf.local.home>
        <e2735a3a-4a9b-8b3a-0671-b3f56187cbe2@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 10:06:22 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> yes, agree it will be safe for dwc3, but i don't know if any possible 
> hacker,
> 
> as the function always return a valid pointer even when hacker input a 
> large size.

But gives a nice big warning if that's the case. This is not something that
can be modified by user input. We do not need to worry about
kernel implementations that could overflow (and trigger a WARN_ON() when
they do). Especially since the max size is greater than the max size of the
content of an event.

A lot of systems that worry about hackers enable "panic_on_warn" which
means that if the WARN_ON() triggers, the machine will crash, which will at
most cause a DOS, but not something people can use to hack into the machine
with.

-- Steve
