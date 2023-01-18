Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A076C671EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjAROCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjAROBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:01:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FBF1E1FB;
        Wed, 18 Jan 2023 05:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BF72B81BA0;
        Wed, 18 Jan 2023 13:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C025C433F2;
        Wed, 18 Jan 2023 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674048928;
        bh=iSLaGYMD0HGZ30iuRMXDkCFCgcqSG3diGiexB8pSxig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WUj0lps7viC4AvXHYSCMK17qgobG2rk2UZhrn9BK8EuqNQhB3gcbcYwzVyZc1OHNN
         FnlZNPh/Kg9H8us26l1IwoOaFWjBa5rgVohIpSaxH5CIQN/eFivnMHQkc8/t7f1xud
         Xc1M58A3KpgwH8tI2RV+twDC8FL1gp2fLs8ZsrNmwn3w3pgkSa4fESaAIF6ZPW9Pok
         jIZkqm9ypnGp815y+H1VDRRsf5HtJwS4i+b/Y6oH7OkxyyUns9BWvk+i0jZvgXqA/F
         EPDiC7Ai9aIAMWiBWHIRjVIRczUJq/K6c1bjzUMTL4ZsSvn7CpSPAmmZwQlux4E6sr
         TGiyhV953vWeQ==
Received: by mail-vs1-f52.google.com with SMTP id i188so35693074vsi.8;
        Wed, 18 Jan 2023 05:35:28 -0800 (PST)
X-Gm-Message-State: AFqh2kqdLw93SAYynaAWpiUSNQwnFGBYUGEiFR7A1hKPc2ne2ZA+pWgK
        mNfBfVeA3CTbripJCBjH7c3xSA9xmSa6I0T1Sg==
X-Google-Smtp-Source: AMrXdXsQgDu+6THrqhsUy92HKPFkhWpVl7EBED13ti83RaLsX8YIerriMvB4/wUrYXRK4saZKR7sbXUKnFYlSnbWlJI=
X-Received: by 2002:a67:f441:0:b0:3d3:e619:3c9f with SMTP id
 r1-20020a67f441000000b003d3e6193c9fmr821243vsn.6.1674048927116; Wed, 18 Jan
 2023 05:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20230118091122.2205452-1-dmitry.baryshkov@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Jan 2023 07:35:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
Message-ID: <CAL_JsqJ=0neiZ4wkPiMqJMT4E1O_xO0uLrTmEGUcnZMqxkw4UQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] of: property: do not create clocks device link for
 clock controllers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 3:11 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Do not create device link for clock controllers. Some of the clocks
> provided to the device via OF can be the clocks that are just parents to
> the clocks provided by this clock controller. Clock subsystem already
> has support for handling missing clock parents correctly (clock
> orphans). Later when the parent clock is registered, clocks get
> populated properly.
>
> An example of the system where this matters is the SDM8450 MTP board
> (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> dispcc itself provides clocks to both PHYs, to the PHY parent device,
> etc. With just dsi0_phy in place devlink is able to break the
> dependency, but with two PHYs, dispcc doesn't get probed at all, thus
> breaking display support.
>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>
> This patch has been posted a year ago in January 2022 ([1]). Since that time
> Saravana failed to produce patches to assist in debugging the issue
> ([2]) or to fix the issue ([3]). The issue we observe has been described
> by Abel at ([4]). As we work on adding support for Dual DSI
> configurations, the issue becomes more and more important, since binding
> the whole display subsystem fails.

That's ample time to fix this, so I intend to apply this. But I'll
give it a few days for comments.

Rob
