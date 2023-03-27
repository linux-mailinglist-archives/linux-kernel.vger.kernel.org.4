Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE486CB0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjC0Vfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjC0Vfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:35:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7127A2D45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:35:32 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i6so12593153ybu.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679952931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFrjOiyw9NOJrCSELCRF57j8yyvcTUmmRYnuJvEzIrM=;
        b=UL7ZgfxSqK1ZVr5QxWWxSlIbYG5Zcsz0bLJV+X6mz8FkUneICpW4a+FfqnapXhkZxm
         kb3DeNSBC4TgbjscjYhPQahw/OZiLfk4SvYOF4RQVodvE7mM1SrgUSouhVfZrQGooIcm
         +6ZzpGReDSUxyRsB3nJTG+Fd0C0hwiFpg+d/bWENPCrrFgj/mxw0rjKfzO+Y7FAx5cDT
         TRfe8kzW/9zGnyJdSs8MXsst2L1dgisdSQKk2cxxKq0sV3n4ehKPPcppq1d13cUO0mT4
         lCdvh+pFClRdmQ62l784Ii1kWulyRhugxuXLsNGVn1b2A6iDdZRTLhG+VBPWjS/NYzea
         3CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679952931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFrjOiyw9NOJrCSELCRF57j8yyvcTUmmRYnuJvEzIrM=;
        b=0bDfBW4x2wFKk99Hnn2e9l7Ztm4DgBwvzF9aNI+a2pDIZUWrDBY6msAxX5etAeZuzo
         Fx4rfiPaX/8PuIfwpTzFvlKz52NYqNpTggowd/XLynaTCT2YzbTFUc/5a2/TqMAUQZDg
         BcFOjjxJ3YtPSFAeBBGZJRc64YdesD0foduNJ4X27grEhbTV72x4hfY9IkkyrHDxzwOZ
         U1z+XdrUZ3C1f9MMec1CUJ+5EroVFCu01l+q9WEVHnKKD8zEpSOFCo9wn5Z3Bkzb2wp7
         iLD+UBPEZsP2KCWqtcyQCCoM93YHn3NwwRY4Yx8GklMmPw7CNYa12+o0efUmVV0dTkOO
         UkJw==
X-Gm-Message-State: AAQBX9fo037NxwVMyuI5Fdpg80qCyGceljRnNXJsvc8PaKvQmjzjjJOs
        KArWJ04qYT711Vw/Rvo6R+aIVTqB5H+B5N8FTQKxTQ==
X-Google-Smtp-Source: AKy350YwCN7aEsQ4PXJbvf3lkx+vF+xXWizPiHiEaONkOLg4Wr85I8hFqVdUbKX8IEbw3PzQq5FuqpOCUFqGKlbHlbg=
X-Received: by 2002:a05:6902:1145:b0:b09:6f3d:ea1f with SMTP id
 p5-20020a056902114500b00b096f3dea1fmr8142319ybu.4.1679952931656; Mon, 27 Mar
 2023 14:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230327062754.3326-1-clin@suse.com> <20230327062754.3326-3-clin@suse.com>
In-Reply-To: <20230327062754.3326-3-clin@suse.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Mar 2023 23:35:20 +0200
Message-ID: <CACRpkdat=069ZyPL=w1_z6cNZ4EbVvG==SLcnT-pmsH6zhqtpQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] pinctrl: s32cc: refactor pin config parsing
To:     Chester Lin <clin@suse.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 8:28=E2=80=AFAM Chester Lin <clin@suse.com> wrote:

> Move common codes into smaller inline functions and remove argument check=
s
> that are not actually used by pull up/down bits in the S32 MSCR register.
>
> Signed-off-by: Chester Lin <clin@suse.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied!

Yours,
Linus Walleij
