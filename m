Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F39C6265D8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 01:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiKLAL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 19:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiKLALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 19:11:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E567CCCB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:11:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so5966767pjk.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEQWZwaHwU7X6IcFAoC/0iUhJeCTsC1IYT4N9/c8U0A=;
        b=c7XIVp1It0E9UswvFUEs/ySxkmdQ2RJ4W2OgLEaSKDlwrcseWqG6d4mQuqnk3PO9O1
         t5glJ4iz4TgZd7wtrzVUWV2fF82c3ItDwnrCKa/KpmcBtFeCyoh9aLdwkrHav5eFjIhg
         ZA2YfIXHza9s756+KnXxkmt9ACM2Q7WORoGYyiotVt8d6YjC0OVgLk7Sj5n8NUivTe5K
         8b+UOoaWjuP0+8aLuNYWqmSFrSP5xhRY8Fn/7pn2rTruUMoIFnut9LJ+qDXFsRSEjY5I
         CEQZ2UVa3m4FbJmTT44l341EYhwnIuRaTAPwI/zVHKeFvzhw9I40TghZ44528UW5vDsU
         ARUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEQWZwaHwU7X6IcFAoC/0iUhJeCTsC1IYT4N9/c8U0A=;
        b=ptwiJiW7VTK1px+km1cX0wMasNyZUAWF5WPBjPTQ6+w4kkBijV/FjXljgRLTb94+mj
         /PvFhcgOP9TR4F1wLXLkFoupACp38ak7SRilQg/rzrk19NkNWape08OEMcpngfythp5L
         qEb9vcpodcSjfshTPTdnbFQafR41AJMIXFyWqo83ifLM0HvuEsdFC7jjJHidS4xc0MAi
         1tnw64QUfAisjFotEqt00kcxeMZVolIAw95FVG9kPpewxHsvg8tPIfSqr2UWCA0+qJJN
         frLC1sp73Nh1gxsYua6Em3teLQz37bmFoFJ01LDg/iXqZadRbdoM26OKR4XixjEd7Eb4
         PQxQ==
X-Gm-Message-State: ANoB5plsI9nZbiK8D/Fbb4NAn/zv+/GIiqws52NiJl51e0rr0X+Vpyjv
        1tTjiQ6GmZ5JZAYCWaPAK9pDXJGvXc2XKw==
X-Google-Smtp-Source: AA0mqf5yKDsqswgjrnQalVP+XqR6b8TClYfolrjk9tMChj9gHoiFYI4NYPg1O9tRmypX5cILlvOX+g==
X-Received: by 2002:a17:902:6b05:b0:188:a6ea:27a1 with SMTP id o5-20020a1709026b0500b00188a6ea27a1mr4380050plk.164.1668211884418;
        Fri, 11 Nov 2022 16:11:24 -0800 (PST)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id pb5-20020a17090b3c0500b00212e5068e17sm2111701pjb.40.2022.11.11.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 16:11:23 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:11:20 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tcp: Add listening address to SYN flood message
Message-ID: <20221111161120.770b9db2@hermes.local>
In-Reply-To: <CAAvyFNhkn2Zv16RMWGCtQh4SpjJX56q8gyEL3Mz6Ru+Ef=SJfA@mail.gmail.com>
References: <7ccd58e8e26bcdd82e66993cbd53ff59eebe3949.1668139105.git.jamie.bainbridge@gmail.com>
        <20221111092047.7d33bcd3@hermes.local>
        <CAAvyFNhkn2Zv16RMWGCtQh4SpjJX56q8gyEL3Mz6Ru+Ef=SJfA@mail.gmail.com>
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

On Sat, 12 Nov 2022 10:59:52 +1100
Jamie Bainbridge <jamie.bainbridge@gmail.com> wrote:

> On Sat, 12 Nov 2022 at 04:20, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Fri, 11 Nov 2022 14:59:32 +1100
> > Jamie Bainbridge <jamie.bainbridge@gmail.com> wrote:
> >  
> > > +         xchg(&queue->synflood_warned, 1) == 0) {
> > > +             if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6) {
> > > +                     net_info_ratelimited("%s: Possible SYN flooding on port %pI6c.%u. %s.\n",
> > > +                                     proto, &sk->sk_v6_rcv_saddr,
> > > +                                     sk->sk_num, msg);
> > > +             } else {
> > > +                     net_info_ratelimited("%s: Possible SYN flooding on port %pI4.%u. %s.\n",
> > > +                                     proto, &sk->sk_rcv_saddr,
> > > +                                     sk->sk_num, msg);  
> >
> > Minor nit, the standard format for printing addresses would be to use colon seperator before port
> >
> >                 if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6) {
> >                         net_info_ratelimited("%s: Possible SYN flooding on [%pI6c]:%u. %s.\n",
> >                                         proto, &sk->sk_v6_rcv_saddr, sk->sk_num, msg);
> >                 } else {
> >                         net_info_ratelimited("%s: Possible SYN flooding on %pI4:%u. %s.\n",
> >                                         proto, &sk->sk_rcv_saddr, sk->sk_num, msg);  
> 
> I considered this too, though Eric suggested "IP.port" to match tcpdump.

That works, if it happens I doubt it matters.
