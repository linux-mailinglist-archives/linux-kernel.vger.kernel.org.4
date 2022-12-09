Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6B647EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiLIHuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiLIHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:50:15 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476250D41
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:50:13 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id n21so9578230ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 23:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjjFPoqzd/I386qTYEsF5a4KDlxZGcCC/aN168YsJ14=;
        b=W3pw3j2e8cWlRVKdu6o1VpBw3wbL0rK7ISTQYou6fmx7ImKH/ye4SN+9QJ/JqCNnQ3
         VvbRBoyrwfQLlfrMIB7vLnIbfdU2iMRGODCz/b7lG+1xxvgEdrm/rM3/jI8qruVzdF1g
         ag5/XhWuYtdoUg+nOw6Y7hCkuIAQy/rGv1tN92D8uYfzDNBke0sUzDr8gYG5uuzM/Mqs
         5P6CqGBRIQtSU5Mh1j5NKpSsKo+fh38qWd6t5WCk0lrmsuXYH5uqfIusvnR6C7GtOydr
         TEvdCrqp2HA+jPLq4pFvLjbYctRFGXlUulWyPR3sPWW5rLtVW9vEuxu9V4lNkxlxHCzF
         pnYQ==
X-Gm-Message-State: ANoB5plCYIhL+RdJQlklWhuTqb3lHmTDKcRrQkQIjENukTD8qeE4lLZa
        QI9bIhLVF41BNh9HWzm2PstjJBE9j+RIgQ==
X-Google-Smtp-Source: AA0mqf57WqAXpPOkgxQiPjfto2I2XV2PeQmjGKKQLNosgU/TexDAzaGt2N3sk61+8GpUM3aAKXEh9g==
X-Received: by 2002:a17:906:2552:b0:7ae:5e5f:58b1 with SMTP id j18-20020a170906255200b007ae5e5f58b1mr3831949ejb.53.1670572212035;
        Thu, 08 Dec 2022 23:50:12 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id kv5-20020a17090778c500b007c0d4d3a0c1sm263590ejc.32.2022.12.08.23.50.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 23:50:11 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so2791604wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 23:50:11 -0800 (PST)
X-Received: by 2002:a05:600c:4b1b:b0:3d1:d771:373 with SMTP id
 i27-20020a05600c4b1b00b003d1d7710373mr10715772wmp.18.1670572211080; Thu, 08
 Dec 2022 23:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20221208220225.635414-1-aren@peacevolution.org>
In-Reply-To: <20221208220225.635414-1-aren@peacevolution.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 9 Dec 2022 15:49:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v665Lfx3OPpWzvYcicqQt=ehfEVaheXxH4kwsUE8X-g3Cw@mail.gmail.com>
Message-ID: <CAGb2v665Lfx3OPpWzvYcicqQt=ehfEVaheXxH4kwsUE8X-g3Cw@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: axp20x: fix order of pek rise and fall events
To:     Aren Moynihan <aren@peacevolution.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megi@xff.cz>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 6:20 AM Aren Moynihan <aren@peacevolution.org> wrote:
>
> The power button can get "stuck" if the rising edge and falling edge irq
> are read in the same pass. This can often be triggered when resuming
> from suspend if the power button is released before the kernel handles
> the interrupt.
>
> Swapping the order of the rise and fall events makes sure that the press
> event is handled first, which prevents this situation.
>
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
