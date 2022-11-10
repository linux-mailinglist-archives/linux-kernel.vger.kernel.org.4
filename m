Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344FC624600
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiKJPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiKJPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:34:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1384AF13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:32:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so5932824ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lLWyKRw2Ej5Lpfhe4CBr1qjwt8vEPyBuJa6C43wuPh8=;
        b=OkyOgnKMAJGwRvPJAFhXDJESxbMLb1Fk0onxCfwxfvJg9rRma53fxA9Hi2o5w58I03
         +8HpwRbWFlTbcs53Se/6vK/S1S2fRP2RwZiXmYjABU9SNbw54OVQbnE0QdpD81tMek/n
         8wAr94Fchj/KpWbCevBtzdDELjSbHgxIu3NTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLWyKRw2Ej5Lpfhe4CBr1qjwt8vEPyBuJa6C43wuPh8=;
        b=B7PxCw3kzNMRwNakpOecvU1Md86xIgR65/ibVKFQWUvVgiT27peUS9pt9wH1bTcIgT
         BaWXM/RttBtLVZF0EKgp+z7FFsn6It1DYhwSLfMMl2jRAmSHSWyZph4iHImhUvmAX2tk
         W2WxUtClR9KMrvpFjq9Zmevaq1CwtPprIeNmOzJG9577Esbs219JqRYQi94dauX8fTUF
         o7BIx98PP5Cem2BY4EM6AYtGwhguLujCORO8Ohc09Oargoz1A2AUzrLRLhjwehd0d11u
         9Xgj0AI6ckFd6aQcpQUDJPtpMBkzzyZhOLEzCfR5BiVjCAdcFRdsaizo2lDo4BFfHnYy
         UaTw==
X-Gm-Message-State: ACrzQf2WIlJc5upSHdKh1k+kDSeqphjWBlIw1rfB8KAtC5olNPz5p7gw
        /NL2yT+Q99HZ32VBHW5Xo1o/z9uCD8WBl93/
X-Google-Smtp-Source: AMsMyM5HiPZ7bSzRVn9EZ4gOOCm2wViH8hw50iyDkxpZfCGXDq/ZleeGCgXc0t67nKWVtGj1s1qJ2w==
X-Received: by 2002:a17:906:a3ce:b0:7a1:b573:c99e with SMTP id ca14-20020a170906a3ce00b007a1b573c99emr3033990ejb.55.1668094364097;
        Thu, 10 Nov 2022 07:32:44 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id o19-20020a170906769300b00722e50dab2csm7364780ejm.109.2022.11.10.07.32.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 07:32:38 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id r203-20020a1c44d4000000b003cfa97c05cdso1958704wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:32:38 -0800 (PST)
X-Received: by 2002:a05:600c:4486:b0:3cf:6e1d:f4a5 with SMTP id
 e6-20020a05600c448600b003cf6e1df4a5mr41251597wmo.85.1668094358585; Thu, 10
 Nov 2022 07:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20220831141622.39605-1-francesco.dolcini@toradex.com>
 <Y01kJbZjkwo1A8l1@francesco-nb.int.toradex.com> <Y2z4zoYU2rxrOKPC@francesco-nb.int.toradex.com>
In-Reply-To: <Y2z4zoYU2rxrOKPC@francesco-nb.int.toradex.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Nov 2022 07:32:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UHOdxmKFSapPshxyo0NW3UxsmzSXroe4riAFDWM6Si=w@mail.gmail.com>
Message-ID: <CAD=FV=UHOdxmKFSapPshxyo0NW3UxsmzSXroe4riAFDWM6Si=w@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: simple: set bpc field for logic
 technologies displays
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

On Thu, Nov 10, 2022 at 5:13 AM Francesco Dolcini <francesco@dolcini.it> wrote:
>
> On Mon, Oct 17, 2022 at 04:18:13PM +0200, Francesco Dolcini wrote:
> > On Wed, Aug 31, 2022 at 04:16:22PM +0200, Francesco Dolcini wrote:
> > > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > >
> > > In case bpc is not set for a panel it then throws a WARN(). Add bpc to
> > > the panels logictechno_lt170410_2whc and logictechno_lt161010_2nh.
> > >
> > > Fixes: 5728fe7fa539 ("drm/panel: simple: add display timings for logic technologies displays")
> >
> > Hello,
> > just a gently ping on this. It applies cleanly on v6.1-rc1, anything I
> > should do?
>
> Hello Doug,
> can you help on this patch? I am not sure who is supposed to pick this
> small fix, but it looks like you recently took patches on
> "drm/panel: simple:", so maybe you can help.

Sure. It looks fine to me so I don't mind applying it. I did a quick
double-check and I was amused that the datasheet of the 800x480 screen
claims that it can show 16.7M colors with an 18-bit interface. ;-)

Pushed to drm-misc-fixes:

876153ab068b drm/panel: simple: set bpc field for logic technologies displays
