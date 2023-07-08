Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C674BEF4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGHTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 15:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 15:23:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD26FD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 12:23:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51dff848168so4005407a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688844190; x=1691436190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=joV2BdE7YOFZ22mdVaTCQPGn7sLlO9d89m2/O8Ni8nw=;
        b=T2pqC72EzC/l5ocPTlE8QR8Er9U2w4UWsADfntO5p1ri/2LUBttZT8aWbBWWcrt3RK
         iamWIuuZApdp95ZOW6KlpJPLAMPAgVdg866cttW1wX0ohDXsvoqgWS482/jgBRe1CHVF
         DCjbOKIqCilAWeeVgKAkuChWygZqj55JlRdso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688844190; x=1691436190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joV2BdE7YOFZ22mdVaTCQPGn7sLlO9d89m2/O8Ni8nw=;
        b=Su6cr/UeDdeaH5bjJZxCiOsMzEyCUNprT0d8DS+g4HjAwjafl0NN7QgfG7G9w0t655
         YKR7y1nQfeKnC6iZvETwd23L0BSWd+drqoujc2Zzp/H6sFWngP70Tqdh5TKwEZijFMWy
         st+gCocZ8UECAztTey9g6TfdBOYL46g7x2ZzsfvpuM5qfiMe6eDz6TakAjfNlJvzltrp
         DbP/ymGZHABCgBDvZMCKi7Py97iPIaqPPFiKHFdS5YMKp36w2WAWdIt/Hw0RI1kryCNT
         KgytAlW7AIBBWzw8IAi9NhMBMcwHgwY9IVXpopQolNix6C/0CtlZ745J0RfiTCv6MHjM
         AAog==
X-Gm-Message-State: ABy/qLaF6yB6psgTwZCCLOFQhXFlyP/rfWDkT7D0hPjRbO9h2d2UFgRU
        FOtOvnZSTDXYoJvaPXSq3MzqrUO/dlcVor/Y4iu98NtU
X-Google-Smtp-Source: APBJJlFzj2RUumrCP9CHjYXoRCQHD0KqF1FQMXaMWfP24/OJLczbQ7G8IzdFhCHenxVKWSPZjL12Ng==
X-Received: by 2002:a05:6402:350:b0:51d:f589:9c7a with SMTP id r16-20020a056402035000b0051df5899c7amr5644501edw.17.1688844190558;
        Sat, 08 Jul 2023 12:23:10 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id f15-20020a056402150f00b0051e06693590sm3588142edw.91.2023.07.08.12.23.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 12:23:10 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so33792645e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 12:23:10 -0700 (PDT)
X-Received: by 2002:a5d:684c:0:b0:314:4915:689 with SMTP id
 o12-20020a5d684c000000b0031449150689mr7611320wrw.34.1688844189725; Sat, 08
 Jul 2023 12:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh> <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh> <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
 <2023070509-undertow-pulverize-5adc@gregkh> <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
 <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org>
 <df1d7d39-56f3-699c-0d0f-fcc8774f182e@leemhuis.info> <CAHk-=whKd05V49AbZGF=inYmhU6H_yNvvw1grWyhQfQ=9+5-VQ@mail.gmail.com>
 <20230708103936.4f6655cd0d8e8a0478509e25@linux-foundation.org>
 <CAHk-=wh498i3s+BgOF=pUOF=Qe_A0A16-mFcH2YGy+iZXvNChQ@mail.gmail.com>
 <CAJuCfpFLc1yoZm9uqRcmcwtFNGHYKyjxrc71tzXennpGB7QbYQ@mail.gmail.com>
 <CAHk-=wi-99-DyMOGywTbjRnRRC+XfpPm=r=pei4A=MEL0QDBXA@mail.gmail.com> <CAJuCfpHszCAc5hDdsxry+1xh3kz+=jsYdBCXKQez-Th9LESSZA@mail.gmail.com>
In-Reply-To: <CAJuCfpHszCAc5hDdsxry+1xh3kz+=jsYdBCXKQez-Th9LESSZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 12:22:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=+qS+5v_7mVxKWUSOKaxzC2V8N7hyFVt1qTWGM_pmAQ@mail.gmail.com>
Message-ID: <CAHk-=wi=+qS+5v_7mVxKWUSOKaxzC2V8N7hyFVt1qTWGM_pmAQ@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 12:17, Suren Baghdasaryan <surenb@google.com> wrote:
>
> Do you want me to disable per-VMA locks by default as well?

No. I seriously believe that if the per-vma locking is so broken that
it needs to be disabled in a development kernel, we should just admit
failure, and revert it all.

And not in a "revert it for a later attempt" kind of way.

So it would be a "revert it because it added insurmountable problems
that we couldn't figure out" thing that implies *not* trying it again
in that form at all, and much soul-searching before somebody decides
that they have a more maintainable model for it all.

If stable decides that the fixes are not back-portable, and the whole
thing needs to be disabled for stable, that's one thing. But if we
decide that in mainline, it's a "this was a failure" thing.

           Linus
