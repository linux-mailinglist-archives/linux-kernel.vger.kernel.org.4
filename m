Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114D705C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjEQA41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQA4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:56:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF8E10DB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:56:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96b0235c10bso17352566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684284981; x=1686876981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u19sBi6Gx4oX3ZUtePL5RNvvMU7eDU7T5lpZ8DtlLqE=;
        b=Dhs7nVF3izFamLJjTGR0ZbHI69tmrp8fOuQLZ+L32hSWy9TF1Wb24kF8i4CeEss1xd
         XnziBMBnlhUWthABZmZTo9HFNU2wPWeouyZ2yy+6S8MC++vO997RWeJXzBBAvFww0BGu
         G9/w6HJVRLBmP9xw02fSczkRTKCHQM//F2nYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684284981; x=1686876981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u19sBi6Gx4oX3ZUtePL5RNvvMU7eDU7T5lpZ8DtlLqE=;
        b=jrp1rUzaaiZe2W145I/RfrEzTPzIygcgSRrYxINFRfCvJJVqXEBOIuBipiWFiN+bVU
         RJpOGKbQYHuawAhmtM14FWQnR4sa5b/C0UoO7elXG+9Ou8fjCKhKU0dedB7fTO6705Ps
         IMDlDym8B+eyrnkfCL0GTYeVgzi5jEJ9Ot9B0cHvkHz3950iBR/De/JPQDMBFWaS4W+L
         TVTrqHtwyCymS7zY/xo8+/WOVNHGqxwUnvBvibbw5H7DNst34Wkg+3QR5sfr/58euaAj
         kQYe81NDx62LDaZJgrboy6anwMtZVFrxKnyrxp2VMQKApbAjZdV15BzDRd4IKUyaVZo0
         s0uA==
X-Gm-Message-State: AC+VfDyEHPg5CH5yXQf5aw2b0JyatKVPzhz6a3uI+olLckF1i1WEvErd
        GVhbCJBncG6p2LgIUGtpDJAZpwYuPyjtKlo8OCzgyA==
X-Google-Smtp-Source: ACHHUZ6RlzkfuDI/GLbpH0Fdu/NEJFpvhcMmHOuGAYsGf2AfMnPDcSgZOpFLltPHjKfrMvKu7jw/vw==
X-Received: by 2002:a17:907:7291:b0:96a:3e7:b592 with SMTP id dt17-20020a170907729100b0096a03e7b592mr28618855ejc.25.1684284981130;
        Tue, 16 May 2023 17:56:21 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id jz20-20020a170906bb1400b0096a742beb68sm7910692ejb.201.2023.05.16.17.56.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:56:19 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-965a68abfd4so17660666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:56:19 -0700 (PDT)
X-Received: by 2002:a17:907:3e13:b0:948:b9ea:3302 with SMTP id
 hp19-20020a1709073e1300b00948b9ea3302mr44683119ejc.1.1684284979144; Tue, 16
 May 2023 17:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
In-Reply-To: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2023 17:56:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
Message-ID: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 15, 2023 at 12:24:07PM -0700, Beau Belgrave wrote:
> > > >
> > > >   ret =3D pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL=
_NOFAULT,
> > > >                               &page, NULL, NULL);
> > >
> > > ... which will call pin_user_pages_remote() in RCU CS.
> > > This looks buggy, since pin_user_pages_remote() may schedule.
> > >
> >
> > If it's possible to schedule, I can change this to cache the probe
> > callbacks under RCU then drop it. However, when would
> > pin_user_pages_remote() schedule with FOLL_NOFAULT?
>
> Are you saying that passing FOLL_NOFAULT makes it work in atomic context?

Absolutely not.

It may not fault missing pages in, but that does *not* make it atomic.

That code depends on all the usual MM locking, and it does not work at
all in the same way that "pagefault_disable()" does, for example. That
will fail on any fault and never take locks, and is designed to work
in atomic contexts. Very different.

So no, don't think you can call pin_user_pages_remote() or any other
GUP function from atomic context.

We do have "get_user_page[s]_fast_only()" and that is the only version
of GUP that is actually lock-free.

Also, just FYI, those special gup_user*fast_only()" functions simply
will not work on some architectures at all.

               Linus
