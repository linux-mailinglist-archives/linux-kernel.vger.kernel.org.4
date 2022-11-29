Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D363CB09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiK2W2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiK2W2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:28:49 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA5359FEF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so37292919ejh.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv5P4YKVke8Uiqx6Xk3+EHcpUQ/fZJSaam81ASeevJA=;
        b=JtnZr6UpSwQNFk6kIu4r9vijUTEsHUkw/JsvAF1ZXWJOpbtaJ0XJwfED9HLlRrtcTK
         qOV7Phcu9KCrk8HFsBJtK4bGa6axQ6qUZIL8lgQCewFA4X/UvjYX6kr4HAAdEWROPkCv
         URe7yoen5FEW9c4UDnFv5upSl5zNAZXMbKYsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv5P4YKVke8Uiqx6Xk3+EHcpUQ/fZJSaam81ASeevJA=;
        b=donp4+4VWPBoGHRllzD9COwGSO14Rtf6cU8Q5opFkXC5Ng+80tMYGQQ+Rwtyz29A/i
         3b7u6/Sn+mH4M3VjCIvTlJG0BmObbuZF3de9h3Q8fnc5rp7BEZdeJJ432Hrtc6D8CuR8
         FKEwG8M63kDr0OJ807pDyJvQLBgk9doChAdfe3vCJaAXBOMI8DwYJPLAiGGxC1rW3G2d
         FCyVLg9rnAsZ0TF+qgshT6i95jrbqVRgzgUqaHqJOpLmVGUizMHKOAeyJozMvQOOQcFz
         Ll4SYevVvy/PAsBXg1sdCsL0vXCWZ7l/EqTT09jUoCcEjbp5NHTNe3FWRKvdHCE9f0rB
         JdYQ==
X-Gm-Message-State: ANoB5pn5y7LeI4kxIsKeKYVsKzRNl8roCUDj8d8cMPVrTnhjJ8avpqeb
        FJIRCqo3nFOtEwCIGzgHOWOMHvTUHYfHE/cH
X-Google-Smtp-Source: AA0mqf6F2uCVBrO0NAa6k7kLmxY5RyKKC49pEmotQ2wPrg2lAuiMfyCyMaBYkBEkF0F/4ez4qR4mPg==
X-Received: by 2002:a17:906:2594:b0:7c0:8d06:33f8 with SMTP id m20-20020a170906259400b007c08d0633f8mr3406270ejb.150.1669760926310;
        Tue, 29 Nov 2022 14:28:46 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id d5-20020a056402516500b00457b5ba968csm6641126ede.27.2022.11.29.14.28.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 14:28:45 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so116432wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:45 -0800 (PST)
X-Received: by 2002:a7b:c4d8:0:b0:3cf:b0ed:de9d with SMTP id
 g24-20020a7bc4d8000000b003cfb0edde9dmr29570493wmk.188.1669760924865; Tue, 29
 Nov 2022 14:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <CAD=FV=XFsSoUqkk8zhta1V-oT2AGGvUz=0qFWAcXiJ7m+nnATA@mail.gmail.com>
In-Reply-To: <CAD=FV=XFsSoUqkk8zhta1V-oT2AGGvUz=0qFWAcXiJ7m+nnATA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Nov 2022 14:28:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WfFNssxLRHKv3OUgAZsfme=k27TaFN1M8hFw2xug+eLQ@mail.gmail.com>
Message-ID: <CAD=FV=WfFNssxLRHKv3OUgAZsfme=k27TaFN1M8hFw2xug+eLQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/panel-edp: Use ktime_get_boottime for delays
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

On Thu, Nov 17, 2022 at 1:14 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
> >
> > ktime_get is based on CLOCK_MONOTONIC which stops on suspend. On
> > suspend, the time that the panel was powerd off is recorded with
> > ktime_get, and on resume this time is compared to the current ktime_get
> > time to determine if the driver should wait for the panel to power down
> > completely before re-enabling it.
> >
> > Because we're using ktime_get, this delay doesn't account for the time
> > that the device is suspended, during which the power down delay may have
> > already elapsed.
> >
> > Change to use ktime_get_boottime throughout, which uses CLOCK_BOOTTIME
> > which does not stop when suspended. This ensures that the resume path
> > will not be delayed if the power off delay has already been met while
> > the device is suspended.
> >
> > Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> >
> > ---
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

fa8e91b12697 drm/panel-edp: Use ktime_get_boottime for delays
