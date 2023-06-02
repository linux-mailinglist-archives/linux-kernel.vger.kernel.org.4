Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1477205B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbjFBPPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjFBPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:15:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16A136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:15:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b038064d97so26855675ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1685718915; x=1688310915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLlNdqI6axFbvYJKMCYGXuL8XXPH0s44RaNvUf/xb6U=;
        b=A62jmKOB1yFlTiUosWU7VYThESPApQWicsGL82YBY5HyRrCmBHSGxhtTsUd7cmxvFP
         FHVeE2Eg5YibxFL0i+3hqOEr0zDDsphcTMgN8Rn6pvDhWsUGMl5plNzEr9zsL6SpjRjJ
         RcyWzBtM0z8ZSV2dTIZYNnKCJ4EzHcTC29MBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718915; x=1688310915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLlNdqI6axFbvYJKMCYGXuL8XXPH0s44RaNvUf/xb6U=;
        b=HibOCW/Uo2enJnDN9M+710M9GZuOIL/l2OVnUdge9M/3stOe7Zl5H36dhsJey8VzgU
         U/w/rSs6t83m4ONtaWIeMsoE8IKCDSRpFuXFc39VTK9WDkcwPaozKEW794W9uHLN/SFK
         T4GI6JKnnkcsMJE9GVZ3qE9zK86jViNWEm5pVnGOmdnhu/zeGLFHe6JWcYZYgrOHn8MJ
         9990GadeumsqkU3CJlvPTDkPXZvL0KZta8KQeaRpMncBg3vzDXxLZU+fqoHA1q5QsqnH
         IyOzF5wFQ/iCwtNU/cZ34lWkO8CdHRVyGBG5rEh64REkD3M3enj/K6DmZqT7YGT1EhG0
         53yQ==
X-Gm-Message-State: AC+VfDzIi7MpnuBEzXwCKoj0SIcitBQ04Ec7tQy9D2PXX71xLcYWEcIt
        cSOVEbeeTjy0YB9+KRRg7fr3QzaIFyiZRCljifjCcg==
X-Google-Smtp-Source: ACHHUZ6qwVeiaUsGgqIiu+lEAgHS5+tjGdgegjL/iZBujmGeXFWFIdEf/ajIH1GWOoFyADttfsNBiOOHfP+VvXz7XZY=
X-Received: by 2002:a17:903:2449:b0:1ad:ea13:1914 with SMTP id
 l9-20020a170903244900b001adea131914mr61219pls.30.1685718914621; Fri, 02 Jun
 2023 08:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
 <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
 <CABWYdi3_zAVpeTRBou_Br-n6VXeM1xWTCSvu==QWdG4sd+nnnw@mail.gmail.com>
 <CAHC9VhReahw8G4Vc0eMdhQMLhGYE53=X48akC13rN4EPkiF3tQ@mail.gmail.com>
 <CALrw=nFdnSOyfd9X9qzpbTT8R_-m3uBM==FFkNSQ2XZsxUz0Fg@mail.gmail.com> <CAHC9VhR4mnoj=uEEO8ceFvtHAy=ziUROnVHgoNAnH1Gr2+tH5g@mail.gmail.com>
In-Reply-To: <CAHC9VhR4mnoj=uEEO8ceFvtHAy=ziUROnVHgoNAnH1Gr2+tH5g@mail.gmail.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Fri, 2 Jun 2023 16:15:03 +0100
Message-ID: <CALrw=nHJWv+igGK3R23DQXB3UE_b14ES=sFAQqL0GG9Tw=hrMw@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Jun 2, 2023 at 7:08=E2=80=AFAM Ignat Korchagin <ignat@cloudflare.=
com> wrote:
> > On Thu, May 25, 2023 at 3:15=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, May 24, 2023 at 2:05=E2=80=AFPM Ivan Babrou <ivan@cloudflare.=
com> wrote:
> > > > On Tue, May 23, 2023 at 7:03=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > > Could you elaborate on what exactly you would like to see added=
? It's
> > > > > > not clear to me what is missing.
> > > > >
> > > > > I should have been more clear, let me try again ...
> > > > >
> > > > > From my perspective, this patch adds code and complexity to deal =
with
> > > > > the performance impact of auditing.  In some cases that is the ri=
ght
> > > > > thing to do, but I would much rather see a more in-depth analysis=
 of
> > > > > where the audit hot spots are in this benchmark, and some thought=
s on
> > > > > how we might improve that.  In other words, don't just add additi=
onal
> > > > > processing to bypass (slower, more involved) processing; look at =
the
> > > > > processing that is currently being done and see if you can find a=
 way
> > > > > to make it faster.  It will likely take longer, but the results w=
ill
> > > > > be much more useful.
> > > >
> > > > The fastest way to do something is to not do it to begin with.
> > >
> > > While you are not wrong, I believe you and I are focusing on differen=
t
> > > things.  From my perspective, you appear primarily concerned with
> > > improving performance by reducing the overhead of auditing.  I too am
> > > interested in reducing the audit overhead, but I also place a very
> > > high value on maintainable code, perhaps more than performance simply
> > > because the current audit code quality is so very poor.
> > > Unfortunately, the patch you posted appears to me as yet another
> > > bolt-on performance tweak that doesn't make an attempt at analyzing
> > > the current hot spots of syscall auditing, and ideally offering
> > > solutions.  Perhaps ultimately this approach is the only sane thing
> > > that can be done, but I'd like to see some analysis first of the
> > > syscall auditing path.
> >
> > Ivan is out of office, but I would like to keep the discussion going.
> > We do understand your position and we're actually doing a project
> > right now to investigate audit performance better ...
>
> That's great, thank you!
>
> > But the way I see it - the audit subsystem performance and the way how
> > that subsystem plugs into the rest of the kernel code are two somewhat
> > independent things with the patch proposed here addressing the latter
> > (with full understanding that the former might be improved as well) ...
>
> You've done a good job explaining the reasoning and motivations behind
> the patch submitted, that is good, but I'm not seeing any recognition
> or understanding about the perspective I shared with you earlier.  The
> performance of audit in general does need to be improved, I don't
> think anyone disagrees with that, but my argument is that we need to
> focus on changes which not only reduce the processing overhead, but
> *also* reduce the complexity of the code as well.

Ah, sorry. You're right - I paid too much attention to performance and
didn't quite read your concern about code complexity. But still, I
think that code complexity improvements fall onto the implementation
of the audit subsystem itself vs what we try to accomplish here is to
improve the way how that subsystem plugs into the rest of the kernel.

Ignat
