Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D116DDEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDKO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDKO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:57:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648CB199B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681224987; i=efault@gmx.de;
        bh=TgyZ5i2M/3KDc8da5n7BAQ9SrzkLC1GBtWlDUE6ES/g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=M1P1BEnL4uwEBvWkXoMsfXEGho1r0lPTBh/RXf1YeM37x5/a619DYznkUC3xyRp3V
         ztAhWNYuzRG9Mdkvbww2GzPAV5rGNvikXU4JwRk8S4nVrqqHzGQXtqTv67BAFfeRE2
         mmMwirQeDA0WSmUSPnVmNV7t0WVRUZ9uX9BfBBDx0K7uDWWzLOMtKpNtdrTOf9L0WX
         +DJqQRrB8ir2+TmDaPd/XfLjuL7c/wn5I0e4Lp4x/xpiYnbvaV/j4aWYIdAA8KINpb
         8meyLqICR4RSm2Ro6DynGnuRq0R/J++pqbOJAACXhsxRfS7j+VCv/hwjPsgyYTJC6G
         LIYqGzqA8WNMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.64]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfJd-1qeUhJ3kHH-00vAD1; Tue, 11
 Apr 2023 16:56:26 +0200
Message-ID: <584da7e2052a11f432afaf623e567610ce17c78b.camel@gmx.de>
Subject: Re: [PATCH 00/17] sched: EEVDF using latency-nice
From:   Mike Galbraith <efault@gmx.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, kprateek.nayak@amd.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Date:   Tue, 11 Apr 2023 16:56:24 +0200
In-Reply-To: <20230411133333.1790-1-hdanton@sina.com>
References: <20230328092622.062917921@infradead.org>
         <20230410082307.1327-1-hdanton@sina.com>
         <20230411133333.1790-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LZ4LcL2xRWvnRFA4Rg8812btaqUC/LgLwUeUiZGpvZWv9QZmzBx
 w8Qn+DNLgm1iGjdcvVjmo0tR5uhfRaFK39gxeg9Dr9ftgokR8ItPlxyL8p+hSMywuj23zaI
 xbxeGQt9IzOmhRjQ5Qu6mViUlpYflKZY13a/g1J6mWVPpqVsu/EAWKfmwvs/R69lhhObehl
 6ylr53eioCD4QFaVrRv6A==
UI-OutboundReport: notjunk:1;M01:P0:ozvJc9Xwgc0=;yXLb0mfuEsFNRb2/+mU5kJrKgfA
 kdCqD8sUCTswrtyrBBuzO6yBsvQgHvT3qOE1wYQe1jWDE7s8UuVbHaorF376zWwRuBt7Ve7SR
 acAs1xIIrdZ7DVaEDCwQKeSpW/UenoTe4F4RgzUewiRNhClhsV/f88kw8tid+fL7Yc3xDKF1p
 BEsBHeqPCK4IgKRtXA5wE35vFeu59vYUCEzg2mUr1BBi16olL7peTS64IPi/6VCyu4To6rYcu
 7YGJTYxtikO13fDYSE8QmIf3+kTclwqAdIo6uKi6/xstqy0vhlO4YcTGSYUXtWhH8lizRtt9V
 Jr9+W271IXzct1YHJSLk+rs9GZE7oMKR5hWQHRvMAW2a7gsiG9+jVa5J1JG+0MXRfRtx8dsbO
 GD7+bFfVdqXrpp/ALikaxYc6JX+GrbuuCqqu8xApL21Om2ekxHe93pgIO9d9ZireIFxXBPCLz
 fh4Qc8/t2vdrk0JLRhU7i/Ce1lFlPKoe+hzs0HuOyTjG6xaKIIIQYa4SdPT/PHCjybS2GvpZn
 qexKyV0E2KpMYTsAbmL+tC9z1Qq0cVmk1vX9aES9jrSnM82ZbzdK6lR185rCkkxjoOfh8RZg5
 2s6tjkss9zsETm+KmhCyZ5B8BHASVoxij5epEDWbMZZI9xzt02f8ShQ6aJ7Fr17wUQBVS9Ny0
 x+fZFAx/IgUeSlIb/e4Cd5w6aaiiK2/Vhh9y6CNqL10+XdOSzp1ux9lRQwXLUsZYubtoEzDuo
 Hl/sDzdeFqYsfI4c9waFwaNRYPgN4WSyhLqNkhzFecBVkvPhQjSJehpM8dCBqllZQtSGAux2T
 b1l8ldT+omc2aGkCFVOblb4d+CmBAZ2V/5l7iuVD9Pkj4HpYPZZ7S/EditBQnBGBTfqVYSoAs
 fA0RUCvCZonqdRv8b+O6RO4L50ArdIzuV+NEaUNoXOopAr5w+NHCMD8rrl37H0KAaf+DOM5rs
 8qwu9iPg5Ad2RxIpNJwPfR/Yr80=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-04-11 at 21:33 +0800, Hillf Danton wrote:
> On Tue, 11 Apr 2023 12:15:41 +0200 Mike Galbraith <efault@gmx.de>
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -950,6 +950,9 @@ static struct sched_entity *pick_eevdf(s
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (curr && (!curr->on=
_rq || !entity_eligible(cfs_rq, curr)))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0curr =3D3D NULL;
> >
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sched_feat(GENTLE_EEVDF=
) && curr)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return curr;
> > +
>
> This is rather aggressive, given latency-10 curr and latency-0 candidate
> at tick hit for instance.

The numbers seem to indicate that the ~400k ctx switches eliminated
were meaningless to the load being measures.  I recorded everything for
5 minutes, and the recording wide max actually went down.. but one-off
hits happen regularly in noisy GUI regardless of scheduler, are
difficult to assign meaning to.

Now I'm not saying there is no cost, if you change anything that's
converted to instructions, there is a price tag somewhere, whether you
notice immediately or not.  Nor am I saying that patchlet is golden.  I
am saying that some of the ctx switch delta look very much like useless
overhead that can and should be made to go away.  From my POV, patchlet
actually looks like kinda viable, but to Peter and regression reporter,
it and associated data are presented as a datapoint.

>  And along your direction a mild change is
> postpone the preempt wakeup to the next tick.
>
> +++ b/kernel/sched/fair.c
> @@ -7932,8 +7932,6 @@ static void check_preempt_wakeup(struct
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cfs_rq =3D cfs_rq_of(se)=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update_curr(cfs_rq);
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * XXX pick_eevdf(cfs_rq=
) !=3D se ?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */

Mmmm, stopping time is a bad idea methinks.

	-Mike
