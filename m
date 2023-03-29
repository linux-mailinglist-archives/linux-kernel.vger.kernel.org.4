Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC886CEE19
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjC2PyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjC2PxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:53:18 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325791FD3;
        Wed, 29 Mar 2023 08:53:17 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so7134427otb.0;
        Wed, 29 Mar 2023 08:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWmtLeCB2PTcAHpGNr0ZZYDBf99xMHUdOSjMIZXheFk=;
        b=gT+gIRABipFTEumNuWr5OL4/LCOnJwyueWpyK6R4odBzFtJLcFWfuB3HLqw4JPYcfb
         Ehucm1O/0IUGKFHv8c0l8s3s9eU2ee2s4igCVbjadowvVW6nbl6NJcCHJkg8MplO8Eh3
         anfkbGqG5CXPo3dv3cV5wT9e99eelVaodzOOU3dsHjvbjYMGGsdVK5mW8SPjbU03wDfU
         y8XGfyUu1FF+ChZEXzBo0TOUqahIcplqC5srwW8PSNdRnmOYOW25UT1zDh/7MCVzISVq
         s8BDVXAbCaaK7cEmWV7D3q4msqEWxoRaSGjf/vsRUElHzm+1pBML8c0shEI19K6yMYnl
         6Eiw==
X-Gm-Message-State: AO0yUKV2NI1lPw0Wrsju9M7Zvo/8ZtfH98jRbPf93rmLFEdoTNxcwron
        BMn2QThOjvoYArCE4zKMuQ==
X-Google-Smtp-Source: AKy350by63hvThVx+G6CTPOFFLOe4lmhMruBxp6akfw7h8ZCmJHsyJFTMVn+Dn/8by4Bc4xtRU8hFQ==
X-Received: by 2002:a05:6830:1695:b0:694:3972:dbae with SMTP id k21-20020a056830169500b006943972dbaemr9305044otr.2.1680105196435;
        Wed, 29 Mar 2023 08:53:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d4b04000000b0069f509ad088sm5047619otf.65.2023.03.29.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:53:16 -0700 (PDT)
Received: (nullmailer pid 3198067 invoked by uid 1000);
        Wed, 29 Mar 2023 15:52:45 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:52:00 -0500
Subject: [PATCH 03/19] of: Move of_device_get_match_data() declaration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-dt-cpu-header-cleanups-v1-3-581e2605fe47@kernel.org>
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

of_device.h mostly defines functions for bus drivers whereas
of_device_get_match_data() is used by drivers. Let's move it to of.h.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/of.h        | 2 ++
 include/linux/of_device.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 36cf94596eba..b7118d68c73a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -416,6 +416,8 @@ extern int of_detach_node(struct device_node *);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
+extern const void *of_device_get_match_data(const struct device *dev);
+
 /*
  * struct property *prop;
  * const __be32 *p;
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index e4aa61cb2bd0..6af4c3acd502 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -26,8 +26,6 @@ static inline int of_driver_match_device(struct device *dev,
 	return of_match_device(drv->of_match_table, dev) != NULL;
 }
 
-extern const void *of_device_get_match_data(const struct device *dev);
-
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
 extern int of_device_request_module(struct device *dev);
 

-- 
2.39.2

