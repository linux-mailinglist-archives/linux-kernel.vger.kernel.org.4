Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306664D167
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLNUlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiLNUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:40:36 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC9B85F;
        Wed, 14 Dec 2022 12:40:29 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id pe2so1800081qkn.1;
        Wed, 14 Dec 2022 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=37IXM0zUASkTDn7IjxHuQRAKlZOX5hdHVl6fQmWIXzo=;
        b=DJy46OTYuM/abwFQZL4f/oavskeaDT5Lq33b+Rq/tjcmt/6f3lkFadj0j2XdMphMoe
         TNGD9t0VPLbwVwtqhXoBE0tQQ2noFGnAabaF6RP4eQxNHWw1jaslXbHjdJvH8wlVxdoE
         63/Jyy2NKK0uftYQQVshiC7PPaJYcqjDbhHDwzXynJGu7lAQpc/XvoKFEdSaEhhqYeRg
         UER5fQA1bptPKCffdnPlVBH8occGtU2cAAG+iJaTTf89jAduKEhFdryvkWWELecJDafF
         dXdDqSm1TOVxJOat0bv6jrsB4uUhPKA15caGa1rdbxeelT+EogLr2Ej94jRt2cPScXbl
         RM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37IXM0zUASkTDn7IjxHuQRAKlZOX5hdHVl6fQmWIXzo=;
        b=g+sXYgttMGZT+V/9HAsZiQn3buLWu1kUsvePa1eKhfUB8Rw8EufqaX56pQr30nZVTq
         UaySPXqiF0X/uRMRhbY1Yi572YMBgz13TMM1xMeeD99MPWmYkbryRoZ3cVrYGVtw1ka7
         jKASN3Jhvz3llbq63lrhO7CuZB69tNeF/ByT+dHJ/gVt1bFP1w8eZTRMpvpgCRALj8Gk
         2T0Suh/TWxvj64TbBdErxC070Qdt0pcREpsNnkmbzLnz5pq4GUoa+aQ1R1Ha32O/9q2j
         e1CMnC7jWi0+KX6xzfStYgPRuLZwrYArpxFYkOPK1k67Eds3yTywwk56aG8ojSf8odOO
         ofbA==
X-Gm-Message-State: ANoB5pmBdwrcDosY4VM6w3rB6gd7gBuLLq0wJehZQK1hLr5wdQARBj3v
        FE6l95VzwBS9G12sQsxXN1b/Lphgro20R7sbsa8=
X-Google-Smtp-Source: AA0mqf5q9d1jBnxombmS785+Y7z/s38n3WGjT27TsjWASMjTEc5qrBV7cK1sOPvm1dDBd0yLrWi7pXCCjBroBEPRjbc=
X-Received: by 2002:a37:a9d2:0:b0:6ff:c2e:c71c with SMTP id
 s201-20020a37a9d2000000b006ff0c2ec71cmr1762525qke.734.1671050428871; Wed, 14
 Dec 2022 12:40:28 -0800 (PST)
MIME-Version: 1.0
References: <Y5mMWEtHWKOiPVU+@mail.google.com> <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com>
In-Reply-To: <Y5otilaHc6HBPCAF@mail.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Dec 2022 22:39:52 +0200
Message-ID: <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, Dec 14, 2022 at 10:09 PM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
> On Wed, Dec 14, 2022 at 11:29:37AM -0800, Kees Cook wrote:
> > On Wed, Dec 14, 2022 at 09:42:00PM +1300, Paulo Miguel Almeida wrote:
> > > One-element arrays are deprecated, and we are replacing them with
> > > flexible array members instead. So, replace one-element array with
> > > flexible-array member in struct RXBUF and refactor the rest of the code
> > > accordingly.
> > >
> > > It's worth mentioning that doing a build before/after this patch
> > > results in no binary output differences.
> > >
> > > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > > routines on memcpy() and help us make progress towards globally
> > > enabling -fstrict-flex-arrays=3 [1].

...

> > >  typedef struct {
> > >     int count;
> > >     unsigned char status;
> > > -   char data[1];
> > > +   char data[];
> > >  } RXBUF;

...

> As both of you had similar points, I will reply them here.
>
> The reasons why it had no binary changes was because of the combination
> of this 2 things:
>
> 1) Existing padding - so sizeof(RXBUF) returned 8 bytes in both cases.
>
> pahole -C RXBUF gcc/before/drivers/char/pcmcia/synclink_cs.ko
> typedef struct {
>         int                        count;                /*     0     4 */
>         unsigned char              status;               /*     4     1 */
>         char                       data[1];              /*     5     1 */
>
>         /* size: 8, cachelines: 1, members: 3 */
>         /* padding: 2 */
>         /* last cacheline: 8 bytes */
> } RXBUF;
>
> pahole -C RXBUF gcc/after/drivers/char/pcmcia/synclink_cs.ko
> typedef struct {
>         int                        count;                /*     0     4 */
>         unsigned char              status;               /*     4     1 */
>         char                       data[];               /*     5     0 */
>
>         /* size: 8, cachelines: 1, members: 3 */
>         /* padding: 3 */
>         /* last cacheline: 8 bytes */
> } RXBUF;

Yes, and Try to make it work with __packed. As I said, the problem is
that the code is relying on something which is architecture dependent
strictly speaking. And hence I disagree with Kees that v2 is okay to
go.

> 2) RXBUF (as implemented now) is just  like a pair of lenses from which a
> developer can have access to one of the circular buffers in MGSLPC_INFO
> struct called 'rx_buf'.

> 2611 static int rx_alloc_buffers(MGSLPC_INFO *info)
> 2612 {
> 2613         /* each buffer has header and data */
> 2614         info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> 2615
> 2616         /* calculate total allocation size for 8 buffers */
> 2617         info->rx_buf_total_size = info->rx_buf_size * 8;
> 2618
> 2619         /* limit total allocated memory */
> 2620         if (info->rx_buf_total_size > 0x10000)
> 2621                 info->rx_buf_total_size = 0x10000;
> 2622
> 2623         /* calculate number of buffers */
> 2624         info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;
> 2625
> 2626         info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);
>
> To be honest, char data[_1_] in RXBUF was never required to be there.
> The code base seems to make sure that it doesn't run past its limits by
> keeping track of size buffer on MGSLPC_INFO->rx_buf_size (and sometimes
> RXBUF->count)
>
> (Addressing one point made by Andy about using of of the macros in
> overflow.h)
>         struct_size(buf, data, 1) would return 9 bytes which could
>         potentially break the existing driver as it produces binary
>         changes.

You got it incorrectly. I believe you should use something different than 1.
In previous lines in the function it multiplies sizeof + max_frame_size by 8.

The full change should be something like

check_add(sizeof(), max_frame_size)
kcalloc(8, size)

Think about it.

> Let me know your thoughts

-- 
With Best Regards,
Andy Shevchenko
