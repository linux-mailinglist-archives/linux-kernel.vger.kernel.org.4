Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA25677E62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjAWOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjAWOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:49:54 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DDCDEC;
        Mon, 23 Jan 2023 06:49:53 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id d16so9782573qtw.8;
        Mon, 23 Jan 2023 06:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mGbSTbmYZ6080GG0Gg9582BdjWiklyqcj1kSaK7l00=;
        b=tnxB3IpvoRkcK42cirInpEisiyqwh6hfOAnnGjc3+av+fw82HENlJlbElzGHC+FIpx
         cXB1zmGaeM+qkR3B8K4ioNJCWUm6uq7a+34YXo98LGCkefjPiyqZra9e3wZw5ZK3WP2z
         zrXwsTHeL1r8VqOEKpr1uizvQAcq0laXNx/Oh64WO9ul2Q1gl9r7Ky4bosZQts0PL/4o
         mi4iGvi7mzoKrEmM9z1AF7WQ/guMTHhiDkz+uznwmm7yRAviSs8/oIOlCo4jfs9kN5cH
         aTMdBRcJ+kZ2mx53EOIYFn7lsHIZiAtWt6ChkfkzmTgJjgZV0Cwgtq75exWl2JiLNUn9
         gFCA==
X-Gm-Message-State: AFqh2koSupeYfxaEbDqOvO59I3e6hKu7U9d+nTQ+8GN1Y9uEkftLANtt
        voFkdwVww5wtp7Qf7dgmWgUTTE7G+daH9w==
X-Google-Smtp-Source: AMrXdXvV38bAkbMrODIjq8dmgQaulL8RGu0ElaRaJ9BPKCbk9zV11jkSZ9a31pMXLWLVdE3cdX1o9g==
X-Received: by 2002:ac8:5c14:0:b0:3b6:33c6:c5ac with SMTP id i20-20020ac85c14000000b003b633c6c5acmr47171629qti.4.1674485392613;
        Mon, 23 Jan 2023 06:49:52 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id bw5-20020a05622a098500b003b64f1b1f40sm8492096qtb.40.2023.01.23.06.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 06:49:52 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-4a263c4ddbaso175582357b3.0;
        Mon, 23 Jan 2023 06:49:51 -0800 (PST)
X-Received: by 2002:a81:6e46:0:b0:37e:6806:a5f9 with SMTP id
 j67-20020a816e46000000b0037e6806a5f9mr2904469ywc.47.1674485391343; Mon, 23
 Jan 2023 06:49:51 -0800 (PST)
MIME-Version: 1.0
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
 <2085aec3-796b-71c3-7cb2-d4103d3b6175@infradead.org> <c74cad7b-9ea3-5223-8292-3fe1172a9419@mkarcher.dialup.fu-berlin.de>
 <Y80vRJfPJ4mIO8Cm@tucnak>
In-Reply-To: <Y80vRJfPJ4mIO8Cm@tucnak>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jan 2023 15:49:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ3MxtJycmTxomz_iJnYj6-2Mf8t7jUzoY490O2DhQfQ@mail.gmail.com>
Message-ID: <CAMuHMdXQ3MxtJycmTxomz_iJnYj6-2Mf8t7jUzoY490O2DhQfQ@mail.gmail.com>
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        jakub@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Sun, Jan 22, 2023 at 1:47 PM Jakub Jelinek <jakub@redhat.com> wrote:
> On Sun, Jan 22, 2023 at 12:33:41PM +0100, Michael Karcher wrote:
> > Am 22.01.2023 um 08:00 schrieb Randy Dunlap:
> > > > -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> > > > +#define _INTC_ARRAY(a) a, sizeof(a)/(_Generic((a), typeof(NULL): 0xFFFFFFFFU, default: sizeof(*a)))
> > > s/: / : / in 2 places.
> > >
> > > Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> >
> > Thanks for your confirmation! Are you sure about the space before the colon?
>
> No, it should be without those, see various other _Generic uses in
> include/linux/
> All those are formatted on one line for each case, so for the above macro it
> would be
> #define _INTC_ARRAY(a) (a), sizeof(a)/(_Generic((a),                    \
>                                        typeof(NULL):    -1,             \
>                                        default:         sizeof(*(a)))
> or so.
> Anyway, two comments:
> 1) I'd use -1 as that would be after promotion to size_t the largest size_t
>    unlike 0xFFFFFFFFU; of course, as for the void * case a can't be an array,
>    any value > sizeof(void*) will do

Or SIZE_MAX.

include/linux/limits.h:#define SIZE_MAX (~(size_t)0)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
