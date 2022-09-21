Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B495F5E54F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiIUVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIUVKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:10:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32289606A6;
        Wed, 21 Sep 2022 14:10:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so11363911lfr.2;
        Wed, 21 Sep 2022 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4M75LCnR7HEj9mQ8XBusERBnMSMu8fybz1DwQ5l1ydQ=;
        b=eTmgdq+0jDw0IWy1m7/i0AfInQwqI8gB0H6o7pPnGf/9thckvHt9AJGM5oOF9+ooLH
         ymGByAeUfbx/gFUaD9mvGcIASKGLPI/Mi5XLV91zm9FpqOuzxORpPFb6HD+PqBtJ0CML
         4ZuhYmA6xL8IZQKn/KI+a5Ab2nm5I78rwrBQYhaQ4MnVs10nA/aAYGZx0d2YUxhkbWvV
         kqvwndgFbiVT6BQIil4Wc2G7vQBMxEVff0hiwypMGxJBM42OZyBUUwwxqhT70fCnwylI
         173RuB2WwV165RRSKufhRR0IlvJRhMhA1f50Wzh9xnHWbvz0RQiOUufFJUmK6n8pLIQQ
         2FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4M75LCnR7HEj9mQ8XBusERBnMSMu8fybz1DwQ5l1ydQ=;
        b=VIpb9ZtNdXfXF3BfL/Q9TynSub3UXrIc7A8jJGAXjHcKQTjg0J31Rh7eHFEyVScpuo
         SxFFgtB4Og6vGp0u93YjVp1PGWLJ33UKKwxAPnm02JPrS3muYbdrMU0aNYaOBZNeFRdd
         im+gkIegSo1iWs6ojLBsOC8SVqxZ2B8MDI9tT+DINBDRRu7VahDEgmDp1PF384G+gqvj
         VT2V2FjbdftmreqbIlqoXb6IBY5mkS3Bh4xLyrlLsfnGmhfyTAA0k3OgoWO9cQbn9Ii4
         rD61CgX2pOdYc2R1gn3Rfm+Y+9D+Y3k4iEpUzV6vClbd1cq09r+ku4cp6uhZFdojf3s2
         1l2w==
X-Gm-Message-State: ACrzQf3WkEa+6jTaiTknWjwjii6d0/bwEbwf66/8ppnBzOVmddFcFHQu
        upbTok94SgdpkWbKXRtrNvU=
X-Google-Smtp-Source: AMsMyM7BZS78FaEFgZwq10AX/72c6ZZ+GlyiViqqj3ES8IRwPmODSH7j3C4TQWbLzmZqbP8lk6RdmA==
X-Received: by 2002:a05:6512:613:b0:497:a8a6:464e with SMTP id b19-20020a056512061300b00497a8a6464emr6689lfe.604.1663794606483;
        Wed, 21 Sep 2022 14:10:06 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-10-176.ip.moscow.rt.ru. [46.242.10.176])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b0049adbc24b99sm599260lfe.24.2022.09.21.14.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:10:06 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: document AMD DaytonaX
Date:   Thu, 22 Sep 2022 00:09:46 +0300
Message-Id: <20220921210950.10568-2-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921210950.10568-1-aladyshev22@gmail.com>
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document AMD DaytonaX board compatible.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..cb9bc65df82a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -29,6 +29,7 @@ properties:
       - description: AST2500 based boards
         items:
           - enum:
+              - amd,daytonax-bmc
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
-- 
2.25.1

