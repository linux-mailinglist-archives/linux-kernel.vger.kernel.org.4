Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5C70E5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbjEWTju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbjEWTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:39:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017FD18D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:39:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a7e639656so219390276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684870750; x=1687462750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSklzBjxhZmzMNotdKdz2ZXQTBM+PT0yLU4Hf0qksUo=;
        b=J1+Lh90+86HHzJ7Ba1MAeG6dBd/GlUnA8IZWFTSpRu1BcxvZ/Bjetmd8L1OCVI7bsG
         /vHoMAhkCLNIsJXlDFSjuhNK/i92CV1ZcXtHndRLXbtLyo814cuuLTHE4PeWowcDRcE7
         QT4gwr5ty9kkloUBxcKKqvl+zIm1CqWoNyw4JmxtgZDzEm20RV4X2T44Ai8MBCIkmd9S
         ayCtjHJW+9kwDX5kcGYBiY2wQwI/UFf7dqbw3XvOKTgV9LxTuSKD2u5scnh5egG2cCDw
         3LBW5QaprHdfc6uj4l7B5WneoF4V+5PfN9trESHUUh3+M0ec9z4nLh5HOOR5FdJHTIFl
         KFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870750; x=1687462750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSklzBjxhZmzMNotdKdz2ZXQTBM+PT0yLU4Hf0qksUo=;
        b=HhHCyzxrvnxqmJYgrRO4joMAmkGfNXnF+4TqYO/SQpb3RlBqhmGGZUTbikJetMsa1Y
         pNGW7k/Y27hm9tv+xOiC6pkjYYHfytnSEkSIZmtAOhwe7eZvE9AYRVfmagmPM091R2uI
         +ih6HV8TTkq9TayNg0oY3sbd0q3MlwYVUES5oKcZC/GwDmOaFMl7uYbEcjgUWSyr6LXI
         BSXepI2TJSrThoD6NsgO8X6QHK7jw1bg3Yh2UtVyBwDtVuBuzsNymAlrZCOWAgo/7Ntz
         2Cx6YeFYvrSq3yMe0HGAwHCPVPebZE0ES/zwWo5ZffRNVGh7XLZ8K+PNAFnB3koxoobf
         aGjQ==
X-Gm-Message-State: AC+VfDwiQQCS6XT46IUUprgvYfI7u7ZO5UgzckMEJ54fzk7opoaiC3WG
        eupOdMagnLHIbh3zuuYtpw7CH/bmzL6ffSC9xZXP
X-Google-Smtp-Source: ACHHUZ5t3ISNlc8css/TIbS3nKAqJFZ751H1T5Cj7O+AaEakwztSyfUhzg3HqqZydPeGF3do/inmnStTBrpGIbF5Z2Q=
X-Received: by 2002:a81:a0d2:0:b0:559:f52b:7c5f with SMTP id
 x201-20020a81a0d2000000b00559f52b7c5fmr15335674ywg.17.1684870750245; Tue, 23
 May 2023 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230511123213.722912-1-cgzones@googlemail.com>
 <6301fdfd0927df2b2fd7a4f2b384e477.paul@paul-moore.com> <CAHC9VhSSA04wzPFgx_Z4jf1gOdEO40hU-augjMqX1uGd-eHLQA@mail.gmail.com>
 <CAJ2a_DeJhGcXBtVfuOp3xeUNxJyFR4QG-+5=4Q_38go+v6d9-A@mail.gmail.com>
In-Reply-To: <CAJ2a_DeJhGcXBtVfuOp3xeUNxJyFR4QG-+5=4Q_38go+v6d9-A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 15:38:59 -0400
Message-ID: <CAHC9VhQ_yLL432Ete+ZB3TV-wwG7capXCOE1NKY029evKxQ9DA@mail.gmail.com>
Subject: Re: [PATCH] selinux: deprecated fs ocon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
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

On Tue, May 23, 2023 at 2:25=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 18 May 2023 at 22:18, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, May 18, 2023 at 1:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On May 11, 2023 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgzo=
nes@googlemail.com> wrote:
> > > >
> > > > The object context type `fs`, not to be confused with the well used
> > > > object context type `fscon`, was introduced in the initial git comm=
it
> > > > 1da177e4c3f4 ("Linux-2.6.12-rc2") but never actually used since.
> > > >
> > > > The paper "A Security Policy Configuration for the Security-Enhance=
d
> > > > Linux" [1] mentions it under `7.2 File System Contexts` but also st=
ates:
> > > >
> > > >     Currently, this configuration is unused.
> > > >
> > > > The policy statement defining such object contexts is `fscon`, e.g.=
:
> > > >
> > > >     fscon 2 3 gen_context(system_u:object_r:conA_t,s0) gen_context(=
system_u:object_r:conB_t,s0)
> > > >
> > > > It is not documented at selinuxproject.org or in the SELinux notebo=
ok
> > > > and not supported by the Reference Policy buildsystem - the stateme=
nt is
> > > > not properly sorted - and thus not used in the Reference or Fedora
> > > > Policy.
> > > >
> > > > Print a warning message at policy load for each such object context=
:
> > > >
> > > >     SELinux:  void and deprecated fs ocon 02:03
> > > >
> > > > This topic was initially highlighted by Nicolas Iooss [2].
> > > >
> > > > [1]: https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELIN=
UX-SECURITY-POLICY-CONFIGURATION-REPORT.PDF
> > > > [2]: https://lore.kernel.org/selinux/CAJfZ7=3DmP2eJaq2BfO3y0VnwUJaY=
2cS2p=3DHZMN71z1pKjzaT0Eg@mail.gmail.com/
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  security/selinux/ss/policydb.c | 4 ++++
> > > >  security/selinux/ss/policydb.h | 2 +-
> > > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > Thanks, this is a nice catch, although some minor suggestions below .=
..
> > >
> > > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/p=
olicydb.c
> > > > index 97c0074f9312..31b08b34c722 100644
> > > > --- a/security/selinux/ss/policydb.c
> > > > +++ b/security/selinux/ss/policydb.c
> > > > @@ -2257,6 +2257,10 @@ static int ocontext_read(struct policydb *p,=
 const struct policydb_compat_info *
> > > >                               if (rc)
> > > >                                       goto out;
> > > >
> > > > +                             if (i =3D=3D OCON_FS)
> > > > +                                     pr_warn("SELinux:  void and d=
eprecated fs ocon %s\n",
> > > > +                                             c->u.name);
> > >
> > > Instead of having to check if 'i =3D=3D OCON_FS', why not simply put =
the
> > > pr_warn() call up in the OCON_FS case block on line ~2249 and let it
> > > continue to fallthrough to the OCON_NETIF block?
> >
> > Bah, nevermind, you need to leave it here because of the 'c->u.name'
> > in the pr_warn().  If you're okay with me adjusting the deprecation
> > comment (below) during the merge I'll can merge this now ... ?
>
> Yes, please feel free to adjust the inline comment.

Okay, done and merged into selinux/next, thanks.

--=20
paul-moore.com
