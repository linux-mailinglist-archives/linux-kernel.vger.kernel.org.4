Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E076971B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjBNXU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBNXU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:20:56 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3622003
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:20:55 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-501c3a414acso228096227b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyl0p8SQm1y6pAg3OTXhzJtHEYuVho6+udK41+XIoIw=;
        b=RUqMLnE+xU+QgkbgEHXrnDs9Uxky30vazz4NOSxlTFAFy7ZDasML5PI8RzhsmulwYr
         Bk/jVbb/sY8++VJhuGxdiK/kTonD+WfNXuUBlttxJ3s6NSTIyydT09X4slKafc6mYUxY
         /lXEwZ2gBT1+GYczbOg0WmOgHNPZmpmX9keUXZp+Am0KnMQmhjNql69YfxMQWj9GhSYE
         77SmA0OXWqimlkJVoRoacd+jSIUlgu2BxfOeUGaBoJV1APBuQjDkxxypaaIEd0zrx8pX
         Vs0SOfOqI+kAI1r6qvccUbvB9MLa/H8HaNao4MNAq4miHYvHGlGg/V9rJvIRSngVr8FY
         0k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyl0p8SQm1y6pAg3OTXhzJtHEYuVho6+udK41+XIoIw=;
        b=FwcwWsGTfUnxCoFyYjjLfYwSZMKazUx+Hmf/3+wV+Ty7qgchteRmXMqe8YMTRz6Ihw
         6X87CSDVLBoRxnwVf17L6pK2AUuc/MRoeCf+jS0CChJRids0A5owSRRyvZQyg2qUX8b7
         PQfHaI5znw/jFceykzgr8vUA2M2quGRmC0DdxwFdPJkuarGENNLRCmmzS1vEcaxWaOfk
         +oD489GQRZf1Sf8hD30THZm68yQQLLYmFAIjXNAY4iL5zYYTgLAqlvrg81JTeB3lTpG+
         y57YJcvNDEvaUdqN05xt1rG+lWTciIA1BxtxN1LCh/3SgeVlDD+lfNMVqujak0ePYYQN
         hP7w==
X-Gm-Message-State: AO0yUKXPdoYchewwFFW8WCj01bMXsiTfDmZpn9El3K7y/pmtZUlwTGVP
        Vn6SDpeXVuiarw5vXMFBLj2iOn68/HXI5Y/5NSBB
X-Google-Smtp-Source: AK7set81DXuGY+35pmRfQRXMfyIQZfomwDZTe26wQ1wU4OiYtSU6DIRVKjiSSoFcGoSfR5ybJ6mHFK0A9alC75TzZLo=
X-Received: by 2002:a0d:f002:0:b0:52e:d52e:97d0 with SMTP id
 z2-20020a0df002000000b0052ed52e97d0mr40421ywe.117.1676416854744; Tue, 14 Feb
 2023 15:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20230214105412.5856-1-walter.chang@mediatek.com>
 <20230214105412.5856-5-walter.chang@mediatek.com> <1726f1d2-7411-2b49-79cd-f5aecff2d19e@linaro.org>
In-Reply-To: <1726f1d2-7411-2b49-79cd-f5aecff2d19e@linaro.org>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 14 Feb 2023 15:20:42 -0800
Message-ID: <CANDhNCrYaepM3d-xHybqc9n5j0q0iMfPiTGPZKskEWjqjD6nRA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Tue, Feb 14, 2023 at 3:09 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 14/02/2023 11:53, walter.chang@mediatek.com wrote:
> > From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> >
> > Make the timer-mediatek driver which can register
> > an always-on timer as tick_broadcast_device on
> > MediaTek SoCs become loadable module in GKI.
>
> Other questions are unanswered. Please do not ignore feedback and
> respond to it.
>

Apologies, I know it can be a pain to repeat yourself, but would you
clarify which questions were unanswered?
My initial skim made it seem like the items you raised were addressed
in some form (though maybe not sufficiently?).

thanks
-john
