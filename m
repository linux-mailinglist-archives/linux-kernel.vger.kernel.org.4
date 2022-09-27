Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4215EC7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiI0P1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiI0P1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:27:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFB18D0CC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:27:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z2so13724673edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kankTRCISUIsAfog0Ofr/wisbx67a2Kvj+VX7g1I/LI=;
        b=fzlkqVQyXabwlDt2N0VtOlZfwq/BadBHEJVad/oL8TIoAObPV8J8nucnuONTqoz6pL
         rGORO7KYTtsOa56o+iY0kBZMd2rY2rhb4ZJQhJLZq/4i6iThyDiQJASbCbTuiZHaRetW
         lLsOxX2O89w45itZoNoHky2l2m93ECHjj6dHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kankTRCISUIsAfog0Ofr/wisbx67a2Kvj+VX7g1I/LI=;
        b=XS5nPZiL2U+XgTnyx2X3ZfYE1+W6hVyH5xrJlt761WTuhA+CnWoIP+N6xzfmv3mPup
         /11dh8hvzvH2+GIfx0XDNcA4dwwEjlxJBO6IMwR02u39J6WAFSN0FVmwKzU74pvc/H6x
         glOW2Vg+9+eCrJe7v0lXxsT35h45ZoqWjzOHWRU28cQtOkksrIvhOjxvbik49gc5kxwY
         2IsKpLTt+mnFI2pyDD22TvczecS+Zw1DYrFXuLFZzV73FPcF3j/bg4jky8CTdDYWbV1Z
         HRKmyMmOiC1JsYW0e8ST7j8dh67sPvm1SHncf86M22MomFx0ERVu3GY3ANiAMvRXcZXx
         FV1Q==
X-Gm-Message-State: ACrzQf3T7LWo9KeQ9vIGz7h8+e2HPIZGkJUhV4Wfn0/uv5Z+3elqEIVv
        Rlgbf5YBRgsNjw+P5cWSrNXc9nnPzIFjYnLc
X-Google-Smtp-Source: AMsMyM7dO6BkIekiDNPNQqtgkwmM0nLmr1cd8peUdlPm89dLIbM6hweVsdcJgnNg5j26aekWcRn7mg==
X-Received: by 2002:a05:6402:22fb:b0:457:537b:b628 with SMTP id dn27-20020a05640222fb00b00457537bb628mr9363949edb.313.1664292429367;
        Tue, 27 Sep 2022 08:27:09 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709064ec500b00782ee6b34f2sm923256ejv.183.2022.09.27.08.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:27:08 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id ay36so6793420wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:27:07 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:3b4:c8b6:15c6 with SMTP id
 u15-20020a05600c19cf00b003b4c8b615c6mr3232537wmq.85.1664292427539; Tue, 27
 Sep 2022 08:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220927063524.493591-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220927063524.493591-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Sep 2022 08:26:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQXOTJu-YUWyBjdoq4wPrwQYoo68FCJBF7EJfdf+9SrA@mail.gmail.com>
Message-ID: <CAD=FV=WQXOTJu-YUWyBjdoq4wPrwQYoo68FCJBF7EJfdf+9SrA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NT116WHM-N4C (HW: V8.1)
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 26, 2022 at 11:35 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the BOE - NT116WHM-N4C (HW: V8.1) panel.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Wow, another panel?!?

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc:

2f24fe8c54cc drm/panel-edp: Add BOE NT116WHM-N4C (HW: V8.1)
