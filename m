Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABE067A89B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAYCM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYCMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:12:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71E26855
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 18:12:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j5so3389877pjn.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 18:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wyo4ScdnKnOpNdEhwobdQ9WeYs+jQOexpJlhKGainQs=;
        b=WQyTcKY9Wn6wifrEjH06aIMPm5KuR8cVj90LyYYJz6t1gLRSgzj4DxVSOIXQrDTHeL
         9zuk9jn2JQ1RAshLv1HMdYfn/ObWLARV+rYWZAYhvVg0ex573km+2YS9+iAxnzzFPWab
         xk3UswT1bRiKDvYUUrjYuisGK3SXVxzpr1oMSX5KjT2qJDBLIOulxdjgfeAMQccwgUNC
         m72LoKWAg5fYvJETfDRi+uSLf6VdRf0ewoX7PM5gLhfDyex8y4ln3R0dJFbdWLLF0w05
         oTABPC3xvqhglWITFsiPtJPXWGmtTLJ6lfAY3IQ23XLwQ1j8xvdZOy65FOU+2aHNk8Tj
         dZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyo4ScdnKnOpNdEhwobdQ9WeYs+jQOexpJlhKGainQs=;
        b=kgMtI1pc/NRWhPc4AnO9ZSiG1OCv5enxX9DI4wvWVCg9krUif7pM35XZujATRWtwuD
         LgenkrqPbO6dE7Un6RfvgpyHur0UIja/HQD2js9D/kiEKSdBhbAMP1RaS+gm3XaEYZcl
         Fg/rLvTpUe3Ma5JZ8rP3AS0/svgFwFLAZz/pLRCAtj4JnnT4t2CayGw99FCE8ijt5pL5
         gHggQzS718T1WvpuKBbEVEE2bxPycrOrfZL2lGXFQ6YTa4/69vWXq891Q3yqMH4RrB3b
         oMo2jq7ZdgnwtaU946dQIJe9wOZcQhZR+MPu32U5zf5iq+ujceiSEKW8fpr8bbOlyT9l
         Dc4A==
X-Gm-Message-State: AFqh2kooaU42m0H2K910WRffROeVU1ZIoUQS5K2V1SdAuJGJ0PKT7Lnn
        TxAN6wnevVxtJr1ejPBj09qeI8I5lGNfqtpiFAHTqg==
X-Google-Smtp-Source: AMrXdXsVEndUelWqeTOq/yI0y1T7Go1AUXK7I4T+7m8PmMng+9RYf16DOxvQdM/cJ77ZduwDlA9DcaAtqzg9qyhk06g=
X-Received: by 2002:a17:90a:e646:b0:229:ca6a:d742 with SMTP id
 ep6-20020a17090ae64600b00229ca6ad742mr3309663pjb.221.1674612772253; Tue, 24
 Jan 2023 18:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org> <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 24 Jan 2023 18:12:15 -0800
Message-ID: <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] of: property: do not create clocks device link for
 clock controllers
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 5:35 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Do not create device link for clock controllers. Some of the clocks
> > provided to the device via OF can be the clocks that are just parents to
> > the clocks provided by this clock controller. Clock subsystem already
> > has support for handling missing clock parents correctly (clock
> > orphans). Later when the parent clock is registered, clocks get
> > populated properly.
> >
> > An example of the system where this matters is the SDM8450 MTP board
> > (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > etc. With just dsi0_phy in place devlink is able to break the
> > dependency, but with two PHYs, dispcc doesn't get probed at all, thus
> > breaking display support.
> >
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Abel Vesa <abel.vesa@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >
> > This patch has been posted a year ago in January 2022 ([1]). Since that time
> > Saravana failed to produce patches to assist in debugging the issue
> > ([2]) or to fix the issue ([3]). The issue we observe has been described
> > by Abel at ([4]). As we work on adding support for Dual DSI
> > configurations, the issue becomes more and more important, since binding
> > the whole display subsystem fails.

I did send out a patch series[1] to try and fix this. Heck I even
talked about this in LPC 2022. So I don't think it's accurate to say I
didn't help debug this or fix this. There's some email thread in lore
where Abel gave more details and I figured out the issue and we didn't
need any more debugging. And then I sent out [1]. Sorry I missed you
in the cc lise for [1] -- I try to keep track of everyone to cc but
things slip through the cracks sometimes. But at the same time, it's
easy to check for emails from me before saying I didn't help or didn't
send out fixes :)

If you do try to give [1] a shot, there are a bunch of bugs that
people pointed out for which I gave fixes on top of [1] in the
replies. I was supposed to work on v2 over the holidays, but that
didn't happen because of stuff outside my control.

> That's ample time to fix this, so I intend to apply this. But I'll
> give it a few days for comments.

Rob, I'd recommend not applying this because it'll fix it for Dmitry
but break someone else's use case. That's the whole reason it takes me
a while to send out patches -- it's easy to fix it for a subset of
devices, but fixing something without breaking someone else is harder
(I still believe it's doable) and it takes a while to test them on all
the devices I want to test before sending them out.

-Saravana
[1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
