Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB7A714F05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjE2RsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE2RsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:48:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E866DE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:48:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-973f78329e3so284365166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685382487; x=1687974487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMdOshEWsCUccpZDIFZZY9qEaKeS/wKY+PKyVf4UtLw=;
        b=ebxoUHMAoHjBwRTQQFj5NAVEDHva9Q+73M4/Q/jpzXMPHcw9bjP39wSyvA7bdgirQc
         hDUdZY8YVnGr12KA2uzMWc133w/odbrTDg9Nbdl8mv3qwoqkKKvfDmu9tG58tYTnLjTP
         yg1PQODaY05oxTogUAi/p3cS8p+y2FjkdNlYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685382487; x=1687974487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMdOshEWsCUccpZDIFZZY9qEaKeS/wKY+PKyVf4UtLw=;
        b=E+xo7G1X+1XgKBzpFNkAt2aL82KeCCnVA9XGnyT9NDmxwwZnr9iBoU6pG12X6M7lM9
         82pOQNDDvj3vNq1ONtHv3d5PkEwb8XLZvFO0qM9PrcKH4CapXpVM6GvOeRQS6xvunYj7
         LN4a+9w/kl184KhrBUtKMzY3f6rJVVfWKF/ikhHQpKKRR1c5RFmif4149IVFFzFTOZMd
         yflMfAUk8NAPW0yYNF89RuN+Z92SlJUsqiBzmdSCPHILW2nflfDBG9bmk2CDN97EvaTd
         noR09yhUkKcc0w1kPG1/TM7ItkR+cNF+Be/DsFnpnf67/PKJodIIn/ZkhB++3EQJoAwX
         DrWw==
X-Gm-Message-State: AC+VfDyXLzn1o1pHD5SNwJWC8kfrLBP3bMxWGZI/TZA2JZq2kt8PoLo5
        dVE+OKMkDTVJ1KR63yH0LqNipsl8TaSZ1gf90KShhHfx
X-Google-Smtp-Source: ACHHUZ7qgZkM29GwHKfVwjfjCwN7FzBukE/4sbS5saaWs8Kh4yt6cpDwy4Jlc1EYZyoK3F8NQ1Sn0Q==
X-Received: by 2002:a17:907:720b:b0:974:32e:7de9 with SMTP id dr11-20020a170907720b00b00974032e7de9mr3503022ejc.56.1685382486929;
        Mon, 29 May 2023 10:48:06 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id s7-20020a170906c30700b0094f410225c7sm6130377ejz.169.2023.05.29.10.48.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 10:48:06 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso2745425a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:48:06 -0700 (PDT)
X-Received: by 2002:a17:907:36cd:b0:96f:7d09:7deb with SMTP id
 bj13-20020a17090736cd00b0096f7d097debmr13772127ejc.69.1685382465126; Mon, 29
 May 2023 10:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org> <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com> <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
In-Reply-To: <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 13:47:28 -0400
X-Gmail-Original-Message-ID: <CAHk-=whHRAntqwt_iGAdezj4i33GTmN+Oa8z3CNz4LO0Puo85g@mail.gmail.com>
Message-ID: <CAHk-=whHRAntqwt_iGAdezj4i33GTmN+Oa8z3CNz4LO0Puo85g@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Johan Hovold <johan@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 8:44=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Yes, those two changes are enough to make the problem go away.

Ok, good. Expected, but just verifying that it wasn't some silly
incidental thinko.

> > I do wonder what it is that is different in your setup, and maybe you
> > could also enable the
> >
> >         pr_debug("finit_module: fd=3D%d, uargs=3D%p, flags=3D%i\n", fd,=
 uargs, flags);
>
> Below is the corresponding output with a working kernel: 174 requests
> for the 131 modules that end up being loaded (without the revert there
> is only around 110 modules loaded).

Ok, your setup doesn't sound *too* different from mine. I have 176
kernel modules on my laptop right now, and that exclusive open
obviously worked fine for me.

But it could easily be some random small difference just from
different hardware, so...

And yeah, that dmesg output is useless, I didn't think of the fact
that it only prints out the file descriptor, not the actual path to
the file. In fact, without that change in place, the module code never
actually looks at the file and leaves it all to
kernel_read_file_from_fd().

With my change, it woul dhave been trivial to use "%pD" and point it
at the file pointer instead, and get the dentry name that way, but
never mind.  I think you're entirely right that it's probably due to a
shared dependency module, and I just didn't happen to trigger that
case.

Sadly, the whole idea was to figure out the exclusion so early that we
don't have the module data structures lookup up yet, so there's no
really obvious thing to serialize the load on.

I'll have to think about this more. Serializing on a per-inode lock
would seem to be the simplest thing, but they are all for IO, and we
can't just take them over the read.

                     Linus
