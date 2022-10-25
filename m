Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02A60D7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiJYXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiJYXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:17:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4483E8C63
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841DD61BF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E136C433D6;
        Tue, 25 Oct 2022 23:17:29 +0000 (UTC)
Date:   Tue, 25 Oct 2022 19:17:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: Re: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
Message-ID: <20221025191741.69a2196f@gandalf.local.home>
In-Reply-To: <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
References: <20221025200656.951281799@infradead.org>
        <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 16:07:25 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The slowness is probably not the trampilines, but just the regular
> "text_poke of kernel text" that we probably want to keep special just
> because otherwise it's _so_ slow to do for every alternative etc.

Yes. That's why I recommended to change patch 4 to:

	if (unlikely(system_state == SYSTEM_BOOTING) &&
	    core_kernel_text((unsigned long)addr)) {
		text_poke_early(addr, opcode, len);
		return;
	}

The only special case we had was the ftrace trampoline that was dynamically
allocated, and there's paths that require updating it (when you add two
function callbacks to the same location).

-- Steve
