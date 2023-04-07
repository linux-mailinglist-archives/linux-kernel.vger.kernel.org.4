Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1826DB5F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDGVyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjDGVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:54:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0A1C66D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:54:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a44so25985616ljr.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680904458;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUf+hItRUlAyl8Odc+K+o9OQqV17J58V+aP3v0kFHhk=;
        b=HDRfRiwyLM/lRXtziEze5NRPh6rgRw/JeQ+qfRM5Cqn7guhS0gRrdgIW9xOpT8Raw8
         N+2IxIYkZudLJOb6CMyliOjZ092IoXrAieqLEVohPUzsgrFKfLb9g6iAhCLHgoq4qgY4
         QkgDhMcrq2aCU/C+7DEu248Jfb3qILitbqCwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904458;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUf+hItRUlAyl8Odc+K+o9OQqV17J58V+aP3v0kFHhk=;
        b=Lr/U44Dw0R9Lsdnz7ELRQVcHem/aED4Wft689MFdteTzbgn3cb4BLluLrV3CmKkuBu
         phpJq+gzkp3lqrRaKJ1cdUgmMG7+CTuVlYyGNDtbDQmCvEvRMtr6qStVj6ylf50WsIyM
         tbcTGbYHHnIVQDkMxZwK6mjrFpriIHrMwEV5UbGB93poU9IGD3jOiNiWLi1Tu3Zf9ks4
         W6o/oOKucAgV1d0hIxnoy6uFDtzesHF64G2zfidGgmQ+dS8ANuE1ody37CmKftVMz0D4
         Lag3R8s27bQOrpIwFqNatcAQFMGfnvg4MllZ2bpt0R6S8LJUchft1i71ematI2XyrH31
         ca3g==
X-Gm-Message-State: AAQBX9eDWHdUNQ2Sw8b1fPP86g0nVApN2y5gU0E9Khp9MKqvyjUtg/BJ
        UBiOFWUGFutV+KsF4leAe81+YOUAI9BkE7xFSCgTtA==
X-Google-Smtp-Source: AKy350bK2tfa/ifMpJd99S5lA9yyNvRN8J9D6TZLrauRv7sSWhzgZZFM6h20BylS5hhLgn59vMCdcBgqoUJ4xAgeXvY=
X-Received: by 2002:a05:651c:1035:b0:2a5:f6f2:1ff4 with SMTP id
 w21-20020a05651c103500b002a5f6f21ff4mr917513ljm.10.1680904458705; Fri, 07 Apr
 2023 14:54:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Apr 2023 14:54:18 -0700
MIME-Version: 1.0
In-Reply-To: <20230331091145.737305-2-treapking@chromium.org>
References: <20230331091145.737305-1-treapking@chromium.org> <20230331091145.737305-2-treapking@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 7 Apr 2023 14:54:18 -0700
Message-ID: <CAE-0n53Dw1tk0vVuToTwGYrKD76O_F97QgSGricBuvuPJnG60g@mail.gmail.com>
Subject: Re: [PATCH v15 01/10] device property: Add remote endpoint to devcon matcher
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Daniel Scally <djrscally@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pin-yen Lin (2023-03-31 02:11:36)
> From: Prashant Malani <pmalani@chromium.org>
>
> When searching the device graph for device matches, check the
> remote-endpoint itself for a match.
>
> Some drivers register devices for individual endpoints. This allows
> the matcher code to evaluate those for a match too, instead
> of only looking at the remote parent devices. This is required when a
> device supports two mode switches in its endpoints, so we can't simply
> register the mode switch with the parent node.

Looking at this in isolation I have no idea what a mode switch is and
how it is related to drivers/base/property.c. Can you expand on this
commit text? Maybe say two "usb typec mode switches"? And maybe include
an example graph node snippet?
