Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4831693EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBMHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBMHmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:42:05 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E7E3B3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:42:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id by3so9810535wrb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkcICsNhEU3d9tXzff/t2x809VmrN16PslQXHTNnYGM=;
        b=CWGBkVYaqwkHpd/Gy5btELcuJ8o3jHeujUhaFF8inQ8Jo78q2hU2jWPvxLuJEZFuUc
         9qqMrWvRL1g3dH63M2XaTXzXG5Cr2EYuryEU/e1Jkgprv1zydTaMnqFa6JBsh62KYKbN
         phjEaQU5G9g/qEmyJs08kOG8LR0L4xXe0Y3LT5E+0QK8Ko5EG300QFfUUZsakSpaGkdW
         JwtaPYHUuM5BHcStEb1Sysq4BTWXlregVT1cc7amd9IpdrPeOrhzj4p+XxA/39AFLmOf
         s4NZimpBErK4m1iisdwwLvFoc1X7BdWJJU+1sAtATBg0LFkGtmozDUK0IJ6mvCAo+UWO
         dNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkcICsNhEU3d9tXzff/t2x809VmrN16PslQXHTNnYGM=;
        b=VsCwFoCLEblca41vzl7bciqqwa5owwg7nHqk9tifVSPldsolBBtLLFylpGuw72AtmJ
         7zVOpfEobR8WAJEVaVQqJ+J4/stIIlfz/egpKs+76fORh6Cq57Cei5wcfaocLVGhy6Em
         WutqovDcI1OkghXzDeE65hS/P6MvAIskzE/L5IteD/jxWW2gZKPikanOIB3u4NzvpT9i
         QRJtzmXuqUGO28GPT6Om+4eqajWM9HWaIBWTq02/v+urPaQwtAtfZA8/eisLg7oSC+qw
         fPtFp4Xl+CFmLCjMRcbsLPUZ1VeUWLQBVHC45jFqWzdf6LTqlLpgQxqZ8CfAX6x+O+9W
         +K4A==
X-Gm-Message-State: AO0yUKWQ7qrldV/Gh1U09myeBGtDmUTmus+2loXf0BwHCSPFEM7iYOc9
        Pq577pwQrHNTfkDkEo5WY1y6EQ==
X-Google-Smtp-Source: AK7set9Parg0elqGoKFE2NlW3nK6McqblFHlJe/YUstOKW6WpXRElM/EaaFyEzr8NUViQtRPLJCTRA==
X-Received: by 2002:a5d:5311:0:b0:2c5:5edb:7068 with SMTP id e17-20020a5d5311000000b002c55edb7068mr414542wrv.60.1676274120183;
        Sun, 12 Feb 2023 23:42:00 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b002c556a4f1casm2728080wrt.42.2023.02.12.23.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 23:41:59 -0800 (PST)
Date:   Mon, 13 Feb 2023 09:41:58 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>,
        Peng Fan <peng.fan@nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "18701859600@163.com" <18701859600@163.com>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Message-ID: <Y+npxisKxJaaSrul@linaro.org>
References: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20230111101030.686885-2-Qing-wu.Li@leica-geosystems.com.cn>
 <Y8VfEfnWwt8+QB1W@linaro.org>
 <a1285cb87151130de782fc1941b13f34.sboyd@kernel.org>
 <Y9VruNgUuA5h3d70@linaro.org>
 <AS8PR06MB74325B5E249EC287F052518BD7D39@AS8PR06MB7432.eurprd06.prod.outlook.com>
 <911ff831eaa686c87682d8e95e90326c.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911ff831eaa686c87682d8e95e90326c.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-30 14:34:30, Stephen Boyd wrote:
> Quoting LI Qingwu (2023-01-29 23:44:22)
> > 
> > > > Is it needed for clk-fixes? When did the system start hanging?
> > > 
> > > Li, Peng, can you provide some details here?
> > 
> > Since IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV were not assigned,
> > if using any one of them in device tree, Linux system hanging after start M7 core.
> 
>  $ git grep -e IMX8MP_CLK_M7_SRC -o -e IMX8MP_CLK_M7_DIV
>  include/dt-bindings/clock/imx8mp-clock.h:IMX8MP_CLK_M7_SRC
>  include/dt-bindings/clock/imx8mp-clock.h:IMX8MP_CLK_M7_DIV
> 
> so we're OK to let Abel apply this?

Replying here as the CC emails in Li's next-in-thread email are all messed up and
the reply I sent there bounced back.

As Stephen pointed out, in upstream, there is no current user for those
two clock IDs. So I suppose we can keep the Fixes tag, but currently,
on upstream, there is no chance a consumer could hang as there is no
consumer yet for these clocks.

Stephen, I'll add this to my 6.4 material, again, since there is no
actual comsumer yet, if that's OK with you.

