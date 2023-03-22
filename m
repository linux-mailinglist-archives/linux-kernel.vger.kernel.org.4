Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D676C4501
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCVIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCVIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:33:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28D2E0D2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:33:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p203so20041350ybb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679474023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfkymLuuLGA9aqTT/fTwE5BR2+dpv7OvI0w4uUz7FQo=;
        b=kt1s2JEhZcIupAvgxv5PW/mgxEPxcPmmsHcMoI9bU1NgVxKF7QII/1gWcALpGsO18s
         /qDOAULLAsakgu8sc40wuhuwsdDYwVlRf1j0MToKfsbwkTBeZb50L2K9XBBQgfLFBA+9
         wKyTUv2q/uDbUQFDdtggs7W349EDklZJ7bFJoHR2V731LJW6ehgyExtlBC7oZvZThbyU
         Ix/T8jJU0LcLWaOESMxC04BYu6oYn+Vxw5wZ6zVUW73e5xNhPaWaXnEcvT7z+6LVzKy3
         iQDrMvTqGwYKBcEz0XgRZQ603dMs+DMdgfEfBJCw2GdaZIlSN+faWkpqxFIesn61NrQ3
         df/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfkymLuuLGA9aqTT/fTwE5BR2+dpv7OvI0w4uUz7FQo=;
        b=ghReNBH9bY68QY44CK1x7uB7NazrO4It1HFimJfZ9JRTmDp0IljeiOP8Tmf4kH9S7v
         ySF9uerGg8VQWbfwu8/IQJWDrKSXt8g7BkX5ME4q7q0x8xHY69EF5OjrhrqEhGdBVMtw
         +mm8acH9X6NfuSTg5WRT5EHCnHKavPGp+ppE5rYYGGjMJMkhutla3OQWwtqr5dIktjwk
         U6SvHiUra+mB/aRBIPzILcxOW3+WGtXaZ0DzYunSurVr4g3nZGjPIhkXh39Bda+zZpxU
         li7wP9zNDjfYkYRrxeN9iT9lSd84mur7Q6t5u72WA8kympVR6ygNDzNGzP9DY7y7RqB4
         0O+A==
X-Gm-Message-State: AAQBX9cob0jBjdDEsd2soEEmfknqI911xfTcpp9pC91IEy13lO0PZZth
        5IkD5IIGDJ6Xh32b0AoXb4U/GcsvAQBxMh2sD+I=
X-Google-Smtp-Source: AKy350adh+nHB6buYjrWfsFnHvEk0ca+WcRGHrKSst/vxFsP7vuHcwrlMEVVGmUooQqSHK53VQ1sqnWV0MKYqjaI/6M=
X-Received: by 2002:a05:6902:1208:b0:b6d:80ab:8bb6 with SMTP id
 s8-20020a056902120800b00b6d80ab8bb6mr3411458ybu.1.1679474023607; Wed, 22 Mar
 2023 01:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <ZBRiRu7hlwxSKHBg@alley>
In-Reply-To: <ZBRiRu7hlwxSKHBg@alley>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Wed, 22 Mar 2023 09:33:32 +0100
Message-ID: <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

El vie, 17 mar 2023 a las 13:51, Petr Mladek (<pmladek@suse.com>) escribi=
=C3=B3:
>
> On Thu 2023-03-16 11:29:26, Guillermo Rodriguez Garcia wrote:
> > Hi all,
> >
> > We have several embedded systems where pass console=3D or console=3Dnul=
l
> > in production to disable the console.
> >
> > Later we check for this in user space: in our inittab we check if fd0
> > is "associated with a terminal" (test -t 0); if so, we are in
> > development mode and we open a debug shell; otherwise (console
> > disabled) we just start the application.
> >
> > Recently [1] this behaviour has changed and now if we pass console=3D o=
r
> > console=3Dnull, the new ttynull driver is used. This breaks the check w=
e
> > were doing (test -t 0 always true now).
> >
> > [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
>
> This is actually exactly the problem that the change tried to solve.
> Some systems failed to boot when there was no console and they tried
> to write something at stdout.

Well, I did not have any problem before this change.

I understand that some systems had a problem (many others didn't, and
setting console=3D or console=3Dnull has been standard practice for a long
time). Since this change in behaviour could (and did) break things in
user space, perhaps it should have been made opt-in...

>
> > Is there a way to get the previous behaviour? If not, is there an easy
> > way for userspace to detect whether the console device is a "real" tty
> > or ttynull (other than trying to parse the kernel boot args, which
> > would be a bit fragile).
>
> A solution would be to check that /proc/consoles has ttynull as the
> only registred console, for example:
>
> grep -q ttynull /proc/consoles && test `cat /proc/consoles | wc -l` -eq 1
>
> Would this work for you, please?

I was trying to avoid something like this as it feels like userspace
now needs to have too much knowledge of what the kernel is doing
internally, however I guess this is the best option.

The suggested check seems to work but now I am seeing a different
(related?) issue: when I try to reboot from the console (using
busybox's reboot command), the system reboots normally if I am using a
"normal" console (e.g. console=3DttyXXX), however when using
console=3Dttynull, the command takes 20-25 seconds to complete. I am not
sure why this would happen; if I understand correctly, for userspace
ttynull is just like a regular tty driver, so why would there be a
difference?

Any ideas?

Thanks,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
