Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE329609516
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiJWRTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJWRTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:19:39 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377DD44
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:19:24 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i12so5281318qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hud+8UtOIj7px+Ybea5ZrafkXvnAXxNHRaMhHn2uzZI=;
        b=V1QpCIEYcXdsNdfcTUmzhuTSu9BjrteRAl3zdbadLIDSab68MePQSKghHk3FwMIDzO
         Ta9mNVttm7GBcLmt4oXgTV49Kgr+QtyehxSJZEQzelFJfCFZNut243qr+t7jo/kaBFzE
         bAa3TfVVRZ7IfXYo8ZoSFGYmz89i/tMFFbvlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hud+8UtOIj7px+Ybea5ZrafkXvnAXxNHRaMhHn2uzZI=;
        b=feFC0NU2Zv/FodpInoAzDNzr2M4Q1p7MlPz91vuq3Vn5gJPZzPcsShICbFmEKqJ4Bf
         SYrAT9EviC/CO94kqTURtTS9tPlYboW6WtaIlJ0FJWV9WgUtvGnVfl1QPaLsBT1hh3nX
         DR4gaCAU2liChgGATK4nqRkG216yadeykvFuPv8KrbKIeo92ycEx9VGslzh2vK0v0+sl
         4zRLO9GROn52pmaW6a219ABLeZhd9uanyt2Y2nC+6ZRPy2zAO76qvW3a1x00ihun6qx/
         igtNCobTy41ODjX4oppWQHHGg0zv1jpkadfAnjh1B1cvNUFwPm45/tGYyHs+JJ+W9h9c
         Fhow==
X-Gm-Message-State: ACrzQf1uHwfBxIpv4xMjFaZgAuzAgQ62CNXSsG31buItAvQtx902S4L5
        s7U815gMBEL3DeRSEceumSXwrpx2nuZG/g==
X-Google-Smtp-Source: AMsMyM7hju2OTd9QBhgalamqhgTl3lbZlOCl8uku8n8f25M2JTnHsl0euoNqoS/cjXTgEqXltOfxNw==
X-Received: by 2002:a05:6214:20a3:b0:4b1:a691:1436 with SMTP id 3-20020a05621420a300b004b1a6911436mr24235916qvd.14.1666545563176;
        Sun, 23 Oct 2022 10:19:23 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id bk41-20020a05620a1a2900b006eeaf9160d6sm13155132qkb.24.2022.10.23.10.19.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 10:19:21 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id o70so8771280yba.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:19:21 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr24896573ybb.184.1666545560782; Sun, 23
 Oct 2022 10:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8lbkx3HYQpnvIB@krava> <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava> <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
 <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com>
 <CAADnVQ+gquOKjo68ryUhpw4nQYoQzpUYJhdA2e6Wfqs=_oHV8g@mail.gmail.com>
 <CAADnVQKj5B1nfkQTSTrSCPq+TQU_SD22F7uG7Carks8oVi8=aQ@mail.gmail.com> <CAHk-=wh5bT2GPy4EYiPd3Vu+wm9QHmsP38XApFp8qLaup=exfA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5bT2GPy4EYiPd3Vu+wm9QHmsP38XApFp8qLaup=exfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 10:19:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtjPiiz-wtjAO2AXHNtUwWa6CXk6r0OfPrVTt6KQmYmw@mail.gmail.com>
Message-ID: <CAHk-=whtjPiiz-wtjAO2AXHNtUwWa6CXk6r0OfPrVTt6KQmYmw@mail.gmail.com>
Subject: Re: bpf+perf is still broken. Was: [PATCH] bpf: fix sample_flags for bpf_perf_event_output
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        X86 ML <x86@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
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

On Sun, Oct 23, 2022 at 9:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have a pull request from Borislav with the fix that came in
> overnight, so this should be all fixed in rc2.

.. and now it has moved from my inbox to my -git tree.

                   Linus
