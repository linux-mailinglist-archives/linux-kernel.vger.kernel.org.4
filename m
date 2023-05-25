Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E54711216
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbjEYRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEYRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:25:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9AE64
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:24:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso4633160a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685035487; x=1687627487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TG2KiabOTIRDETeuidPveq5vd/DC84WzmbIAz8Xbn0=;
        b=g/c3t+Jte85Hauun7NR2559wp9vRtlwRU1Ir9tnqHBR+XkmM/1G6dp1+QIxHdLgmXq
         28vM+W/gx3SIJDmWcdsX6p5+IoNP7VHmHQ376lp+7Qjo6QoTOmHqFd+Zj0m6V4rbhHvZ
         Q7GotxjIyWBLkDgHBUBxG1XTAnwI7PQa3ApdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035487; x=1687627487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TG2KiabOTIRDETeuidPveq5vd/DC84WzmbIAz8Xbn0=;
        b=GADSzl8/UHWLtNr/NDS2slzdLddpi09yKw/uJykYKzuPud1t/Q8T+s32bf8Xcid5Wb
         Z79espVKIZRFeG17CFuXae3VAoImUHozh5uYs+A81vtSQ99+O+LSju7Evknl1P6m7ro+
         yJavY13HMeOU7rDyHmgXZWKcjUd2Fa2w/lswj4M9rbl9OKub+/9wWJiCrcRoW4HcQQIJ
         ff4XQKKJifjyZJHIekOk0RUK2iS701Ffgwvo21XNsfuAQBxdBQkYVe5TTOJwsFhl6Ivk
         cLZfShYvofAhUZwzeDqOuS3uUmDiUOhNMcnaLyOzxwMc8MafrFY5lnsFsRN8WSflRKr3
         9tCw==
X-Gm-Message-State: AC+VfDyQQhHzwxLir9OEmpU/77g3Joz7bYdbKY9FgyIuHqd7zZ4Qsw3F
        e0NlttG82fSvJ4Mkd9bFwbkgZBDBNyP4mTu86mqljppQ
X-Google-Smtp-Source: ACHHUZ6wXQnjpBnglMWoXGrNQJ/yCJ1kzPEikugNgXftFpumv/Cm9mbAMqPunxUJHr9SLAYqSrET0w==
X-Received: by 2002:a17:907:9618:b0:96f:2b40:4503 with SMTP id gb24-20020a170907961800b0096f2b404503mr2394030ejc.74.1685035486942;
        Thu, 25 May 2023 10:24:46 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id lz13-20020a170906fb0d00b0094f67ea6598sm1096418ejb.193.2023.05.25.10.24.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:24:46 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96f53c06babso163476166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:24:46 -0700 (PDT)
X-Received: by 2002:a17:907:9289:b0:96a:6723:da48 with SMTP id
 bw9-20020a170907928900b0096a6723da48mr1860929ejc.75.1685035054236; Thu, 25
 May 2023 10:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com> <98511.1685034443@warthog.procyon.org.uk>
In-Reply-To: <98511.1685034443@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:17:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht8Z=Vm-WkvZ2fMcBkF+CZSwm0nMpbtFoKc5_o+0oEbQ@mail.gmail.com>
Message-ID: <CAHk-=wht8Z=Vm-WkvZ2fMcBkF+CZSwm0nMpbtFoKc5_o+0oEbQ@mail.gmail.com>
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

On Thu, May 25, 2023 at 10:07=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Should everywhere that is using ZERO_PAGE(0) actually be using my_zero_pf=
n()?

No, that would just make code uglier for no reason, because then you
have to turn that pfn into a virtual address.

So if what you *want* is a pfn to begin with, then use, use my_zero_pfn().

But if what you want is just the virtual address, use ZERO_PAGE().

And if you are going to map it at some address, give it the address
you're going to use, otherwise just do zero for "whatever".

The only thing you can't use ZERO_PAGE(0) for is literally that "is
this a zero page" address comparison, because ZERO_PAGE(0) is just
_one_ address.

                   Linus
