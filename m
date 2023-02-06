Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22768BE8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBFNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjBFNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C53AAE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:19 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ba1so6342436wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdDsTum1L187tCV5H314M2VOHnznVA4j1l+89UWeiF8=;
        b=jlaG85rbsc+NfSU7vQXeKD4rz1YWj1z7QurcuDklbSn4iQqoVJcVh8Z0G2DOpXoK8a
         ZaeM6DJ53qqEjRrgM5ckFTBB3nQoYb7MtkfH4z7cqol+ovWLuskZ96a2W2TKdP0TpxF2
         CXzG8F3cIfHc01ctUuCjVmLrQt3/pa5+aoTc7pxRuIHivWmzT6mgdzZWTsI4hvktMwlf
         WkXVVjaW5aO30iBSL9WBs7xPIvAqqJeVW8tqi6tU9mCdWFLjZ8qMZI1/QlKXLJjsHGFV
         CXA11jSUT/A7Loj93ewe4HPlAes9SBKB8yp97j9w9k9APQjgwp4ntSw4gpisoJ0K1OyY
         PHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdDsTum1L187tCV5H314M2VOHnznVA4j1l+89UWeiF8=;
        b=vhABusxKECB+cclUoJvHQTeDavlekPa5jEAT4U6eBqFiFOvkpkweaGQqcF7bNwH2k4
         0zSjZF7vQAkN0cB8li+L70vvy1fvRjei4mocQG2dQJMQqW3lo95nCHjDAzUFzer5+iRZ
         F051t0PftMo/9o3dS3ouDs3bprXaxcTMs23dmx7XLlMGlUB7oC0CZct+U+eoEdQn5EWw
         xcARP5qwJxjEinwjoDuAvnltbubB+ftzm5v67ZKW7PzsGnH9FPWBbgouc/HBIDr+ycc+
         N4JnmrMdxs6Pp+D3N6rb23B13LoGNWbjBfLFVYufXyDH0s1MnrY30dYj5+Yadr+27yuV
         Zbww==
X-Gm-Message-State: AO0yUKW/1YKc+h5iKBlLMhVt2ezMACDWvNKyUv1lPhwJMmQUSe9KhMlu
        biGjPA4oUkeYutxCRL2DoBDTUw==
X-Google-Smtp-Source: AK7set/07vHVzpXkrlKmI3EtIVrqvcUfYGW8vso8my/g5FNaD3hKpp/QAHoGet2Q+IT03TtWgIxQmQ==
X-Received: by 2002:a5d:55ca:0:b0:2c3:e0a0:94f with SMTP id i10-20020a5d55ca000000b002c3e0a0094fmr6496593wrw.37.1675691058688;
        Mon, 06 Feb 2023 05:44:18 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/22] of: property: add #nvmem-cell-cells property
Date:   Mon,  6 Feb 2023 13:43:45 +0000
Message-Id: <20230206134356.839737-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Bindings describe the new '#nvmem-cell-cells' property. Now that the
arguments count property is optional, we just add this property to the
nvmem-cells.

Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 989e692e0319..95b838185b2f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1307,7 +1307,7 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
-DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
+DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", "#nvmem-cell-cells")
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
 DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
-- 
2.25.1

