Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FAB5EB961
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiI0E4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiI0E4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:56:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEAB6553;
        Mon, 26 Sep 2022 21:56:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t3so8100661ply.2;
        Mon, 26 Sep 2022 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=j36BNVGpYVmEQnZBQfKyj44H3Hy9E6/b4rFER+QdP6E=;
        b=oi7HwN7RJNZDnVszTIWyeGQSvKg0BSQkbuvG1tVU+l6ZqgAKQiK4Tv7O0JQ6empWz8
         ychjkSkxsVCw24RdV1EqRq0QHFkgX4fJks5E9KZcClOnItR+oZxwPjiWeX8ZD0iJBf5a
         8ypL3p+GxvGLkT7AK5rYvTn6R/iOcpXLEfrenbofcyCQpfkIp8/+ubi77MvExbjLER//
         pNbH/ItNIq3APoPpaHLTt7mJE3x5SlIUc036HJ+xhExRtMBFMvkHTbeVYNUite2+YQXj
         gxxamyw6bJqTylaj5mdaLYgcvygT9tF8tJY7hzelEbyLPHxwEY5rZ5BLzySiMAtFxDNZ
         Mxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=j36BNVGpYVmEQnZBQfKyj44H3Hy9E6/b4rFER+QdP6E=;
        b=xHLNCUXDcbI6w8+6yCyS1MudVzJVaZ7VfYoydq93RQWxkJflQuB0K6TFTpwCNEdAUE
         gHzKOJPdU3Fr4MEJYUOvlFckkPjj1mlb1Hq252eI9BAURK0KP37pPP9FCkBuQzNRyxaz
         YIrTA1zqs3d2U9HP7Xdy6s9K18alE8LOB16xhrdGPnrvjPPuWqUMdSJrh4lW4C5PQolM
         lYDzas/j8pMzOrHHTdyjLht219Cb8TwapwvLBwe6qbMRD6ghYaVbEgddfHLLwJyvDkp6
         kyoAgCL3ql2fcPvLDIvnN85lWprKCmQlXwxW2ktdulDWhizsYnd1iiffNdfvDHS2hPtn
         +agA==
X-Gm-Message-State: ACrzQf0/cFB6oWui+EZoSnND/jH3p0eRJHF+12BoC5AqOwpPNIq2HfdN
        swA40kSdo/U+U5wzvrEF3Ek1QHtcQ0U=
X-Google-Smtp-Source: AMsMyM4n4hRnVeUvdZ837WE3di7iyugMulTDHs6SDh9HHXKZ8JXyt4M0Ps0o58d9frDoor2bl7zgJQ==
X-Received: by 2002:a17:902:e405:b0:176:8bc1:b09c with SMTP id m5-20020a170902e40500b001768bc1b09cmr25176028ple.1.1664254571591;
        Mon, 26 Sep 2022 21:56:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b00179e1f08634sm352506plg.222.2022.09.26.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 21:56:11 -0700 (PDT)
Date:   Mon, 26 Sep 2022 21:56:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Lantiq: switch vmmc to use gpiod API
Message-ID: <YzKCaMU9wlFbPZS7@google.com>
References: <Yy08TBymyuQb27NU@google.com>
 <20220924104612.GB10628@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924104612.GB10628@alpha.franken.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Sep 24, 2022 at 12:46:12PM +0200, Thomas Bogendoerfer wrote:
> On Thu, Sep 22, 2022 at 09:55:40PM -0700, Dmitry Torokhov wrote:
> > This switches vmmc to use gpiod API instead of OF-specific legacy gpio
> > API that we want to stop exporting from gpiolib.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  arch/mips/lantiq/xway/vmmc.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> applied to mips-next.

My apologies, I screwed up. I thought this patch passed 0day before I
sent it to you, but apparently it has not.

Here is a fixup (actually cross-compiled this time), or I can send a v2
incorporating it into the original change.

Thanks.

-- 
Dmitry


MIPS: Lantiq: vmmc: fix compile break introduced by gpiod patch

"MIPS: Lantiq: switch vmmc to use gpiod API" patch introduced compile
errors, this patch fixes them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/mips/lantiq/xway/vmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index a1947306ac18..b6b0d9884b88 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -41,11 +41,11 @@ static int vmmc_probe(struct platform_device *pdev)
 		if (IS_ERR(gpio)) {
 			dev_err(&pdev->dev,
 				"failed to request GPIO idx %d: %d\n",
-				gpio_count, PTR_ERR(gpio);
+				gpio_count, PTR_ERR(gpio));
 			continue;
 		}
 
-		gpio_consumer_set_name(gpio, "vmmc-relay");
+		gpiod_set_consumer_name(gpio, "vmmc-relay");
 	}
 
 	dev_info(&pdev->dev, "reserved %dMB at 0x%p", CP1_SIZE >> 20, cp1_base);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

