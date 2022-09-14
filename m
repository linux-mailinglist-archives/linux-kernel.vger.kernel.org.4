Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8385B8A78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiINO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiINO1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:27:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A92646;
        Wed, 14 Sep 2022 07:27:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f20so18048112edf.6;
        Wed, 14 Sep 2022 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=JP95ma47qrdvlJsJm3fTS/uHsMwIKJEK/YCLI3Ebq8k=;
        b=IVEuXnuTA8UzHQMeXwKt0RDG2RTegpBNa95gy7LChIIc1a6cuWpxAoDg3zSItZiWj6
         TrtGrsJaWog/G7Z9f5WTgDFLHgUD8FKUyvZ6uX3Wqum7masupsarPkgxA5OQ1C3Nd6wl
         4nyTGYLQTk199yhVI9YQwjJh91oVNWWssBjyFqNNSf1/xJfdTegvkLKm0FcDC66boYlE
         2d/xv9oUvl7Sa3AayW3TAGr6KYBeaY/nTAV9RYCp+dvt+7V0qf0MfYy5NY5cU31DS61d
         LuB3Q5ZZwEF93ne2HAES0BKJllANLIszmx3CdcF+IQPec5iWHuFKBpFob126Yf2oSYqo
         IsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JP95ma47qrdvlJsJm3fTS/uHsMwIKJEK/YCLI3Ebq8k=;
        b=VDEL+QIRvdCKow9/b0db3u//28KwhUxgp8M0IJ4nuyL/H6+bUGCXK4fkJ5uOiaWzdi
         XpGTevuwumi38eCfdKHwl05R9V3TYnS+yZrUyhs9k3r/CX458ayAJdv35XlnkZKvJ/5j
         dTQmlcI2uW7uxIQVFsnXcqmKMwCHx4z/u+ymP4lkbbEBh89lZq9ckrq5r4Rp1imy3I97
         pV1MdaR5kTM0XFs4QrQk6iVFXXGwSSKvo9+zX6RRn9hpDskPsPbjE7g49XNZVg3FtH2Q
         BcUOMYFSvTwJRBJN206CrgOPGsS6EP/O7nFhVGF7KEPS+WsoSSmlfC3NvOmmFD+FY8RF
         TfOA==
X-Gm-Message-State: ACgBeo1YpAcfbOB3+YE1qpr8U1HJ+voJDU6eCP3R3Usd079NBC0ycKjJ
        oILGCKd1NrndHmCMxooY/nc=
X-Google-Smtp-Source: AA6agR7jrqjjbW1nGf4SWamFa9Q3aRZ4Nvb6DDs925fLoaNgiZdO+0utdRYQY1YV2FcBxWVywTEAHA==
X-Received: by 2002:a05:6402:1655:b0:44e:b208:746d with SMTP id s21-20020a056402165500b0044eb208746dmr31218126edx.229.1663165663670;
        Wed, 14 Sep 2022 07:27:43 -0700 (PDT)
Received: from felia.fritz.box (200116b826cf470059b9799edefde240.dip.versatel-1u1.de. [2001:16b8:26cf:4700:59b9:799e:defd:e240])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906329200b007708635be05sm7661502ejw.4.2022.09.14.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:27:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] ata: make PATA_PLATFORM selectable only for suitable architectures
Date:   Wed, 14 Sep 2022 16:27:13 +0200
Message-Id: <20220914142713.29351-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
References: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is currently possible to select "Generic platform device PATA support"
in two situations:

  - architecture allows the generic platform device PATA support and
    indicates that with "select HAVE_PATA_PLATFORM".
  - if the user claims to be an EXPERT by setting CONFIG_EXPERT to yes

However, there is no use case to have Generic platform device PATA support
in a kernel build if the architecture definition, i.e., the selection of
configs by an architecture, does not support it.

If the architecture definition is wrong, i.e., it just misses a 'select
HAVE_PATA_PLATFORM', then even an expert that configures the kernel build
should not just fix that by overruling the claimed support by an
architecture. If the architecture definition is wrong, the expert should
just provide a patch to correct the architecture definition instead---in
the end, if the user is an expert, sending a quick one-line patch should
not be an issue.

In other words, I do not see the deeper why an expert can overrule the
architecture definition in this case, as the expert may not overrule the
config selections defined by the architecture in the large majority
---or probably all other (modulo some mistakes)---of similar cases.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index c93d97455744..fc11d9d30d72 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1102,7 +1102,7 @@ config PATA_PCMCIA
 	  If unsure, say N.
 
 config PATA_PLATFORM
-	tristate "Generic platform device PATA support" if EXPERT || HAVE_PATA_PLATFORM
+	tristate "Generic platform device PATA support" if HAVE_PATA_PLATFORM
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems.
-- 
2.17.1

