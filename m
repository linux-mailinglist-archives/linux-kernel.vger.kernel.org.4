Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACF6094E6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJWQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJWQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:55:50 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B94E844
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:55:49 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c8so4532241qvn.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qQfIbjGjR86ILl8fPB2hc7oW/p2rUgV9JRxehRdQ4E=;
        b=NVORG9wAnPcLMk50stkHpSj6P4vsMtH074KxTCg9VXGrSqzaSaBnDeJgcR/6D1bhLl
         wbQPHt20bA5N3cPSCbZdimSw+r56pAkGiXfyx5qKD9Lv/n+JqI0oFoLiJ+YFG3RrN3N3
         JHj6C2yeCcfZKJRZfrLqkL+cc18mEDf/tATHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qQfIbjGjR86ILl8fPB2hc7oW/p2rUgV9JRxehRdQ4E=;
        b=iUcOYe9sfqbnfjT0B2sNIHgfI6/yOrrKEHjiaHKTdcSC1OpK9xV0vUDrnn84q9GEDK
         +9xLlmvGsCR+kU9rYEZF8PNROJPiNriYLrWnIiZFOzmi2hN+2JEKJv/dTc6jnO69iLOx
         Drbs9UWj3Wo1QxrQIcqpHvpI/H3CD51gIG1gdTblmymVIkUvBn/qLphDDowEg4j4Kr/N
         sPvXHFCER5ThlBwIz25zNp2iBi292/04TpkyR9IvxY/m095gtgIJvoQslQntw5I1+MGv
         QdabS5UMlRohN8349pBt8Xttfy6+uR1YpsDZahH/gRammkp/KJO4bBZUmlfM05Fo4ZNr
         9DTQ==
X-Gm-Message-State: ACrzQf3rWiOWE722bqMZcZOEdKFR2fL3Dx4xBTHP12xvaO+JFPpIgEti
        qRbAhK+fUgd11mq0O+EJ5XvQu7TpjnKc4A==
X-Google-Smtp-Source: AMsMyM5k/7OfDK1lUw0tSbC55SR7j0akuMAlooUfn85H9sjzdRAvbZsyA9D8uXHz/W7b2bjNkp2haQ==
X-Received: by 2002:a05:6214:e6b:b0:4b3:dcaf:c3a7 with SMTP id jz11-20020a0562140e6b00b004b3dcafc3a7mr24502420qvb.34.1666544148095;
        Sun, 23 Oct 2022 09:55:48 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b006b949afa980sm13313746qkn.56.2022.10.23.09.55.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 09:55:45 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id r3so8746875yba.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:55:45 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:6ca:9345:b2ee with SMTP id
 c4-20020a5b0984000000b006ca9345b2eemr6998276ybq.362.1666544145288; Sun, 23
 Oct 2022 09:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8lbkx3HYQpnvIB@krava> <20221007081327.1047552-1-sumanthk@linux.ibm.com>
 <Yz/1QNGfO39Y7dOJ@krava> <Y0BDWK7cl83Fkwqz@hirez.programming.kicks-ass.net>
 <CAADnVQJ0ur6Pox9aTjoSkXs43strqN__e1h4JWya46WOER9V4w@mail.gmail.com>
 <CAADnVQ+gquOKjo68ryUhpw4nQYoQzpUYJhdA2e6Wfqs=_oHV8g@mail.gmail.com> <CAADnVQKj5B1nfkQTSTrSCPq+TQU_SD22F7uG7Carks8oVi8=aQ@mail.gmail.com>
In-Reply-To: <CAADnVQKj5B1nfkQTSTrSCPq+TQU_SD22F7uG7Carks8oVi8=aQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 09:55:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5bT2GPy4EYiPd3Vu+wm9QHmsP38XApFp8qLaup=exfA@mail.gmail.com>
Message-ID: <CAHk-=wh5bT2GPy4EYiPd3Vu+wm9QHmsP38XApFp8qLaup=exfA@mail.gmail.com>
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

On Sat, Oct 22, 2022 at 6:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Linus,
>
> please apply this fix directly or suggest the course of action.

I have a pull request from Borislav with the fix that came in
overnight, so this should be all fixed in rc2.

                 Linus
