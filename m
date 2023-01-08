Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B978661471
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 11:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjAHKDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 05:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAHKDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 05:03:51 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13718D11F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 02:03:50 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id h21so5602747qta.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 02:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp2Y/oZcaRM1jCxieWIWnVWN7O8i1Vi5kHffRAbB8Ac=;
        b=u8arBepIR0wh9daP0F2ElSHEyV0vEAJSov/UfLNTQUmCPtBSbsWeB6Dg1XciiHxGUe
         V3d6JyTR9hBj7Yq+oDSdNwGQ6gWjkRYptIz6WANnfqTU6U+6Mv9UjTz4y+2bjhELAuLr
         221kU6U+JsxmGJHvTgtG69Wtr2zbnylWNev/YZsLWWJiEz1MAUiGeLEkrXMlGXAATPUH
         sW6XqFuISn52iORSs/lDXbU69K7Lhs8XmtFvQZ9KHDIQUezie5VBfv6vXBKxMPSF/WY+
         SLSJwA3sR6NkMF8cKeeGIa7LGeOli1bTT0CaRkUYzj5NyETINrVfo+pJ07a8jyvPtqrD
         HFZg==
X-Gm-Message-State: AFqh2koaKVncB0WLt5ZO2CtGDWUvqo0nRWOmOl2gBq8tE7waJ92SX28E
        kb9xyrUBEsCodss+cW6Y7c5gOaG+s3gldg==
X-Google-Smtp-Source: AMrXdXssztVrIvx2tchyNo34NS1QpYa06/fQZsBC3vffcd93juKxykY9IfaiEvrdbpkByR3Xxy3CLA==
X-Received: by 2002:ac8:4792:0:b0:3a9:7ab8:a962 with SMTP id k18-20020ac84792000000b003a97ab8a962mr95170412qtq.40.1673172229035;
        Sun, 08 Jan 2023 02:03:49 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id r3-20020ac84243000000b003a5430ee366sm3033337qtm.60.2023.01.08.02.03.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 02:03:48 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id l139so6023110ybl.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 02:03:47 -0800 (PST)
X-Received: by 2002:a25:d84e:0:b0:7b4:6a33:d89f with SMTP id
 p75-20020a25d84e000000b007b46a33d89fmr887470ybg.543.1673172227766; Sun, 08
 Jan 2023 02:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20230106143002.1434266-1-steve@sk2.org>
In-Reply-To: <20230106143002.1434266-1-steve@sk2.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 8 Jan 2023 11:03:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
Message-ID: <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
To:     Stephen Kitt <steve@sk2.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 4:10 PM Stephen Kitt <steve@sk2.org> wrote:
> backlight_properties.fb_blank is deprecated. The states it represents
> are handled by other properties; but instead of accessing those
> properties directly, drivers should use the helpers provided by
> backlight.h.
>
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> This means that BL_CORE_SUSPENDED is now taken into account, as it
> should be.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
