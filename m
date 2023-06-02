Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA467204F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjFBO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjFBO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:56:16 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943A123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:56:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-568ba7abc11so22307947b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685717775; x=1688309775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSc1mIlAIN7T8qwuQMAeG2rrwOlsQAEp2SX7sUtptjU=;
        b=AxNp7puxdMMqMXmGgkIoDrVBDNw5uRrHXHblHwIOdHwhYC7AgJLJcNYO7aWgJ+3Pls
         E3maHNxcEOUWYpVknxaYFPcL06vYrA0VVqjRYL89mvQgm4UeB3M4AWnx/Ryo8K26uwQ5
         L/I18jzOUr0xE2JWkzXbiiVhlDCbuGeeDrJQdozwqB81LfdTKhSCQrr5TrQtbOeNPzkR
         Nra9gdQnwrB3L9AhyttSyvOUJbHEh+9nz2KX2Av2eCizfCez5dux405M3IabSy+H+Lu1
         0dAbVr9NTKdk4ViY5Zrv0uRI6a3+LlLRtnth4wfQm2j9zgrBI6WLKlHPzz8CCmL30Wve
         CSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717775; x=1688309775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSc1mIlAIN7T8qwuQMAeG2rrwOlsQAEp2SX7sUtptjU=;
        b=FJS7gEp2bAsHnTyi78FhI99krRd2NBAFNUkrKg9UjCfMvfcpk/jH3EjgpcTgSbnrsL
         eBU/uJ1lhUsv0hSYwfmXVqSszKlKrzjEdZuhtbryVIY34SFJIUeAELAGBJ4kWmtHqkQN
         8Djzqr+UX/4kHQZfrwaHvhOC3HKGZW0kKx+FRt/5lD04qzUxNUEs/LG5h6qk9HQRGh96
         CEADbkW2XRUQgs29t6HnFCecMa+WI/b63QFMjtZiA8hvviboU5FwBbesA2ldamtSvkHJ
         Qzt/wOM5Pukf0lsnKTNhhc1ebKiHZHn9TYM7vukmJLSqCwr6c3M00j3a135aqz1bReeO
         Fo2g==
X-Gm-Message-State: AC+VfDwAV9oNwDRFeZSj1iu2HPbZ2H5HkJeduCMlvPAhAale3mzZeq8v
        XYbipTxSJNFbb0Fv6HrTgl7QEGiqRgueH1emN9z4
X-Google-Smtp-Source: ACHHUZ5uxiZ9gotbcKervOInKw/l9vDiTuZxL9NIc8GpmQWs55p/dRv94o7xKqC5RVWj9oZ7G5HP1bVl3ZNUprOXgJY=
X-Received: by 2002:a81:a155:0:b0:568:d586:77bd with SMTP id
 y82-20020a81a155000000b00568d58677bdmr240670ywg.1.1685717774811; Fri, 02 Jun
 2023 07:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
 <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
 <CABWYdi3_zAVpeTRBou_Br-n6VXeM1xWTCSvu==QWdG4sd+nnnw@mail.gmail.com>
 <CAHC9VhReahw8G4Vc0eMdhQMLhGYE53=X48akC13rN4EPkiF3tQ@mail.gmail.com> <CALrw=nFdnSOyfd9X9qzpbTT8R_-m3uBM==FFkNSQ2XZsxUz0Fg@mail.gmail.com>
In-Reply-To: <CALrw=nFdnSOyfd9X9qzpbTT8R_-m3uBM==FFkNSQ2XZsxUz0Fg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 2 Jun 2023 10:56:04 -0400
Message-ID: <CAHC9VhR4mnoj=uEEO8ceFvtHAy=ziUROnVHgoNAnH1Gr2+tH5g@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 7:08=E2=80=AFAM Ignat Korchagin <ignat@cloudflare.co=
m> wrote:
> On Thu, May 25, 2023 at 3:15=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, May 24, 2023 at 2:05=E2=80=AFPM Ivan Babrou <ivan@cloudflare.co=
m> wrote:
> > > On Tue, May 23, 2023 at 7:03=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > > Could you elaborate on what exactly you would like to see added? =
It's
> > > > > not clear to me what is missing.
> > > >
> > > > I should have been more clear, let me try again ...
> > > >
> > > > From my perspective, this patch adds code and complexity to deal wi=
th
> > > > the performance impact of auditing.  In some cases that is the righ=
t
> > > > thing to do, but I would much rather see a more in-depth analysis o=
f
> > > > where the audit hot spots are in this benchmark, and some thoughts =
on
> > > > how we might improve that.  In other words, don't just add addition=
al
> > > > processing to bypass (slower, more involved) processing; look at th=
e
> > > > processing that is currently being done and see if you can find a w=
ay
> > > > to make it faster.  It will likely take longer, but the results wil=
l
> > > > be much more useful.
> > >
> > > The fastest way to do something is to not do it to begin with.
> >
> > While you are not wrong, I believe you and I are focusing on different
> > things.  From my perspective, you appear primarily concerned with
> > improving performance by reducing the overhead of auditing.  I too am
> > interested in reducing the audit overhead, but I also place a very
> > high value on maintainable code, perhaps more than performance simply
> > because the current audit code quality is so very poor.
> > Unfortunately, the patch you posted appears to me as yet another
> > bolt-on performance tweak that doesn't make an attempt at analyzing
> > the current hot spots of syscall auditing, and ideally offering
> > solutions.  Perhaps ultimately this approach is the only sane thing
> > that can be done, but I'd like to see some analysis first of the
> > syscall auditing path.
>
> Ivan is out of office, but I would like to keep the discussion going.
> We do understand your position and we're actually doing a project
> right now to investigate audit performance better ...

That's great, thank you!

> But the way I see it - the audit subsystem performance and the way how
> that subsystem plugs into the rest of the kernel code are two somewhat
> independent things with the patch proposed here addressing the latter
> (with full understanding that the former might be improved as well) ...

You've done a good job explaining the reasoning and motivations behind
the patch submitted, that is good, but I'm not seeing any recognition
or understanding about the perspective I shared with you earlier.  The
performance of audit in general does need to be improved, I don't
think anyone disagrees with that, but my argument is that we need to
focus on changes which not only reduce the processing overhead, but
*also* reduce the complexity of the code as well.

--=20
paul-moore.com
