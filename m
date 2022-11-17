Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3F62E6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbiKQVQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbiKQVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803185EC2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so8198132ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QtRibc0jfvWRzr3zxWRcvkUmcozMC6ScLHF+VtqaDfs=;
        b=Egpl7harq1z/ThqqQTXWRBPLNrlqdIkIpsvtE5n/qqbnpOsNKNIC7H79qLQ20AsthE
         KFYPPdXYhFMHeFfwMysLQUcAKTPog9IWST+4eO7zJLc4vCw+oz9JGmuih9ouhw7SJ3SI
         bZ6I8zJN1gqh9IXG8OR9YNipLVgFHF3pztO4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtRibc0jfvWRzr3zxWRcvkUmcozMC6ScLHF+VtqaDfs=;
        b=XHoJD+jnEMzZN0h8szlvFMHhnRM61IImAqw/TEBhVFXsKgRMVB0jh0TfK7uRYrAc3/
         ytrVYYOqQ851/Pye88mN0oTO8fCN8a5chgdyhiH27KZxzNV/pRe0eG0gY9QVSqColtkg
         8EawZsCv9bjmpdPHjRtsJtCtkcLh6NWkeUbFLQwAt3XGRJCzrZL1WIqRiG7LT1vn/rUY
         nu53DCe7ux1+EZ301+uyvka5dN9F4NQ9zQfbm8wARWBxilJagZ6ScI9sIc1kmAk04mkC
         g5K32TDlWZV+dIK4Pc+A7Edgb7HmlMGHcYYbrgZaLidmJaOuNPF8jdcFWRRF+u/Gil9d
         6nUg==
X-Gm-Message-State: ANoB5pnA1c/4+H4zTnxDh2J80qMGGEkOc6mrbifdHk/UCIJ2HIl6SLz7
        fNKvPpWhTn7NNC37qkHzZxYHtQLJMpvvHYYb
X-Google-Smtp-Source: AA0mqf48nueL7l0hIOHQ89jhU1+uVG+CDaeh47Fne8HNHp7gz370Jhq9NXlKtHd0quqM9qgQh75ePQ==
X-Received: by 2002:a17:906:1b15:b0:7ad:dc7e:1b8d with SMTP id o21-20020a1709061b1500b007addc7e1b8dmr3575655ejg.276.1668719715347;
        Thu, 17 Nov 2022 13:15:15 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b007a4e02e32ffsm838298ejb.60.2022.11.17.13.15.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 13:15:10 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id g2so2277339wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:09 -0800 (PST)
X-Received: by 2002:adf:cd82:0:b0:238:b29e:4919 with SMTP id
 q2-20020adfcd82000000b00238b29e4919mr2590182wrj.583.1668719709264; Thu, 17
 Nov 2022 13:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.4.If6153da69ec4bc9e83d5f095ef6e6b07283940a5@changeid>
In-Reply-To: <20221117133655.4.If6153da69ec4bc9e83d5f095ef6e6b07283940a5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 13:14:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VvhzEgjQidvF3DVokNyiQ1hRkqGShCoNbM5ytma3gZYQ@mail.gmail.com>
Message-ID: <CAD=FV=VvhzEgjQidvF3DVokNyiQ1hRkqGShCoNbM5ytma3gZYQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/bridge/parade-ps8640: Extend autosuspend
To:     Drew Davenport <ddavenport@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
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
> Same change as done for panel-samsung-atna33xc20. Extend the autosuspend
> delay to avoid oscillating between power status during boot.
>
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This seems fine to me. Not 100% sure what changed in the probing /
booting to make it need 2 seconds now, but this really shouldn't cause
any issues and it's nice to avoid those slow power cycles.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
