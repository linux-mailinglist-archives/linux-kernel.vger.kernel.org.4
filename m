Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092995EDEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiI1OWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiI1OWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:22:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5289A9C0E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:22:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so4597505eja.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WGcuGfkA0NNROaRfJ7RegLwzZPlW3SABFiduRXSBKF0=;
        b=ihxwsYc23t+RIPEj9ErW4RTMh/idLnefTnL5RE3Yp0QEI2poOaZ0NjHNTztTXBCs9H
         EgfbWFYvsJ9EZyVVIfCZ5ZG5/y0wFDSxsMjSvwJlJHnLHfwezvz7t9xs5i66D5gWbUHm
         z/5HTwCM6QbNfGK503ZkGk9iuBP9+BjASLeXvEUpYdzUqsrdGSrIc80YQshx7Sxhx4x6
         b1o2WaiZP7aVGXvz+AIEoSCKsIL8p/yAH01OzWw+Cm/P3POjP1wxhApxrsNjztgLoMF3
         5xhhRvMvgMBrHgv0bO3pOfaXtQI6IBke9biCWyKJNsAbYjEC3c+QR7Yq4rq4x0I66N14
         Ip9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WGcuGfkA0NNROaRfJ7RegLwzZPlW3SABFiduRXSBKF0=;
        b=mn04lQH58Q25It3JDFZR0Klicn54YPPlqvplR1SYlskI+oH14GaFPBDKymSarTYoKr
         mddgQDEt0upc/VafPjc4G+fdw+IpU6p6FEyqDybQCOBfUW027lGotxFxmN7r8nxdyl40
         uRZSMRXPB4rNfL9t2ZMN7T8hh3ZXi0NSJedYhp7O1y0zcD/14Ia+Av1gKjkZiHpKyckG
         MUgXkIu7lefyBqZnoclBO5PK+ASCpsDczATbw4j2NiDmWfxm4UT4oudI88bUr+viHQth
         ircajek4N1IhWwHqpCN7XRn19gjXTYeuDf8r+US+Mjhbd/Iy76s/1qblZrEbrudoRpfA
         diJQ==
X-Gm-Message-State: ACrzQf13EJA+ymqP9itc6hM4Vyvsj8pJcqpGUz8kaOHhBfBcrrsxXAFv
        j8YY+YqBddcW3sZ9uuoFsBZAnl67SZz/lxaWJZsyhw==
X-Google-Smtp-Source: AMsMyM7SALhgOzAjbIZo1w1hmRcT7YJOAI6uYBsKyg2LUP0qzO21ocvpCKgqsEX0jKpE40cTUXKhDcGECF2kx66wlmg=
X-Received: by 2002:a17:906:730e:b0:783:87a1:b5db with SMTP id
 di14-20020a170906730e00b0078387a1b5dbmr13751710ejc.383.1664374965417; Wed, 28
 Sep 2022 07:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220922124306.34729-1-dev@pschenker.ch>
In-Reply-To: <20220922124306.34729-1-dev@pschenker.ch>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 28 Sep 2022 16:22:34 +0200
Message-ID: <CAG3jFyuziotbv4F0EaKbrgOqbXZ1fDSi_T=CB2AufyjrUMqmRA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/bridge: lt8912b: Fix corrupt display output due
 to wrong bridge config
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Philippe Schenker <philippe.schenker@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sept 2022 at 14:43, Philippe Schenker <dev@pschenker.ch> wrote:
>
> From: Philippe Schenker <philippe.schenker@toradex.com>
>
> This patch-set fixes the lt8912b driver that currently does not take
> care whether or not the attached display has postiive or negative syncs
> and or reports on EDID if it needs HDMI mode or DVI.
>
> This series addresses also an issue where the LVDS startup sequence was
> written to the wrong I2C address (the lt8912 has three). This caused
> writing into reserved registers and causing an unstable HDMI picture
> that manifests itself only sometimes and depending on the monitor with a
> flickering and a repeating of going black and coming up again. While at
> it move also some sensible comments to the sequence.
>
>
> Francesco Dolcini (2):
>   drm/bridge: lt8912b: fix corrupted image output
>   drm/bridge: lt8912b: clarify lvds output status
>
> Philippe Schenker (2):
>   drm/bridge: lt8912b: add vsync hsync
>   drm/bridge: lt8912b: set hdmi or dvi mode
>
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 39 +++++++++++++++++-------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>
> --
> 2.37.3
>

Thanks for the series & the reviews.

Applied to drm-misc-next.
