Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8586BBE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjCOUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCOUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:48:02 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B69E056
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:47:51 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5447d217bc6so56126617b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678913270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhlMApgTkitNvhVZeol6qqWUUqpGhh2PDZC8Nh6/Mug=;
        b=VV3hKgAQja7csYJ8TaNaV2aACeZQvbra4oYAC1TSN6JM/EYDDCLWO2bNMIxsfXCz0A
         U7AvsFYxYZF4Zn8DcE1Lc+icG9tBzpUqiEvuC7HTASd91OI5rTGCPgkZ5FG4xQIhoR38
         I8mPLvoErXarwbOj3UOm6emXcmryQi6XFydl1NZNhodaITyC6KizWOEDYCwfMdvAduzZ
         EawFiZud2Ix3jGwAoCDDdQ/REW3NUzuazPGIT95UUnVbFcuIEyMSAnyaXdHBIy5cpCK3
         ZMXmYHt+oXUWaqU9dmn5HxSjUdK8bBZL/4/q0Ey3gJD+I+i4xZTGr1uhnK1M/rp73/6d
         vl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhlMApgTkitNvhVZeol6qqWUUqpGhh2PDZC8Nh6/Mug=;
        b=pje8k1Jtc1vjVhevkJs1S0Ea9RXGgDjLgfLEohXI42evAMjt/tfViCZxSyG14C+vdH
         yKcGmbWTNwvqMk8CyqaU/YLFaEk/Lih9LOEu11kUhO/o3CrdJfXCkpbcsn8jpH1ZpRPT
         maIn6cmA+0Z/7ZvMtBX5g3uByucpGlPgLe9CrR30XlNbjl/Ew+mZ7pnIKzMv6+XBWGX5
         zz+zX/KfkFEFTas0Y7uHmSWOv+a1dok4fTfX0j1hgEl/bKjaExEuEiUtvhOTWCBAUoTs
         dc0QGMoAVkR0bszxBFZCfw2orQ0yWCBqwkcKVPzeQlHcU1mVUuG+xDPrD0Czq4/Dfajc
         0Chg==
X-Gm-Message-State: AO0yUKXyvQNEIhsMpgmQaEz1ohkaVgKSW5cnbQc6ljUAinVkki1n+z0D
        6BgsR2Fi9MWWp58Mi2jEMxxsfysL2zTaDpn60stRJdz4au/vegdkCyE=
X-Google-Smtp-Source: AK7set/+BVzEQhyfNAWDw+Yt/scbHKbQXxV7zoD7fpm0EVWlhDGDkVwWyIuF3qk54qHrrqgJ37/c234vk98FoR5N2Ho=
X-Received: by 2002:a81:b184:0:b0:53c:6fda:835f with SMTP id
 p126-20020a81b184000000b0053c6fda835fmr778513ywh.0.1678913270335; Wed, 15 Mar
 2023 13:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230307125358.772287565@linutronix.de> <20230307125538.818862491@linutronix.de>
 <20230315133659.4d608eb0@kernel.org>
In-Reply-To: <20230315133659.4d608eb0@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Mar 2023 13:47:39 -0700
Message-ID: <CANn89iJUE3De9t3Vf-H6K+DAscEM98VZU4FaVCEOhE0ULUz9hQ@mail.gmail.com>
Subject: Re: [patch V2 1/4] net: dst: Prevent false sharing vs. dst_entry::__refcnt
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 1:37=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  7 Mar 2023 13:57:42 +0100 (CET) Thomas Gleixner wrote:
> > Move the rt[6i]_uncached[_list] members out of struct rtable and struct
> > rt6_info into struct dst_entry to provide padding and move the lwtstate
> > member after that so it ends up in the same cache line.
>
> Eric, David, looks reasonable?

Yes indeed, thanks for the heads up

Reviewed-by: Eric Dumazet <edumazet@google.com>
