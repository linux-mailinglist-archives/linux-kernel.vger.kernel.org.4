Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0179A7111A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbjEYRFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjEYRFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:05:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9C194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:05:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96f818c48fbso160779566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685034311; x=1687626311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSr58RBXCv1EwUMOYtICqFDX8H+m5pyEj79JnZvBvqM=;
        b=FUBX4bX4Rtu2T0f2hT26650q+dMnkZkzNX0I0hBfyLgOH2Ax4epbIripcg6b1UDFpM
         o3prOgLKFbhWUaC45DzFa9SPMncTSsRCM3jaIgaKdONEpkKIUcalhdfLJHBraYaiCHV8
         h8i1H4qHYaOI0fXj3tt41b8ArUeOIe7GFAM0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034311; x=1687626311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSr58RBXCv1EwUMOYtICqFDX8H+m5pyEj79JnZvBvqM=;
        b=EWLfjGDTs/KCWlyz+GhaLao530AnP2paZyFFcQV+CXRYycs+Z29LO5Co1bu99AIggF
         S6c+blRii4lSUU9wEmVGETvvzfhK324Ttc0DLZwxL9UCyUpMau2wUSEG4IB+1mVy7gQy
         DUPJOxm1jnBe6MUItZ4pclvsUEuBYrnERKyAokqbZw+Bsk3nZb5TTnuspiwYqEfoMPiJ
         tOBoN+pyGdypjBFNOHGTVTB0pe2Red5eaM5EV9HWy2uSzUBU/p2qHIJN4iYFK0FYUVkX
         ULlMJiQTihg2SIYHN2SkPTQfNV1DZIMqEdq3idSbGSaTW7P8jL7fEvl19peBJaJjFZG5
         kPaw==
X-Gm-Message-State: AC+VfDzEI0Cr7OI4Xlix+vn6aG/ww721jYyAgOOtLv8GcBgJfBiuVgrA
        ngy/H4Cn01Vg4KOhlw9WznhL3C0lNG08oIZ0yZu2t7jD
X-Google-Smtp-Source: ACHHUZ6uH0dxGmSHk2QP4FGd05sZlruROx1GHPp7aE6YWMjtS1eNeiDc/ZUC9aGHrRnO0QYK8uJIRw==
X-Received: by 2002:a17:906:c155:b0:96a:41ed:e3fa with SMTP id dp21-20020a170906c15500b0096a41ede3famr2578944ejc.22.1685034311646;
        Thu, 25 May 2023 10:05:11 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id u12-20020a1709064acc00b0097382ed45cbsm1089846ejt.108.2023.05.25.10.05.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:05:10 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so4907454a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:05:10 -0700 (PDT)
X-Received: by 2002:a17:907:3185:b0:970:925:6563 with SMTP id
 xe5-20020a170907318500b0097009256563mr2076202ejb.8.1685034310240; Thu, 25 May
 2023 10:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
In-Reply-To: <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
Message-ID: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
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

On Thu, May 25, 2023 at 9:45=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> I think the correct way to test for a zero page is
> is_zero_pfn(page_to_pfn(page).

Yeah. Except it's really ugly and strange, and we should probably add
a helper for that pattern.

The reason it has that odd "look at pfn" is just because I think the
first users were in the page table code, which had the pfn already,
and the test is basically based on the zero_page_mask thing that the
affected architectures have.

So I suspect we should add that

    is_zero_pfn(page_to_pfn(page))

as a helper inline function rather than write it out even more times
(that "is this 'struct page' a zero page" pattern already exists in
/proc and a few other places.

is_longterm_pinnable_page() already has it, so adding it as a helper
there in <linux/mm.h> is probably a good idea.

                Linus
