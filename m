Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5587628472
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbiKNPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbiKNPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:54:42 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D202DAB5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:54:40 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668441276; x=1668700476;
        bh=D9pd/GSe7CysleXLWr8DdYAfbfFA6TQ9To8qlC4a4rk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Rn8IPitLRkNTeAiCB0IPjpZPDAsxlcfaIyE0cGg/qwLwfGvY/2IwysoWqJJq70lZc
         E/PnYLiFMqPRdDOD13xdoZzXf44rH+rt4nyRVplVL9heFWLdWV9mOW3Sk8XSka+JPY
         Q1DIJq57RZ7JkG0XVXkXgqjPgs6J2ruoZKiawMjI5Rzj+WiEOiInLQhgIZl6GcJsvX
         lRE4DN2zM5WuAn23FLfGBDRrH/y7tUfwMGLSZZzXF85RBluSA9j+9YebhHhfIRPIZL
         LjvyeeCsES8EJPCylvWj9ROVWTmtRCLvpRg5z8Rh7bjgATnvCLF88BsOhqRsYCd7VV
         fSOpb8ehA1NbQ==
To:     Thomas Gleixner <tglx@linutronix.de>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>
Subject: Re: [PATCH v1] timerqueue: use rb_entry_safe() in timerqueue_getnext()
Message-ID: <BNP2PqwI58CzAxJejDx9BcX2nWxSOo-hoZ1qh_7ZrmvqcNwz49RCBxZscYZCoHTlG7bqz2V12bhc5r88dPKopRgoy_XxO4QypcWoRFe3fMI=@protonmail.com>
In-Reply-To: <87v8nis83n.ffs@tglx>
References: <20221027212506.3745164-1-pobrn@protonmail.com> <87v8nis83n.ffs@tglx>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2022. november 14., h=C3=A9tf=C5=91 1:17 keltez=C3=A9ssel, Thomas Gleixner =
=C3=ADrta:

> On Thu, Oct 27 2022 at 21:37, Barnab=C3=A1s P=C5=91cze wrote:
>=20
> > When `timerqueue_getnext()` is called on an empty timerqueue
> > the returned rb_node pointer will be NULL. Using `rb_entry()`
> > on a potentially NULL pointer will only - coincidentally - work
> > if the offset of the rb_node member is 0. This is currently the
> > case for `timerqueue_node`, but should this ever change,
> > `timerqueue_getnext()` will no longer work correctly on empty
> > timerqueues. To avoid this, switch to using `rb_entry_safe()`.
>=20
> I agree with the change but not with the argumentation above.
>=20
> Whatever the current offset of node is does not matter at all,
> really. This is a blantant missing NULL pointer check which works by
> chance.
>=20
> So there is no weasel wording justfied about "coincidentally" and "might
> not longer work correctly".
>=20
> Just spell it out that this is a blantant bug and nothing else.

I agree, I was just trying to describe why it has not caused any issues yet=
.

Would this be better?

  When `timerqueue_getnext()` is called on an empty timer queue, it will
  use `rb_entry()` on a NULL pointer, which is invalid. Fix that by using
  `rb_entry_safe()` which handles NULL pointers.
 =20
  This has not caused any issues so far because the offset of the `rb_node`
  member in `timerqueue_node` is 0, so `rb_entry()` is essentially a no-op.


>=20
> Back then when that code got introduced rb_entry_safe() did not exist at
> all so it's even more obvious that this is simply a missing NULL pointer
> check, right?

As far as I can tell it did exist and it was actually used
when the offending change was committed (511885d7061e).


>=20
> This also requires a Fixes: tag which flags the commit which introduces
> this bug.
>=20
> Thanks,
>=20
>         tglx
>=20


Regards,
Barnab=C3=A1s P=C5=91cze
