Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B336298E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiKOMbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKOMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:31:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4EE1F2CB;
        Tue, 15 Nov 2022 04:31:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i21so21637540edj.10;
        Tue, 15 Nov 2022 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtOTHKIZ6A/I3hs7BfEXlQ0kPVymIIHZKezQdn2E0uA=;
        b=Xfz6iaQ0fCf4t3J0J/BuCbm8zGPkJSHj/zxhbbhNado/0mO7ara5PP0cExqXn9JNLH
         dPtQaoBSrVmitxwYbrpfwIXa1zRiT9Ws/PK4WyZeS/mRawxuHFMb3QBjdL2aD25xm39R
         Xkj2nD+LhaeGDMqoLdfGc7yn9RKKopVenXD1HRINSIWlgonUqnp35z8Adr8rb2D17hRH
         k/hnJ0M0vG6Vh+mQAi8BXmwxOmaYGzXLrf/tSxDY1RyUlbfnCt0l68qXPgRsLjHeeOq/
         C3S+ctJZooG1xcErFrZp88J7bPdxfIrDBqJAWqubuxU+SiYDIm4JoTkvJMU/1fJofzJD
         tX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtOTHKIZ6A/I3hs7BfEXlQ0kPVymIIHZKezQdn2E0uA=;
        b=OsLBqUrqZrY6KclkDg5OZFx+lG7HdKdgDpYC+PgykY7u0332iskhcvEbGYek42en/i
         /RKxUHMAWU0I6F38Cm81yJgGOHRFwV17exXVsJXUGK6PIyUQsJHbvIDa/gD+M2mY2hlT
         MepMb/HD/WGKKjAA4FFXbGJW8VdWrM+Dk71161TlUGl2RnnW1sK6qBTo3W8Awa4h07Qk
         ee1NsVBYv/FFpcx4kMcdvp79tNWJvkgK0GTEbxjIPNDthP15Wce28W4UhkSYt+V20cWk
         SrDZ/bru0qL14xNFpToLa5sAgxCD0fjLOo2xCEfHXM+D9243CbjOGOL9J3djrLOcC70V
         A9LQ==
X-Gm-Message-State: ANoB5pmlZ5ik92cmt10aWqZBTDJCcjr6MZs7W+ImYJjQDScQkIXvRCcf
        Gb8nDVCpjabPgsoz0OlAklU=
X-Google-Smtp-Source: AA0mqf7A2NRexDle89XEgIuAECuKXbb9AZrWTSaxs0rClZOqmgODazcce2pl1CGfyX+Z7NX97kAzQw==
X-Received: by 2002:a05:6402:2407:b0:467:5e4f:591 with SMTP id t7-20020a056402240700b004675e4f0591mr14635237eda.414.1668515491135;
        Tue, 15 Nov 2022 04:31:31 -0800 (PST)
Received: from felia.fritz.box (200116b826a73f00b885958edf4850c0.dip.versatel-1u1.de. [2001:16b8:26a7:3f00:b885:958e:df48:50c0])
        by smtp.gmail.com with ESMTPSA id l7-20020a170906644700b0077a8fa8ba55sm5372891ejn.210.2022.11.15.04.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:31:30 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 RESEND] MAINTAINERS: adjust ARM/INTEL IXP4XX ARM ARCHITECTURE to ixp4xx clean-up
Date:   Tue, 15 Nov 2022 13:31:02 +0100
Message-Id: <20221115123102.22732-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c83227a5d05e ("irq/gpio: ixp4xx: Drop boardfile probe path") and
commit 155e4306107f ("clocksource/drivers/ixp4xx: Drop boardfile probe
path") remove files include/linux/irqchip/irq-ixp4xx.h and
include/linux/platform_data/timer-ixp4xx.h, but miss to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Remove file entries for those files in ARM/INTEL IXP4XX ARM ARCHITECTURE.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/lkml/20220601050200.22213-1-lukas.bulwahn@gmail.com/
v2: https://lore.kernel.org/lkml/20220919081753.16934-1-lukas.bulwahn@gmail.com/

v1 -> v2:
  added tags from v1, no other change.

Linus, please pick this minor non-urgent clean-up patch for ixp4xx arm.

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 547ba994ea98..e057108f2709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2290,8 +2290,6 @@ F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/crypto/ixp4xx_crypto.c
 F:	drivers/gpio/gpio-ixp4xx.c
 F:	drivers/irqchip/irq-ixp4xx.c
-F:	include/linux/irqchip/irq-ixp4xx.h
-F:	include/linux/platform_data/timer-ixp4xx.h
 
 ARM/INTEL KEEMBAY ARCHITECTURE
 M:	Paul J. Murphy <paul.j.murphy@intel.com>
-- 
2.17.1

