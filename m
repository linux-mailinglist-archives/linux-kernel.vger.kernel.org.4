Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC06E3456
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 00:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDOW5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 18:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjDOW5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 18:57:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B431B1BCA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id kc3so5001141plb.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1681599471; x=1684191471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jm23euiY98fsN22kiG5rHbRtDdr3VWwy800+EazcFQ=;
        b=GBfLzDMaedtUl6MyPA5MjqwskjXDB8bXlQkls/cGP4aq1jUv7RrRFtXHLwgTEGVidb
         x+yYSroQA1+8wmK2nLvfaVEN3cMOIs5qH3X54gCP+KRH3xJ+4SmDE1grbMoFifyFXlPc
         RI0xSxywOQMml3hnpp2skrtAslxJZk2wR9p79TDktIn6BkkyDaCbEmvvHIRn0QjEWqht
         8eQQirlYYZgBQ/JwhSrlewqOHstVPBpK4duQ8aUnfUE+nLGCySqyLX1g1NOzCO3wSxFa
         jm9ygqNznrgQ9S2/G24r7ngYQJBkMGHFycKgNG88gySGQA40KnO1k13R5U3FnMpOhOD2
         Pi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681599471; x=1684191471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jm23euiY98fsN22kiG5rHbRtDdr3VWwy800+EazcFQ=;
        b=HGJxiv2+LPoxxrvZ2tf3Te39ORUp5tYRoYW1az0qooqgTZuDAfA8Pw0XJkjTjP8jmq
         CDmgDBY6w0neOfY7AtVetLFDnpIVcvKjyQMN7r33gH34oV98UkJsbezNIsZ1+9MO95/l
         A+NoN5bW91cPF2Bw7dN/DA5Y7AseB6oA+EdT/BxB7GM3V4TDc7alGIeOp72Yk7Jg23ji
         ecxvdzvsPNCQcoxqUY1R45oQuJ+3W+4+xIcFJCu4Ah46qW9tjYL2VMAEzCG9gUoef0cc
         EGYAI3Sopri5LdgRsIFN6yGtUljRlPqSUuj4r9mBTji0ies8Y5s3JvOXEalrp57OMNgX
         KE7w==
X-Gm-Message-State: AAQBX9cxXJPhCVDfcB7Zqrn4XP5IDT94vQQF5Ib6UsCGvXQWOEsWohFa
        sE21XK9LavE+JL++PW8gPSc+8g==
X-Google-Smtp-Source: AKy350atP7YyE1uh5Cv1o1OIAdHqZyYd5TMCJvKCXUcCmogo34GyZWci+oDz1ExgkYU+uGfEZj3q7Q==
X-Received: by 2002:a17:902:d583:b0:1a0:6bd4:ea78 with SMTP id k3-20020a170902d58300b001a06bd4ea78mr7929045plh.31.1681599471180;
        Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001a68991e1b3sm4801780plr.263.2023.04.15.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 15:57:51 -0700 (PDT)
Date:   Sat, 15 Apr 2023 15:57:48 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>, Jason@zx2c4.com,
        keescook@chromium.org, ilay.bahat1@gmail.com, aksecurity@gmail.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Replace invocation of weak PRNG
Message-ID: <20230415155748.2c9663a9@hermes.local>
In-Reply-To: <20230415173756.5520-1-david.keisarschm@mail.huji.ac.il>
References: <20230415173756.5520-1-david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2023 20:37:53 +0300
david.keisarschm@mail.huji.ac.il wrote:

>  include/uapi/linux/netfilter/xt_connmark.h    |  40 +-
>  include/uapi/linux/netfilter/xt_dscp.h        |  27 +-
>  include/uapi/linux/netfilter/xt_mark.h        |  17 +-
>  include/uapi/linux/netfilter/xt_rateest.h     |  38 +-
>  include/uapi/linux/netfilter/xt_tcpmss.h      |  13 +-
>  include/uapi/linux/netfilter_ipv4/ipt_ecn.h   |  40 +-
>  include/uapi/linux/netfilter_ipv4/ipt_ttl.h   |  14 +-
>  include/uapi/linux/netfilter_ipv6/ip6t_hl.h   |  14 +-
>  net/netfilter/xt_dscp.c                       | 149 ++++---
>  net/netfilter/xt_hl.c                         | 164 +++++---
>  net/netfilter/xt_rateest.c                    | 282 ++++++++-----
>  net/netfilter/xt_tcpmss.c                     | 378 ++++++++++++++----
>  ...Z6.0+pooncelock+pooncelock+pombonce.litmus |  12 +-

NAK
You sucked in some unrelated netfilter stuff.
