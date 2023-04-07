Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892F26DB578
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjDGUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjDGUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:53:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7455A6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:53:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cw23so10815463ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680900778; x=1683492778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8xM6r6/rOzbRR11rE4PPyc0SA/I8K68bLshe2lzvT4=;
        b=AYFrTpg1m87JjskjlUbD3Y540rAQROTwgYO8jaDYgMlWEXVBLkfRSn/upu13hQpwOs
         0L9q74bZd4i3Si7TeWIMNU+0St5PYlcxrnH7KFZsrsGgGaLe3++g6B8rSj1j5f1LlhPn
         NOjnmhfCdyA6EY1gRVqkmJjPxqYHrJP1A6T9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680900778; x=1683492778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8xM6r6/rOzbRR11rE4PPyc0SA/I8K68bLshe2lzvT4=;
        b=Fo9ye/f8lg88845LMxlisoeFcQnpJdS37bhoMXDlW6dJH2Kb4vtG3x5zLiGun4vgr3
         ZQWpkE9UmT2NKamzHZHrpK2hWTnFcQXj5SS9t1ptdfKCF7ahx6B06G2e2W9NEAK8D8KE
         aMLVfyUkfeX4IQFQ+2J814yIdbhff15a9GlqcBCjnliU8efhy1aIBocWrwtmu4+72ee8
         PMjz2qF2kXs4qNTd6r4bX32sGPEIjQL5CGezscNiFoI3MGT789xwqmAU656Xy4Ri+dkm
         OlgJoW4AsatvsPMYiRtzn6645vLATUDEvtAkQCkLLUIm9qEYfnRy7mgABJ7WV2L2aPF1
         equg==
X-Gm-Message-State: AAQBX9ca39oRhiY6UVgWfAtgK1j3VzhurEn3YpIhpnQnmc/IvzLxQTIX
        ail4Jvkw4wTBHsQSuJ9N66XkSj6h7a9uyXGG2Mf4FQ==
X-Google-Smtp-Source: AKy350YEoBshGGAkfmInTC/VlbbCd9Yu8/uQ9uRK6ldKgR9vLUobYCCzlR0OXMnJ+3BjK2aYkNU3wg==
X-Received: by 2002:a17:906:2b51:b0:8a6:e075:e364 with SMTP id b17-20020a1709062b5100b008a6e075e364mr628937ejg.26.1680900778240;
        Fri, 07 Apr 2023 13:52:58 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm2367817ejo.106.2023.04.07.13.52.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 13:52:57 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id l17so10828995ejp.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:52:56 -0700 (PDT)
X-Received: by 2002:a17:907:b687:b0:947:72cd:9325 with SMTP id
 vm7-20020a170907b68700b0094772cd9325mr310007ejc.15.1680900776633; Fri, 07 Apr
 2023 13:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230405203505.1343562-1-mcgrof@kernel.org> <20230405203505.1343562-2-mcgrof@kernel.org>
 <ZDB+zn3X4sac9DFU@casper.infradead.org>
In-Reply-To: <ZDB+zn3X4sac9DFU@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Apr 2023 13:52:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYFGyy9jBmwEJHtdtdaEbqiyFn7GtMN6jP2ZFw92zYDA@mail.gmail.com>
Message-ID: <CAHk-=wgYFGyy9jBmwEJHtdtdaEbqiyFn7GtMN6jP2ZFw92zYDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Change DEFINE_SEMAPHORE() to take a number argument
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 1:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> I'd like to mention completions as an alternative to semaphores, but
> can't figure out a nice way to fit that in.

I'm personally a bit sorry completions ever became a thing.

There's a real reason for having them, but they have been used and
mis-used in so many confusing ways that I am worried every time I see
a completion. We've had some nasty use of 'init_completion()' in
particular.

There are many obvious uses of completions, and they have nice strict
semantics wrt last-use etc (so that you can put them on the stack and
know that you're the last user when you return, which is not
necessarily true of locking in general).

But there are several less-than-obvious uses too, and any use of
reinit_completion() ends up just making me go "Uhh".  The
serialization needed for that to actually work right often means that
you might as well have used a "wait_event()" with a
"smp_store_release()" variable instead and made the code more obvious.

I dunno. I might have had a few bad experiences and it's just rare
enough to be one of those things that I feel wasn't worth the
abstraction cost.

And I can't even blame anybody else. I think I'm to blame for that horror.

              Linus
