Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2246CEDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjC2PxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjC2Pw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:52:56 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB00526F;
        Wed, 29 Mar 2023 08:52:50 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id bm2so11933321oib.4;
        Wed, 29 Mar 2023 08:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL9zh/S00J+cmPfrAtv4vflOTxQVISfijtGfdl2R3L0=;
        b=2GqYyDasVdp/d4qbKmAOFqsFPZSzX5fckvQYEsoNS98Mgb3oc8V2Z0uwhphSSzdisi
         CG7L20Wh2/vqvvRSk6KqHfh6cMXBr+CKhQvW1NEEFtuadvCdtGTWF3wBoFADNzdnw4fV
         5sjZDwAmrJOwj3MjGIJ5WH1ACBZ0HP7XisLzfh+aHyjee1j01PWn/+CbU1ezatMt9qZM
         NLZtDhbiXoix9K5VTMiIkuCw8HX9V42RQ6Jos1D5MCDYoNOyS2fNk0WMgfoTucaFgYK5
         1q+1q7r71yJmu2k6CTKRDCESzsERW/NboaSjuoInZtF5+ftUTKyLRjc3OLqiJAXUQOkx
         sUEQ==
X-Gm-Message-State: AAQBX9espMAlD35h2SCtd8sHALKdMISL4xOmKdCDX4Ig+9BSogrzZV0P
        arZ0IAK+Yvvf7olqNRx/Gw==
X-Google-Smtp-Source: AKy350YWPg6naXojJ+dh5QDGD5h6eaepx41Bc/m1xdmR3LQVsEP9dglulW7uPvOZ4q19z4rMeJNnvA==
X-Received: by 2002:a05:6808:4da:b0:386:9883:ca9d with SMTP id a26-20020a05680804da00b003869883ca9dmr1291968oie.2.1680105169571;
        Wed, 29 Mar 2023 08:52:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v184-20020acadec1000000b003871471f894sm10161090oig.27.2023.03.29.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:52:49 -0700 (PDT)
Received: (nullmailer pid 3198065 invoked by uid 1000);
        Wed, 29 Mar 2023 15:52:45 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:51:59 -0500
Subject: [PATCH 02/19] of: Move of_device_(add|register|unregister) to
 of_platform.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-dt-cpu-header-cleanups-v1-2-581e2605fe47@kernel.org>
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of_device_(add|register|unregister) functions work on struct
platform_device, they should be declared in of_platform.h instead.

This move is transparent for now as both headers include each other.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/of_device.h   | 4 ----
 include/linux/of_platform.h | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index f4b57614979d..e4aa61cb2bd0 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -26,10 +26,6 @@ static inline int of_driver_match_device(struct device *dev,
 	return of_match_device(drv->of_match_table, dev) != NULL;
 }
 
-extern int of_device_add(struct platform_device *pdev);
-extern int of_device_register(struct platform_device *ofdev);
-extern void of_device_unregister(struct platform_device *ofdev);
-
 extern const void *of_device_get_match_data(const struct device *dev);
 
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index d15b6cd5e1c3..8ac5cb933dc3 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -52,6 +52,11 @@ extern const struct of_device_id of_default_bus_match_table[];
 extern struct platform_device *of_device_alloc(struct device_node *np,
 					 const char *bus_id,
 					 struct device *parent);
+
+extern int of_device_add(struct platform_device *pdev);
+extern int of_device_register(struct platform_device *ofdev);
+extern void of_device_unregister(struct platform_device *ofdev);
+
 #ifdef CONFIG_OF
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
 #else

-- 
2.39.2

