Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A9711217
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjEYR0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEYR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:26:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2EA199
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:26:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so4316986a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685035560; x=1687627560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJa+li1Oy5bbsqG6UFm3MUpvaFnPsLyMyN5vhg0qjCI=;
        b=Ok2oHq3cev+oksqRUcG1p3USoN99IbgxduJYBtiM1ZppktJCef7OJEAeTtiFyV4Pla
         ualjpqrKd+WIl8n4NZV9wQWuCy1d7zew36uRaxySx+XcHvwZotJwo3OYIopLB4A7A7Jg
         Af69GCES8xqOENGnIFKoV7WULD0sjK3aGPWqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035560; x=1687627560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJa+li1Oy5bbsqG6UFm3MUpvaFnPsLyMyN5vhg0qjCI=;
        b=cgAKW/MhOKrhePkKg+dHOXikcT4pOUoqiflrUztMMUEACI6dxVWFhgnxKlyBd3OKDo
         ZSCgbvVUKarg3BaHEfu1b7gLY6lbIH5hpf5XuE1S2aw2AI2EKJl7hZfwXxAU7TlvgTpL
         DKufQtu2tRcdFkW1fOTZ/QVg4Q2akxCyEUPe060X/ymKzMoJrOhLPxk6J8NBBjpMYgXn
         sNkyGpN4qbQ2mJgOmsIJ6+eaRCAYvhKQ+OUpIxrRf8U1N3mvZQJbd533ToEzwzIb+5ov
         w7NTmUm4eJeB9MaS3rn1jRa/a70cNRqUkViyYyiDEvg7f2hP5eOIGZUpTqSt4/Ucjexc
         BmYw==
X-Gm-Message-State: AC+VfDx6jxJw6TKdMnt0bWEX0Atw4HeVruMxJLKWdj0FwQ1i5KmB4ONe
        2ImbTEHQYCyD/e2esWgu2gCwf2V8V1swq51f6uqtZT22
X-Google-Smtp-Source: ACHHUZ4IpWpRBNh1vOhZ4rTTriX34uhXaH8VuWtxKQ9wFwxvZykMoGXlQjQqYeUUjV0DFZY0+YxTSw==
X-Received: by 2002:a17:907:7204:b0:971:484:6392 with SMTP id dr4-20020a170907720400b0097104846392mr2447535ejc.38.1685035560775;
        Thu, 25 May 2023 10:26:00 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id u24-20020a1709064ad800b0096f67b55b0csm1107050ejt.115.2023.05.25.10.25.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:25:59 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96f8d485ef3so143082666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:25:59 -0700 (PDT)
X-Received: by 2002:a17:906:7954:b0:96a:37af:ff37 with SMTP id
 l20-20020a170906795400b0096a37afff37mr2274160ejo.15.1685035559397; Thu, 25
 May 2023 10:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com> <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
 <144598.1685034915@warthog.procyon.org.uk>
In-Reply-To: <144598.1685034915@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:25:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirrJNoVSOSVK2ae9pa7Q5kJKFYMk2ad-_6YrS1cEScqA@mail.gmail.com>
Message-ID: <CAHk-=wirrJNoVSOSVK2ae9pa7Q5kJKFYMk2ad-_6YrS1cEScqA@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:15=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
>  It doesn't seem I can add it to mm.h as an inline function.

What? We already have that pattern inside is_longterm_pinnable_page(),
so that's really strange.

But regardless, please don't duplicate that odd conditional for no
reason, and don't scream.

So regardless of where it is, make that "is_zero_folio()" just do
"is_zero_page(&folio->page)" rather than repeat the question.

I also wonder whether we shouldn't just use the "transparent union"
argument thing more aggressively. Something like

   typedef union {
        struct page *page;
        struct folio *folio;
   } page_or_folio_t __attribute__ ((__transparent_union__));

and then you should be able to do something like this:

    static inline bool is_zero_page(const page_or_folio_t arg)
    {
        return is_zero_pfn(page_to_pfn(arg.page));
    }

and we don't have to keep generating the two versions over and over
and over again.

                Linus
