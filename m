Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E61705A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjEPWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEPWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:22:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94066587
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:22:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51f405ab061so1468087a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684275773; x=1686867773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgndSkZWPUZJRd5SeDV+wesFmdRbBGGTSW23rdoFQhk=;
        b=bJ9hO2NlZEa91lmCBa3cYU8I14iS+hJWAybKXcc7FB03ddDm4YR8cS/rc6QvI0dFgC
         FqebizI4rr55xrt5xaDss3aSzeIIjKJmpoAwW/Pgf2iXF4H1oJ2aoNScfMLNlSi7nOox
         CxeB8TUHSPRIf/FPwiDScm7LvUnl/uVClFNLHLB8KkKKArRAMkwf9kKmXViSzmIzvT4F
         mDd2izzOK7GNQrMDHF8BahFMmsma/ebBFIssqypHaJQKO+Soy9zwv+/H31WTS+e9ugu8
         dT+5AGLq1hMmffSfvDXlEVZ49QADAte8VVqvXSPSi950I+r1hoh659pHQfjXyWVFzNWZ
         fNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275773; x=1686867773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgndSkZWPUZJRd5SeDV+wesFmdRbBGGTSW23rdoFQhk=;
        b=LlYkr2pA1Hx5CrXASIQbkRzG8HqSqtP7DexoMd6dmp4+/1s9mwbW765DFwIE1mdb/G
         V2evzn1jH9npG1mwXEkkHpq4gupUcf2X2Y7GNPlrIRGHztfeDRy4CNeSpQzg26azOKLN
         K5HCuxcAQLKZOgHztLmrLccmKjUtLM8JOrdr5QLk45vrQQ65lqGtMkwa6ar+t+S3hDsZ
         mqmYvIVaZcD+dlsYkXHin8slFDwioIWkBpPpy2LFRJwF6uJu9AMqgNnNjd7Ih3r32/KQ
         HeyLQw0wE8VVnTIJckz62QjsgjKmj+5Aq2GSUH5GhvK+ir6fsuUVcnIYmBvTo6Uu9GL7
         HESg==
X-Gm-Message-State: AC+VfDy/wwceXmcZ3Vm1uO+lRdTObFbVjchPDLE0A+3yvvDrRBW7vYVD
        jsnEtOdrGH+PEaZF8NBhrLZ57tFrrPEtpTyJF2s=
X-Google-Smtp-Source: ACHHUZ5v3JODxPaa7E9Q8oh+wX3LOQN8E+VuPC6vcFXbf7bbRYgANWsaCx57oSVFDguecOp2V8QpEwUSjuwgaLWtlco=
X-Received: by 2002:a05:6a00:2489:b0:64a:ed6d:53ac with SMTP id
 c9-20020a056a00248900b0064aed6d53acmr683963pfv.2.1684275773179; Tue, 16 May
 2023 15:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230503163313.2640898-1-frieder@fris.de> <20230503163313.2640898-3-frieder@fris.de>
 <2225400.iZASKD2KPV@steina-w>
In-Reply-To: <2225400.iZASKD2KPV@steina-w>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 16 May 2023 19:22:41 -0300
Message-ID: <CAOMZO5AiWM64tZgArUL89q5spuLD91R-pnURbfqPU9O0w54sQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi83: Fix enable/disable flow
 to meet spec
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Marek Vasut <marex@denx.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Frieder Schrempf <frieder@fris.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 6:12=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Am Mittwoch, 3. Mai 2023, 18:33:07 CEST schrieb Frieder Schrempf:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >
> > The datasheet describes the following initialization flow including
> > minimum delay times between each step:
> >
> > 1. DSI data lanes need to be in LP-11 and the clock lane in HS mode
> > 2. toggle EN signal
> > 3. initialize registers
> > 4. enable PLL
> > 5. soft reset
> > 6. enable DSI stream
> > 7. check error status register
> >
> > To meet this requirement we need to make sure the host bridge's
> > pre_enable() is called first by using the pre_enable_prev_first
> > flag.
> >
> > Furthermore we need to split enable() into pre_enable() which covers
> > steps 2-5 from above and enable() which covers step 7 and is called
> > after the host bridge's enable().
> >
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> #TQMa8MxML/M=
Ba8Mx

Should this have a Fixes tag so that it could be backported to stable kerne=
ls?
