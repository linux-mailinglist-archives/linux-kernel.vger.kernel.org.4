Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2BD711CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjEZBki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjEZBke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:40:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDE819D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:40:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso148814e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685065231; x=1687657231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm58cdLmSJ5zDiAtA58RWN5FnFQJSGcvSIirliOWuIM=;
        b=hM86DWSSrWcI/RPc3GLJogtgReoZ8OSKtimvjFZX6uP/eQHyPF3IZSAsICSYIhRTWD
         qdTZl7Xqgffk+q70bYMwZR57LTQZkmuUCZye4RbORzO9Qn2Qqb4nUkmybl3drVTiLZ08
         zkMJdVIAC7jtYv2RvdaBnVv8BpqNV8EgYkFqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685065231; x=1687657231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm58cdLmSJ5zDiAtA58RWN5FnFQJSGcvSIirliOWuIM=;
        b=E9V7QD2otcQYWlAZyfEjl9ESWGf7N4wL9OP+1I32qFzfbEfRV000vua3g5aquTKMCN
         cBCuG+3yL3T2dq0V4O8IxN9pMk0+XfM0nFIm9NyfltkmvmRWX0smqiOFTCCsfovIz5C8
         t3zITC/YNZD2sbUqahY2cvRuhfLl1lNcw10jRawJ8wogJ7AQYyG9ihk9KgDcURB8ZA5l
         4eN4aSzQJ2k7Z/mbWxTYXhprhrpvR56kkeICBkSd2ltX0WJscSEhOqcEyJuMGY/EoZux
         iQToifLhCNh1RlC3pssYB5vGftxGCaHoy3/c9DAZTAac2XtMJkJ7CB/q/LuRzi2GZ/Xi
         CsRQ==
X-Gm-Message-State: AC+VfDzI6dxeQPswJ4nRTs+ubMjMqOGzc+mcKwZYHYyXeSB+QnEOIFtI
        7h/XpncZzPE6DQlJTvK59davoOEXDcNz/HWQ3uNVhrkZ
X-Google-Smtp-Source: ACHHUZ5yekqj6qPHSNVhQDMnMcRuUNy8QOJFadJzMvGrZ1v5/Gd/EEfsRtIViNSDwPuNX5cn66cQJQ==
X-Received: by 2002:ac2:54a7:0:b0:4f3:872d:10ff with SMTP id w7-20020ac254a7000000b004f3872d10ffmr7789lfk.64.1685065231600;
        Thu, 25 May 2023 18:40:31 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id t20-20020ac243b4000000b004edc9da63bdsm404843lfl.160.2023.05.25.18.40.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 18:40:31 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af1822b710so2056421fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:40:30 -0700 (PDT)
X-Received: by 2002:a17:907:31c3:b0:96f:912d:7922 with SMTP id
 xf3-20020a17090731c300b0096f912d7922mr478321ejb.53.1685065209995; Thu, 25 May
 2023 18:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com> <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
In-Reply-To: <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 18:39:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
Message-ID: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 3:02=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> So yeah definitely a pretty good improvement. Sometimes the system boots
> without any duplicates at all, for some reason Vs the previous attempt.
>
> Tested-by: Luis Chamberlain <mcgrof@kernel.org>

Ok, I decided to just move it from my experimental tree to my main tree.

I think I used about three times the time and effort (and lines of
text) on writing the commit message compared to what I did on the
patch itself.

I tried to lay out the background and the implications of the change -
it may be pretty darn simple, but it does have some subtle issues.

Anyway: I've committed it to my tree. This is not necessarily the best
time to do that, but let's get this behind us, and in particular,
let's get it out and into wider testing asap.

If it causes any problems what-so-ever, I'll just revert it very
aggressively (unless the problem is trivially and obviously fixable).
It is, after all, not a fix for a _kernel_ bug per se, and whil eI
think the patch is very benign, it does change user-visible behavior.
Very intentionally so, but still..

                         Linus
