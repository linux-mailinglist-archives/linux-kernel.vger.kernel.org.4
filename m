Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071F6D6D44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjDDTib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjDDTi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:38:28 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5AC7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:38:25 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i6so40122260ybu.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680637105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CGGYiK7R7iym5OMqiH+Gz2BZGoptbAOBkaXb5F+LEU=;
        b=FHG9pOZw6QmiAsoXPIuoU//8W+Zy9FAsKNV4Ix2hWzpJnqm6WKjv/tnPxvIKjz0ICe
         inNKM4e6vkHLrcr1dAtRZdPlv2+82wL1LgaehGuzpQ9jkG19X6B80g/R2EmtwqxoXpUm
         fCD3qaGgerG73zrDeEDzqtLGWfVRgoE8Y+F7uM22Ei2qu6A7R1SDcsJKuteZuL0SeeYN
         5xD2JKWiT9q8TLpty/KpQWU0CGYTd0ks66+Ird2xV3c2gkE5zaxZCJk7poCJpDd1wpN7
         cPPG9pR85FY41stTvKpEPyVgO2/iuasCzmIZjEQyBjcx9aMvTeHbE6tDbKyKpZOfcioX
         2SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680637105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CGGYiK7R7iym5OMqiH+Gz2BZGoptbAOBkaXb5F+LEU=;
        b=lBCdS+N9YuFkz7cjkP9JyOPjebZLL2JjMb53czsaSE3NzYibZfbkOE4tgqWv/lK670
         y+YHfsY9xSzmP0oWWDKusrELh9hkDXk3L8vaWXM1SBwBh1IIf+seCozlx+xh19ESV/HW
         I1aOe055eRuSW28i0MSm5AEGPE7XnERbDTgGeenTTVNf6WrtzsWxUbDv+LktsJzWTh1c
         gnwjHCaPeqXXrreWGRUPOGbO4eLuJS9m6bsPGaIqczs2P7avEeUDtSnbTkoNTBhtdgLg
         m1wSH2tbnzXAK3ABHLDyRikP4YmFPuGZ6DbPrxCTac1nio4HbESPRFBB3B3lsn76RufF
         12/g==
X-Gm-Message-State: AAQBX9dseewRqyzL/aCxIisv6D2vI19EZ4qLR7i1owZBgEr6cCn33wAB
        p9h26K7S9HgoDbNfIqdxqY+aH2rwjayx4KZ2Uj4cHA==
X-Google-Smtp-Source: AKy350YdpwcmCAIfgrl9aBo8937S54tCb6PHrWfempCUWc3MDYV5wpRLQJ87k2u/bvsnq9FdcYwlm0/6QxVUD8QyF54=
X-Received: by 2002:a25:ca41:0:b0:b7c:1144:a708 with SMTP id
 a62-20020a25ca41000000b00b7c1144a708mr2525071ybg.12.1680637104711; Tue, 04
 Apr 2023 12:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230404052228.15788-1-feng.tang@intel.com>
In-Reply-To: <20230404052228.15788-1-feng.tang@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Apr 2023 12:38:13 -0700
Message-ID: <CALvZod7XaXZsmatTieK=KTqfDABBgbZxGg=G9OcUezORA0DO5w@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Add document for false sharing
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 10:28=E2=80=AFPM Feng Tang <feng.tang@intel.com> wro=
te:
>
> When doing performance tuning or debugging performance regressions,
> more and more cases are found to be related to false sharing [1][2][3],
> and the situation can be worse for newer platforms with hundreds of
> CPUs. There are already many commits in current kernel specially
> for mitigating the performance degradation due to false sharing.
>
> False sharing could harm the performance silently without being
> noticed, due to reasons like:
> * data members of a big data structure randomly sitting together
>   in one cache line
> * global data of small size are linked compactly together
>
> So it's better to make a simple document about the normal pattern
> of false sharing, basic ways to mitigate it and call out to
> developers to pay attention during code-writing.
>
> [ Many thanks to Dave Hansen, Ying Huang, Tim Chen, Julie Du and
>   Yu Chen for their contributions ]
>
> [1]. https://lore.kernel.org/lkml/20220619150456.GB34471@xsang-OptiPlex-9=
020/
> [2]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> [3]. https://lore.kernel.org/lkml/20230307125538.818862491@linutronix.de/
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
