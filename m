Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8B6F2234
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 03:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbjD2B5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 21:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjD2B5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:57:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5430D2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:57:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8db10a5d4so3861431fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682733457; x=1685325457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t00tIj5yWAc7faP0tYPiw/rgUVzJQa1XhBZJU6+uOm8=;
        b=Gvr64uOzbm2+u7qchU8VUyQPCLj8Y3wu+YXQN041C9VyCAzKUMiSr9vbNBGvA3t/Dt
         LyFGvNw0tr6Jqgv9daYpZuANojKyVNeSNWRe1jFZRoCKGQ84PbNBtTuebhmbZhmTic2l
         10eKACIpLD487OF6LamXMp9T+Z2fM9C1O+FJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682733457; x=1685325457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t00tIj5yWAc7faP0tYPiw/rgUVzJQa1XhBZJU6+uOm8=;
        b=cOCupYtJfDx3OepFNmHWOdHsitllwOH0IaiKalJGiQui+giISRCbTMBZgNRkBfyv5e
         FGLLbo6UM+rxsUC68VAvumS4AOK9F0FSaiTGlFYNLpqn8M2vKoLd0bAGNFvhUncetspG
         LksXbGcww42g/mnmGgc4pMTtbpLckU7wfqnjyYXh3hOY1JEbtTdb9O2omDSWcCtVhp8b
         BGgTBeGrIV6lOdY9IWu8swDjs9/qxUS0haOgjXB26kL5TmIPekYA1pAB2IkOwuPPkN+t
         gHPaGZaBcDug+PO1us0LUJh6naSSQGcYhS5qejHurZVDqBBxK+sqFTep3Pw31RmvsFNK
         F2Eg==
X-Gm-Message-State: AC+VfDzH42a6kfzzQn+WQD4Fa0I6qLRFCqWk7IkUSLSbOivxJReRVE3P
        lyoVuW7pGmTfXFx1/F8E+atNdE2vJkybwHpYOSSoQA==
X-Google-Smtp-Source: ACHHUZ5io4qUeGrfg3f9oJCpWVAM/m1VRfS+ECBUz3mUCS3SloeF7NMn6tqQH4zt1sGLrMf5q+BJDZFY2GgzIucgmvo=
X-Received: by 2002:a2e:b607:0:b0:2a8:b133:6597 with SMTP id
 r7-20020a2eb607000000b002a8b1336597mr1954034ljn.9.1682733457230; Fri, 28 Apr
 2023 18:57:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Apr 2023 18:57:36 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Wqu21ErJGwf24mkFcXTZx_vR1r++0cP68vr9FQDY8O-A@mail.gmail.com>
References: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
 <20230329143317.RFC.v2.2.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
 <CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8MMw@mail.gmail.com> <CAD=FV=Wqu21ErJGwf24mkFcXTZx_vR1r++0cP68vr9FQDY8O-A@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 28 Apr 2023 18:57:36 -0700
Message-ID: <CAE-0n50vofDO6dpEvnetfvXL41m55j7_OXF=JGZ9L34M0xXPDA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] regulator: core: Avoid lockdep reports when
 resolving supplies
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Collins <quic_collinsd@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2023-04-13 17:36:09)
> Hi,
>
> On Fri, Apr 7, 2023 at 2:46=E2=80=AFPM Stephen Boyd <swboyd@chromium.org>=
 wrote:
> >
> > Quoting Douglas Anderson (2023-03-29 14:33:54)
> > > @@ -2190,7 +2263,9 @@ struct regulator *_regulator_get(struct device =
*dev, const char *id,
> > >                 return regulator;
> > >         }
> > >
> > > +       regulator_lock(rdev);
> > >         regulator =3D create_regulator(rdev, dev, id);
> > > +       regulator_unlock(rdev);
> >
> > I'm sad that we're now locking the entire time create_regulator() is
> > called. Can that be avoided? I see that create_regulator() publishes th=
e
> > consumer on the consumer_list, but otherwise I don't think it needs to
> > hold the regulator lock. It goes on to call debugfs code after
> > allocating memory. After this patch, we're going to be holding the lock
> > for that regulator across debugfs APIs. I suspect that may lead to more
> > problems later on because the time we hold the lock is extremely wide
> > now.
> >
> > Of course, we were already holding the child regulator's lock for the
> > supply, because that's what this patch is fixing in
> > regulator_resolve_supply(). I'm just nervous that we're holding the loc=
k
> > for a much wider time now. Maybe we can have create_regulator() return
> > the regulator and add a new function like add_regulator_consumer() that
> > does the list modification? Then we can make create_regulator() do
> > everything without holding a lock and have a very short time where the
> > new function locks two regulator locks and does the linkage.
>
> While we could try to come up with something fancier like this, I'm
> not convinced it's worth the complexity. There are already cases where
> we hold multiple regulator locks for quite long periods of time.
> Specifically you can look at regulator_enable(). There, we'll grab the
> lock for the regulator and the locks for all of the regulators parents
> up the chain. Then we'll enable the regulator (and maybe the parents)
> which might even include a long delay/sleep while holding the mutexes
> for the whole chain.

Does that long period of time cover a large section of code? I'm not so
much concerned about holding the lock for a long time. I'm mostly
concerned about holding the lock across the debugfs APIs, and
potentially anything else that debugfs might lock against. If the lock
is only really needed to modify the list in a safe manner then it may be
better to make it a little more complex so that we don't exit the
regulator framework with some rdev locks held.

>
> Mark: do you have any opinion / intuition here? Is holding the rdev
> lock for this larger scope a problem?
