Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0016F1C76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbjD1QSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346089AbjD1QR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:17:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9997AF4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:17:56 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54fbee69fc4so833627b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682698676; x=1685290676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFyJc8+p4qTuozgH/v/B+1NflQRfcLItZsoQOpNrm4I=;
        b=KI6WifT1huW26vIMkQLL3klATIcHmUITIOLhmKPoBSZAVdw5odSR4lQ7QfzgVL2Sa6
         sxnbscyqWPfKsK5XMqqlJdblwIl5wfDje0FeISy/ie3hUuH/dOexjxVSWRpGN9JqF3ro
         4MNwZVuy+59IWxX+ch7zlDRFoY5BgvXTavJOX3+x6Q2lRog2uL/q8EdKNYf72eBox+po
         Yh9BW0u3jMdlKf+GNY7aANIEwQZjscT85ORaOaSIMcTXGg5DbC/ZyKzTsNmSEIN6smK5
         tE1ZbfxSG9NQLg//0mv3u6163fclJcSgt3Eu+FIu8sPSd4S0OUqnIGw17uK6AGVUPWQK
         SVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698676; x=1685290676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFyJc8+p4qTuozgH/v/B+1NflQRfcLItZsoQOpNrm4I=;
        b=dVJ7gryrxQCN0gDClwwD6bbI2sDhyZtHkvREfMKBSyyJtUFHKlvJPfBxVxER1FePGl
         vvVclg7kpZr+XSDrJZSx9rODX7OE8BPRvMrSFde081oebYvu5rp+xolF2SxossPvPyFI
         7m4Nnp7BMO0QF6Ddbl0EF/UQyDBQJr99YomDI3p+4wTWxkWHbSSnruTZq64YVGHloPzQ
         48OaN8iTcKmxSvXQ/Z40OjIL5uN/6SFOgebh8C4m9cTCoy0itG5urPJnUxVxy5y6Tzgk
         7u9+NAfzCHdZFYzzZXXPrVPgqKjDgUwRqfQBCE9I04pvzvOcguSgFxlHBwXCPAeVCvP4
         c0oA==
X-Gm-Message-State: AC+VfDwsExQHse2dop6SQVAHolg0X6U1WA0DgewOREyDm9bk6DAlV7Rq
        nThvxKyAFu9ERiatoT2+z1CBIDdMk7rYXgpiaFzohQ==
X-Google-Smtp-Source: ACHHUZ7nYMiGVX+Zyd6HKF12DlZ5nRD3X367dMTMrVNC7OnmWNX9lMIAFe2WO1BbxF00t0ps+U4NpYzDWgoMKA/4Uhs=
X-Received: by 2002:a81:4ed3:0:b0:540:c99d:efc1 with SMTP id
 c202-20020a814ed3000000b00540c99defc1mr3296966ywb.35.1682698675470; Fri, 28
 Apr 2023 09:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
 <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com>
 <CAJuCfpHZSEjG2nti5iWbPQjWgXcHZ95hFS2FKwaPC-sZPdSznw@mail.gmail.com>
 <CAHk-=wg0SyFDp_sdcEH-D+LNxuzL_dWA1vZEowUN16n_+yRHPQ@mail.gmail.com> <CAJuCfpHouhrEtomhPe2sf+p0oG4pGFKb3xidhOXP6BN-PydY-Q@mail.gmail.com>
In-Reply-To: <CAJuCfpHouhrEtomhPe2sf+p0oG4pGFKb3xidhOXP6BN-PydY-Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Apr 2023 09:17:44 -0700
Message-ID: <CAJuCfpGcnJiJyU78v1r548W3bZ2LyfaYpr5huKKG8-WaiRHFHA@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 9:14=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Apr 28, 2023 at 9:08=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Apr 28, 2023 at 9:03=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > I wanted these stats enabled by default to be able to identify
> > > possible pathological cases and to also let users disable them if the=
y
> > > can't tolerate even a small overhead in the pagefault path. Should I
> > > document this reasoning for the config option?
> >
> > You should document what the stats actually count (at a high enough
> > level for a user to understand), and why anybody would want to keep
> > them on.
> >
> > Honestly, 99% of the time, these are things that *developers* think
> > they might want, but that nobody else will ever ever use.
> >
> > Really, ask yourself if a normal user would ever look at them?
> >
> > Now, ask yourself whether this might be something that a cloud
> > provider would want to look at to gather statistics.
> >
> > And if it's the latter case, then it should be "default n", because
> > the default should be for the people who DO NOT KNOW, AND DO NOT CARE.
> >
> > The cloud provider will be using a custom config anyway. The default
> > is irrelevant for that use. The use that *matters* is literally the
> > clueless end user who I bet will never look at these numbers, and will
> > never be asked for them.
>
> Ok, sounds like this should be 'default n'. I'll prepare a patch. Thanks!

Should I send a replacement patch for "mm: introduce per-VMA lock
statistics" or a followup patch fixing it?

>
> >
> >                Linus
