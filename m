Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64373679144
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjAXGsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAXGsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:48:53 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B12725
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:48:52 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1442977d77dso16695500fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AS5EPumdJE/ljodYn5mZW2+16rEefnXi4vtaHTIu7Ao=;
        b=OsZLdnpGnSWgl4LR68pmj+8NdtgtcZBI59IY//Cmoj15kob1KPObbTxoMcqFCMnkO8
         ENN8JjMAogX2KIbeqRrk6PysJDSyEg3q0m+aOT2XblOv/Bn1CCY36c8eEJ1OzOwGPJfi
         V2DsiArKfjFa5Ed46WN50M2aITLBOKmQfr1J/Cg7NQVetMLKmz6LR3Y37UbUogMp9KT7
         eql4U0ufGnipPfJhJNYqkH6NSiBr2KLYQEWLwD94ys1DeZgoQj8TDpnCO5gSZg0tXCqT
         rGYEYXP8jhlGWOd5J5b6B1BERo9wGe7amNTM3IYSa1xy/VAsRQYz+lI3PSFB3OnhSOCq
         z+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS5EPumdJE/ljodYn5mZW2+16rEefnXi4vtaHTIu7Ao=;
        b=5z7jh/URJSLBcjvpNuTJZ5hlPoqdOLMfoTv0S+0UeEKthrzAxdV9W521Wf0dQ2U0Ye
         1HOIHzNbFD5/dzpQVc50WpZiuwvQ5LSYxRN3LvsKd27cwq3JOVGYw0uBENCdtANb/t5G
         WPHNGDiHdqgrQZDbNUlfJoGWAgdwmp7hrKwuwmaMkr3QvfISPZRAi8hhV/8V4+9hVbLa
         /uwJ7aQ1v75rlQJ+wTQRkFVU5Zvvo0IaFwqxb721ne181MERtyo2ivEGcs/W5jDNhv45
         decXk4P29QN2efCc30pn2zqQ0NlDb1P+2Gq5KDwDb5carf3oCFx43jCPCnh0FONTEAAw
         2kOg==
X-Gm-Message-State: AO0yUKWkW2L9DVF/HPxd/yYUAbkE+MNbwpNpyg7mLpC+QjuOLv6AXo46
        KsW87sD45uYUi6eZtCkq14lSwxt8o1MykEHiW7Gu9aCp
X-Google-Smtp-Source: AK7set+OvUAycq+piqAkDSnzkQXcMEyrwQoEnVC5grq6zcJMuK8juGpg9pH0H3xnhL7hJkLHCLe0L9xEhgY5PbGW8I8=
X-Received: by 2002:a05:6870:1115:b0:163:1d2a:aa5d with SMTP id
 21-20020a056870111500b001631d2aaa5dmr12792oaf.81.1674542932016; Mon, 23 Jan
 2023 22:48:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ad6:0:b0:49c:e11d:f815 with HTTP; Mon, 23 Jan 2023
 22:48:51 -0800 (PST)
In-Reply-To: <CAHk-=wiRtgOweogzkky6phOSCySWRzWmDQ1S7J5xxQR2UCJ+dg@mail.gmail.com>
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com> <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
 <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
 <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com> <CAHk-=wiRtgOweogzkky6phOSCySWRzWmDQ1S7J5xxQR2UCJ+dg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 24 Jan 2023 07:48:51 +0100
Message-ID: <CAGudoHHD3ZpYhx+wLSCeQV_bEkBysLahAO-ovXhbPDc4vWeO5A@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Uros Bizjak <ubizjak@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, Jan 23, 2023 at 4:11 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> On another point how to end up dealing with lockref less, I have to
>> note glibc switched fstat(fd, buf) to use newfstatat(fd, "", buf,
>> AT_EMPTY_PATH) internally.
>
> Yeah, that's just plain stupid.
>
> I don't know what the thinking (or rather, lack-thereof) was inside
> glibc for that one.
>

To my reading the fstat system call is now legacy so they switched to
something else. There is a lot to say about the stat situation (going
past the fd vs lookup issue), which I'm going to do on fsdevel (perhaps
next week).

All flaming aside, I think Uros is still waiting for an answer what
should be done in cmpxchg loops and someone else will have to provide
it.

I stated my case for the best course of action being to do nothing
(for x86-64 anyway), but I'm not an authority figure.

-- 
Mateusz Guzik <mjguzik gmail.com>
