Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC16E60A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjDRMHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjDRMH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:07:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D251D30C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:59:40 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j15so7722491ybl.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681819179; x=1684411179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKarR15sfw1awM7pqcVsw1KDbYwpKozLtjgjIH1o72I=;
        b=r/phZTqOrWnxyivYlg1AWe7h0UEItmvToCXsuM/mOXo5a0Jskm5GT5UWvh+xw+Y9go
         w/eXst8R3yAd4hYFm7jNohMjFcK6yed5eBK+EymvJo8PPVAFmayAxWg8I2BAi1WVxaDt
         MktHbnuCggmQL/99ZyGZ6hZ8iD6YEyJI+cYChToGt6c2kE0fCM6TMso25rZEuhJJD/zE
         SJkIuNcnQD+XF9qrLfOSO8ScKUn/UUPQP+OutDQ1oAcTSOdeUMDbByZ741ocvaxmAYQ8
         iHJwXeeST0keS+hryF3CefcnNlq7QP+7IxNnmsXVF3qJegMfzdwySkl8yvu2IKHnODZZ
         Oozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819179; x=1684411179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKarR15sfw1awM7pqcVsw1KDbYwpKozLtjgjIH1o72I=;
        b=DFuCD2PN6AcvzJsv2omNgFhMkFTg/ZsHSmoYRaMBrGHKzfOAZhUxSUmlPf23ijQHTs
         uEryyDHF9NsaTLtCP6iH3HuHwemPYpSD7ZtxwvOfLP0XJ+UWvYrX1Ooxd7jq6WZj6IVH
         7mYqJU6Vl2jeHF7UWfpUUnjCBX72wvcIjLf3Ttqy/gM4Qr4yuMYZZTgR30vtval+i/Fl
         gT4W/Y9oGhNj0CBvht+Jq6y013VcyFMc6ayvbo3JkRhsoyDPKMXuPN21/0bYpSp6uJ6o
         AiwuUzHQvFFGfRYw9XBeBkcalqMeHQX6jRSR1KpoCdqTUtIvJw8eVXlOckF6sLIeoSc7
         zx1A==
X-Gm-Message-State: AAQBX9cNbJCkDQUNyXaaXbDSAZK2jR9yAeXoTn0VbEnxM5XGAn+h+nDI
        KCwTaa1pC7HvvK5vRr3mS3piZ6/eAlJcKncwtP5x
X-Google-Smtp-Source: AKy350aVc+pG5cSnZqGh7Qb5dDcC3+DcWDbHP9mXq9/DGKpXF1IooBVsoWyMCoTNA55rvEdPo4GFVpJ6cU0gHcMb7BM=
X-Received: by 2002:a25:df41:0:b0:b8b:eea7:525e with SMTP id
 w62-20020a25df41000000b00b8beea7525emr12045327ybg.5.1681819179231; Tue, 18
 Apr 2023 04:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230412023839.2869114-1-jstultz@google.com> <20230412035905.3184199-1-jstultz@google.com>
 <20230417111949.GJ83892@hirez.programming.kicks-ass.net> <CANDhNCp2WEAMjK1DUVKCen05-EdwVBYZxxLSP3ZSZvRh1ayAhQ@mail.gmail.com>
 <20230418103010.GY4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230418103010.GY4253@hirez.programming.kicks-ass.net>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 18 Apr 2023 13:59:27 +0200
Message-ID: <CANDhNCoG7Or+o04gB=aCU2MmFD6kM6jGu-2w3QALWXLDBhyuUw@mail.gmail.com>
Subject: Re: [PATCH v2] locking/rwsem: Add __always_inline annotation to __down_read_common()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com,
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

On Tue, Apr 18, 2023 at 12:30=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Mon, Apr 17, 2023 at 06:22:14PM +0200, John Stultz wrote:
> > On Mon, Apr 17, 2023 at 1:19=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Apr 12, 2023 at 03:59:05AM +0000, John Stultz wrote:
> > > > Apparently despite it being marked inline, the compiler
> > > > may not inline __down_read_common() which makes it difficult
> > > > to identify the cause of lock contention, as the blocked
> > > > function will always be listed as __down_read_common().
> > > >
> > > > So this patch adds __always_inline annotation to the
> > > > function to force it to be inlines so the calling function
> > > > will be listed.
> > >
> > > I'm a wee bit confused; what are you looking at? Wchan?
> >
> > Apologies! Yes, traceevent data via wchan, sorry I didn't make that cle=
ar.
>
> No worries; good addition to the v3 Changelog ;-)
>
> > > What is stopping
> > > the compiler from now handing you
> > > __down_read{,_interruptible,_killable}() instead? Is that fine?
> >
> > No, we want to make the blocked calling function, rather than the
> > locking functions, visible in the tracepoints captured. That said, the
> > other __down_read* functions seem to be properly inlined in practice
> > (Waiman's theory as to why sounds convincing to me).
>
> Right, but we should not rely on the compiler heuristics for correctness
> :-)
>
> > If you'd like I can add those as well to be always_inline, as well so
> > it's more consistent?
>
> Yes please. I'm not sure I care much about the whole 'inline __sched' vs
> '__always_inline' thing, but I do feel it should all be consistently
> applied.

Sounds good. I'll respin with this.

Thanks so much for the review!
-john
