Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE260691A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBJIwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjBJIwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:52:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ED922797
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:52:01 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n13so3258718wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YZAhfBQYquLF1qnZYO3CTH5oSKC+08iiTknQihvWDiA=;
        b=fwGE+8ZXY4Cqp7eooYZ0dYLd+1x3muucfpFXGjo9lEDwCb9aW536kfIl5wvOL9ukDK
         ZPOW4f5iyqFYvMSxowTCoJKZebalcQT5tqGc4gg+WWV/O1Xlqhry3TsT/jfvogtix2ou
         VsVh/c8fKkXC3yf2bGsdgSUScN0i1uIdjU2hgzAHyeRqmW0IAhHho218gODY5fUtUORK
         /pSadvC4Q6tD01pE63iGs0cxFKNdc3CgZKIyKjPSTraWX//sx/g1A2eqBxAZa/1vCVc8
         +KspIoqrJ4Weklwd0UDwAUv+/YQGT5bROiuQb1WBScSPXC6T2RBAqKqoJ2C2wihh9Bpy
         BLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZAhfBQYquLF1qnZYO3CTH5oSKC+08iiTknQihvWDiA=;
        b=KB/D9lqIx+kid4GBrbId64U/yzEYPUi8iPvB9jlX3UKy6xpBgdnFmKRpWMh8KcQthX
         xYkRxPueQcJ2SJ5qzbXcGC3Fdgs7X9yKENDWY4Qqye1VqLZynjDroI2/3678pqwJcvsb
         mYb3zcOvtNJagyrGiFhl2DDC3ea5P/ExJa4l+4JDIWdS6dlSbR+RVhBztdRSB52PaeGh
         slSMPWEgmpeuPZbH08cfBbbFvbM9O5DqLdoov+pth70KUZ10qm8ae8eeugxovNHPJuAf
         9VLsueekV/ptLayQm3X9jNsArv5akLI/oSxIHsYy3vGABbTc3/SSRsgB9S7nFgU55oo5
         xw+g==
X-Gm-Message-State: AO0yUKUhISGrHz9YNDwuVWkGE7SQZM4VQZeE7qKNhhvmZ55LPbOq7xW/
        g8Zg2N3VIxFR6qEPiNtrS5KPjg==
X-Google-Smtp-Source: AK7set/OKo4yEv07P848igeq6Jgq0peHDJLiD5bvtcLGw5Ybo81esX+fCq4M7Yn6i8m3EQT/mZjzEA==
X-Received: by 2002:a05:600c:4386:b0:3df:94c3:4725 with SMTP id e6-20020a05600c438600b003df94c34725mr12272914wmn.38.1676019120422;
        Fri, 10 Feb 2023 00:52:00 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003dc434900e1sm4771255wms.34.2023.02.10.00.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 00:52:00 -0800 (PST)
Date:   Fri, 10 Feb 2023 09:51:57 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     John Stultz <jstultz@google.com>
Cc:     walter.chang@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Support timer drivers as loadable modules
Message-ID: <20230210085157.GA175687@linaro.org>
References: <20230208094813.20874-1-walter.chang@mediatek.com>
 <fdcea75c-1ddf-c4f4-5d46-f32a6619b66d@linaro.org>
 <CANDhNCp6esdor4kDDTDowkKRfRN9QW8Au7uJMhsxyw0eAG4i8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCp6esdor4kDDTDowkKRfRN9QW8Au7uJMhsxyw0eAG4i8A@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:50:49AM -0800, John Stultz wrote:
> On Thu, Feb 9, 2023 at 7:36 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
> > > From: Walter Chang <walter.chang@mediatek.com>
> > >
> > > This patch exports functions in kernel so that timer drivers,
> > > such as timer-mediatek.c can become loadable modules in GKI.
> >
> > What for ?
> 
> In general, it's the same reason why modules exist: We want to be able
> to support a wide array of devices with a single kernel, but we don't
> want all devices to pay the memory cost of code that will never be
> used there. So being able to support loading device-specific bits like
> clocksources (along with other device specific logic) helps.

Agree, that is why modules are for.

> Obviously it still has to make sense, and others have raised concerns
> of stability issues if the hardware support is needed before we can
> get to module loading, but I think if this allows drivers (such as
> timer-mediatek) to be loadable safely, I see it as beneficial.

From a technical point of view, it is arguable.

But my main concern is the real reason of changing this to the module
format. I see that as a way to overcome the effort to upstream the
drivers. And the GKI is an alibi to justify the module conversion.

Given the timers is a base brick of the core subsystems, without
proper support of the timer (eg. bug fixes), the platform support will
be wobbly.

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
