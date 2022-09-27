Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4D85EC7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiI0P35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiI0P3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:29:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9B5B05D;
        Tue, 27 Sep 2022 08:29:46 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v4so9701195pgi.10;
        Tue, 27 Sep 2022 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=PC+Hc/elvhqTxTichDVkzstNbLimlhIdma1wjUftGTc=;
        b=hLKo1tDIgy2HnketeqSERYw+Xfike0Fp1Qla07Ws9mTgjldMP3sFEGxTiH5nwJFCPa
         FA5/JEmj9gzJrZe82i8nsRv5tX2AAmaBv7RlapuekSy2o64HK3XKo8zdPEzVLDyPLYHa
         JkWb5qopYjv7eS+d00EsIEQAEAvu3XyquLXmBEOV20zbMVO/oeLZEZzw9Yn3XA6ElnA1
         aPCMA3O2IOxocnD2DFn83JMV7O2P9rA0bt/mhrNc+7eV0fkGTIzbWgODNEVVBzCPg179
         GlxtxluiK9Dl4UcrE1eDZEbtWSj4O+0sV4Ay8AQIMNVvDxkia3VuytTaPgn3DuhX0dlE
         XlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PC+Hc/elvhqTxTichDVkzstNbLimlhIdma1wjUftGTc=;
        b=UJqbe06gOR7Niyy4Bkwt9MKULGdcByjDaXM7d0NeqkW1wd22RolXBvP94MNuU7shWs
         z3q8V5CSYwrZecQ26atmbDxODj0P/ijHJNmI2RHseffxSUMgS2ziVyiKCFPrlegGCmrp
         la7avsmAPIA3YXVQst63Qax0kha0ERNsM8yM4OAZh66A4MmBqHvSa7cahL4eoXmLrVB3
         bNPFt/hlwADAKaikgxn8F6Qt73qa/rx134pzg+XIpUeGnmpkT2jsw89ba+tdFT25d8Ps
         /VQGePGHlsdo3fwnFLY7ZbzdpR0lOIvcaJx0uN/rDYAEni8EPQIQR3712JvHdZgpxKpu
         kkmA==
X-Gm-Message-State: ACrzQf1Zkg9auPu5ePZ3AvI8mXLB9Q6eiqnC8Pv9a1tUNuHTBJ+vnFrs
        x7q0cT8ypfAa4N0R6ZqKRsE=
X-Google-Smtp-Source: AMsMyM4YRA4lddzql9hdXREYL8v+/lNRtKkx83Gqym/TdYjSXXENTPY60MOn6KNGP3uv4GzaZxAVxQ==
X-Received: by 2002:a62:2985:0:b0:544:77d4:f43b with SMTP id p127-20020a622985000000b0054477d4f43bmr29990954pfp.9.1664292585910;
        Tue, 27 Sep 2022 08:29:45 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id w16-20020a63d750000000b00439dfe09770sm1632222pgi.12.2022.09.27.08.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:29:45 -0700 (PDT)
Date:   Tue, 27 Sep 2022 08:29:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Lantiq: switch vmmc to use gpiod API
Message-ID: <YzMW5r5+1NY1tual@google.com>
References: <Yy08TBymyuQb27NU@google.com>
 <20220924104612.GB10628@alpha.franken.de>
 <YzKCaMU9wlFbPZS7@google.com>
 <20220927074953.GA6127@alpha.franken.de>
 <791EE67B-9A27-4A3F-BE0E-A62CDB5CE9FA@gmail.com>
 <20220927082946.GA7667@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927082946.GA7667@alpha.franken.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:29:46AM +0200, Thomas Bogendoerfer wrote:
> On Tue, Sep 27, 2022 at 01:08:35AM -0700, Dmitry Torokhov wrote:
> > On September 27, 2022 12:49:53 AM PDT, Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > >On Mon, Sep 26, 2022 at 09:56:08PM -0700, Dmitry Torokhov wrote:
> > >> Hi Thomas,
> > >> 
> > >> On Sat, Sep 24, 2022 at 12:46:12PM +0200, Thomas Bogendoerfer wrote:
> > >> > On Thu, Sep 22, 2022 at 09:55:40PM -0700, Dmitry Torokhov wrote:
> > >> > > This switches vmmc to use gpiod API instead of OF-specific legacy gpio
> > >> > > API that we want to stop exporting from gpiolib.
> > >> > > 
> > >> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >> > > ---
> > >> > >  arch/mips/lantiq/xway/vmmc.c | 22 +++++++++++++---------
> > >> > >  1 file changed, 13 insertions(+), 9 deletions(-)
> > >> > 
> > >> > applied to mips-next.
> > >> 
> > >> My apologies, I screwed up. I thought this patch passed 0day before I
> > >> sent it to you, but apparently it has not.
> > >> 
> > >> Here is a fixup (actually cross-compiled this time), or I can send a v2
> > >> incorporating it into the original change.
> > >
> > >I need a fixup, but this one still fails in my build:
> > >
> > >/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc.c: In function ‘vmmc_probe’:
> > >/local/tbogendoerfer/korg/linux/arch/mips/lantiq/xway/vmmc.c:43:5: error: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long int’ [-Werror=format=]
> > >     "failed to request GPIO idx %d: %d\n",
> > >     ^
> > 
> > I see, I did not realize PTR_ERR() is actually long. I guess I can introduce a temp variable and use PTR_ERR_OR_ZERO(), but there are a lot of places in the kernel that use %d and PTR_ERR(). I wonder why we can't define PTR_ERR() as (int)(long)ptr or something.
> > 
> > What compiler/version are you using for your builds? 
> 
> it's rather old:
> 
> gcc version 6.1.1 20160621 (Red Hat Cross 6.1.1-2) (GCC) 

OK, I tried the below with gcc 12.1.0 cross-compiler, hopefully this
does not trip on 6.1.1.

Thanks.

-- 
Dmitry

MIPS: Lantiq: vmmc: fix compile break introduced by gpiod patch

"MIPS: Lantiq: switch vmmc to use gpiod API" patch introduced compile
errors, this patch fixes them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/mips/lantiq/xway/vmmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index a1947306ac18..2796e87dfcae 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -29,6 +29,7 @@ static int vmmc_probe(struct platform_device *pdev)
 	struct gpio_desc *gpio;
 	int gpio_count;
 	dma_addr_t dma;
+	int error;
 
 	cp1_base =
 		(void *) CPHYSADDR(dma_alloc_coherent(&pdev->dev, CP1_SIZE,
@@ -38,14 +39,15 @@ static int vmmc_probe(struct platform_device *pdev)
 	while (gpio_count > 0) {
 		gpio = devm_gpiod_get_index(&pdev->dev,
 					    NULL, --gpio_count, GPIOD_OUT_HIGH);
-		if (IS_ERR(gpio)) {
+		error = PTR_ERR_OR_ZERO(gpio);
+		if (error) {
 			dev_err(&pdev->dev,
 				"failed to request GPIO idx %d: %d\n",
-				gpio_count, PTR_ERR(gpio);
+				gpio_count, error);
 			continue;
 		}
 
-		gpio_consumer_set_name(gpio, "vmmc-relay");
+		gpiod_set_consumer_name(gpio, "vmmc-relay");
 	}
 
 	dev_info(&pdev->dev, "reserved %dMB at 0x%p", CP1_SIZE >> 20, cp1_base);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

