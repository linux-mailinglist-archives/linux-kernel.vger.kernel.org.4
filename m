Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12A72DFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbjFMKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjFMKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:38:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A8129
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:38:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30fa23e106bso2764315f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686652728; x=1689244728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6d+VLj6m3MAAbwrIUd63IBRinbYN+a8k/C8reDLCUoA=;
        b=hgjHCdmVZj17ygZWDKclgn2+Ytse1qSnmaG4LRvuBitz3LJyh5HgOVAUSo0/r7wbdt
         fdSIKGBQtVODe5/DiwzNAY75tQn14eC3cn9Q2yhq2toPlE76Oa5oFJdV9l1XnL0YG0RH
         fxvfeGPQ4hK4wvvH1FIqK7kR5+J3EkpRC2wIwVTAmEGdctNMUqczSpR/pqHqlcdrvXNx
         w+5FbTeVgBNFZVVGyto35QUzWBVlGziPVY46F9DgTYoTMe+PwdW3jVov2buriiM7Vv2s
         PvmiMKy9I+IiUkPF6osBSwKSkROBznVLomANfzqMBfERLZUvUZy0htIwFzMk6D4nAIGS
         /3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652728; x=1689244728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d+VLj6m3MAAbwrIUd63IBRinbYN+a8k/C8reDLCUoA=;
        b=gnQRtT3/jum6FLjiWcBTff9Iu48HKVvADwEAyeS5HbPR56LMzS+YqFVHPlbr3Mkw/l
         6wDAVwjd8optuSFf59sDVfva5spJ/P0Al8bwWczNVCMuN9S/HKcgS2ItF49uUA4hlbVF
         MyBP6mB3+AoRvh7S6glEd8MgzwvJdde0zimiRdvR9PDOdUVHiZSlC2AAMWg6ouEfU8Ro
         E5kSj+9b+l3OKD0hkRT2Mct0TwrEx/NeKNP6/XByUiGJpMvLNBRN3z4K0budT85rGdBK
         BiXBKqhc1v6DOSASqjhlibqQT+14nRNdL+FtviMirNMiJZB4gCU7Yw8tw48HjNjpAcFe
         ADCg==
X-Gm-Message-State: AC+VfDzdG5v9i8lJQl8UfLXZplBqom3/06H1bRssQKcEG66FjDcCTIZR
        IRay3QMWcSvSfTsHKlxSGe6sMaz05Ucj69gzRg7q8A==
X-Google-Smtp-Source: ACHHUZ5HGIJRgD5nl4Qh50NEPcobvGP0CTVSW1VYZZsJoGlj0SicoFaUzO4TaUafxBw4qtclMnMW2w==
X-Received: by 2002:a5d:6a0b:0:b0:309:46a4:6378 with SMTP id m11-20020a5d6a0b000000b0030946a46378mr5778964wru.12.1686652727984;
        Tue, 13 Jun 2023 03:38:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f9-20020a5d6649000000b0030f9dc63ff1sm13001387wrw.88.2023.06.13.03.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:38:47 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:38:45 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        jingoohan1@gmail.com, dan.carpenter@linaro.org,
        michael.j.ruhl@intel.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 03/38] backlight/gpio_backlight: Compare against
 struct fb_info.device
Message-ID: <20230613103845.GC169438@aspen.lan>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-4-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:07:41PM +0200, Thomas Zimmermann wrote:
> Struct gpio_backlight_platform_data refers to a platform device within
> the Linux device hierarchy. The test in gpio_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
>
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
>
> v2:
> 	* move renames into separate patch (Javier, Sam, Michael)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-sh@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.12+

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
