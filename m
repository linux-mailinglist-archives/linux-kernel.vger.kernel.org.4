Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490CE62E6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiKQVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiKQVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDBD85ED9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:22 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so8317242ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H8azmGXIzeJiOhQpt5DFohCPxp1zDOuXjCtNAqmteBs=;
        b=K22a6BoFnPxV6N5ez/90iIJltU50Hl3k+/slP43Q/9IymNZe1iJFK14T8sfCc48yI1
         9Bw5ItYztLZhwKt4GjaTuhiMqHLt9Zke7s575opvOGVXlWw8yiv0BAn+cxNW5KNRb6YE
         BAIFRlv9h/+wHI0q1Mj9gR0JloFw7GlSyRNeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8azmGXIzeJiOhQpt5DFohCPxp1zDOuXjCtNAqmteBs=;
        b=nuG2H/qXcFDd+tQNHshbvZQbHZThnCulyoJ5H17Q52tQL4pNhcagUaNDjWn6kBLC8l
         ixFDuYG2iOcnYJAd2wmOKoem61InQpPfwlvPZXL8zzfbmin7sjpnuXCib1jUbhHsszwT
         uhCN8tLzwkDj+4SzAf3kcTT1e1XsE9BjgBdpCm4MTlvascXAIhiqyepMxpwZ2BEQN1rI
         q80x6ZiEsl2ALZUuvml/ixQKUHM2sBwq51JNoGOlFfHd9JaSQvTw4A/7SKCkZXnDpmD6
         uhmrVHk8U6OqQBYdcbDuiA2JMzD0/4fohb6h5WQ1CoqtsEG5sPWVcLbFQTgxLewxKNjP
         Km5Q==
X-Gm-Message-State: ANoB5pmgm7P5/vut17M5tJu6d9Srw6I9L1I8mPyPH4QyKQB9GYNVx8JR
        0W4EQY2VZrmuxBV5v/PISmDRoby8JLC7BDjP
X-Google-Smtp-Source: AA0mqf5Hqu/JSrVyA2GiruMSSmiAZfG1El2pBbQaR4NVPkNBB0cyrjdphD9FBiQ1R+HPmEBwTotgNA==
X-Received: by 2002:a17:906:cf85:b0:78d:b66d:749f with SMTP id um5-20020a170906cf8500b0078db66d749fmr3506857ejb.566.1668719721015;
        Thu, 17 Nov 2022 13:15:21 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id h2-20020a170906260200b0078d38cda2b1sm817694ejc.202.2022.11.17.13.15.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 13:15:17 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id a14so5972908wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:14 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr2510203wrs.659.1668719714379; Thu, 17
 Nov 2022 13:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.5.I96ce2a565ff893eddcbee70174c991179311a3ae@changeid>
In-Reply-To: <20221117133655.5.I96ce2a565ff893eddcbee70174c991179311a3ae@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 13:15:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W_P3BbxRsPH0vQ4qRW_fiyM+u7RzRj+i0N9G3_4Zhtcw@mail.gmail.com>
Message-ID: <CAD=FV=W_P3BbxRsPH0vQ4qRW_fiyM+u7RzRj+i0N9G3_4Zhtcw@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/panel-samsung-atna33xc20: Extend autosuspend delay
To:     Drew Davenport <ddavenport@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
>
> Avoid the panel oscillating on and off during boot. In some cases it
> will be more than 1000ms between powering the panel to read the EDID early
> during boot, and enabling the panel for display. Extending the
> autosuspend delay avoids autosuspending during this interval.
>
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
>
> ---
>
>  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
