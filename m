Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCC6A464D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjB0Po0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB0PoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:44:21 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4830E078
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aq+VLdY4aNQ5pxLlJPA/q6c9pyCPQ69D53VyrAtsJWk=; b=RUDVj7c24v4KEFF+H1IMRrl8YG
        HbRzSpgLY3JFQDrOrTk7Ukfj/h/iqQQvbLpG2NfR6QDaJG9SkUNul7OwTRbGAEy+jvEOI51G7cHDN
        pXXogSkKfhhNg4zAmpr7LZ4SWqa22uOFsE6t8YHQnuvaoXjW1tFYjGJTcWcBBAkmV8YEFHwKRVB9L
        d7rxQqsHdgkN/uU14Oayy8gjCBKK0p5TLzu1mPDC9mMKxhf0yIpLb7dmo6PWmw/woMOY1h1FnsM5v
        0Lq7oodnz+TMmYJtv50UwVi0sO+GGuR6n/XAavvvhsn8jAWecrAe52FNBJZUopi9M9GMTVCr+ORIW
        QCBoWs4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWffU-00EGTN-2e;
        Mon, 27 Feb 2023 15:44:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5DC03003E1;
        Mon, 27 Feb 2023 16:43:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F576209F7545; Mon, 27 Feb 2023 16:43:59 +0100 (CET)
Date:   Mon, 27 Feb 2023 16:43:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Schspa Shi <schspa@gmail.com>, linux-kernel@vger.kernel.org,
        cocci@inria.fr, mcgrof@kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        buytenh@wantstofly.org, johannes.berg@intel.com,
        gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch
Subject: Re: [RFC PATCH] cocci: cpi: add complete api check script
Message-ID: <Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
 <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
 <20230227102808.2cea9705@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227102808.2cea9705@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:28:08AM -0500, Steven Rostedt wrote:

> So what exact race are you trying to catch here?

on-stack copmletion with a wait_for_completion that can return early
(eg. killable, interruptible, or timeout) can go out of scope (eg, free
the completion) with the other side calling complete() on some possibly
re-used piece of stack.

IOW, Use-after-Free.

Care must be taken to ensure the other side (whatever does complete())
is either terminated or otherwise stopped from calling complete() on an
out-of-scope variable.
