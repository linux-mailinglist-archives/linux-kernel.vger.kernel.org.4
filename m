Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79C65C7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbjACUQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjACUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:16:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D13FDE92
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:16:16 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j16so25467913qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTnuIAJdCSnqOgUCfI1VegmgFYxeW1ngR0BDNyHkGf0=;
        b=DokQ/BEIgEpL/ia17Z2x8+os3L6Iix7X3VYwgY2oWHbqXrXltMNtHkuxWFNC0TiQoL
         cBgZVKREYRgoskXuojqZ3A1XLXXW46nqyABZQqesu1jY6qAYwaNx5oLjtODVhfjUliU3
         eVndN+o81O0zIOd96+Ti2/uGI99RMfL7MdUR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTnuIAJdCSnqOgUCfI1VegmgFYxeW1ngR0BDNyHkGf0=;
        b=qJsZTTDvL9TZZd947ckUNwCyBhPA190+gWk6cvPwQ4wXYCVE4PquJlPL5MufuZ123j
         vO111J7sKC635Hxydwv8UfP94geIUMiJm4VlgcrJxpSLaLsPfSkyOOS5iPGlmhBGsr8H
         bNd4l0RXLWC74XL2jBBIEZgOB1Rwc9RdIZf41tu3S6lJpTKRKKstgarVH+rvV4WsGjUy
         JGbJi/DeSai8tOFSeS45rw9hET7NybFHTIhak2ugJQt/GICuihak7r65bOGhFLhFFAnA
         cuKg2ZZK4KUxpibsezbLC7VoyRziuH+9JAt4vy+G7Mkcs+YKRydXBnLPIb5ZENSmLT5p
         rOpg==
X-Gm-Message-State: AFqh2koBMrRLU2ole2RN7x0WbZqPE7A5mC4rnACliQC9Hr6iBlhq/uhl
        ZQVU4ODASWqhs4YGDOquQgqd4YxsAV5eYFx3
X-Google-Smtp-Source: AMrXdXu6Lf7juIlvAHNmV4jcHYW5ttZbIzEsYr01YlITWvInhFs27EIrVhRcsySdRYfKQ6YcGGL6AA==
X-Received: by 2002:ac8:65d6:0:b0:3a9:691e:8dc6 with SMTP id t22-20020ac865d6000000b003a9691e8dc6mr65218826qto.47.1672776975334;
        Tue, 03 Jan 2023 12:16:15 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id z24-20020ac87118000000b0039cc0fbdb61sm19351146qto.53.2023.01.03.12.16.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 12:16:13 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id k3so15324113qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:16:13 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr2045085qkg.594.1672776973189; Tue, 03
 Jan 2023 12:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
In-Reply-To: <Y7SJ+/axonTK0Fir@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 12:15:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
Message-ID: <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Tue, Jan 3, 2023 at 12:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> That buffering cannot be done safely currently

.. again, this is "your semantics" (the (b) in my humbug list), not
necessarily reality for anybody else.

I'm NAK'ing making invasive changes to the VM for something this
specialized. I really believe that the people who have this issue are
*so* few and far between that they can deal with the VM forking and
reseeding issues quite well on their own.

            Linus
