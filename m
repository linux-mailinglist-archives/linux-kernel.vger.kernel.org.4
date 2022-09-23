Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18445E7CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiIWOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIWOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:18:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBD113F715
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:18:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z2so453162edi.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ru59U2esiIhk7+EF+2LbnUHsFAZoPlTGUQLU9H/L14c=;
        b=lHeWZbXQLCDE5ZurhMHvC4i50bxjwMsuwGjWkCl6Gy9Gdaga5OTJi0ceH3MH4cPaZR
         QPz2VWjHblPDQPMUXr1e61RR7DbdGhRqKMaqv7SJLh57MkA/sHifI+zV8QbXUtyk4dH5
         imJtdwNU5fnhqDFcQYI2xB7/fI0W9pP9n4zUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ru59U2esiIhk7+EF+2LbnUHsFAZoPlTGUQLU9H/L14c=;
        b=jGslWXoaSqRXqLI6J1gTf5ocynDGkAt0nI3fNerrpetPTAGkkjDBEgmYUK1lKX+ji4
         kjCbvlQJo3MoiGI3hvyGVLP7S8h0uOsv6M2cPLRSDUErWb4w2c85zNISJ3EjAb9QhPhO
         BgJpTmbI7KuNM6z0t531xMd74idFxB2ZnM53cOgrgB/QPAbGsxqPo03cc7qwqw/ShN6n
         dGDI+495rM8dht5mSz2eJY2PzCDQBgSpvlb7+yEVPOUlPoaEJwhYIWdqP2iG1MkcxX14
         hxXwQuM+Aiz37uCLREdIeEXYak8jGh2VYb9e6SH8gSt0l/yabSpELRxLkCCDL0wiAImJ
         WS9Q==
X-Gm-Message-State: ACrzQf1jW9F4ApQIKl4NtJ4XDoYkAGEjX2xiijoYIrCEjCXa6YZFriD6
        GHYymfebZcJzAByBohawTs9xbHje2ohLNuxp
X-Google-Smtp-Source: AMsMyM70rT+T1G/Tw0nLSOm8ekE32E6Tx6r3D0eLKj575M2QoZbJX5CjdSsElJlcFl59O/+vP0qijw==
X-Received: by 2002:a05:6402:847:b0:453:944a:ba8e with SMTP id b7-20020a056402084700b00453944aba8emr8503495edz.326.1663942686791;
        Fri, 23 Sep 2022 07:18:06 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b0073d638a7a89sm4077251ejt.99.2022.09.23.07.18.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:18:05 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id ay36so350321wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:18:05 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:3b4:c8b6:15c6 with SMTP id
 u15-20020a05600c19cf00b003b4c8b615c6mr13369432wmq.85.1663942685258; Fri, 23
 Sep 2022 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220822180729.1.I8ac5abe3a4c1c6fd5c061686c6e883c22f69022c@changeid>
 <CAD=FV=W5X2XvvKT5tq+1ywJSmVB0TAHquGgn02uNmn4s-sqndg@mail.gmail.com>
 <CA+ASDXMetKHtL8Hm_=S7xPcHX19FDaCoXtHmh=E6i6pLEXQZ0g@mail.gmail.com> <CA+ASDXOMYGgaJSrxQUNFhN+9qT-kfedk_UJJnOO58iJpWdxu1w@mail.gmail.com>
In-Reply-To: <CA+ASDXOMYGgaJSrxQUNFhN+9qT-kfedk_UJJnOO58iJpWdxu1w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 07:17:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xqbx+fzPMYv8VJ-u3=tJf7cX-bmpHhWSOvs6tQU+cRiA@mail.gmail.com>
Message-ID: <CAD=FV=Xqbx+fzPMYv8VJ-u3=tJf7cX-bmpHhWSOvs6tQU+cRiA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm: bridge: analogix/dp: add panel
 prepare/unprepare in suspend/resume time"
To:     Brian Norris <briannorris@chromium.org>
Cc:     Zhang Zekun <zhangzekun11@huawei.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>, xuqiang36@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
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

On Mon, Sep 12, 2022 at 11:48 AM Brian Norris <briannorris@chromium.org> wrote:
>
> On Thu, Aug 25, 2022 at 11:06 AM Brian Norris <briannorris@chromium.org> wrote:
> > On Thu, Aug 25, 2022 at 10:37 AM Doug Anderson <dianders@chromium.org> wrote:
> > > Given that this is _not_ an area that I'm an expert in nor is it an
> > > area where the consequences are super easy to analyze, I'm a little
> > > hesitant to apply this to drm-misc-next myself. Ideally someone more
> > > familiar with the driver would do it. However, if nobody steps up
> > > after a few weeks and nobody has yelled about this patch, I'll apply
> > > it.
>
> For this particular patch, I'd be interested in whether Zhang Zekun
> has any feedback (even a Tested-by?), since they were patching this
> function in the first place, which is why I paid attention:
>
> Subject: [PATCH -next] drm/bridge: Add missing clk_disable_unprepare()
> in analogix_dp_resume()
> https://lore.kernel.org/lkml/20220816064231.60473-1-zhangzekun11@huawei.com/
>
> But in absence of that...it has now been a few weeks :)
>
> I'll also mark this to come back to again in a week or two, in case
> somebody is still hoping to wait longer.

At this point people have had plenty of time and plenty of warnings to
speak up if they cared. Since this is a fix, I threw this in
drm-misc-fixes.

cc62d98bd56d Revert "drm: bridge: analogix/dp: add panel
prepare/unprepare in suspend/resume time"

If anyone comes along with a late objection, we can always revert the revert.

-Doug
