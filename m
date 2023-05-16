Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044F9705AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjEPXDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjEPXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:03:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A57EDA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:03:09 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so13622200a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684278186; x=1686870186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXAXcPnEMhyYXSrts+BDCr1Z/hTfqLKKX238n2NzWBU=;
        b=ZaYI444pbrAJnKuwwB6FmMd9/+7vA6m7aqpKO2KB4K6wpdOuVTJ4peS7vqlo+sBOJl
         psXPnW3stkR6RTjXBOrJuAf35iRFHABoze5Ct/0zSl6fVZCqfqNTbNwaUlIPgdjE83r0
         uh5cUW/eg1hB2fnztcH8412WRfoun9sJOllYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684278186; x=1686870186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXAXcPnEMhyYXSrts+BDCr1Z/hTfqLKKX238n2NzWBU=;
        b=YJuz5d9yua/UqUQVW2y1CT5ci07S/4+NDjU5oKHYtHsDb5KZrk6ZXaOKTpjFlNN/fu
         NAOXJpLSR4BDjCBj39ZUVFUSucalusOnxc/n/fDCW6jATemG4gCRok3OmTRm3tafn85K
         Ql7K6p3/c72eAmuUKWBAIn2la2qPnL3myyLACJ+1AeUrUT0SSfWugZt8CUrrFZB1RwqZ
         131grhX/wF39pZ8fkHlLCQ5uzsGGcVNRZcUkx+lD2/mXD9L7/MQs1w6iy3DQzqCjL80H
         Nq1bMwazZW2f+wlOdJS/Epq/rbj36wLri+IS+xBs2zMqMa+DIwK1Zva+xQimDg3NwP+J
         82DQ==
X-Gm-Message-State: AC+VfDx3xiZTrntFF6aLwznKtL8nMPhgi4Zo+V0pXbIteXyRu+RlQz7m
        JOm+XcAmjoZXyZXUvXY+HLLOt99UMlEJn2oXlEc=
X-Google-Smtp-Source: ACHHUZ7xz1gnW///g3XubTqAxPSnquKcyBrHwDBikjLZgpnPk4M0op2ghS3Owgas3I93qUw1n9XCtw==
X-Received: by 2002:a05:6a20:840f:b0:106:8b:99cc with SMTP id c15-20020a056a20840f00b00106008b99ccmr11790630pzd.45.1684278185816;
        Tue, 16 May 2023 16:03:05 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a680a00b0024de0de6ec8sm111966pjj.17.2023.05.16.16.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 16:03:05 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1aaf702c3ccso12355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:03:05 -0700 (PDT)
X-Received: by 2002:a17:902:f0cb:b0:1ae:4008:5404 with SMTP id
 v11-20020a170902f0cb00b001ae40085404mr136910pla.0.1684278183867; Tue, 16 May
 2023 16:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
In-Reply-To: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 16 May 2023 16:02:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W76Skw_OFezBRrGf5SZtpMOgtV0S-HVcWmbrmAvFL7vQ@mail.gmail.com>
Message-ID: <CAD=FV=W76Skw_OFezBRrGf5SZtpMOgtV0S-HVcWmbrmAvFL7vQ@mail.gmail.com>
Subject: Re: [PATCH] SoC: rt5682: Disable jack detection interrupt during suspend
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Stephen Boyd <swboyd@chromium.org>,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 16, 2023 at 9:47=E2=80=AFAM Matthias Kaehlcke <mka@chromium.org=
> wrote:
>
> The rt5682 driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap
> in cache-only mode if the work runs before the device has
> resumed:
>
> [   56.245502] rt5682 9-001a: ASoC: error at soc_component_read_no_lock o=
n rt5682.9-001a for register: [0x000000f0] -16
>
> Disable the jack detection interrupt during suspend and
> re-enable it on resume. The driver already schedules the
> jack detection work on resume, so any state change during
> suspend is still handled.
>
> This is essentially the same as commit f7d00a9be147 ("SoC:
> rt5682s: Disable jack detection interrupt during suspend")
> for the rt5682s.
>
> Cc: stable@kernel.org
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
