Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEDE647427
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLHQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLHQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:25:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E16245A30
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:25:09 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id v82so1893945oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yZVkluqAdglv3EHsLew8wJwcBKXP+wP1Mag/KxLQSs=;
        b=BwVeuTcDfLSTZrSjHLuiakOSC/ep0V894NkRCoK2REUB+BrRF44aU6WBZYLRR/o22Y
         RW/1ubGJo3HH9lchcD7+iDu5BqwWRYG+X95kDv7FlQZaxFiBas9FqEr/x6p0XA1vNCxX
         E5PXUqCRBCtl7655B0ylUIR0VYqg31TcsQWuYrP8R/84h0kXyYVMOte2Utgze1zzwCyn
         ZJzHiwc3bZB+4RJoqRHYmmQJI9lLaQOxQKXD2evVZa9qH8JRM/SRPfiNDqihA6oNBGfk
         PhpCROGKVTprqzZ/d3Ccc0fWb06c6dJhMgCCSWudElinuCpH/mdZhOWLZE7e0FjaDXSC
         gqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yZVkluqAdglv3EHsLew8wJwcBKXP+wP1Mag/KxLQSs=;
        b=CN+0Gz3VJ+NNRmBupaX4UlGR3awgGhD18l5GMj+amV5ehvACzlAUXy6C1iOwiVyyV3
         jtGjkuJ1+iTCYL5tMZXbiER2vgRE5yE/cbRsyPTP4r1ZgZjX7VDI3uv1jBuDRwWHDkiZ
         +sil7gMGVrXWberv/Xk6WYZDrY9PxFpVZHX2ExWkZWHgEiWp43gGISCkoEBnwbS3UAqK
         JRey2/AMHil9nPspHusuEh40JecTXDEdE2jn34wj91tnGSw6HASmI2UOXGagQhd0oChj
         LMv28k5F4bWu6ROO8vVj0wzuRuB6EGc44tB6DCZbCYZIIYCcqkwvYsDVwMuYGMyQeAP7
         riyA==
X-Gm-Message-State: ANoB5pkmA3vhZ9/TX+LS13LT1uneVahTB9xzc8S6L8QX8JsYtgnEpEds
        n8xB4PY293W5gX2GE5LY6zWgc9WQ4WUjUT8aj8MDjA==
X-Google-Smtp-Source: AA0mqf4AGcBT2ckDS+9n6KwnkfxRKsMyC4j/w/jAEFBJz6mZglLyyJBZW80DLb9+SkYzh2t28cqWas2cjJtQ01z5kPM=
X-Received: by 2002:a05:6808:143:b0:345:8913:17ae with SMTP id
 h3-20020a056808014300b00345891317aemr37409795oie.155.1670516708636; Thu, 08
 Dec 2022 08:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-20-uwe@kleine-koenig.org> <20221207141546.tvpbgmjej5kmoxtm@pengutronix.de>
In-Reply-To: <20221207141546.tvpbgmjej5kmoxtm@pengutronix.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 8 Dec 2022 17:24:57 +0100
Message-ID: <CAG3jFysqWgknBW4hVHvyxFMQi=e_91bQVatXXaNsQtfUETQT8w@mail.gmail.com>
Subject: Re: [PATCH 019/606] drm/bridge: chrontel-ch7033: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        kernel@pengutronix.de,
        "linux-i2c@vger.kernel.org Doug Anderson" <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 at 15:15, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello dear drm/bridge maintainers,
>
> On Fri, Nov 18, 2022 at 11:35:53PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >
> > The probe function doesn't make use of the i2c_device_id * parameter so=
 it
> > can be trivially converted.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Do you plan to pick up the drm/bridge patches in the upcoming cycle?
>
> You could do that using:
>
>         git pull https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linu=
x.git i2c/client_device_id_helper-immutable
>         b4 am -l -3 -P 14-35,37 20221118224540.619276-20-uwe@kleine-koeni=
g.org
>         git am -s ./20221118_uwe_i2c_complete_conversion_to_i2c_probe_new=
.mbx
>
> Note that Doug Anderson already applied the patch for ti-sn65dsi86,
> which is patch #36 and so this is skipped in the above range.

Applied to drm-misc-next.

Feel free to grab a hold of me out of band if you hit any snags like this a=
gain.
