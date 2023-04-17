Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1066E4A26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDQNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDQNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:42:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102740F0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:42:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso3573839a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681738924; x=1684330924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7q804lvwVfzVDb04S7d3arCFTMYVaFz/3CbX2I4M+g=;
        b=PTdEhXsvOAH0NPbH1KvjkZ30CxIHea9a8M5x6iGhsGoklYTu1JOGyiFtJX7SBQ6/Pa
         vs4nXR2w66a9tH/pLotuNt1vTLJLChWL7bCGco6Fn2ot9MZG+7dX8RuPqp9zuVeJTuKS
         zd8m4H8fbbi2iI4HKkjtQsJIC/p0yj4RM+OsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738924; x=1684330924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7q804lvwVfzVDb04S7d3arCFTMYVaFz/3CbX2I4M+g=;
        b=cgfG7mVIBQhYNg0JcQRzKaLPPFzhXECo5/hl/1bDTOcjudPjQr2fTwj0A5pzCJvycO
         0B/mWR6/we5GqlpiCdMCdX/nPx9AHd1uX2qtb8iLQN7YTTLCMC3AdemUSoaOex0lKx/J
         R12hcWSokomYr7u54ZXpqdzPuYZgyKG9Y+jSlnyY9EeVYRM1TBaZ+0OS5a0krMGxwC61
         IV8xMcyQnvN53GHFzipkFoImdV0EjMIuDP2uZ7OlotsKiEzgV2OannbjoXgDpdeE30IC
         G5B3veCErQLNOq7tOKZ7kd0zwm7LPh2SdOafITtc1fc1NL6Kq4CvHCIYLcX2etDHo+7o
         m9/Q==
X-Gm-Message-State: AAQBX9cb/Cd55RCpnwA3OFEIMxq+iMJnF8+fDeq08wzc1CpWTnaKKZV9
        aoQ99W1fPoIK6ES5rQCfzatpTF4xFMJgQDF2eONJ6Q==
X-Google-Smtp-Source: AKy350Zg3QLHvnw/95Q6vTliZqLHidyDkByatnyFjttjBqUdRRoocqimA7oznXx8BAS5QIBs7O/4aw1cWeaH5bWr/TA=
X-Received: by 2002:a50:9f88:0:b0:4fb:7e7a:ebf1 with SMTP id
 c8-20020a509f88000000b004fb7e7aebf1mr7231823edf.6.1681738922075; Mon, 17 Apr
 2023 06:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer> <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk> <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk> <CAHApi-m4gu8SX_1rBtUwrw+1-Q3ERFEX-HPMcwcCK1OceirwuA@mail.gmail.com>
 <87o7nrzeww.fsf@toke.dk> <CAJ8uoz3Rts2Xfhqq+0cm3GES=dMb2hTqPzGm515oG_nmt=-Nbg@mail.gmail.com>
 <87o7nmwul7.fsf@toke.dk>
In-Reply-To: <87o7nmwul7.fsf@toke.dk>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Mon, 17 Apr 2023 15:46:46 +0200
Message-ID: <CAHApi-nSpUSVjeAX=UQEYGd2=H+DJ+xQYPvP8yQMuosGq22-Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > We will measure it and get back to you. Would be good with some
> > numbers.
>
> Sounds good, thanks! :)
>
> -Toke
>

+1. Thanks a lot for doing this! :-)
