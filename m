Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090CB6622B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjAIKN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjAIKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:12:57 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF9211462
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:11:45 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id k4so8035474vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl5gtLkelHYob0yvxLrGJZ0WToOte9ATFrvdQKICgVE=;
        b=QNMyZmEv6uPuj/qm5nlVIOi9oLDwVoh7ki5s2SwsVlxB8Qa7tRd3oTaIfeHbBD+Dd0
         a0R6oWjAg772gZCDdeUZDLbwtzO1YittETMC244DFqNxDyLX+C4+Xktl9Qt7T64NE5Xi
         grJsVq7rhsC/EGWaUlY5lp6ayREbcqt4h6wMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nl5gtLkelHYob0yvxLrGJZ0WToOte9ATFrvdQKICgVE=;
        b=01YWaW3h099j/fBfGZHiPe93THcFTBbZkZKW7WJnrVQr5pqFwVbo1GgpK3Rl5bcVVL
         4mtFSBtevRTqSpYV8zrzAhzxe4OOf7aPLQl1ThqoHNheFK89LPVZRaY4FektM6TJZlnv
         f7KSnCuVAisPiIno0NN8ibuEVJyfMPi8vUnpD7R5JRv9rIQgR/QFgX/U+mGyt5f+CjZJ
         624JA0n0P0OlKm11TRbYCFB6jNKdUztxtCuva+PgTU9P3KGEi9WqmPJadXm+Ky6Lm9hK
         HFAP7RGZpzaiv0FBjcndkYXPexVjPeXrF2nNTrmUtjcdXG7KyIwhJKSjYG/47V3Rz9TU
         1H0w==
X-Gm-Message-State: AFqh2krC47GV1VzAh7G8JjoRKHBy01ugUGT5+1qWIyAOsziIYRTet3VC
        RKVqCS+otIXBrcqWxgpjy9wTVmfKWGEnPczcPTdKCw==
X-Google-Smtp-Source: AMrXdXtcNn1bVy1ULhiaYChXgRMGkSnSLx4444KzFv+N7rK2lYGkipv1i04e7jLkrmz585HPK6nXmJX0twUwXvIgfVY=
X-Received: by 2002:a05:6102:374d:b0:3d0:af13:3b6 with SMTP id
 u13-20020a056102374d00b003d0af1303b6mr141886vst.65.1673259105126; Mon, 09 Jan
 2023 02:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20230109084101.265664-1-treapking@chromium.org> <20230109084101.265664-6-treapking@chromium.org>
In-Reply-To: <20230109084101.265664-6-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 9 Jan 2023 18:11:34 +0800
Message-ID: <CAGXv+5GnLhUfdDzDQ2Y1Hb7gb+rjZzMhLU+38MYR+VHRdUCtkQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] drm/bridge: anx7625: Check for Type-C during panel registration
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-acpi@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev, Xin Ji <xji@analogixsemi.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 4:41 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> The output port endpoints can be connected to USB-C connectors.
> Running drm_of_find_panel_or_bridge() with such endpoints leads to
> a continuous return value of -EPROBE_DEFER, even though there is
> no panel present.
>
> To avoid this, check for the existence of a "mode-switch" property in
> the port endpoint, and skip panel registration completely if so.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8192 based Hayato (ASUS Chromebook Flip CM3200).
