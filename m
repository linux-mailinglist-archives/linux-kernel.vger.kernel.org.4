Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0A65F97F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAFCT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAFCTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:19:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36A063192
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:19:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so340822pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 18:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3c7r5CVeKCtGkrjBQKe2j2BkzZGAFZSBu4iQLvl/Dc=;
        b=ymOp4FsBVO3b1dCJgqCzg2dWBwFCIirOuHMEwXPctLHzaUPUF3He3otmmrBLRffN0C
         cjMipDRv32HQ1aatzMbbZv5mbht4mT0D9Bl2TSXPvO2JMzawqNQ7C9MeUk7m+IdBcOTL
         rdSF9mxuTnYGxMvE7dUXnb3D9Nd83ReJXsJ+xadvl63kIOAmTUPwUVXYrMkBSseyVLHI
         hrC9PUCo6VYymAcVwF6aXI9ANK0i6C9dNLRn0wGoh6ESD5Pf3qzBi9nLtCzO+BFAIbsv
         BY6d+lZxJ/xAUVfr36mHi16cRTmYa0K+pSZrgZxQo6OJiVKak7qhoJts32z5haX7Yflz
         B38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3c7r5CVeKCtGkrjBQKe2j2BkzZGAFZSBu4iQLvl/Dc=;
        b=ISPYwR6ce9D3UPDlHqi53RkEZ7S+pfAC8QUmfgvhftMBeeBxj4XZtazQjqpSi4tkQe
         mejzwSV8UP8LYrEyuZfZ71Si7Ur97CBqXNvkpHavlcKBwHIY0oQXfL8Ib9fza6r1cXhl
         Yw0bNPMsFjMU1vSCcZEQnkmY49nEjE1crtd9Rnb4wNEfE1xSZ2JCsRHH/ihaagK8Rsf4
         Eze+IPGkozZuY94SlhAkVJ0VaBg0ZLsN/hdakTDf+ycFLI637nXgtBuRyWc4P0ok6PRm
         hlZXriHIVC97IP8Tn7SPL5mruhWoOyEzzhwgrXkVX+VwUlu1z0B1Eehlt23RJDnkUNbW
         3Apg==
X-Gm-Message-State: AFqh2kpo/CLk7zxCb+o9PAFxy2c4m7ZjEkP6fDmvddDU4rdvLSj/cipx
        sKOxOrhYHh1N5aS7iwLFUBN4OQ==
X-Google-Smtp-Source: AMrXdXt+zMra2PsOltyR7AhUQ+yAJvYJwHcUm6/hIXZneUjM6OQ2KmRhnJ6wy9bINmE2ogH9ZVjBLg==
X-Received: by 2002:a17:90a:7e14:b0:219:eeb9:943f with SMTP id i20-20020a17090a7e1400b00219eeb9943fmr55978542pjl.49.1672971563379;
        Thu, 05 Jan 2023 18:19:23 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a134100b002260b06befbsm1890357pjf.16.2023.01.05.18.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 18:19:22 -0800 (PST)
Date:   Fri, 6 Jan 2023 07:49:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 04/27] ARM: pxa: drop pxa310/pxa320/pxa93x support
Message-ID: <20230106021920.65cnix2lmcj6k5bs@vireshk-i7>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-5-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-01-23, 14:45, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is currently no devicetree support for any of these three
> SoCs, and no board files remain. As it seems unlikely that anyone
> is going to add DT support soon, let's drop the SoC specific code
> now.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/pxa3xx-cpufreq.c |  21 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
