Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5C6273CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiKNARG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNARE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:17:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B75114B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:17:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668385021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=298xBiPdMw3VmsAX52yzXCL1aaXNA99BGmwtLF53JB0=;
        b=VW8Wea5ctOF2moD2CSTNeGJrdaxIT4Pp389xo1FAU08w5VNAxi4HJ/h+Tvc7h7Y82VolOQ
        c3Yaas9JDAd7yTQPwjU9xCmO5u+PfMVQ7Nb9t0QW+wIAGcAwiTJMgSBSPoYIlhNw3gVpvU
        3TVubgYrHceb3FKCdyMkfUv4u5ronXzT2h2p4OkkDHMJN5AohcXDjF0csRW/rQ+OBOq1YL
        RaV5DigPcNg7TJopmcFuJxXrez4FVILe5OYopFZJ/gIifVsmBjyz2SSHvSS6ZbUAsaqu0H
        aL8euhlZPc6Hl2FMzQcjfE2T6VKqa5uooO1zMi6ijBUA6RcM08XX1/pDEbZvJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668385021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=298xBiPdMw3VmsAX52yzXCL1aaXNA99BGmwtLF53JB0=;
        b=l87wUFsJWebq3nni0+O4C9yku4r/95K7ZWS+vCWpJbNR+snG+knme4cn0IVehzpzz0wZhW
        BhwSv75dMDGs5eAg==
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>
Subject: Re: [PATCH v1] timerqueue: use rb_entry_safe() in timerqueue_getnext()
In-Reply-To: <20221027212506.3745164-1-pobrn@protonmail.com>
References: <20221027212506.3745164-1-pobrn@protonmail.com>
Date:   Mon, 14 Nov 2022 01:17:00 +0100
Message-ID: <87v8nis83n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27 2022 at 21:37, Barnab=C3=A1s P=C5=91cze wrote:

> When `timerqueue_getnext()` is called on an empty timerqueue
> the returned rb_node pointer will be NULL. Using `rb_entry()`
> on a potentially NULL pointer will only - coincidentally - work
> if the offset of the rb_node member is 0. This is currently the
> case for `timerqueue_node`, but should this ever change,
> `timerqueue_getnext()` will no longer work correctly on empty
> timerqueues. To avoid this, switch to using `rb_entry_safe()`.

I agree with the change but not with the argumentation above.

Whatever the current offset of node is does not matter at all,
really. This is a blantant missing NULL pointer check which works by
chance.

So there is no weasel wording justfied about "coincidentally" and "might
not longer work correctly".

Just spell it out that this is a blantant bug and nothing else.

Back then when that code got introduced rb_entry_safe() did not exist at
all so it's even more obvious that this is simply a missing NULL pointer
check, right?

This also requires a Fixes: tag which flags the commit which introduces
this bug.

Thanks,

        tglx
