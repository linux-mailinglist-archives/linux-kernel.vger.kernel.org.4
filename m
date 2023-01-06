Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD86660943
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjAFWH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbjAFWHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:07:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89884BE2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:07:11 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c7so3282386qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9dqVddWwlNIkWBEkX2eMMbroRQSsxPmZhf5UK2bJx4=;
        b=O6fLaeMkOAI9qlrlbD9V9hqb0FRi+3fYwY656X3zqlxsNXYgmUCLgJYTFwJVKAjthE
         irUaeSLWBxwa416jiNkQxJky4pxbLUW3S/rzOYcjecUxbP1aO1xBadn5G83AJZJjM0GP
         8LNX+VfdzXkl4XSINWkZYmRr2ww9tgPFY2yho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9dqVddWwlNIkWBEkX2eMMbroRQSsxPmZhf5UK2bJx4=;
        b=LXGQbpP7VdIGqPr8/6lxt1w0d1+df9Gb87ChV4ZNN1f9GsyzCxc8HD3IPnuXvr1FXF
         PUZWFIOxxe18a86r6aw6iagy1gwm3hdy7/d/Ur3/hrlxgo7g3sS0Vj8jWS/fGoCzDr/y
         +RqjWKu6Nl/mN0n01tBzMx7OZnEjTI+4prCYdTgew+uNAA0c5kT88VAQaMLz5a3OlsyS
         1nMIyA9D5jUd1WlMJm8muUj9DVvMpjygKwZ2cTXmUYCgA9NIXqm7rGi0HGg2FKuy/kmQ
         3k/rOusajpJasObArCDi0FyaQakVxwtQA5wC1wIcaU+7wHozMpjghFSFlg7nKi9hLItN
         qViA==
X-Gm-Message-State: AFqh2krEYqwyw87NqhBLKNe1ruMRo7INLmhLdD8ka1OrHQLBAe/lpbej
        ZkYZntTA23CZVTIzhHOga4BdZ24fJZXvP+N5
X-Google-Smtp-Source: AMrXdXu92lT/3b9FkUFbzFuuTs5xRAh6N3oeAo2F/JOYs80VNx4YKnColLl299pJ7yBedRADFFFS6w==
X-Received: by 2002:a05:622a:114f:b0:3aa:82c0:1ca1 with SMTP id f15-20020a05622a114f00b003aa82c01ca1mr65099943qty.21.1673042830370;
        Fri, 06 Jan 2023 14:07:10 -0800 (PST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id u17-20020ac87511000000b003a7f9b48e35sm1066611qtq.29.2023.01.06.14.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:07:08 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id g10so1872027qvo.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 14:07:07 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr2661817qvv.130.1673042827328; Fri, 06
 Jan 2023 14:07:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com> <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com> <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com> <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
 <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com> <Y7iV18CqKAa4gO9r@casper.infradead.org>
In-Reply-To: <Y7iV18CqKAa4gO9r@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 14:06:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7jenrb6UNjv--xLC4hrjJDsCFxuaHw1e67a4ihVEmUw@mail.gmail.com>
Message-ID: <CAHk-=wj7jenrb6UNjv--xLC4hrjJDsCFxuaHw1e67a4ihVEmUw@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 1:42 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> I'd be more inclined to do:
>
> typedef unsigned int vm_flags_t[2];

No, that's entirely invalid.

Never *ever* use arrays in C for type safety. Arrays are not type
safe. They can't be assigned sanely, and they silently become pointers
(which also aren't type-safe, since they end up converting silently to
'void *').

If you want to use the type system to enforce things, and you don't
want to rely on sparse, you absolutely have to use a struct (or union)
type.

So something like

   typedef struct { u64 val; } vm_flags_t;

would be an option.

              Linus
