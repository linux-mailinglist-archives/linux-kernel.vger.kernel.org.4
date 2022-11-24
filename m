Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696A63802C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXU3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:29:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0E3686AB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:29:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669321783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZRhQgUyKTejHhoVRsIy2ZCfjEDs8QLbpfGrSeyryLQ=;
        b=OHv820+G6yIaFPs0vCVP+/BxXBlJj4x0JbbCNKr6ARGqV88M/5zlcgRjgeNaAeZiFneKeQ
        4sXLV9vKqsXYGyRK9eIMRjV5pAbXZrj7A5pKFFAaWJ1rYnDWjESyKk1Qx2yYrgk8ipy6aj
        ivWYhIkl+A4rYKS4+uX/wRj7ZbJHuJ3GVKOnEnOXhchKCPsWHC3xGEoJO3905WexIaxblY
        CuTE1gT5iDVyG8/4wWaf3+qoMjR9mWf+66NAUh1JiV+h9kI8B0/0KeghLgnAoz3delHv0c
        jBVVXs4iytCcbkvKvZ0YpubbOf3gqsyQOzRUuUdpyCWZMXfqRkC1gqF6IbK0PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669321783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZRhQgUyKTejHhoVRsIy2ZCfjEDs8QLbpfGrSeyryLQ=;
        b=0ihy7vsD4gvm43dxriRZ0Ci2xlw9gH96Tdt3yFoNJd46C4nhHfhux1n+qJgZuRYTwx6nML
        uo33Y3w6u44vJnDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 5/7] printk: Use struct console_buffers
In-Reply-To: <Y3+MNS0yarwSgpR+@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-6-john.ogness@linutronix.de>
 <Y3+MNS0yarwSgpR+@alley>
Date:   Thu, 24 Nov 2022 21:35:33 +0106
Message-ID: <87r0xskseq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-24, Petr Mladek <pmladek@suse.com> wrote:
> A better solution would be to remove DROPPED_TEXT_MAX completely
> and pass the buffer size to call_console_driver().

And then call:

    call_cosole_driver(con, text, len, dropped_text, DROPPED_TEXT_MAX);

Is that better? We do not want to pass the actual buffer size because
the buffer is shared with the regular messages.

Later in this series the dropped messages are handled in quite a
different way, so maybe this mid-series solution is acceptable. But even
by the end of this series DROPPED_TEXT_MAX still exists just to put a
limit on the dropped messages length, even if more buffer space exists.

John
