Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88BC6F7322
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEDTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDTWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:22:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A9268C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 12:22:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a950b982d4so457905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 12:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683228120; x=1685820120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVeOmg3xdSp7Uw5iyCm8zM5Dz5FyKSpYKnmTGjHt5Og=;
        b=VBFPVDSC0c4rxWO4idhpCMlzoMP104ludumoYHtf979EhJL0NYKQKPtZnZ4VoiNdg3
         mObKrynBwa2GYQ8x1CdpPjYY7yYtk7G0pehHkjaSqcIkoUfodu25o36Hd4qKdYY8OzCv
         wPyzO9c7X8dI8pcQo957XHnT4phWgBIckCmoTN3pK3zvpqNv10hiIS/gtbpm6vGoFfnX
         nZLTl4/NjJHR0CQxytaExT7uHd7TT52JURX9IgikJhf2kNg00H/Wot7oMeAECXVr69Wh
         SoGYAg+Eh7uw7a92eNmFk3wAGvz47GLKWN3Lt1HWhmPvghEK+w6gYH71cuK//Xb1Dqmi
         HDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683228120; x=1685820120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVeOmg3xdSp7Uw5iyCm8zM5Dz5FyKSpYKnmTGjHt5Og=;
        b=Trd2YNoUVO9KR+V48V8CyRxy0XaZOO4c8XTH9AovKu0T3+yjTu3sRVTmlQTCXmh1dZ
         tqJ0LCPeQ1vGtAkNWvuLCkYpi7HDfKDAHTP+adRYBcqBhqB75RAHa3aKX/0Bgk9J12WB
         sQ7MQSLjzvYVOFdU4vTTVvYUyX3eJbiSQasFIj850gwJgkk+TgDtUug/Hl09KS+1nhgC
         TdaXIDx+v3SKpQK7/mR6hJQHAavDiuvrAxF48zjqaWaN3dl27ifCQHtj/KVflHhpyJYD
         L5DF9MofJvXE6oDKLf/k5QJgqlRplT3vyO4Lj2PQkE3YwZQw89xrJC+ZubXVrgL758by
         DZDQ==
X-Gm-Message-State: AC+VfDzA4qeGUmITAfozNQdo1RXk4Zriitmlt4MacBr2O2XLwpCirXBD
        9FPrubFroSebp5qDbT87WUVSqRlfUVFgZ16moTyXOg==
X-Google-Smtp-Source: ACHHUZ6uUxIDYifA/bh2RT8YQ5MNPwejTUWlOc93oIZLrxzI8RScUNDCnY1oAJur7+Djc/gO0llDoKdzJd/lv/zh45Q=
X-Received: by 2002:a17:902:d2cd:b0:1a9:3251:e3ae with SMTP id
 n13-20020a170902d2cd00b001a93251e3aemr27268plc.3.1683228120488; Thu, 04 May
 2023 12:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230310063910.2474472-1-saravanak@google.com>
 <4737cacc741c939ca1d980a4858d0748faad11f8.camel@puri.sm> <CAGETcx_0NaSTFFn34nvax2_pG+_5BJtOD0j0wrqU0NSCqwfKWA@mail.gmail.com>
 <CAGETcx-CF83Acp5CQ=RMJq9DD6f_Y70c37zSbLq2R6L5VyoKHg@mail.gmail.com> <nlycqgae2r3urwh536hyklyutmdzdoz3ssabcjqdfoxlqlbjln@5u5dr552albo>
In-Reply-To: <nlycqgae2r3urwh536hyklyutmdzdoz3ssabcjqdfoxlqlbjln@5u5dr552albo>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 May 2023 12:21:24 -0700
Message-ID: <CAGETcx9DnHUZa8986Mueu2O5s-Euvy5bJJSdRbLv0Og92PdKvA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/mipi-dsi: Set the fwnode for mipi_dsi_device
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Thu, May 4, 2023 at 12:51=E2=80=AFAM Maxime Ripard <maxime@cerno.tech> w=
rote:
>
> Hi Saravana,
>
> On Wed, May 03, 2023 at 09:40:05PM -0700, Saravana Kannan wrote:
> > On Fri, Mar 17, 2023 at 3:36=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Sun, Mar 12, 2023 at 7:45=E2=80=AFAM Martin Kepplinger
> > > <martin.kepplinger@puri.sm> wrote:
> > > >
> > > > Am Donnerstag, dem 09.03.2023 um 22:39 -0800 schrieb Saravana Kanna=
n:
> > > > > After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > > > > detection more robust"), fw_devlink prints an error when consumer
> > > > > devices don't have their fwnode set. This used to be ignored
> > > > > silently.
> > > > >
> > > > > Set the fwnode mipi_dsi_device so fw_devlink can find them and
> > > > > properly
> > > > > track their dependencies.
> > > > >
> > > > > This fixes errors like this:
> > > > > [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > > > > link with regulator-lcd-1v8
> > > > > [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > > > > link with backlight-dsi
> > > > >
> > > > > Reported-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > >
> > > > Reported-and-tested-by: Martin Kepplinger <martin.kepplinger@puri.s=
m>
> > >
> > > Maintainers,
> > >
> > > Nudge nudge. Will this be picked up for 6.3-rcX?
> >
> > Greg,
> >
> > Can you pick this up please? It's a fix that hasn't been picked up for
> > a few months.
> >
> > Here's the link to the actual patch for your convenience:
> > https://lore.kernel.org/lkml/20230310063910.2474472-1-saravanak@google.=
com/#t
>
> Sorry, I'm not quite sure what happened. I've applied it to drm-misc-fixe=
s

No worries. Thanks Maxime!

-Saravana
