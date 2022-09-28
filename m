Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181655EE31F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiI1R2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiI1R2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:28:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE5F1D5A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:27:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a13so3065257edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LoaCqW3jpS8TGypc4TVU/1rL8RVEj1gIc68KQRqm5M8=;
        b=WQi3vRXWrLpV5LLIyL3HI0/XBIdEZDVlgeISWfa1H4KEcZU4m8LKG2wFPBnmJVmXAV
         K2l0fhZq62LVNM3PRD0ZCTfA+8x6l4JygClEFkfTEu1sAeiSCN5h41vFkRLYVsllV3py
         v9XQ/Zh7sZyFWHTbsMepsHHm4RyBiHiXn2BwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LoaCqW3jpS8TGypc4TVU/1rL8RVEj1gIc68KQRqm5M8=;
        b=faJxTBWWQRoGBaqisL4LSxBn/wWPxlTygz5iYYe4LU5hoXU2uHLlWma2lp67QySd3r
         skBfTtlkCLtADaBZAoiA/EwQ++cA/wjwCO2rNxSkGdaDBed9GksFVc3V+Jt41IpM9Zpn
         06ps+XFCKvRpSR+PP9GLHwH08HhlfwPUfdn3HtYAEd9ZUyzKF6uBYHpFGCOfrqKmaKH0
         uJiCbPwWPLy45GR4JMsBbqQWn26bUMtYaiPg05Tigqoda6nNGl/m/vgTJf2bfcVb5Sii
         a3tUpPIkFhi0EzJKoZLDJ9lkVCdAMo0RhZdDtQ9EaZp8l8iCzAYZnSYpINWFgW1LJQgi
         mv9g==
X-Gm-Message-State: ACrzQf24lcjuZNy9OgQ24SJpDJFOsPDybFrxrdBjP3SDmKBqZO7zUx07
        hMxpCnvpgEqC7f2+H/xYtEBz5K01hP0VhBVq
X-Google-Smtp-Source: AMsMyM5VC3ruimVjWPCmAgCHIS3NG2thT/seL9VRct1iJGMFF5RUTTyz7snB9oDrmDvGFKVR4P0j0A==
X-Received: by 2002:a05:6402:2947:b0:451:32a:2222 with SMTP id ed7-20020a056402294700b00451032a2222mr34162947edb.376.1664386074955;
        Wed, 28 Sep 2022 10:27:54 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id k6-20020a50cb86000000b00456e98b7b7asm2656974edi.56.2022.09.28.10.27.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:27:53 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l8so8964239wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:27:53 -0700 (PDT)
X-Received: by 2002:a05:600c:510e:b0:3b4:fed8:e65c with SMTP id
 o14-20020a05600c510e00b003b4fed8e65cmr7575844wms.93.1664386073218; Wed, 28
 Sep 2022 10:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220927063524.493591-1-sean.hong@quanta.corp-partner.google.com>
 <CAD=FV=WQXOTJu-YUWyBjdoq4wPrwQYoo68FCJBF7EJfdf+9SrA@mail.gmail.com> <CAP19T+6SWu_siXom4EANarqSRGif7qnkUPwhfKgjASnFnYG+cQ@mail.gmail.com>
In-Reply-To: <CAP19T+6SWu_siXom4EANarqSRGif7qnkUPwhfKgjASnFnYG+cQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Sep 2022 10:27:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRX5AuRcw9=0jw+9WnPfeXtYnPEu+iYgqQxXcJh4LvTg@mail.gmail.com>
Message-ID: <CAD=FV=XRX5AuRcw9=0jw+9WnPfeXtYnPEu+iYgqQxXcJh4LvTg@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 11:51 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> On Tue, Sep 27, 2022 at 11:27 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Mon, Sep 26, 2022 at 11:35 PM Sean Hong
> > <sean.hong@quanta.corp-partner.google.com> wrote:
> > >
> > > Add support for the BOE - NT116WHM-N4C (HW: V8.1) panel.
> > >
> > > Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Wow, another panel?!?
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Pushed to drm-misc:
> >
> > 2f24fe8c54cc drm/panel-edp: Add BOE NT116WHM-N4C (HW: V8.1)
>
> Hi Anderson,
>
> I found some mistakes on this commit. I typed the wrong model name on
> title and content.
> The correct model name is NV116WHM-N4C and the code is correct.
>
> How can I fix it? Do I need to revert this commit and then submit a
> new patch upstream?

There's not much to be done at this point in time. Reverting /
readding the same code with a slightly different commit message
wouldn't be worth it. The code is correct and that's the important
thing. The commit has a link to the mailing list post so anyone who's
confused will hopefully click the link and can find this discussion.

-Doug
