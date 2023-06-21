Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15A73783B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjFUAaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFUAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:30:15 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC1173F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:30:13 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-570114e1feaso61043407b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687307412; x=1689899412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwNTCKmMgvc2nJrRbHQLKCJs8IWViNUrZIuXoDpTgTc=;
        b=KTmlRfuzVHIbYKZsvQLka9gLQySta0BOsnWVzXbzSnYvXPJU0KIm66yUCFPGxaZw25
         DyXgWr9lVvf7IGSkSclDGTE5/uJoOODbYkzbzOJ/axO7oRKNLDv9dS8oqiSwOiGqrVsr
         XfzrrTlBEKdZeBl+J7CvitUn/fmkBtkSHRFYMtXiSKNwdyYiC0So4dM+1qDyLfBDfZJH
         ElPVu0BH1ZudgbRubnO4XBx0TQLp6MQ2F+YofaVxyxrgcRMvFO7a38/xPVMC9SGAgDSm
         485l4OVgxNlSf7u/pz9cTeG0hiL9f7EfvSWqGht0XOfBH339WJkhjKQfSFNw/V1HwCki
         R3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307412; x=1689899412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwNTCKmMgvc2nJrRbHQLKCJs8IWViNUrZIuXoDpTgTc=;
        b=AhvGiwC6mwWChTEWxrLn63z+udRFTHlZCmIjcT8tvDUarNCwuv7a8VwUBFO9S8U7F7
         /Kn6Dl9I2n/EnUyg4IiqLo+7QfRn6Rk/vhqptMRAWDUWXqjuFhzXMpSBacUJf3dHWFaI
         nGxqugL473xNzDzNMfbpKaEnN3gPrTuE5vdD2o7ZfXAoogteBKAol6BeNh+tIYCJO9Jr
         Ag1S5OywFQGrtZLtWIHNSeIj+xoAgdbmBMIKVKsDQYm3puuskwr9LZ8LkOwJF0xzaDUh
         Upy1hqAratXUPqX2WThutecLHsZYAguzXZ/59Q54Hclhjop9t7DriR87NNx570KbLPdy
         7eWQ==
X-Gm-Message-State: AC+VfDxx3WopGdLI9McQQR6gRnbhsjLIUE89MfDZPEH7GGjNyaQDl0qb
        6XrYqzrAST39/JCY0Dv803QVI360pkqx4sLbVRmR
X-Google-Smtp-Source: ACHHUZ432ixhOBQxfLZ9QEclgrfhsFFPd+GVpkZShXuAH9yfI2Lp0ijrpUA6LkS1MngsJcOXDUHiBEefyZSwfhlzsmg=
X-Received: by 2002:a81:c24b:0:b0:567:7db6:3d48 with SMTP id
 t11-20020a81c24b000000b005677db63d48mr15278626ywg.12.1687307412295; Tue, 20
 Jun 2023 17:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
 <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com>
 <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com> <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com>
In-Reply-To: <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Jun 2023 20:30:01 -0400
Message-ID: <CAHC9VhSGhV6SoOeV2h4ehrkUCK9Sds1wx=CGdRSouvnLn0Z3Kg@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     mortonm@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 2:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Jun 6, 2023 at 5:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > > >
> > > > > pr_warn message clearly says that GID should be printed,
> > > > > but we have UID there. Let's fix that.
> > > > >
> > > > > Found accidentaly during the work on isolated user namespaces.
> > > > >
> > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canon=
ical.com>
> > > > > ---
> > > > > v2: __kuid_val -> __kgid_val
> > > > > ---
> > > > >  security/safesetid/lsm.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > I'm assuming you're going to pick this up Micah?
> > > >
> > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Dear Paul!
> > >
> > > Thanks for your review!
> > >
> > > Gentle ping to Micah Morton :-)
> >
> > Micah?
> >
> > The right thing would be for Micah to merge this via the SafeSetID
> > tree, however, considering that it's been over a month with no
> > response, and this patch looks trivially correct, I can pick this up
> > via the LSM tree if we don't see anything from Micah this week.
>
> Searching through all of the archives on lore I don't see any email
> from Micah past August of 2022.  I'll still stick to the plan of
> merging this via the LSM tree next week if we don't see any response
> from Micah, but beyond this patch we may need to consider the
> possibility that Micah has moved on from SafeSetID.
>
>  * https://lore.kernel.org/all/?q=3Df%3Amortonm%40chromium.org

This fell through the cracks in my inbox last week, but I just went
ahead and merged this into lsm/next.

After the upcoming merge window closes we'll have to revisit
SafeSetID's status as "supported", we might need to demote it to
"maintained" or "odd fixes".

--=20
paul-moore.com
