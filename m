Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B096378B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKXMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKXMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:16:32 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6699EBF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:16:31 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l127so1386690oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=xkgOOoR55naEVrK40Wadm7CKSFaP+TtjkA0V95FFtQig0FqjBXoxg5AczLVoZABCSI
         RKW+UZFs07r/8QbajkgkbARvMuCkxDkgTHACQAdEs6i3yGxWMGfORA6R/BHx3bjurpC9
         yuVRsAlQZlkPDBVZ3gzMbMY2/wop4cN6tNjay/yF1Y2BzJfOEslh+km+OdQPdiRL6QZA
         mXfg4XyRuCDWI5JHyIzMxdGeE4v9QLuVwRNeCBnNnlMwdAIAlWqY9tFbxdseCU6ymGIL
         JQX0iU9sZAciqoAHQXOsQV8b20/9kd8xyx60QXeohdoSdICogiNPxup0bL9LDSpubZn2
         kuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=4RTUCIh3BuaJOkx3//0wLpse+EBdI/mS+4XpL8sXccqzpPQXA7++anBbvSA6HZMtAZ
         +p+0KoGwYP/c2U8heeGTq6TpP2WK7ndlCfBZJo4fQ0FdlneZA4qL34LS53m/b8MC8wBD
         XZPlXb80b+NWLk8EpF3/9d+r9MW6AD2igh0WffDd8BE3KJHCnVd4oS6o0MrfgCXUezWH
         20oOJadoARyNTEXS/OMCAg55aM1IlHfwxq8FR8mQZAetvqd7ie6qpOnIWW6hRGtjKp8S
         6flN0T4KZnquSzd+B3Hd/wH4mI2KHjHw4nLmEfY0t48zn3NjErXYyEF+0pLDhQVyTDCB
         UQNQ==
X-Gm-Message-State: ANoB5pkDCpOapPj7HpJOMujttE3xgn4EHBY32StexAReHdH8RzJyx7z8
        LJse8lLoJAsjszqCyTLSjfX3rEcc4Qe0b0TXv4LU9g==
X-Google-Smtp-Source: AA0mqf5L9+lrul1I/1+IDLi94tm9hWpUFUpDXBQmzSQdIXIUp8plQRGnsolhUNGiRLT/zlEFKPJLP+FVe3zMEWIotRU=
X-Received: by 2002:aca:5bc4:0:b0:35a:7056:4f9c with SMTP id
 p187-20020aca5bc4000000b0035a70564f9cmr19837991oib.72.1669292190923; Thu, 24
 Nov 2022 04:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20221122081219.20143-1-frieder@fris.de> <9079928.rMLUfLXkoz@steina-w>
 <7761d66c-a8a7-c11a-9c09-a47f57bd1311@kontron.de>
In-Reply-To: <7761d66c-a8a7-c11a-9c09-a47f57bd1311@kontron.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 24 Nov 2022 13:16:20 +0100
Message-ID: <CAG3jFytse8xcyFe-1F95tqdixeZy5ivYd=vxXUBVkiwUu-yjWA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Fix delay after reset deassert
 to match spec
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Frieder Schrempf <frieder@fris.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
