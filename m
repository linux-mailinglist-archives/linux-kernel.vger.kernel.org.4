Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66329666564
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAKVOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjAKVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:14:16 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB053F106;
        Wed, 11 Jan 2023 13:14:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b4so4700965edf.0;
        Wed, 11 Jan 2023 13:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgmGHq+wF/nfzia7H7lvFLfbILv7rJsZCdugVo5WIaQ=;
        b=XiyRXezSdBqHop4xsub958Jt3NOyOQqHZtve1fccwUhYXTiZi/x3H8HMhEKq9t7yBR
         MmZmSFYzkWFw3aPscz+KUT3sYfEKYcnMVnSY9Qi4ToAWANNBOLBVop7U72AJzyJysv+R
         hFDDJ5c1D8nCw2bAqwX3LO7EiN4+k0cTUoYKsWUr10kVN3XNcpfCnOJ+g9u6NTYz4CBj
         qyuJFpF4Cuyvm1Y1dpZxC/OH2GOqs8gIMOYbU8qH25a72fukPtcWHw/LPyAXgt+3nETb
         /6420R/qwqymhrrNQpNYgwufaoRpQFw2HXGtxrIix2GJoyTm5+KoIglkqvyA1r76DX/n
         3vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgmGHq+wF/nfzia7H7lvFLfbILv7rJsZCdugVo5WIaQ=;
        b=T9m2EdOx/zRSKPrIOPG1xgpjJRvZXJQ1Mq++UbZMUwcQwKdmzj+F6AQPadjMNXc39X
         uNj9NiZ/BDUT8LWZN1kbtzaKzE7OyZhH6gLPTx2s4TA1lLPyy7JBd6Wvz0VW+d4QzMrs
         Zo7Ug5JdiyN+TzU01HMgdvhp0T9dMYjhEddAjpbagLvxy2ntbhW4nQ0dUK9T0g9I50PS
         YOHyHNr2Jhed834IMmucZcjpFOo2qCQYoHgkyjcQQWXCmI9P3c4Wz05yVGaG+UqqEsGm
         nKzJtCISIfDNqXO0+vPwwwj4hnuE7lzBCnLEgFvkJDJ74ibIb6OVtJX+LEdToP9RUwOb
         Hs6A==
X-Gm-Message-State: AFqh2kpvqJXGld6nnFpW7bfo9DB3U2BQCXKbcPUq4YZ4AMDyvOi8cKQD
        PF4F8rHkGKDyBK+Eqi3klcI=
X-Google-Smtp-Source: AMrXdXvFC2b/WG9kEjTZm1HQHakHIgxX6A3R5/NVUOgN75NmOn4NLyqTQojI4TYuqMkCT6XGEm+8fA==
X-Received: by 2002:a05:6402:2a02:b0:470:44eb:9e58 with SMTP id ey2-20020a0564022a0200b0047044eb9e58mr66445495edb.30.1673471653661;
        Wed, 11 Jan 2023 13:14:13 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7325-0300-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7325:300::e63])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056402344400b004822681a671sm6485079edc.37.2023.01.11.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:14:13 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vyacheslav Bocharov <adeep@lexina.in>
Subject: [PATCH v2 4/6] arm64: dts: meson-gx: Fix Ethernet MAC address unit name
Date:   Wed, 11 Jan 2023 22:13:48 +0100
Message-Id: <20230111211350.1461860-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unit names should use hyphens instead of underscores to not cause
warnings.

Fixes: bfe59f92d306 ("ARM64: dts: amlogic: gxbb: Enable NVMEM")
Suggested-by: Vyacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes from v1 -> v2:
- new patch

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index e3c12e0be99d..f8b115cd6775 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -233,7 +233,7 @@ sn: sn@14 {
 			reg = <0x14 0x10>;
 		};
 
-		eth_mac: eth_mac@34 {
+		eth_mac: eth-mac@34 {
 			reg = <0x34 0x10>;
 		};
 
-- 
2.39.0

