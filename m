Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7B46CEDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjC2Pxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjC2PxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:53:14 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ABA10F0;
        Wed, 29 Mar 2023 08:53:08 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id p2-20020a056820044200b0053e5914a50fso1233252oou.2;
        Wed, 29 Mar 2023 08:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qOq2NGpUAbxXp1g8F5WR4fkX2S7bH0m0xxnMP60FJ8=;
        b=XkouJt2RhMRBqqeek+OXcgxC+1hWWNASgQzUkUrKoEW7RtA/WdqoU9GOtiIPVKFXzo
         sBR6a4W4Zg6cbvEQ+qWh7bZegVwFBM6n9Owe45S6Q6P6hWPvp3obfuLoT67jYsQBFKeV
         878ZISfyJATV4JVdqnktH5ike1z0F6kW2n/V8xVVZojnqFQg7fybDDiFr5EvI+c2iPLI
         ET/ngT7/4A+GtqxM0OJI2IRCf829K+Ce4ULfrXfIcagQgEyJYtgE/yn1/RHhzxBlPb1q
         JFnUbKrm/5/2aEZG1nJEuTi/QovIOEErBbtPcvx7nDQGRA3mSdh5UvqbUn0lszjGWp7i
         Qrmw==
X-Gm-Message-State: AO0yUKXFNw29Se3D8m+XmEmCBSVbCPVMp5j7I7F5Xr3/H7FMbu9q1Oxf
        IyQfINoGWPSRPoPP/+l7rA==
X-Google-Smtp-Source: AK7set+oji6+6UZVdlF32jW97Cd5wKPzdK3BfB/MTFUCEZ/Z55TdZpfcLorcJt7g+5txg06Aa2xkVA==
X-Received: by 2002:a4a:3797:0:b0:538:1e63:1725 with SMTP id r145-20020a4a3797000000b005381e631725mr10070334oor.4.1680105187664;
        Wed, 29 Mar 2023 08:53:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s9-20020a4a9689000000b005255e556399sm13966954ooi.43.2023.03.29.08.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:53:07 -0700 (PDT)
Received: (nullmailer pid 3198063 invoked by uid 1000);
        Wed, 29 Mar 2023 15:52:45 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:51:58 -0500
Subject: [PATCH 01/19] of: Make devtree_lock declaration private
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-dt-cpu-header-cleanups-v1-1-581e2605fe47@kernel.org>
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
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparc is the only place devtree_lock is used outside of drivers/of/.
Move the devtree_lock declaration into of_private.h and Sparc's prom.h
so pulling in spinlock.h to of.h can be avoided for everything besides
Sparc.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/include/asm/prom.h | 3 +++
 drivers/of/of_private.h       | 1 +
 include/linux/of.h            | 2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 587edb8b5a65..8184575b1336 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -19,11 +19,14 @@
 #include <linux/mutex.h>
 #include <linux/atomic.h>
 #include <linux/irqdomain.h>
+#include <linux/spinlock.h>
 
 #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
 #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcmp((s1), (s2))
 
+extern raw_spinlock_t devtree_lock;
+
 struct of_irq_controller {
 	unsigned int	(*irq_build)(struct device_node *, unsigned int, void *);
 	void		*data;
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index fb6792d381a6..b57f1014e419 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -38,6 +38,7 @@ struct alias_prop {
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
 
 extern struct mutex of_mutex;
+extern raw_spinlock_t devtree_lock;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 0af611307db2..36cf94596eba 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -16,7 +16,6 @@
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
-#include <linux/spinlock.h>
 #include <linux/topology.h>
 #include <linux/notifier.h>
 #include <linux/property.h>
@@ -145,7 +144,6 @@ extern struct device_node *of_root;
 extern struct device_node *of_chosen;
 extern struct device_node *of_aliases;
 extern struct device_node *of_stdout;
-extern raw_spinlock_t devtree_lock;
 
 /*
  * struct device_node flag descriptions

-- 
2.39.2

