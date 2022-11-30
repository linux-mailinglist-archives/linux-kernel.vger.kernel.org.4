Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA81263D981
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK3PeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiK3PeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:34:17 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667E66248
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:34:15 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:34:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1669822452; x=1670081652;
        bh=eQRixGy4kw5VGm/wWLNEoHl82ETy9juVuvbg2not45E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=i+lP3fuqLe22Ym+G+fT5cssaR6FMOdmr5I+BDccwLd1yGG9tM2KTnAsDhjxUbpCAw
         5RVW7MjdaGwDbR7ZlAUGrMJbGbcRQb7kqQqpfyki+yr908M0+cYCK0m9PUPeEy0u9L
         EwfnjN5rhMinpG9oS7Gln2T+QIxXkWSP/sq0PUtYuUDBjjNOpiOvzXRrqG1LOhHozC
         9AZRaUQxeb+xdVWaozmYW/i/JwheISEctQ7Z3z41IKk/UnyaScvhveU1yurd4B/P1l
         +17SM451vUE+oYq0w4GHJhojZPeB053I3s6PyHAB+jlfsQngJL7RCdHihpL+XtTnvj
         SuLrcPfUIaz1Q==
To:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, contactshashanksharma@gmail.com,
        amaranath.somalapuram@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH v3 0/2] drm: Add GPU reset sysfs
Message-ID: <9WiGqqLyo5VwAmb8qBPZAhUiq_ptdB-lNo5d6A42raXoJU8XPxojB_44bKkR8Tw82SdiiPz1lAKpe7HH9HlDA0fFpgcy6shNjTDxOfsadFE=@emersion.fr>
In-Reply-To: <2dbf222e-7694-ea5e-c35d-663011c16e84@igalia.com>
References: <20221125175203.52481-1-andrealmeid@igalia.com> <20221128112528.1206b1f5@eldfell> <584UdQAqoPr4vSxCTJg70LFQm--HpHH-EhnAo78lRAZ89OnrDkUeKlTnDGT_DMzDT3PeEtmXNsrqB6GuiV4TsZv3pBU8kFWjyPLWGrevIMw=@emersion.fr> <2dbf222e-7694-ea5e-c35d-663011c16e84@igalia.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 30th, 2022 at 16:23, Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:

> On 11/28/22 06:30, Simon Ser wrote:
>=20
> > The PID is racy, the user-space daemon could end up killing an
> > unrelated process=E2=80=A6 Is there any way we could use a pidfd instea=
d?
>=20
> Is the PID race condition something that really happens or rather
> something theoretical?

A PID race can happen in practice if many PIDs get spawned. On Linux
PIDs wrap around pretty quickly.

Note, even a sandboxed program inside its own PID namespace can trigger
the wrap-around.

> Anyway, I can't see how pidfd and uevent would work together. Since
> uevent it's kind of a broadcast and pidfd is an anon file, it wouldn't
> be possible to say to userspace which is the fd to be used giving that
> file descriptors are per process resources.

Yeah, I can see how this can be difficult to integrate with uevent.

> On the other hand, this interface could be converted to be an ioctl that
> userspace would block waiting for a reset notification, then the kernel
> could create a pidfd and give to the blocked process the right fd. We
> would probably need a queue to make sure no event is lost.

A blocking IOCTL wouldn't be very nice, you can't integrate that into
an event loop for instance=E2=80=A6
