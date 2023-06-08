Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93A172874B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjFHSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFHSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:34:39 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC212695
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:34:35 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-569fc874498so8889107b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686249275; x=1688841275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJKDvRBPgWVhhD01EiidiIAn4eRCDSE/e6f94myR/Cs=;
        b=TqtZi9N0hEWsH0aEkWKDROw3M6m0P3GgE7tDwHz/SprtCX7eECP7Oiu78AObagVYzb
         M6C+8gS/l0y0kKSxkrbktQGA2zJsxQwFPVrEn8OO6c7Dbu9Vd9YqQbBpoiXgpEHYVbgN
         UgOWt2i5KS0MVt+6Szgxwrb0MTAYLW2fkHEmJejpbMyrPwUdS3sE3bh/nNMP/aRx8y/n
         iq0IuLr80Va2IDON76hM63b+W+bJqJyMvc29JIJ/xyOo/bNhROsIhGA1Z8RSj7/f8bSX
         MhD38afCyknAyMvVXxzEEHV+yb61tk8YBTwCTlW5XZrVMz2xiA/xvd+dLs92hXPu6Xod
         FOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686249275; x=1688841275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJKDvRBPgWVhhD01EiidiIAn4eRCDSE/e6f94myR/Cs=;
        b=T02JVkzgYy4c7rfegLaxHqeU6iFtpzx90vLBmiqo3RxZlkdp/dUFC68XVrcGBfgRfh
         ACxPJ2ueYW2kYxUuTl0hJ4AIWRV4OxOVW+WVwIiSHhiIuoU0O+eg5e+BtLooWpDBMVqz
         Oqj/F4tX3HjI9jl9dfLxjBOGiBlaToYKj9/kAia1wa5uf60KNpJaK7mV6lPQwInze+Fu
         gYG8yuiy5pCpM5GyTHZAD8xqlW6/w643R3b1zb8pYo8F9M4Qtree8Mp8BGkmC8moWwTi
         RQ6eBVP5COC+/2KHW935CKVIa+evdnn/5x5e06K3WsybPk+JBkv0JX9q8tzHzR3nj/5X
         s8OA==
X-Gm-Message-State: AC+VfDwo2up1Z8udbiL16XKnZe9uoQ+TpBRABqf7F3FGMDLNWvS9B98E
        NK5hz0hDKhFDfnmF3Str5Q7JDRScr6XLs5T/G+Jt
X-Google-Smtp-Source: ACHHUZ7buDqkEHJqJNiXJlFHy+XAsZXMlNc0dNDi3yiyg7hf8P21IIMf7scrhGSRPVbvig4xPjs+HAwpfrgmzLJ6sMU=
X-Received: by 2002:a0d:fb47:0:b0:561:d25b:672a with SMTP id
 l68-20020a0dfb47000000b00561d25b672amr455206ywf.21.1686249274860; Thu, 08 Jun
 2023 11:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
 <CAHC9VhTx+6f8riuGOG40HZoaYx3F8Kf3Hm7Eb5k3-An91eMWgg@mail.gmail.com>
 <CAEivzxcVQoA9rN06BtHJzyHCaN60RG1-cyGEEw-P+dp-tCB=QA@mail.gmail.com> <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com>
In-Reply-To: <CAHC9VhQnOszTFaFVBZACQCDxsuD6JrxDffmmJ-wBudK2MJ2pUA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Jun 2023 14:34:24 -0400
Message-ID: <CAHC9VhSF+j=qFH4M9bt-Q8HUOwk7qLOEkCSve8onUMgADJ7+3A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 5:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Jun 6, 2023 at 2:50=E2=80=AFPM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> > On Thu, May 18, 2023 at 8:59=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Wed, May 3, 2023 at 2:44=E2=80=AFAM Alexander Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > >
> > > > pr_warn message clearly says that GID should be printed,
> > > > but we have UID there. Let's fix that.
> > > >
> > > > Found accidentaly during the work on isolated user namespaces.
> > > >
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > > > ---
> > > > v2: __kuid_val -> __kgid_val
> > > > ---
> > > >  security/safesetid/lsm.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > I'm assuming you're going to pick this up Micah?
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Dear Paul!
> >
> > Thanks for your review!
> >
> > Gentle ping to Micah Morton :-)
>
> Micah?
>
> The right thing would be for Micah to merge this via the SafeSetID
> tree, however, considering that it's been over a month with no
> response, and this patch looks trivially correct, I can pick this up
> via the LSM tree if we don't see anything from Micah this week.

Searching through all of the archives on lore I don't see any email
from Micah past August of 2022.  I'll still stick to the plan of
merging this via the LSM tree next week if we don't see any response
from Micah, but beyond this patch we may need to consider the
possibility that Micah has moved on from SafeSetID.

 * https://lore.kernel.org/all/?q=3Df%3Amortonm%40chromium.org

--=20
paul-moore.com
