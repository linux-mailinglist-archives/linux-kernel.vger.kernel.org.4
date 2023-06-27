Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95F57406BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjF0XDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF0XDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:03:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEADD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:02:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso4012958a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687906977; x=1690498977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PSVGx8MBJk7AabVQCKe77+o2ODNwpAskHokqpD0hzdk=;
        b=GIrEXWaq2Kvyh7U+zJsbCYkjDRXC63BrjE0XMV7iguwOb7Py8uN2ICfsiIHTKEtXBw
         wNjbwYF7eLbAbXRG8qTa9nMeDOURzv+veL1mUrwMh4h8zUmm5vLizdsSrB+fzPnam191
         D2qX8RCX/RCxwFfuDbFquzLJiAGG12KNJnx/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687906977; x=1690498977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSVGx8MBJk7AabVQCKe77+o2ODNwpAskHokqpD0hzdk=;
        b=Dtpf8uebeTjwCb0sxxockK/Z9Mr26XLro6sI5dqqr/lVq1CoDcOTBzHKyd1VQ6HPkd
         8suXBlmXkIwX0pqoQo1/1q3Tq7F4es83aLdogC79JIZh3JlvkSZsk+Z48kd7sX9UzAKC
         /djqdYU+ub6ynxJDxR5T/2ci3Zf9lM1FIH8oziw1CloYNkePJYQd+iZ7zbwIcw7j1RwY
         Eg32Ern4zCQ/T+o1IjU8s/nSYJtYttHkc3J3DwVg+VA1pi7lCP5CO2T4KVTJ+9TA13JF
         9q9Xa7cTocCuGk7EHU0CVRJdAI5ETcvTBu3eRg/EZ9nrLc2V18mRQ6zaavH0ipegxNSe
         nANA==
X-Gm-Message-State: AC+VfDwOiZU0frqRHfnobQISc3GkdyBoVTPu+iq0SsHusdRFJTs//zib
        LxfWhqJ9igkAAhzcUmhdEO2+1pQKGlnpe+SKLasNMKAS
X-Google-Smtp-Source: ACHHUZ6URWAEqy+qbJ3qk7BgVPbL1pKnhlklGnHuJRygDSog9KkqclYADCXps48KThhB2MCVpueBfw==
X-Received: by 2002:aa7:de0f:0:b0:51d:7f4f:871 with SMTP id h15-20020aa7de0f000000b0051d7f4f0871mr7198578edv.8.1687906977716;
        Tue, 27 Jun 2023 16:02:57 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id l22-20020a056402125600b005149b6ec1bdsm4120017edw.29.2023.06.27.16.02.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 16:02:57 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98e0c1d5289so469642166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:02:57 -0700 (PDT)
X-Received: by 2002:aa7:d4d5:0:b0:51d:3747:f88a with SMTP id
 t21-20020aa7d4d5000000b0051d3747f88amr7469054edr.31.1687906976883; Tue, 27
 Jun 2023 16:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com>
 <1982e4b4-3858-d456-6c90-92782b95726a@linux.intel.com> <CAHk-=wiQEj1cP7tnQ6Uw1jjFYnZmMdNgodga3b+rw98vBBvENg@mail.gmail.com>
 <CAHk-=wgMw2VE8afWp4p6RyJKCvnkhNXx4XUByUOHUWKiAo=WLQ@mail.gmail.com> <51f58d51-d5bf-79a2-a32a-e6849a118123@linux.intel.com>
In-Reply-To: <51f58d51-d5bf-79a2-a32a-e6849a118123@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 16:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtrxkRDR95y=U685LMd_ZR5TrLW0_LGoQi3v8Or11Yrw@mail.gmail.com>
Message-ID: <CAHk-=wgtrxkRDR95y=U685LMd_ZR5TrLW0_LGoQi3v8Or11Yrw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 15:51, Arjan van de Ven <arjan@linux.intel.com> wrote:
>
> I'm not surprised though; running 2 parallel streams (where one stream has a fixed zero as input,
> so can run OOO any time) .. can really have a performance change like this

How much do people care?

One of the advantages of just having that single "update_csum_40b()"
function is that it's trivial to then manually unroll.

With a 4-way unrolling, I get

  02: 184.0 / 184.5 cycles (8b414316) Upcoming linux kernel version
  04: 184.0 / 184.2 cycles (8b414316) Specialized to size 40
  06: 89.4 / 102.5 cycles (512daed6) New version
  22: 184.6 / 184.4 cycles (8b414316) Odd-alignment handling removed

but doesn't most network hardware do the csum on its own anyway? How
critical is csum_partial(), really?

(The above is obviously your test thing modified for 1500 byte
packets, still. With 40-byte packets, the 4-way unrolling obvious
doesn't help, although it doesn't noticeably hurt either - it's just
one more compare and branch)

                  Linus
