Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E46EB508
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjDUWiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjDUWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:37:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1ED1FD5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:37:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682116606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfH5BpbyKK5dQ34jS/OCQSHqGj3SkYW4711d7npJf2Y=;
        b=LzhU38WhkF9t4rpK1JwXvStTBvNKVfnjKU/VPFgHZdCzzYnts6mh7saLLkJamXUGJKVl/c
        4ntB0TJDA/j46NHTfnAnuKzs4A5EtRv+8HA5kUy02D4UH9DA5IDcmKb9OAFpC/+8Y6Oc12
        HmTvN1OHm5jHKWN8og1cOzkx4Wbz9zHQOWElhkDDmZCjvDKXGocSSWG+odrisiti13JsYT
        wk+xE5c/qJBgY7x0VQ/d2QnPjING/ATCot/fV5IgvKWBAFjW69jZT8XNKdMV6nuXEzeoTQ
        l6v8uAhRFyfQg7y5Oq35cQdglrLs87O8uV6EVdzW7W9/8HiXbpoWaFkD00nXfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682116606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfH5BpbyKK5dQ34jS/OCQSHqGj3SkYW4711d7npJf2Y=;
        b=ydJ7hxttLPLtG8Awp5k6BJ8dPwUf+kOG4J+cLpOKI9YsMSlfaDuyrTfy7+8FiPPtiHmpna
        gxnXlxB5fEWjBRDA==
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Marco Elver <elver@google.com>
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in do_timer_create /
 do_timer_create (8)
In-Reply-To: <CACT4Y+b2Bf6N=Wto686X=BJsjhpDJw7Xm4yJtszgxCSogX+0-g@mail.gmail.com>
References: <000000000000a3723305f9d98fc3@google.com>
 <CACT4Y+b2Bf6N=Wto686X=BJsjhpDJw7Xm4yJtszgxCSogX+0-g@mail.gmail.com>
Date:   Sat, 22 Apr 2023 00:36:45 +0200
Message-ID: <87cz3w277m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21 2023 at 16:49, Dmitry Vyukov wrote:
> int first_free_id = sig->posix_timer_id;
>
> runs concurrently with:
>
> if (++sig->posix_timer_id < 0)
>     sig->posix_timer_id = 0;
> if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
>     /* Loop over all possible ids completed */
>     ret = -EAGAIN;
>
> I am not sure how important/realistic this wrap-around handling is,
> but as the result of the race first_free_id can be negative (if it
> reads the value at just the right moment). Then wrap-around will never
> be detected and the loop will loop forever uninterruptably.

It's probably not that problematic, but that code is silly for other
reasons. I'll have a look.

Thanks,

        tglx
