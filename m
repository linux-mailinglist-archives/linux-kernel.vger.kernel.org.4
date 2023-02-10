Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E69692896
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjBJUp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjBJUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:45:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C927A7F3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:45:17 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id sa10so18871261ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ouszKA6QqICt+YxGce9SY3oz4SsHUe9oFN+JOLlH88=;
        b=BtUoz55elLFqQDfXVT2fRepfHO1VRasY7bNzTcVJa3+3O5Djx3ghbK7G70ibZuu5vN
         3dc49Cy8mFHNkJ1Vv/oF3CA3dF13tG/Y81zRPTekzdHD6j5UHk4GfmpJ70LOUcP2NqZ2
         LylcoEZit07hjr9sxmipoBqLVL7wknoCGK6LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ouszKA6QqICt+YxGce9SY3oz4SsHUe9oFN+JOLlH88=;
        b=zbLhDIircKU6b2vu9ObirjXqwbqcl1229eOiRDUZcSDTBh3z28XDdnL1gmIrlsBPeB
         cuT4kgtiaM2Qt84wdRJdIHyIONDjaXLIesMPjmTDHBEdkdTTsYos0wqu5P1YwS6lOKbR
         Th6w2x8ZYXD1JypEOEv2JQe3RsQmOYJh83hahMQ3Vl3TnMnUPSFjtSlaF8FWcNJGXYmz
         XotOM//YdVO1fIJfQL8tN6Fco2j5/fyXJgsbeJf6jiq7ZYAkmIzuPouhrBXpKCKarfJO
         Hp0i8eiaVe6MjEZ/EEf6OHiNKMoSLeqUV/FGvUeJiMFbdQ916YUbwYCWqBBD1k/hdJra
         OngA==
X-Gm-Message-State: AO0yUKUVDQ2drnHUVYXTh0/YrJMDo5voHmWsbUw6MoZUPgvjhyUwzmOq
        LHIGk5H/itBAHbWCmx3wbGeOGbKYFgSIm9kvFHU=
X-Google-Smtp-Source: AK7set+94RJxh+Ab2/LrvE8wQi3SBNdOCcuvZ780Lq9tWlcQWkLPFs9GBLq4J9rPnTKd9+D8ddIkyA==
X-Received: by 2002:a17:906:3159:b0:88f:a23e:6f0d with SMTP id e25-20020a170906315900b0088fa23e6f0dmr17645028eje.37.1676061915687;
        Fri, 10 Feb 2023 12:45:15 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id b5-20020a170906d10500b008784bc1dd05sm2823343ejz.76.2023.02.10.12.45.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 12:45:14 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id cq19so3115304edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:45:14 -0800 (PST)
X-Received: by 2002:a50:f603:0:b0:49d:ec5e:1e98 with SMTP id
 c3-20020a50f603000000b0049dec5e1e98mr3298664edn.5.1676061913926; Fri, 10 Feb
 2023 12:45:13 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com>
 <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
 <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
 <CALCETrWuRHWh5XFn8M8qx5z0FXAGHH=ysb+c6J+cqbYyTAHvhw@mail.gmail.com>
 <CAHk-=wjuXvF1cA=gJod=-6k4ypbEmOczFFDKriUpOVKy9dTJWQ@mail.gmail.com>
 <CALCETrUXYts5BRZKb25MVaWPk2mz34fKSqCR++SM382kSYLnJw@mail.gmail.com>
 <CAHk-=wgA=rB=7M_Fe3n9UkoW_7dqdUT2D=yb94=6GiGXEuAHDA@mail.gmail.com>
 <1dd85095-c18c-ed3e-38b7-02f4d13d9bd6@kernel.dk> <CAHk-=wiszt6btMPeT5UFcS=0=EVr=0injTR75KsvN8WetwQwkA@mail.gmail.com>
 <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk>
In-Reply-To: <fe8252bd-17bd-850d-dcd0-d799443681e9@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 12:44:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
Message-ID: <CAHk-=wiJ0QKKiORkVr8n345sPp=aHbrLTLu6CQ-S0XqWJ-kJ1A@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
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

On Fri, Feb 10, 2023 at 12:39 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Right, I'm referencing doing zerocopy data sends with io_uring, using
> IORING_OP_SEND_ZC. This isn't from a file, it's from a memory location,
> but the important bit here is the split notifications and how you
> could wire up a OP_SENDFILE similarly to what Andy described.

Sure, I think it's much more reasonable with io_uring than with splice itself.

So I was mainly just reacting to the "strict-splice" thing where Andy
was talking about tracking the page refcounts. I don't think anything
like that can be done at a splice() level, but higher levels that
actually know about the whole IO might be able to do something like
that.

Maybe we're just talking past each other.

             Linus
