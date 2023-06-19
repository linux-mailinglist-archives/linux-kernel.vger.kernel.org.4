Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A19734FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjFSJ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFSJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:25:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB7199F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f904dcc1e2so20848605e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687166687; x=1689758687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9s1x3c7QNuOFRt6lgdYLElxecPSoFAMzWLC3FdfqIZc=;
        b=Cb9+OhzFX8TWMpuDD1JYwCGZWilzSDYAhR3xdTiMAt9/9mCzMvEt8hdamjCkCiyzSY
         78WKh51J0W93yvjliKPCHhXkMrk0zEs/UE6e3F/qmF3HPf60yOrqJWW1YbuuAsEBIs2G
         LDwJrjO/kpzQkgBPrpSNQT0GSd1flMP4d1fIIw6F6BdgRGxuf15c93W2Pm+luig6hRny
         E+SqmLwtBXvmWGzVQowWyknjuVeeoQmfhRnqTbRULrxAhlTOB+OBwPnMX3s6DIC2d4Zk
         rnDAHesTXLv5Aa3CWbqBJ4yM05MvE3WCYJ6L/8oT8rVAf9i1uRVqT+V32CrUUfHrpIVZ
         H94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166687; x=1689758687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s1x3c7QNuOFRt6lgdYLElxecPSoFAMzWLC3FdfqIZc=;
        b=ipDgWsg3yd/VS/nL5Eg3jwuYwFyu2WYa460+Cwg0Y3K1A9oM2GgMCdCFLNUXVIXYaT
         6NNzf/DnLh21MZHcCB8IR5DsGohNZBndUGt+S7uyUMGPTNRIDlMYvlvP5lyrrX1N9C51
         NpT9FA2NVH2BP2b09v6cBx6yJ/ANpeAoCmxNEQIRwoW0Ovxgr7KekKK6/9aL/1p9GD/L
         VpyCwrNsTKFcEpsU/Wd7STSh04frOR/F404ACJhDj1xZpC4QiuMj5AvkIWorjnKLaCwJ
         GZILKNUmX4v+L4/WQDnDIsfoJSjpNytn/b4sIUGExHHOOOD8Wz662TNYB8fQxZ7+6Oej
         himg==
X-Gm-Message-State: AC+VfDzE2OXJSpFE6gMOHm9NWh3hpnrAYYCTKeDWr7mpa2Zt29c9jw1G
        KNYbOGTWbnT2BF9dG4j8k8cqpg==
X-Google-Smtp-Source: ACHHUZ7TD8eBZ7kJZ0iaGyNSBSM+0P0UaX8hVV1uzbY7WCnwy1BebvWpDOcaroJcFvdQHqv2msQ/0w==
X-Received: by 2002:a7b:c5d7:0:b0:3f8:2777:15e with SMTP id n23-20020a7bc5d7000000b003f82777015emr7154287wmk.31.1687166687486;
        Mon, 19 Jun 2023 02:24:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c220800b003f9b1131a90sm2202590wml.23.2023.06.19.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:24:45 -0700 (PDT)
Date:   Mon, 19 Jun 2023 12:24:41 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Fei Shao <fshao@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: Fix memory leak in devm_clk_notifier_register()
Message-ID: <32fa8c0e-26f4-4ee4-889a-4037530c128d@kadam.mountain>
References: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
 <35f6212e-69f8-432f-a5c8-99ed5c844f11@moroto.mountain>
 <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:05:47PM +0800, Fei Shao wrote:
> On Mon, Jun 19, 2023 at 4:48 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Mon, Jun 19, 2023 at 11:22:53AM +0800, Fei Shao wrote:
> > > devm_clk_notifier_register() allocates a devres resource for clk
> > > notifier but didn't register that to the device, so the notifier didn't
> > > get unregistered on device detach and the allocated resource was leaked.
> > >
> > > Fix the issue by registering the resource through devres_add().
> > >
> > > Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_register")
> > > Signed-off-by: Fei Shao <fshao@chromium.org>
> > > ---
> > >
> >
> > Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> >
> > How did you find this bug?
> >
> > I can think of some ways to find this bug with static analysis.
> >
> 
> It was actually detected by kmemleak on an unreleased Chromebook device.
> I added the trace snippet in the message at first but removed that
> before sending this. Maybe I shouldn't have.
> 
> I can resend a v3 to add that back if that's preferable. What do you think?

I'm not a clk maintainer, but let's not go overboard resending patches,
especially when they're as straight forward as this one.

This is good information though so I would include that kind of stuff in
future patches.  I don't really need to see the kmemleak warning itself
because I know what those look like already.  But to me it says a lot
that actually this was detected at runtime.  It says good things about
your test infrastructure and makes me feel more confident that your
patch is correct.  So maybe just a comment that "This leak was detected
by kmemleak".

regards,
dan carpenter

