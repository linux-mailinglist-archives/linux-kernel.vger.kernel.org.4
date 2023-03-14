Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05DD6B9F61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCNTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjCNTKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:10:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD01722
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:10:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so66204088edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678821002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAToBCAVYt3GcGYadQEhb7AkREOTPXmIkwVjM1uSyZg=;
        b=NkFjtkLoXbRILsSISuqp0dVywd4nQ7PYdZL1ie9aQuH1CTHCMG7AT/XsjuaHWJS15X
         U73hS5PVjTRrcBUNa/5rXqAL8ZMkIHedHwv+kOKUbr9ndeNguqVLnqyQbv5AthkJdl9C
         YGOnB3f3KqypaBLHo6tn1nud60KnbWRT4RxnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678821002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAToBCAVYt3GcGYadQEhb7AkREOTPXmIkwVjM1uSyZg=;
        b=C3YborkcyMiJ/EE9wn8czOU4RVbJvTA3qre7yR1PUilP5Oa5o0TDFYsag2wQkE3eXH
         cS1nxAmHX9IvzAb9z0xA5w52MzDwjdmEp54ztRDuaV4e27hkX1EC1MMbU5URXQbNddA4
         XdIXnUp85XI1yhxefzCmsY+fivyWBdC8Ki8QXGMku9aJRH3ZG+TJ1hFz6gqbDjfyCVqc
         OjKIIl2s8NObXVcU36mVriubxxUr2LFQG5J4dubZ2T18UOR6ZFIiuZEMSe1JIuRUbHuv
         WJySKJGO1olbLo4qUDTYFb95wUgMs4Z8P1q1lwShB1lAZ1ZBxS0ct2OCOINlQwuZNmTz
         YxVg==
X-Gm-Message-State: AO0yUKX1/lLLWlftdcI9j0sJXqtgMOLEAki6zQcW9kC20wbuIO098r37
        gvX+sv2Au1lxb3zFh8FdrtQi4pAxeVRNvab8NUN32Q==
X-Google-Smtp-Source: AK7set/zfkjZJo95nueqz1Pd98TL9Yv+kha+X/Q436KikmA1HET1HF0zsPISbxuZ0Lr4hZTg7PNHoQ==
X-Received: by 2002:a17:906:5012:b0:91d:a049:17a9 with SMTP id s18-20020a170906501200b0091da04917a9mr3474413ejj.36.1678821002468;
        Tue, 14 Mar 2023 12:10:02 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906138d00b008b1fc59a22esm1513322ejc.65.2023.03.14.12.10.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:10:01 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id z21so955707edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:10:00 -0700 (PDT)
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr1869330ejb.15.1678821000656; Tue, 14
 Mar 2023 12:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
 <ZBCkDvveAIJENA0G@casper.infradead.org> <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
 <3761465.1678818404@warthog.procyon.org.uk> <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
In-Reply-To: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 12:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEuJ6VXqaCemzXR-nss_aM-hUVWEnKSwdGioQJXDLF_g@mail.gmail.com>
Message-ID: <CAHk-=whEuJ6VXqaCemzXR-nss_aM-hUVWEnKSwdGioQJXDLF_g@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:07=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe we can do /dev/null some day and actually have a common case for th=
ose.

/dev/zero, I mean. We already do splice to /dev/null (and splicing
from /dev/null isn't interesting ;)

            Linus
