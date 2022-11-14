Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869DC628914
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiKNTQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiKNTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821B2714C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:16:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668453385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPdwp/g08bka+69OpwNXh951PVSPeIxeURirZGzH7sg=;
        b=gXnLZQgfBsRVUuI5hdUBv17AbkxXV9z5LhVWC8SrYfuLr3xNqphKHYDErBM7X3GRtoNQAQ
        cubatc44CVtC+3a7IoKx/ikfoZpywhmJorhNCQ6aUHJ9kiqUXMxJlh4qO9IzhGRbEa3owF
        8om3hNXqLfmh1jgTJ8VoY/CMfas/UYp2M0zqTAfSvNNPGa3UcedJ/5Y9b63BLr2yzTCj49
        AG6Bx2/SpXn7qSYMmxiBdBcb0+D2sFdbo7SGdHolB0t0RBNjvfhyNPo6oza3XT0YUXWfh+
        Qn0nXVjDaLpBEox8DjjNsXfSJ7PMNgUmliyR7Vvb7E1kPKvT7QcKY5Rs7rlHEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668453385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPdwp/g08bka+69OpwNXh951PVSPeIxeURirZGzH7sg=;
        b=/74L/A6R2vs5VKRIMQjuAmgg/Tknh68uhamhhZD/C2rdYNGMNv5u3KkA+THERROH6/ruzM
        VJpIr4IJ0TbYctAQ==
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>
Subject: Re: [PATCH v1] timerqueue: use rb_entry_safe() in timerqueue_getnext()
In-Reply-To: <BNP2PqwI58CzAxJejDx9BcX2nWxSOo-hoZ1qh_7ZrmvqcNwz49RCBxZscYZCoHTlG7bqz2V12bhc5r88dPKopRgoy_XxO4QypcWoRFe3fMI=@protonmail.com>
References: <20221027212506.3745164-1-pobrn@protonmail.com>
 <87v8nis83n.ffs@tglx>
 <BNP2PqwI58CzAxJejDx9BcX2nWxSOo-hoZ1qh_7ZrmvqcNwz49RCBxZscYZCoHTlG7bqz2V12bhc5r88dPKopRgoy_XxO4QypcWoRFe3fMI=@protonmail.com>
Date:   Mon, 14 Nov 2022 20:16:24 +0100
Message-ID: <878rkds5x3.ffs@tglx>
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

On Mon, Nov 14 2022 at 15:54, Barnab=C3=A1s P=C5=91cze wrote:
> 2022. november 14., h=C3=A9tf=C5=91 1:17 keltez=C3=A9ssel, Thomas Gleixne=
r =C3=ADrta:
>> On Thu, Oct 27 2022 at 21:37, Barnab=C3=A1s P=C5=91cze wrote:
>
>   When `timerqueue_getnext()` is called on an empty timer queue, it will
>   use `rb_entry()` on a NULL pointer, which is invalid. Fix that by using
>   `rb_entry_safe()` which handles NULL pointers.
>=20=20=20
>   This has not caused any issues so far because the offset of the `rb_nod=
e`
>   member in `timerqueue_node` is 0, so `rb_entry()` is essentially a
>   no-op.

Yes. Very precise and informative.

>> Back then when that code got introduced rb_entry_safe() did not exist at
>> all so it's even more obvious that this is simply a missing NULL pointer
>> check, right?
>
> As far as I can tell it did exist and it was actually used
> when the offending change was committed (511885d7061e).

Hmm. I must have messed up when searching in the history.

Thanks,

        tglx
