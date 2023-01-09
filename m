Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29C6634E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbjAIXPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbjAIXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:14:47 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A93D9F6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:14:44 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id bp44so9641604qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/TL+YBcWddbJqu2MLf1ZEjYu9UV+XN6ji96ExeGoPK0=;
        b=VjmKjZ2qcfNAHdIE7DfJFYF0+BubXcnvmhF/ef4jMYNojhNfGK4s985yxPSsbdJirK
         3lkYvWtf0sfoz7yiC2NeaQ8C9TaXoPWvvHzrOORBCzRjlRSLSrXS2B12zsQpFlB8WWyd
         LYe1zyzJ3+wAnLesrPvqokeNq8KRtrZBAfTjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TL+YBcWddbJqu2MLf1ZEjYu9UV+XN6ji96ExeGoPK0=;
        b=kCEgbFFm/aVN36/csIbV0Gob+3G/s7twUh664JCMgj2Pah2WbH/nW7mhdaNCEN4cru
         P+eU1bMwFRkSjkAskUeZ2A8ZrPsR8kkk6Mm+RyZoR6+j7ocnLL9GgmLjydwevAFHcL/3
         +4mXYi0z7dWn2rwL09NZhDl5Zx+JnJASymdv5Hx7nXfBPPikADKBto15DcAXCeWhzKP5
         QyO7luwBRaihhE6KU9sP6+FdpXm/oNX+DhF2+elThxsd5FXTAmfTKNs+yFsx4v6gvGMn
         y5KsHXcltAnYejBeyr2ST6woVtGjV6L8Znk9Z0YLqiov87ZM8qyjCNDY6mgWoL/UU2Nh
         GXLA==
X-Gm-Message-State: AFqh2kp5JTiIIP9dPqO2f3pOOkDJy88bAo5uk+HqnHxyEP+TKPf8aJli
        qL5SpSfcDnKNjwul6IhQFC2LdcAVDgsv+0rmU1E=
X-Google-Smtp-Source: AMrXdXsl6rejYoXXzjooJVXKzRFVpzUXsXypHiuzltV6MTmyQ54Br3Lxd1szb7wWorku5+YuLQAKiQ==
X-Received: by 2002:ac8:5243:0:b0:3ab:6d83:4bb1 with SMTP id y3-20020ac85243000000b003ab6d834bb1mr94057607qtn.14.1673306082892;
        Mon, 09 Jan 2023 15:14:42 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05620a179300b006b929a56a2bsm6181703qkb.3.2023.01.09.15.14.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:14:42 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id d13so7403479qvj.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:14:42 -0800 (PST)
X-Received: by 2002:a05:6214:2b9a:b0:4c7:20e7:a580 with SMTP id
 kr26-20020a0562142b9a00b004c720e7a580mr4364640qvb.43.1673306081964; Mon, 09
 Jan 2023 15:14:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net> <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
 <f39c266c-9802-71a5-8f1c-2d0a1340f59f@suse.cz>
In-Reply-To: <f39c266c-9802-71a5-8f1c-2d0a1340f59f@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jan 2023 17:14:26 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgg0hqiU5M3ExJdSNjx+BzDEC_fH7H_Rb0h_uykavg=Fw@mail.gmail.com>
Message-ID: <CAHk-=wgg0hqiU5M3ExJdSNjx+BzDEC_fH7H_Rb0h_uykavg=Fw@mail.gmail.com>
Subject: Re: Linux 6.2-rc3
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jan 9, 2023 at 4:43 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/9/23 23:18, Linus Torvalds wrote:
> >
> > Does anybody remember - what was the compiler version again and what
> > do we need to disable?
>
> Guenter reported that "The problem is seen with gcc 11.3.0, but not with gcc
> 12.2.0 nor with gcc 10.3.0."
>
> https://lore.kernel.org/all/20221227002941.GA2691687@roeck-us.net/
>
> Kees said it's -Warray-bounds, already disabled on gcc 12 for other reasons:
>
> https://lore.kernel.org/all/D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org/

Thanks.

I added a GCC11_NO_ARRAY_BOUNDS symbol to match the existing
GCC12_NO_ARRAY_BOUNDS one, and to half-way document this thing.

I obviously don't see this warning myself, so my commit is "blind",
but looks completely obvious.

Famous last words.

               Linus

                 Linus
