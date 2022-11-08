Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FB621DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKHUhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKHUhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:37:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19662397
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:37:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s196so14398424pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nWvp2e+oKJWyx0K1zRRA6J7urUQfpyg2ewzudAsOlo=;
        b=aO/EszaukAYmKYcoD6tJppj43grTZ/d8wNcXOqyzB0yzo8Mjsn76b7qVKtk7JmCxAV
         ojLXgY6kKAZLdHhZz2mVR1XPQg9PWKPl/3W6bCsiRL3BP0ZFyXr/arS7u9dhjGR3hcmm
         yFR9mkXb1NM02TZAYgL1jb2LEdwUjdBAPiHZE3ermYWWfW0K24F006oDjd6pAv0GtSd8
         iWfablpgU0Q1fgAl6F5L93YLbZzRPEfKsn8JdF1qq70+IEI67ayoynyVXfG5cyAMYH6j
         J+f1XwEjwGMnazYxW0kGJwKOfpl4pMG92xJGEH2qWeDfldWhi3Jm+4mFL/PUudyjN/M4
         vs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nWvp2e+oKJWyx0K1zRRA6J7urUQfpyg2ewzudAsOlo=;
        b=X0iiWTxrNyTA22ukU7TjtkjFA5x1LK9K3e66KGk23RK7Q1Cqq5Kn5Aua2lf3/6XKEY
         QWulN8v66ONKUTpm3Q8IQ3+uc0nDbLhNEH/YRoXrzCVlAYFDgaaUyWctWdscDbw06ApC
         J63MJZl7EeJ9deedB5jqnU1IYe82XaOT5bGkw6WF9p3gFMusviFhpe67BNkatBbEzzmL
         VZBP26ivqsC3UZVVlVeaSzNsY+ZCClX6zgwgSgklDaflScEUTtW9ykoPx/2rYF1uU9b0
         udEojxeX2nJA5WQwjqDzgpgNh4x4OHqgupz8cQFYmpYF3qFOUlawOYoAl3ijXvamfaSE
         t5Ag==
X-Gm-Message-State: ACrzQf0kYqqvTo0pTXtuUJRJsu3KfewV/SYhzpYDPFDZAmLvr6ztU2kC
        XIETHaUYBu5hlrKuUN+XBGc=
X-Google-Smtp-Source: AMsMyM6f16O/waD7g2O6EOvNvJnDo2yA/DY1jWMzjLTt8vwPUa9z/+KZeS0TqnGTgjopVcPMzoCc/g==
X-Received: by 2002:a63:f20a:0:b0:464:8c6:f27e with SMTP id v10-20020a63f20a000000b0046408c6f27emr49363372pgh.411.1667939850860;
        Tue, 08 Nov 2022 12:37:30 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090aab8900b00217ce8a9178sm4048840pjq.57.2022.11.08.12.37.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:37:29 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded
 extra bits
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221108194139.57604-1-torvalds@linux-foundation.org>
Date:   Tue, 8 Nov 2022 12:37:28 -0800
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <15A1A033-73DC-4ACA-87B0-3535E9236F7F@gmail.com>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <20221108194139.57604-1-torvalds@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Nov 8, 2022, at 11:41 AM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> We already have this notion in parts of the MM code (see the mlock =
code
> with the LRU_PAGE and NEW_PAGE) bits, but I'm going to introduce a new
> case, and I refuse to do the same thing we've done before where we =
just
> put bits in the raw pointer and say it's still a normal pointer.
>=20
> So this introduces a 'struct encoded_page' pointer that cannot be used
> for anything else than to encode a real page pointer and a couple of
> extra bits in the low bits.  That way the compiler can trivially track
> the state of the pointer and you just explicitly encode and decode the
> extra bits.

I tested again all of the patches with the PoC. They pass.

>=20
> +struct encoded_page;
> +#define ENCODE_PAGE_BITS 3ul
> +static inline struct encoded_page *encode_page(struct page *page, =
unsigned long flags)
> +{
> +	return (struct encoded_page *)(flags | (unsigned long)page);
> +}
> +
> +static inline bool encoded_page_flags(struct encoded_page *page)
> +{
> +	return ENCODE_PAGE_BITS & (unsigned long)page;
> +}

I think this one wants to be some unsigned, as otherwise why have
ENCODE_PAGE_BITS as 3ul ?

