Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DCB5F0F77
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiI3QBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiI3QAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:00:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8745F47;
        Fri, 30 Sep 2022 09:00:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so9513223pjs.1;
        Fri, 30 Sep 2022 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=FS9U4HiZAsGgqY/DtnJrlxHPe7Vei1czp0bKBblV4Uc=;
        b=br741/GY9rSbibEBjMBhau94yLKjJqtsQtO19w5CXjjsM5PsSsivKf8ppdelCmY0dO
         FCsvwPHzbWlg243ALrMXkmpZMjJY0VBKPJDby7czLfxnMHIOEZMznCYLM6YJBRgIXcmc
         rABibBNH53Cg7E/Ap5QwI+jtfg7MkKwiCyU5NkxzRvxwPeIXDfKU1vKTY8N9LiWy3Ves
         nPUDe02OWKGu4/ufGGp2AU4ZPr5qB3PNMgsVfhn2cJLp0KlRvxCQLQAwkHsilFQr49sj
         eno1qIir1FgMHKv0DzPIKprxoiL+KJRDutG2SslTvB2xLchl7Fsb+lnOQnbNrBFO3sbp
         CkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FS9U4HiZAsGgqY/DtnJrlxHPe7Vei1czp0bKBblV4Uc=;
        b=vKOFAVUDHsAhlupFK2Reb+q5ntxZoq/fkZE9r2WHK/6zA0+rSjgtOZcZ5g2ozO20D5
         yI6cVlRwTLYvXIzTUF2f1TtI2Sxs1AcxhTnsokflZ916znj24E62BeVIUTHE2wvkGi2z
         fWmpk1MNpwYC9I8p2I9Aczil1LCHa/0kImEce6Qxee9oRBrwfgtmFH83CLOQ4zBPIgd5
         V80IcxOJ+6DPQL0Z1+qwI6JPLkyTebnqCaEPstpWsU5bLZE+FpJsZh5W8p3tHXKaOzUT
         /oPo3gk9OziPpDQc6SN9mn1PMnIbHLcBOUFd/zwOGDKJe6im2m0ZRCOQI2mzebIcG7t9
         oQpg==
X-Gm-Message-State: ACrzQf0JCi0q9Y1fHJL2KyW6Zx48fecTnR/7T0B7sObruVE8XScUtH47
        j05wSbsBXNdzURsgreR8y0rHUVliIxU=
X-Google-Smtp-Source: AMsMyM7K2u60Bd00aifMbQajqGPv6qAb7CRoVEICF5d9uR5AWqPALzslMAiO4FemKpSp/kTzMSSiqA==
X-Received: by 2002:a17:90a:8909:b0:203:ab27:a41 with SMTP id u9-20020a17090a890900b00203ab270a41mr10667520pjn.163.1664553644724;
        Fri, 30 Sep 2022 09:00:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d016:f5be:4ff2:43f])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902bd0600b0017854cee6ebsm2079059pls.72.2022.09.30.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:00:44 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:00:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: stihxxx-b2120: fix polarity of reset line of
 tsin0 port
Message-ID: <YzcSqZdpNbdINp4Q@google.com>
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

According to c8sectpfe driver code we first drive reset line low and
then high to reset the port, therefore the reset line is supposed to
be annotated as "active low". This will be important when we convert
the driver to gpiod API.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: fixed typo in the subject, added Patrice's reviewed-by

 arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 2aa94605d3d4..d52a7aaa1074 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -178,7 +178,7 @@ tsin0: port {
 				tsin-num = <0>;
 				serial-not-parallel;
 				i2c-bus = <&ssc2>;
-				reset-gpios = <&pio15 4 GPIO_ACTIVE_HIGH>;
+				reset-gpios = <&pio15 4 GPIO_ACTIVE_LOW>;
 				dvb-card = <STV0367_TDA18212_NIMA_1>;
 			};
 		};
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
