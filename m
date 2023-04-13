Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ACD6E172C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDMWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDMWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:07:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8759C0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:07:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94ed301bba0so25492866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681423628; x=1684015628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=friaFVRW2nEkWI8GqaRgUP4OaK4hMpGVYJNwq+6sPzI=;
        b=DsyluJJo6Gom9PRhwdltwR+7/pQj6HC8Ru3crTjYVpnCuwwCzmB5W4uIThpX0PvJfH
         RQXx5BE/yFZKNZQEhsf0jjVUYf0wRWFp88Djf3hiZqURIlau4PmuAm6FjjXhc/Ylocze
         kDOWE27v2wmPAQ1I8Kk1AviCLLFoPzwF8JpVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681423628; x=1684015628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=friaFVRW2nEkWI8GqaRgUP4OaK4hMpGVYJNwq+6sPzI=;
        b=NYbCIUr9nK96HJrZOOdJtt6/RZQ2jTTXP11bLwtTO/uXuSdNlu3Oz++AIvQom8OYml
         dRQ2nTMpU1JXd31k+hETguI9axR8N172nGPtWHLadcNK77wDrvGIa8pkDtslqMH6Sdl9
         FVQR4QVljOwRQmm3bx39Fg/uhA+oNgboKbXTPariVx6XgMmFZeHpcf3Rh4JMeIvCR3kB
         AS/h86g6lnxbX+Xk/yCHVwzrwV0nsLAG3d/N52v8/35684MDP+SUgmAMXeCupZ+gEzDW
         T49ZEp1we/tHdZIsQWOmvxdwYkebavcr6uozc+6IOTd9PM3ASiolnp2F6hs3CQBtwHCY
         tUrg==
X-Gm-Message-State: AAQBX9c/izz+wrjFfZj767eZuCiw27LTOjYQ6KDfJ0UWncRxTSC0s+IT
        f/Dsbw6KLg1znnlu0vtjTRngWu6aaQ0+y9xgDWGA3A==
X-Google-Smtp-Source: AKy350bJvy2LkZU3ndK85yZddnes7jQSqL1w1K7DgMkkBqnQ05cq07nfQuXtaKhm9XsnkRGGmCcytGw90/9Hwy+wtLk=
X-Received: by 2002:a50:a40a:0:b0:505:4fb:4430 with SMTP id
 u10-20020a50a40a000000b0050504fb4430mr2047782edb.6.1681423628016; Thu, 13 Apr
 2023 15:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer> <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk> <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk> <CAHApi-m4gu8SX_1rBtUwrw+1-Q3ERFEX-HPMcwcCK1OceirwuA@mail.gmail.com>
 <87o7nrzeww.fsf@toke.dk>
In-Reply-To: <87o7nrzeww.fsf@toke.dk>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Fri, 14 Apr 2023 00:06:56 +0200
Message-ID: <CAHApi-=BcdTD7KvE0OEzYya0RmDLDBS19NgtZsESADYXbySLOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> "More annoying" is not a great argument, though. You're basically saying
> "please complicate your code so I don't have to complicate mine". And
> since kernel API is essentially frozen forever, adding more of them
> carries a pretty high cost, which is why kernel developers tend not to
> be easily swayed by convenience arguments (if all you want is a more
> convenient API, just build one on top of the kernel primitives and wrap
> it into a library).

I was trying to make a fair comparison from the user's perspective
between having to allocate huge pages and deal with discontiguous
buffers. That was all.

I think the "your code" distinction is a bit harsh. The kernel is a
community project. Why isn't it "our" code? I am trying to add a
feature that I think is generally useful to people. The kernel only
exists to serve its users. I believe I am doing more good than harm
sending these patches.
