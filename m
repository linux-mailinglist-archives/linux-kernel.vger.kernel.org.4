Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DD5BF2F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiIUBba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIUBb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:31:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9711178
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:31:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id go6so4915223pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=vrZbq/hL3g85/CLbfG3JsdHSRD/rOZmQkOZ2dFbbZj8=;
        b=YqklhaPHAumP+mpxQOMS2PTelXmDSbHwCVTEGId5S3oUI9NHDbl3DkUrpKbtLeeWIA
         2WRjwBq6oyFsyn+/5x6Et1CVVbUyKjy6N+R226ZrKm3P/Ns8EZ2LRYk1jY8sreF2KCrj
         AchXRJWyZ9X06oJC8Vb8eTak93idcRf06/8x4SK0xitQThUCRgUGo791HcIAgLH6vjo0
         fG4EiNk502ObStRIHJ93rGf9TT5wqenR5W0pLfVeh3v4Gj7qdfO4a6fJPraLO+U3QXPI
         /Am0t2yKYt+bj/bFIu3hGl3JRolfa+FypTnrEBImAJ7WGuKI4iWXfHU6JFrKBdXNClJa
         bQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vrZbq/hL3g85/CLbfG3JsdHSRD/rOZmQkOZ2dFbbZj8=;
        b=sSz/p52WSyTM/O3HCspuy9KxIO4oGuRr5Sl4GoblJ4fEephR/7LCM/OsjMZa7AK//f
         WKlu6sLFVElSLQSTvHOA4hP5Vhv+5snFzE9WamJ1l2nZqteHdyUkJI5q7zBXmo9IrFHI
         /4ETFFFGJ4KmMkqFtTEBFKmp9RMapRHPaBFhj/ak09AkImSPcGoPC+EfMG8lUe6xkRuw
         FtMd7nWl8toVJlpvdSSFGhfvgN+H4Pt27HBd3kK7AJJVt0gv+SJFlYt333ck2NOne6J+
         PuJnqTOGegCPcI/qjDhWTB7//rfeM/Z03jJ0Czwdn8pSmTfNnbhOs6KBehViMuhCOp0r
         PWXQ==
X-Gm-Message-State: ACrzQf1sjOgeCA18yYzGvZ6BCQPfzqdfBZk7l1YDvozPnjziTpcgBJ+V
        LN0LOm6o2SzKP1WfDm3wPrM=
X-Google-Smtp-Source: AMsMyM7UX7WEXDteCamL95O73fPuFXTYXrivpQulkszrFaInrAveKAYA0XX4sTgJrGenGvos4OnP1A==
X-Received: by 2002:a17:90a:b00b:b0:203:a6de:5b0f with SMTP id x11-20020a17090ab00b00b00203a6de5b0fmr6752757pjq.134.1663723885976;
        Tue, 20 Sep 2022 18:31:25 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090322c200b00177fb862a87sm603621plg.20.2022.09.20.18.31.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Sep 2022 18:31:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <D0F82355-EB17-46A3-82AA-CC0B26344A08@gmail.com>
Date:   Tue, 20 Sep 2022 18:31:24 -0700
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <72644F1F-7A13-4CC1-8C24-BE271323FE94@gmail.com>
References: <20220913135213.720368-1-namit@vmware.com>
 <2D09BBFE-45F3-4B9C-8734-D002CA99FD94@gmail.com>
 <Yymds595qthVSnt0@hirez.programming.kicks-ass.net>
 <D0F82355-EB17-46A3-82AA-CC0B26344A08@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just following my questions with the answers I figured out, just to save
others time.

On Sep 20, 2022, at 9:48 AM, Nadav Amit <nadav.amit@gmail.com> wrote:

> On Sep 20, 2022, at 4:02 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
>> On Mon, Sep 19, 2022 at 07:35:42PM -0700, Nadav Amit wrote:
>>=20
>>> 1. What is the reason that inline functions are marked with notrace?
>>=20
>> IIRC the concern is that a notrace function using an inline function;
>> GCC deciding to not inline and then still hitting tracing.
>>=20
>> For noinstr we've mandated __always_inline to avoid this problem. The
>> direct advantage is that those inlined into instrumented code get, =
well,
>> instrumented.

Commit 45959ee7aa645 (=E2=80=9Cftrace: Do not function trace inlined =
functions=E2=80=9D)
gives two reasons which correspond with what you were saying: (1)
consistency and (2) function that should not be traced are mostly marked =
as
inline.

I am not sure I fully agree with the arguments, specifically the =
consistency
(any function might be inlined and not traceable). But I am too =
afraid/lazy
to cause damage and fix it. I will remove the inline and play a bit with =
the
kernel to see how it behaves.

>>> 2. Is probing function that is called from do_idle() supposed to =
work, or
>>>  should the kernel prevent it?
>>=20
>> Should work for some :-) Specifically it doesn't work for those that
>> disable RCU, and that's (largely) being fixed here:
>>=20
>> =
https://lore.kernel.org/all/20220919095939.761690562@infradead.org/T/#u
>>=20
>> Although looking at it just now, I think I missed a spot.. lemme go =
fix
>> ;-)

I did not try your patches, but I do think I figured out what=E2=80=99s =
wrong and
sent a patch.

=
https://lore.kernel.org/lkml/EECE6FD7-FC3D-40E2-A957-151A1BE2B2F9@vmware.c=
om/T/#t

Thanks again,
Nadav=
