Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D36669A935
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBQKo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBQKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:44:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E5763595;
        Fri, 17 Feb 2023 02:44:53 -0800 (PST)
Date:   Fri, 17 Feb 2023 11:44:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676630691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkPcPd+xgtQsD3qZIGba0QRwG2JOhIDxaj1fNHLfpMw=;
        b=TZJQ+5WxgqmWuzYUeu7YhjuLHoxQ+myMZtFhxviZkfbUcZ3FwezBsLoSFbSCQ0iEVcA79k
        c5CF+48slEEX6po7q56zJNZCmRxbezeDONFXjOt4MCY4YKz9Sm9JwxYhXrveGA42M65BkI
        6eHXPZ/W9R9QLHQAAMDMSc5TFcLwoA+863ApZ2xIeHAO7dj4rlr9iWPETkEwXI4h16v9hJ
        Htfk93Gq3RtJIm7s6FKanrx+5htuHZFTVtAqunj8cvy76YiFHy7X8Ouj7uYKMK1FuZN3Cx
        apUTYcZRDWbHOkglDBQ64ZhYxkL1tzeeSGB06NY9Qac+nQ+NaFSzJnEz6y75QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676630691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YkPcPd+xgtQsD3qZIGba0QRwG2JOhIDxaj1fNHLfpMw=;
        b=bUArmIts3itq27MMl4ap3gaew9ndIvFWlsbJjuZXQcqhhorDcHkXkj2WBohJfEXx//ua16
        RbMIhZspIlsLhEAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Johansen <john.johansen@canonical.com>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org,
        Anil Altinay <aaltinay@google.com>
Subject: Re: [PATCH v3] apparmor: global buffers spin lock may get contended
Message-ID: <Y+9aoFjrYkpFSvuE@linutronix.de>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16 16:08:10 [-0800], John Johansen wrote:
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -49,12 +49,19 @@ union aa_buffer {
>  	char buffer[1];
>  };
> +struct aa_local_cache {
> +	unsigned int contention;
> +	unsigned int hold;
> +	struct list_head head;
> +};

if you stick a local_lock_t into that struct, then you could replace
	cache = get_cpu_ptr(&aa_local_buffers);
with
	local_lock(&aa_local_buffers.lock);
	cache = this_cpu_ptr(&aa_local_buffers);

You would get the preempt_disable() based locking for the per-CPU
variable (as with get_cpu_ptr()) and additionally some lockdep
validation which would warn if it is used outside of task context (IRQ).

I didn't parse completely the hold/contention logic but it seems to work
;)
You check "cache->count >=  2" twice but I don't see an inc/ dec of it
nor is it part of aa_local_cache.

I can't parse how many items can end up on the local list if the global
list is locked. My guess would be more than 2 due the ->hold parameter.

Do you have any numbers on the machine and performance it improved? It
sure will be a good selling point.

Sebastian
