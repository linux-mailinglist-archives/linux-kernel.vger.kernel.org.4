Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67B67BA66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjAYTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbjAYTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:09:52 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F55CFE3;
        Wed, 25 Jan 2023 11:09:28 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-142b72a728fso22528305fac.9;
        Wed, 25 Jan 2023 11:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MLmGkT2SK3f360t9hf5/htptUivca3wX/My0WtWeik=;
        b=307IN5qvaajpRAnXCvKDdL0x6I6+pAnUmj4+ugYb/zWm8rERnSR6irTm7XxcIucjb2
         /mPQknzqLoUEVp47rjOoB5wSulCbuvcMhnHYE7lTiTBHG7x0I6FQwQu7cibcXTnDRP3H
         dCTVGdm9w+/Bq+Z4q1VGVhfQBOwHtu0s3V0ry++oAKWPA795YReffMA0ACAtvhrFRf7m
         3AWs/+1V1fq9HpoP/qJ5U0WzuXTPBwH7/1BwM2G2/bhAezg1gJCswVB/Nh7CcAC2Rfy/
         fF3bPx5OiZGhsnBrEFxkzns6HQcwrGSiodphOGQc+Zw2dbsVwrOe3041gyqTIhWbTEJ6
         b6uA==
X-Gm-Message-State: AO0yUKVueAIVQd/Cn/QIDCLxEX7Xig7hrpESCQm/QASHshKQWgiLThFR
        YdoqogRfci2xgwxlN8c1ZA==
X-Google-Smtp-Source: AK7set+iyXhDM22xjyMk3SIjhPT70nD64XpeZf2Q/Xj3FLeInvBumyjmQ0xW3gQOk4H4Kjnqdj+8mQ==
X-Received: by 2002:a05:6870:472c:b0:163:3070:9059 with SMTP id b44-20020a056870472c00b0016330709059mr1870593oaq.46.1674673767603;
        Wed, 25 Jan 2023 11:09:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o36-20020a056870912400b001446480a042sm2189442oae.58.2023.01.25.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:09:27 -0800 (PST)
Received: (nullmailer pid 2698868 invoked by uid 1000);
        Wed, 25 Jan 2023 19:09:26 -0000
Date:   Wed, 25 Jan 2023 13:09:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [RESEND PATCH] of: property: do not create clocks device link
 for clock controllers
Message-ID: <20230125190926.GA2697290-robh@kernel.org>
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
 <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8Xy5OzsbW3123esxsbQJq-SqDkP1S5g2mmwzoCz4shtQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 06:12:15PM -0800, Saravana Kannan wrote:
> On Wed, Jan 18, 2023 at 5:35 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > Do not create device link for clock controllers. Some of the clocks
> > > provided to the device via OF can be the clocks that are just parents to
> > > the clocks provided by this clock controller. Clock subsystem already
> > > has support for handling missing clock parents correctly (clock
> > > orphans). Later when the parent clock is registered, clocks get
> > > populated properly.
> > >
> > > An example of the system where this matters is the SDM8450 MTP board
> > > (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > > clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > > dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > > etc. With just dsi0_phy in place devlink is able to break the
> > > dependency, but with two PHYs, dispcc doesn't get probed at all, thus
> > > breaking display support.
> > >
> > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Cc: Abel Vesa <abel.vesa@linaro.org>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >
> > > This patch has been posted a year ago in January 2022 ([1]). Since that time
> > > Saravana failed to produce patches to assist in debugging the issue
> > > ([2]) or to fix the issue ([3]). The issue we observe has been described
> > > by Abel at ([4]). As we work on adding support for Dual DSI
> > > configurations, the issue becomes more and more important, since binding
> > > the whole display subsystem fails.
> 
> I did send out a patch series[1] to try and fix this. Heck I even
> talked about this in LPC 2022. So I don't think it's accurate to say I
> didn't help debug this or fix this. There's some email thread in lore
> where Abel gave more details and I figured out the issue and we didn't
> need any more debugging. And then I sent out [1]. Sorry I missed you
> in the cc lise for [1] -- I try to keep track of everyone to cc but
> things slip through the cracks sometimes. But at the same time, it's
> easy to check for emails from me before saying I didn't help or didn't
> send out fixes :)
> 
> If you do try to give [1] a shot, there are a bunch of bugs that
> people pointed out for which I gave fixes on top of [1] in the
> replies. I was supposed to work on v2 over the holidays, but that
> didn't happen because of stuff outside my control.
> 
> > That's ample time to fix this, so I intend to apply this. But I'll
> > give it a few days for comments.
> 
> Rob, I'd recommend not applying this because it'll fix it for Dmitry
> but break someone else's use case. That's the whole reason it takes me
> a while to send out patches -- it's easy to fix it for a subset of
> devices, but fixing something without breaking someone else is harder
> (I still believe it's doable) and it takes a while to test them on all
> the devices I want to test before sending them out.

Okay, will give it a bit longer.

Rob
