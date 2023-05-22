Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A872870C308
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjEVQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjEVQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:11:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C244103
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:11:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ae87bdc452so21251445ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684771871; x=1687363871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlTuKCpTfScIgq9ct5Kk62dGeSZ0AoPP4uiPnxLmKoA=;
        b=Nfu/2RUaW1tYVKC2tdVc6Bf9QNqkDB/7oOjSha8sq9f81x4SUpygV+olqgPJlt0BgN
         D4NDkQI49lG1l2GXzByRETI3z3e2aYULOp6jZSXaB2aQgmFhojUltUyhxSmqXr5XfpE5
         ast3IEZiKSL/BdnMiu6YuojlNKvKlqTyD8aFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684771871; x=1687363871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlTuKCpTfScIgq9ct5Kk62dGeSZ0AoPP4uiPnxLmKoA=;
        b=OEWdVW5sFAo0kxgYksAVlfdHCRyTJubQrDpcFWWKWo12eQM6sDSebBlL2AZji9DlvX
         gBczsqzMHw4UObc6fgM5hDPzZ7/0EhxUa/S4gCc52PWjX1w2rHFZPrKJjgPvJ+UljM9M
         1hXHmwC0cNRoKJHifFOSfM1EFegXu52Qj+X4ykKhy3DrV/kUtuPOTTVh1Hg7zekuZE3G
         Fq0Uc0P+/P3oCrdqggghvdOTUhqQcXl++4jWzyW4QI1vWAwXeyRcvEebaAaO67osMqIx
         GEpZhYCzqbHtvpN5KO35Dqn8TAxrDIExaWqHfZFK5UB44yN01mePBhN7ExNLg5N0YdFe
         eLdA==
X-Gm-Message-State: AC+VfDy/aoGu55BIsxNENcsDaCOgBtktcf0p0jqppRwKlgUl+b87tfoh
        9q/rZsS0tQd3q9r3sBTEF6nV62lRZI9Hkinnp7OszQ==
X-Google-Smtp-Source: ACHHUZ4589KVVYihC7sIujHzHREO0IpLkoy63yaqOH70aXEOJFrjLCF3XStdxjOl0moSX4gJxGt4eG5dn8+IRp+3YNI=
X-Received: by 2002:a17:902:ab4e:b0:1ae:4ddd:9961 with SMTP id
 ij14-20020a170902ab4e00b001ae4ddd9961mr11503274plb.20.1684771871356; Mon, 22
 May 2023 09:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230517150321.2890206-1-revest@chromium.org> <20230517150321.2890206-5-revest@chromium.org>
 <7883b08b-6bdc-a214-96a3-3f5bc1d36da4@redhat.com>
In-Reply-To: <7883b08b-6bdc-a214-96a3-3f5bc1d36da4@redhat.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 22 May 2023 18:11:00 +0200
Message-ID: <CABRcYmKnEW-OafqYeDp9jkBz3VSQawi_8mz6W-M1L52MR4y8zQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:01=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 17.05.23 17:03, Florent Revest wrote:
> > +#define MMF_INIT_FLAGS(flags)        ({                               =
       \
> > +     unsigned long new_flags =3D flags;                               =
 \
> > +     if (new_flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))               \
> > +             new_flags &=3D ~((1UL << MMF_HAS_MDWE) |                 =
 \
> > +                             (1UL << MMF_HAS_MDWE_NO_INHERIT));      \
> > +     new_flags & MMF_INIT_MASK;                                      \
> > +})
>
> Why the desire for macros here? :)

I just thought that's what the cool kids do nowadays ?! :)

Eh, I'm joking, I completely agree. Somehow this was suggested to me
in v1 as a macro and I didn't think of questioning that, but a static
inline function should be more readable indeed! I will fix this in v3.

> We have a single user of MMF_INIT_FLAGS, why not inline or use a proper
> inline function?

I have a slight preference for a separate function, so we don't spill
over too much of this logic in fork.c.

Thanks for the review David!
