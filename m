Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4D6A48B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjB0R52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0R5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:57:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B225323121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:57:24 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s22so9649060lfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNq8WcvUy3HYbrOr3zCPYfpihfq+c1d750sU5yoEUm4=;
        b=nuV1f3UhMjSrBVwozLqD7LiYP2QI4PUUAEBQc7zWzMcfF+CTNU+op2TXr9qit4YbAt
         9yWyPeGybre5KJSC5qdmQD8kRS4jRDmQ9ymKj6KQCIP0oyULt0C1cenZ3rFTmL2QEUdm
         Mhbtp3DYa6o7brQiTIAhCLIVFP85lec/jYffs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNq8WcvUy3HYbrOr3zCPYfpihfq+c1d750sU5yoEUm4=;
        b=SXE2JkZ2DlvzQm6E8xakuDwaqJHxr0uf0Gdsb8uGHbn/CA/OICzlvS+g3zwW+fY6wC
         GZIrpHlv1qKUZQtZwoY08+GeEwMD+XcV8EALG50Hyu+NQt+85m8FxZxKx2NKCBtAsIEy
         Sk3899UNWOQT5hjbvoQoQZJ5P6rFZr/OIIeWCL+XSF3PazCkCDIjrTiOCJR3gLkRvJYJ
         G/lTTcYjqnPEMv5fbHT11WFL80QFt0PVzxvHbiVC5I0NHuNx++G0RmQk5xaX3GbHli2D
         6RJf34WnUn4bsKMSCMauRqKl0+KXcyQtR4EHPdpZnAqobJ51KTIkzAJH5ChNPpS1HvmT
         76dg==
X-Gm-Message-State: AO0yUKUGGj+Aj9B+YIWIGpwN+S32jsOxWhPAnn0h0EhUryuX+zct/GRW
        qN74M8j9gAOTXDiOQ+xglUU/IxQgyQfOFR6N+dA8PA==
X-Google-Smtp-Source: AK7set/7SQRn36fH8NxsDDHNytrueLDYSti7/XhHaDHhnii2qEpXcyUYjM6wqLorVbJXCzd9Oji0Uqz19VuZnNfmI+M=
X-Received: by 2002:a05:6512:208:b0:4d5:ca32:9bdf with SMTP id
 a8-20020a056512020800b004d5ca329bdfmr7847430lfo.11.1677520642896; Mon, 27 Feb
 2023 09:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/uHjpbJ3JmVAe9d@google.com> <a5f1695d-cc1f-04aa-fe61-f2b8687cfb0e@huaweicloud.com>
In-Reply-To: <a5f1695d-cc1f-04aa-fe61-f2b8687cfb0e@huaweicloud.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 27 Feb 2023 12:57:11 -0500
Message-ID: <CAEXW_YQMXKDx0gr1S5HkraVA+ori-AnQL-yGU6r=u6B5_XciUA@mail.gmail.com>
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 9:39=E2=80=AFAM Jonas Oberhauser
<jonas.oberhauser@huaweicloud.com> wrote:
>
>
>
> On 2/26/2023 5:23 PM, Joel Fernandes wrote:
> > On Fri, Feb 24, 2023 at 02:52:51PM +0100, Jonas Oberhauser wrote:
> >> As stated in the documentation and implied by its name, the ppo
> >> (preserved program order) relation is intended to link po-earlier
> >> to po-later instructions under certain conditions.  However, a
> >> corner case currently allows instructions to be linked by ppo that
> >> are not executed by the same thread, i.e., instructions are being
> >> linked that have no po relation.
> >>
> >> This happens due to the mb/strong-fence/fence relations, which (as
> >> one case) provide order when locks are passed between threads
> >> followed by an smp_mb__after_unlock_lock() fence.  This is
> >> illustrated in the following litmus test (as can be seen when using
> >> herd7 with `doshow ppo`):
> >>
> >> P0(int *x, int *y)
> >> {
> >>      spin_lock(x);
> >>      spin_unlock(x);
> >> }
> >>
> >> P1(int *x, int *y)
> >> {
> >>      spin_lock(x);
> >>      smp_mb__after_unlock_lock();
> >>      *y =3D 1;
> >> }
> >>
> >> The ppo relation will link P0's spin_lock(x) and P1's *y=3D1, because
> >> P0 passes a lock to P1 which then uses this fence.
> >>
> >> The patch makes ppo a subrelation of po by letting fence contribute
> >> to ppo only in case the fence links events of the same thread.
> >>
> >> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> >> ---
> >>   tools/memory-model/linux-kernel.cat | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/=
linux-kernel.cat
> >> index cfc1b8fd46da..adf3c4f41229 100644
> >> --- a/tools/memory-model/linux-kernel.cat
> >> +++ b/tools/memory-model/linux-kernel.cat
> >> @@ -82,7 +82,7 @@ let rwdep =3D (dep | ctrl) ; [W]
> >>   let overwrite =3D co | fr
> >>   let to-w =3D rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> >>   let to-r =3D (addr ; [R]) | (dep ; [Marked] ; rfi)
> >> -let ppo =3D to-r | to-w | fence | (po-unlock-lock-po & int)
> >> +let ppo =3D to-r | to-w | (fence & int) | (po-unlock-lock-po & int)
> > Alternatively can be the following appended diff? Requires only single =
'int'
> > in ->ppo then and prevents future similar issues caused by sub relation=
s.
> > Also makes clear that ->ppo can only be CPU-internal.
>
> I had thought about going in that direction, but it doesn't prevent
> future similar issues, at best makes them less likely.

Making less likely still sounds like a win to me.

> For example, you could have an xfence that somehow goes back to the
> original thread, but to a po-earlier event (e.g., like prop).
>
> Given that to-r and to-w are unlikely to ever become become inconsistent
> with po, I am not sure it even really helps much.

I am not sure I understand, what is the problem with enforcing that
ppo is only supposed to ever be -int ? Sounds like it makes it super
clear.

> Personally I'm not too happy with the ad-hoc '& int' because it's like

So, with the idea I suggest, you will have fewer ints so you should be happ=
y ;-)

> adding some unused stuff (via ... | unused-stuff) and then cutting it
> back out with &int, unlike prop & int which has a real semantic meaning
> (propagate back to the thread). The fastest move is the move we avoid
> doing, so I rather wouldn't add those parts in the first place.
>
> However fixing the fence relation turned out to be a lot trickier, both
> because of the missed data race and also rmw-sequences, essentially I
> would have had to disambiguate between xfences and fences already in
> this patch. So I did this minimal local fix for now and we can discuss
> whether it makes sense to get rid of the '& int' once/if we have xfence e=
tc.

I see. Ok, I'll defer to your expertise on this since you know more
than I. I am relatively only recent with even opening up the CAT code.

Cheers,

 - Joel


>
> Best wishes,
> jonas
>
> PS:
> > ---8<-----------------------
>
> haha that's so clever :D
>
> >
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/l=
inux-kernel.cat
> > index 07f884f9b2bf..63052d1628e9 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -70,7 +70,7 @@ let rwdep =3D (dep | ctrl) ; [W]
> >   let overwrite =3D co | fr
> >   let to-w =3D rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> >   let to-r =3D addr | (dep ; [Marked] ; rfi)
> > -let ppo =3D to-r | to-w | fence | (po-unlock-lock-po & int)
> > +let ppo =3D (to-r | to-w | fence | po-unlock-lock-po) & int
> >
> >   (* Propagation: Ordering from release operations and strong fences. *=
)
> >   let A-cumul(r) =3D (rfe ; [Marked])? ; r
>
