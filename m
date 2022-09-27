Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4195EBCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiI0INx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiI0INR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:13:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE91CBAEA;
        Tue, 27 Sep 2022 01:08:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d82so8987169pfd.10;
        Tue, 27 Sep 2022 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=3EsvtXDqTlOoa6jvekvXcMeE0FvYX7tHlhmq2YLT8/Y=;
        b=DC7SUY8RQeQL5YCTzXXnD9B7QvdqFiz2bGO+ql+uDpKeMzFty2fViVNpMaq/tYVpQQ
         R6laDqVykmkjY2QWl05uvDMqvzoi2Uhs8rD+hEppy5N5AOkEtTMj/6/WbT6Aim9d7SuI
         htpgwlntYmp/hVKMeO6z2Meqi+SbBcKeC/0wcXEYROYWGNowBmOVE71s1L9F7l4St/Z4
         T79RnEFvEKAhI+krpZJF4N0X8sQiF5QGm4N7sXAVxguGuSYdDRJTjWbT3OKbEWHRuSv2
         7N90XDlH+gZolwicc8x+dcuINcnQD1wnHD/g3PqLnrsQAkb8YG/IPrSUhCNaIsloLIau
         YUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=3EsvtXDqTlOoa6jvekvXcMeE0FvYX7tHlhmq2YLT8/Y=;
        b=LE5YJLz1ucf5Tjje5Z/tooWGeJTpr1v51wl5At0cgZaaJn4+FvKqmDkI8UN/0SKnlo
         4BkbA9bN+lK//3RTMI88CNqzArM9IGz7uiWCy4u0EjnOI40uEmYQp9gjSHhMYxyQoRy+
         DiZbg6NDdgFIG/oxu5tmXg4Vy0JduHQxDMDVo7mLUwgEott5O1sKWXDYk0g/xLn5hIEr
         2TVTgQY3DFfoEBd6XaNO6zC8oMxnFBNpzA+3pmc1h2iL6h6Ajn03wHKaaVUQlqPmslZA
         nfCYp4zE6CFfEciyLa+fNcWOV7wu+Xn+pEf5pjgFGE2ZPK9T7M3kB663kHbeWJLyujRg
         vbrg==
X-Gm-Message-State: ACrzQf3NpzIU+oOP8dGUiWyZ2yELGezIqcWVSikzBw4DldehyyAjKuuO
        q4b+HvkZVGWaaN7hDgSje9CpDvZRB9I=
X-Google-Smtp-Source: AMsMyM6SRIhaU5DDgh9EzfiKnkmC4F10dMRBMD6umArQ/FRlFA2u+Ol2O73XhqQM7Tt2hqiq0Xi/7w==
X-Received: by 2002:a63:d0b:0:b0:439:72d7:ef81 with SMTP id c11-20020a630d0b000000b0043972d7ef81mr23162747pgl.605.1664266118285;
        Tue, 27 Sep 2022 01:08:38 -0700 (PDT)
Received: from ?IPv6:::1? ([2601:647:5e00:1473:c9e1:c18d:1df4:1436])
        by smtp.gmail.com with ESMTPSA id c188-20020a624ec5000000b00537b8deef41sm962269pfb.136.2022.09.27.01.08.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:08:37 -0700 (PDT)
Date:   Tue, 27 Sep 2022 01:08:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Lantiq: switch vmmc to use gpiod API
User-Agent: K-9 Mail for Android
In-Reply-To: <20220927074953.GA6127@alpha.franken.de>
References: <Yy08TBymyuQb27NU@google.com> <20220924104612.GB10628@alpha.franken.de> <YzKCaMU9wlFbPZS7@google.com> <20220927074953.GA6127@alpha.franken.de>
Message-ID: <791EE67B-9A27-4A3F-BE0E-A62CDB5CE9FA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 27, 2022 12:49:53 AM PDT, Thomas Bogendoerfer <tsbogend@alpha=
=2Efranken=2Ede> wrote:
>On Mon, Sep 26, 2022 at 09:56:08PM -0700, Dmitry Torokhov wrote:
>> Hi Thomas,
>>=20
>> On Sat, Sep 24, 2022 at 12:46:12PM +0200, Thomas Bogendoerfer wrote:
>> > On Thu, Sep 22, 2022 at 09:55:40PM -0700, Dmitry Torokhov wrote:
>> > > This switches vmmc to use gpiod API instead of OF-specific legacy g=
pio
>> > > API that we want to stop exporting from gpiolib=2E
>> > >=20
>> > > Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>> > > ---
>> > >  arch/mips/lantiq/xway/vmmc=2Ec | 22 +++++++++++++---------
>> > >  1 file changed, 13 insertions(+), 9 deletions(-)
>> >=20
>> > applied to mips-next=2E
>>=20
>> My apologies, I screwed up=2E I thought this patch passed 0day before I
>> sent it to you, but apparently it has not=2E
>>=20
>> Here is a fixup (actually cross-compiled this time), or I can send a v2
>> incorporating it into the original change=2E
>
>I need a fixup, but this one still fails in my build:
>
>/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc=2Ec: In functi=
on =E2=80=98vmmc_probe=E2=80=99:
>/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc=2Ec:43:5: erro=
r: format =E2=80=98%d=E2=80=99 expects argument of type =E2=80=98int=E2=80=
=99, but argument 4 has type =E2=80=98long int=E2=80=99 [-Werror=3Dformat=
=3D]
>     "failed to request GPIO idx %d: %d\n",
>     ^

I see, I did not realize PTR_ERR() is actually long=2E I guess I can intro=
duce a temp variable and use PTR_ERR_OR_ZERO(), but there are a lot of plac=
es in the kernel that use %d and PTR_ERR()=2E I wonder why we can't define =
PTR_ERR() as (int)(long)ptr or something=2E

What compiler/version are you using for your builds?=20

Thanks=2E

--=20
Dmitry
