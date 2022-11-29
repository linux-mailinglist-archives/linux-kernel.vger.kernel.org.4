Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C8063CB13
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiK2W3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiK2W3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:29:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FB370441
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z20so21711832edc.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1gKZClLZmEiVOIk1j7cicwzi+DjtZJzvayZlsThxfFA=;
        b=PDQHwMDxqw96E4BjZGoYCNxOxYiUPtBJOTGKZ0b9ugbOYqSmE6ZA0sMsTaMNaew/N3
         6+0JgyBhmhBew5dmm9B/lacTYS4E6x5LeKeHID5zLpYeDKVtNal7+3DKrK0YxVrC6EuG
         TZIs/Pw9H9xFba7BY2ZgWUa93/4soo2uZ3Z6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gKZClLZmEiVOIk1j7cicwzi+DjtZJzvayZlsThxfFA=;
        b=vqGzMx/16AAQOPHa6ImlVslzW8q8HpHoGg9VNw+QxUaLdl58s77p7ZUpAblzV7r31q
         MeR+Q8ov7szU5RO26o7VJYefyLck8J6q6er7cS4ZQBX81udVJPs1BUVMBEQAgOG+MLM0
         AckoAtV+ykxiWun5qgDiMeWVSA1X9Y/qxt4eP4Q0mRpUMO0ALvbMP2Ox2eAaBqlF2pr4
         7CuPJQMIj4SGrVyLXxe8MPsaTjA+dO9KG19nK9QiPWbjG4IRfSsnAArbKnULRiCwBDwD
         qZh1YdYgHl7e7u11z6CWyruA1vIfUCjbJMXKKiL3YJFhRvqK+XOiF93JSIluN8XFnV6h
         IQjw==
X-Gm-Message-State: ANoB5pnNdXiSGUWWQmz3LeGdqdPOczcJBbM2gug0RYTfce4b9LWSr3BT
        xnyG146AyjeZ0kUep2b/yqgPHSmJCzJO+ih8
X-Google-Smtp-Source: AA0mqf5b5urchnkJlWq+irVkhUj6yIXwPjUjDo1szrg/PPqA1k5pL5+MpRoyOtFEWW5zCYc0hKS3Pg==
X-Received: by 2002:a05:6402:2a09:b0:461:30d8:6742 with SMTP id ey9-20020a0564022a0900b0046130d86742mr53418496edb.172.1669760952628;
        Tue, 29 Nov 2022 14:29:12 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id tb20-20020a1709078b9400b007bd0bb6423csm5326199ejc.199.2022.11.29.14.29.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 14:29:11 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id x17so24336388wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:29:11 -0800 (PST)
X-Received: by 2002:adf:fd89:0:b0:242:1f81:7034 with SMTP id
 d9-20020adffd89000000b002421f817034mr4295062wrr.617.1669760950923; Tue, 29
 Nov 2022 14:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.5.I96ce2a565ff893eddcbee70174c991179311a3ae@changeid> <CAD=FV=W_P3BbxRsPH0vQ4qRW_fiyM+u7RzRj+i0N9G3_4Zhtcw@mail.gmail.com>
In-Reply-To: <CAD=FV=W_P3BbxRsPH0vQ4qRW_fiyM+u7RzRj+i0N9G3_4Zhtcw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Nov 2022 14:28:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XbHX5Cz6LLS1eNgjQ6qo6mzDtndeM6BxiXGF=6HtpkXw@mail.gmail.com>
Message-ID: <CAD=FV=XbHX5Cz6LLS1eNgjQ6qo6mzDtndeM6BxiXGF=6HtpkXw@mail.gmail.com>
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

On Thu, Nov 17, 2022 at 1:15 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
> >
> > Avoid the panel oscillating on and off during boot. In some cases it
> > will be more than 1000ms between powering the panel to read the EDID early
> > during boot, and enabling the panel for display. Extending the
> > autosuspend delay avoids autosuspending during this interval.
> >
> > Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> >
> > ---
> >
> >  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

8d5d063fd669 drm/panel-samsung-atna33xc20: Extend autosuspend delay
