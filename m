Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70370F6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjEXMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjEXMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:49:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23F12F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:49:25 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so190897a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684932564; x=1687524564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5bYhjesjBsxjaSysPkMJO99V3Ea7SCjBnlff9eYvbY=;
        b=onTMlDek1lsDHY/2PJKI0VAWe+DU8HN6eSloXlvlqwTOous0g0QLPwn3hDQQI13yAD
         HIM1jV0JJBftM+cgQnxKAQzOEODn3sFJAKAISIqWccqw2aglhzDolTqJ6pTo6j5vgl19
         FpcndoobY7T6vaOan8xI23GbfLlgv0yr/3Dt4B9w0vPH1ARv8fgpSDNjoMj43KFrj3u/
         sqodjWtr8pmA3VPhx9aXCCeh5+0B9yQ2PLUmsBCaE1pYym3g+G4YpAbeLlTJicHKQDIm
         XZX8e2AEQeEvsZFGb+7nabvZ0s0YF/krrDZQ0KzhrIZkBgd8dZit16/ib9GnHKn03IrR
         pn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684932564; x=1687524564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5bYhjesjBsxjaSysPkMJO99V3Ea7SCjBnlff9eYvbY=;
        b=XhDZMgr40FdTD5loYS9Axw7iS88hCDITUhsvJejOqzQCboKCOXxqWqn8wT4G4YQhxd
         z1/IuuKD5jZUah8WXA5qiDNtWlK2af1UrOeXddJBTI4Giq3cmGiHevZdjLVVy0uOvIU/
         OI3xXDLkFkN1tD88kS6ctwxgviuu0qzvcSA9kXTwIpqC8LLJ0zu2RjTJUj30gFJhqzb5
         5QT5bjMcm2iMzNs57PubCaoEaao1y4hGJVi98TUN6TuXAZDQEmTviV7Pb0gUuva0ToS1
         FoSovS9iIEfsJVp6OiHZEX7wYEcQ2p3nRexXEYHD3e1WPCsAxMEVCZ91jvp0zUgaW/7Q
         kK5w==
X-Gm-Message-State: AC+VfDzG69Y3ZQbYmU8XJg2itIPZ+M6Att1Lt0NQnVzPPiOmlFBbANHK
        K7qOL2VrE0yE9ZTXSPBGnfxk1dcNYPyL9D7A4d4=
X-Google-Smtp-Source: ACHHUZ5ItBNeHc1mocu63gt5yO5aEXFbBG2651LJcmnhZbL0sPpUsAqGOTVsQB5ww5tjO15bfmfDwMX/ev2ULfHLdSM=
X-Received: by 2002:a17:902:7008:b0:1ad:edbd:8547 with SMTP id
 y8-20020a170902700800b001adedbd8547mr15325761plk.15.1684932564214; Wed, 24
 May 2023 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com> <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com>
 <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com> <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
In-Reply-To: <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 24 May 2023 07:49:12 -0500
Message-ID: <CAHCN7xL2GWLTwMttCha=b9_W0nE5aimCQ08YJFrCF5vNZUOL7Q@mail.gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     Fabio Estevam <festevam@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 7:45=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Tue, May 23, 2023 at 8:49=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
>
> > Inki,
> >
> > I haven't heard back from you on whether or not you want the bindings
> > patch to be included with me resending the series as V7 or if you're
> > OK with a single, stand-alone patch.
> > Will you let me know?  I have the patch standing by waiting for
> > instructions.  If you're not the right person to ask, please let me
> > know who the right person is.
>
> Neil has also been collecting samsung-dsim patches. Maybe he can clarify.

If it matters, my preference all along was to do the bindings as a
separate thing once the driver updates were merged into the tree.
Since the bindings can be done in different ways, I was hoping to have
a separate discussion on the right way to do the bindings. If they
need to be part of the series, I can do that.

adam
