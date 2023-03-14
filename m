Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE916BA3CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCNXzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCNXzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:55:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28330B2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:55:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw3so1467176plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678838142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WizLnkQzu/0Y1Lv+vmWA4A6vgwmutnCW/cgvOhxwUTw=;
        b=UAGxVbFv0cQvP6ngXKOLsXbFWg6L6YKGo31pKfx4gjVa6KNN/EzIS19kGnfsw3nKRi
         LIV2OziXg8cHxR+3KHoMjx+WYppl35RN0DdSLxEP1dZO5luQjK0ZwCIXQforu7NtB33H
         hfC7Fl77A8pG78umAMLy21DiR7htKoHYtsWC9toCkNsmCQvLpt9P6PpP3arKBBevH7Ra
         oiFSCXIj3HHBLNU8aDP3Gykm3o2s3JuOkVJDinWxVUTfDaoKsTM8gTwaiC4pbRGs0+fU
         r/HQuuaQES11oueU5j3KsYz3DbtO3yTDWYWhof0dtbWAalFM3+R/R7Hv2Rt9/5BSzoRd
         O4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678838142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WizLnkQzu/0Y1Lv+vmWA4A6vgwmutnCW/cgvOhxwUTw=;
        b=tf4MeaRqCiK5WC2PAzq6NtVpEcWJBZJbXjnbmf4jB83HGAsq6U+OP0BXwuLMAbNEgH
         hIiim6cgFcOW27MlJSQk9StJ9p8Mfhe2EsdZlRxxx+w7GZXfbkf8ZAnmw6akeKjUM7wV
         /KnnJRkA1jpdRKIEX5MUofxUkQbaSQORu0SlKrKNpcaOHtjhBecPEMNW5DTSg0L0WxMy
         uyACPNciBVX5RIVe/nOttfhzyvLgt4qZXW0eB8KGm/QFcifV2RQ7RpaLfEh70sThCwP0
         QSX0924djHtUDVqS/aTAf4zwlA9rdp6ZK8ze+2KwF6YxLPQ5VVtGjbK02VsIgRdpMhGK
         RstQ==
X-Gm-Message-State: AO0yUKWSQWQUcKDYNhQALKVrWZITlxDDMPH3NeTugOu0V4qbP0K64i5V
        +ZaaxfaOGXRYTmd/0a0PPBw=
X-Google-Smtp-Source: AK7set8wnh5F6ybtoXpVjlSt1QRsAACmpE0qxf013sV4LMlYya6a5g+OVOCTpPVe8B5Ky0s2zJza/A==
X-Received: by 2002:a17:90a:f0c4:b0:23d:3383:1d68 with SMTP id fa4-20020a17090af0c400b0023d33831d68mr4397542pjb.35.1678838141694;
        Tue, 14 Mar 2023 16:55:41 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ad3c400b00233d6547000sm12764pjw.54.2023.03.14.16.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:55:41 -0700 (PDT)
Date:   Wed, 15 Mar 2023 07:55:33 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: Fix panel mode type setting logic
Message-ID: <ZBEJdX6WVZ3Kqdo0@Gentoo>
References: <20230314114451.8872-1-lujianhua000@gmail.com>
 <CAD=FV=X7K2KQoRCsr17kj-DWiPs7h_zfcYxK_cdBVnC0wR1NwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=X7K2KQoRCsr17kj-DWiPs7h_zfcYxK_cdBVnC0wR1NwA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:12:02AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Mar 14, 2023 at 4:45 AM Jianhua Lu <lujianhua000@gmail.com> wrote:
> >
> > Some panels set mode type to DRM_MODE_TYPE_PREFERRED by the number
> > of modes. It isn't reasonable, so set the first mode type to
> > DRM_MODE_TYPE_PREFERRED. This should be more reasonable.
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-abt-y030xx067a.c     | 2 +-
> >  drivers/gpu/drm/panel/panel-auo-a030jtn01.c      | 2 +-
> >  drivers/gpu/drm/panel/panel-edp.c                | 4 ++--
> >  drivers/gpu/drm/panel/panel-innolux-ej030na.c    | 2 +-
> >  drivers/gpu/drm/panel/panel-newvision-nv3051d.c  | 2 +-
> >  drivers/gpu/drm/panel/panel-newvision-nv3052c.c  | 2 +-
> >  drivers/gpu/drm/panel/panel-novatek-nt35950.c    | 2 +-
> >  drivers/gpu/drm/panel/panel-novatek-nt39016.c    | 2 +-
> >  drivers/gpu/drm/panel/panel-orisetech-ota5601a.c | 2 +-
> >  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c      | 4 ++--
> >  drivers/gpu/drm/panel/panel-simple.c             | 4 ++--
> >  11 files changed, 14 insertions(+), 14 deletions(-)
> 
> Can you explain more about your motivation here? At least for
This demonstrates a bad way to set DRM_MODE_TYPE_PREFERRED for panels
with more than one mode. It mislead the future contributors to send
a patch with this piece of code. There is also a discussion for it.
https://lore.kernel.org/lkml/904bc493-7160-32fd-9709-1dcb978ddbab@linaro.org/
> panel-edp and panel-simple it seems like it would be better to leave
> the logic alone and manually add DRM_MODE_TYPE_PREFERRED to the right
> mode for the rare panel that actually has more than one mode listed.
I think we can order it to the first mode if the mode type should be
DRM_MODE_TYPE_PREFERRED, It's also same.
> That feels more explicit to me.
> 
> -Doug
