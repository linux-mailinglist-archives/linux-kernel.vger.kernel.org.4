Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CEB5F118C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiI3SXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiI3SXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:23:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45A120BF3;
        Fri, 30 Sep 2022 11:23:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v186so4937677pfv.11;
        Fri, 30 Sep 2022 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=yNOkCRuUYeWkrNIpn/XORihFa9TD9NE+j1Uh42bypbY=;
        b=gRE6Llbs2lycjjyV03Wsvk3UJhV4FIFEPEzkpz36W1QeQTV9Y9+nKqIztPruYiccEf
         CQz7NT2FCLkd2ITgcMUYHnUva1sgJktCCyMf4nDtKiU9ch40A+MTjjAeTnvs/yj6yT14
         Xz9lriUMdf0nc78WciChTWQeY8GYCUJ8nGEWnNYhXS7Kt+trWHXRLFwXVshhR0c4sBHh
         U9A8dYFcqYxzBD9BDBDDss+RhcBzZ41dqkAM+QPDM4+t7QgMCVRI+mxFBX4bv99OZ4eT
         HI0MFb1QqMUWGtO1T5ThjD5bEkgt8ABYRPino3POUcYRmVkP5PK6DtdgOPd+aEJkLGYD
         n/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yNOkCRuUYeWkrNIpn/XORihFa9TD9NE+j1Uh42bypbY=;
        b=vHiYCYjKKwUqRCwFk9v/AUJ2cGZsZhXpSkmboQuv9KEVsx3upBkmfaNHNYGXha67mw
         IQZSoT1FiEERUbc8kd3f6QNnVgM0wxsXd7TxSBAs/4p2ffjbhDd89CpjWnUBH4/PnXx4
         aygqD02S+UuEVb4dCnrW7PBIqWa0sOHJEWJuhbApTTCo+9F1JUQYDlGinJdU5x9pmovc
         LhqsGBnJ3eEhVOHQAZkiQnQyAXIAw4KqvZu8Of9XGMq5Lg2GqKciiEL9hP/mE6jaYAyG
         HQJDNV8JWSgLxf3QZurQ1wNA1qu/jPpZohK2CkaOd7O5Jsk3sm/91myI1rVPit+p/Kfx
         V8vA==
X-Gm-Message-State: ACrzQf3YAuD4qcFCiJKEleTwegBTBguGf23tM75pITnlVHU+9Qfqdd32
        zWIFYdk1BcqJu9t7pokU7/c=
X-Google-Smtp-Source: AMsMyM4im5X8+ytP+H9igb+lohWXqH83KTi2/Mwy3GiMhKk3E8OIyLrDffZtVRvthT+PlJ1LaUwreQ==
X-Received: by 2002:aa7:946f:0:b0:541:fcf0:31d7 with SMTP id t15-20020aa7946f000000b00541fcf031d7mr10114405pfq.35.1664562186847;
        Fri, 30 Sep 2022 11:23:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d016:f5be:4ff2:43f])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a00c900b00205f5ff3e3bsm3902825pjd.10.2022.09.30.11.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:23:06 -0700 (PDT)
Date:   Fri, 30 Sep 2022 11:23:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-c: fix polarity of at86rf233
 reset line
Message-ID: <Yzc0B6jNsZyQZizj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at86rf230 driver starts with having reset line high, and then drives it
low and then high again, and even calls it "rstn" internally, therefore
it needs to be annotated as "active low" in the DTS.

This will make difference when at86rf230 driver will be converted to
gpiod API that respects declared line polarity.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index de79dcfd32e6..f892977da9e4 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -259,7 +259,7 @@ atzb-rf-233@1 {
 		xtal-trim = /bits/ 8 <0x06>;
 
 		sleep-gpio = <&gpio0 24 GPIO_ACTIVE_HIGH>;
-		reset-gpio = <&gpio6 10 GPIO_ACTIVE_HIGH>;
+		reset-gpio = <&gpio6 10 GPIO_ACTIVE_LOW>;
 
 		fsl,spi-cs-sck-delay = <180>;
 		fsl,spi-sck-cs-delay = <250>;
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
