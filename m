Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67F7492A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGFAcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGFAcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:32:22 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338F130
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:32:22 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c6833e6e326so77865276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688603541; x=1691195541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b059XCxsCkOrU4O3JPVlTW246Y1hW5JtDs6f+L57Wmg=;
        b=eBJaGFvCWu50szMQtD2V3lIYr0va0vgg0MD9I0V4Uy05PtsBkeUnpLMEFo70l0fwdT
         mI2CCzX1FSskABvJuTKkMgjos4w6uGIC5T+YFH1guzJ3/CCfkvjIXMPA1h52s6iXMVLi
         z7pbJ/wkC5/1tTHrQ17hZufbpJq3ayPXMQ4Ik9Uo/slagtEWh8mpS0NlLqy8uKlV8Q+o
         90+kaYx1od2lBMTCbD6+iQ4Z6JhbrViiALSqlRNV6+wwqVlPSZFLvoLg7J6RTgSQ94oW
         7rZXx+2X2uhdv4wa0HvlXSDqCaJ/XNnIJw+9cW+NBwEIZyc2l3fBzn+gotMNL/UFc1ee
         jJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688603541; x=1691195541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b059XCxsCkOrU4O3JPVlTW246Y1hW5JtDs6f+L57Wmg=;
        b=MW/8KUxaftYhP4pfpau7q4SR5Ct+SQKZ5wfJjWLYJvTqEVK9rlA4ykkU9qbxY7yW/J
         Na0nVAu5BC4unNzZfBwHFW47CnsKw3O2rnGYDWkdbNmBFUPuEvGexvQaBh/vdtkVeZJd
         OL3663kmbte60st/QagtRO/GRLWDDWkWy3pUZrjKT76TiSnXGsQ4GRSsOSuA+ZkrRmhu
         mNTTo4C74IzQT/VPw7riFqlg4nUkC2G86mpsoLcVRildhjOB6dS8eQFJw2TeRfKapnxM
         pgbz+QJ7sDO7OcooLkc1nz5vsBOnkYgvSIFY1OWempscuj4rL1cr1nIjT9aJYnFxUtIw
         FcdQ==
X-Gm-Message-State: ABy/qLbHb438PHapGWDK+h8rSDpm6hWoP6NTuZY5jaoBxvtUfd56ZMCe
        h0w1VrW/tjKwr+WxBSfG7G+L+0OB1HdWX3QfjLabaw==
X-Google-Smtp-Source: APBJJlExs/sClZhmqN+LrYffIQ4a3G+fZe5JH4iqdSm6PJE+juvPYAodhwhw38hs723ulwsxVKeT+DDgwx1UICga0eM=
X-Received: by 2002:a25:fa11:0:b0:bd4:c299:a80a with SMTP id
 b17-20020a25fa11000000b00bd4c299a80amr438121ybe.10.1688603541038; Wed, 05 Jul
 2023 17:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n> <CAJuCfpGHRfK1ZC3YmF1caKHiR7hD73goOXLKQubFLuOgzCr0dg@mail.gmail.com>
 <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org> <CAJuCfpFLRePeOsrSg--5GtWbC1M5y21Sq7gzrs1vVEUE7C+30A@mail.gmail.com>
In-Reply-To: <CAJuCfpFLRePeOsrSg--5GtWbC1M5y21Sq7gzrs1vVEUE7C+30A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 17:32:09 -0700
Message-ID: <CAJuCfpGWW7wsrtqi4rZUz4vxW-N0CaUEeUqY4e7iX1hzgRsT2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Wed, Jul 5, 2023 at 5:30=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jul 5, 2023 at 5:24=E2=80=AFPM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Wed, 5 Jul 2023 13:33:26 -0700 Suren Baghdasaryan <surenb@google.com=
> wrote:
> >
> > > I was hoping we could re-enable VMA locks in 6.4 once we get more
> > > confirmations that the problem is gone. Is that not possible once the
> > > BROKEN dependency is merged?
> >
> > I think "no".  By doing this we're effectively backporting a minor
> > performance optimization, which isn't a thing we'd normally do.
>
> In that case, maybe for 6.4 we send the fix and only disable it by
> default without marking BROKEN? That way we still have a way to enable
> it if desired?

I'm preparing the next version with Liam's corrections. If the above
option I suggested is acceptable I can send a modified second patch
which would not have BROKEN dependency.

>
> >
