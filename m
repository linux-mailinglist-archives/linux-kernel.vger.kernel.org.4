Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473C170A50B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 06:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjETEBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 00:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjETEBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 00:01:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3331B4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:01:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96b0235c10bso733330466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684555287; x=1687147287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lN4GcKWsmyboezh08Qy1RSmzm/C0mfuVswPHh8pOik=;
        b=NB4Bpcw7vXTvHxoE2iUrI+xTUBVuMgD3t6AJjKe8i1AaG5euuBHtPDB3v0ue+7MTG2
         GNx37rnZJ0uhHsnT0oCmNcuFhBSbhr9HYd0sC/HRhT9qTD9RWaGZyevcpeX9h+okVj4v
         YY0/JD+dHOYpPG38EfRu0ogZz+a8cOiS2Pk9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684555287; x=1687147287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lN4GcKWsmyboezh08Qy1RSmzm/C0mfuVswPHh8pOik=;
        b=XEqzct8zurdp8RU0iD4gajATZz0uY27CNl77HDhUme9MEoVTcnDVZvmBGC6sf0BVrc
         6LV4KXGvvCw6vKvt5yPmJN4jzd98lc8+MlA9khGGFosczMgpAKjA+6BbAkDi+LHuQhtN
         /UnJ4o+Dn2vpn/bOi4aMStBlQEOkE+d9UgGZXaS9hIVlcSnek+8kOKQZYQMYhVyVFngv
         hg1pataokztF0t11kDahWtmicTALT5UOQtI0mmxD3fr1FvVDZB7Jr7mwmOWLoynH44om
         eqjGLWRDfybQD2dgtR34D7OnSJSclTzYSfG5e4Z3b4pW9tHBFtt1kdEPY3Wv/f6YfX9M
         GO9w==
X-Gm-Message-State: AC+VfDxExxWZQlz3FVyhmwYXdmx6UvbeiyB9d/lyLoVp+sd0PZ2kqdKN
        jI+7mxoOHMlAwduk1zdp8vBE+amz0dfrDXNJfij9xI5Y
X-Google-Smtp-Source: ACHHUZ5a8+8LGUEYU4vC4LU+Wkzt4mu3FcCoZzRV33xVzfEn97Ejw/DtkFgZXrTJYKfpwqZ5uMbXJg==
X-Received: by 2002:a17:907:72cc:b0:96f:136e:eadd with SMTP id du12-20020a17090772cc00b0096f136eeaddmr4107574ejc.66.1684555286805;
        Fri, 19 May 2023 21:01:26 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090672c500b009666523d52dsm340920ejl.156.2023.05.19.21.01.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 21:01:24 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso3085551a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:01:24 -0700 (PDT)
X-Received: by 2002:a17:906:858d:b0:959:6fb2:1c3b with SMTP id
 v13-20020a170906858d00b009596fb21c3bmr3193781ejx.39.1684555284253; Fri, 19
 May 2023 21:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
 <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
 <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com> <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 21:01:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
Message-ID: <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
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

On Fri, May 19, 2023 at 8:57=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> I also realize that I don't really need to check whether the masked
> source address falls under a VMA neighboring to that of the source's.

I don't think that's true.

You can't start randomly moving other source vma's that may have other cont=
ents.

               Linus
