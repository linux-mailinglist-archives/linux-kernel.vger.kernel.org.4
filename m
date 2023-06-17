Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F74733E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbjFQFZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjFQFYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6F1FD7;
        Fri, 16 Jun 2023 22:24:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3110ab7110aso1203294f8f.3;
        Fri, 16 Jun 2023 22:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979488; x=1689571488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=DWVWlsv+DY0BtlXJOK+TO2cyNO9d/eSdrU502cwPY9u4+SJEh1YcURZY5w+ORfUnM1
         axcCR6YSztlPndCs+v3A6CB8ZN6lrEx8dQ2K9qVIj8x/pCFa5G1YMBqVpXJju8AJY7FH
         KLXLwlW14Ex3ZDhLQ/Q9cxqaKqy0hCE8lZzlnTEuAxw0QrEQHkCZ4B4kRamZZOVdj5Ww
         pBVoQMpBk+Vcbu92sxhxzDiya0lC8y81EjfEj9EiLkdjEgT8kp6mwLPk7TeIia9/XzQi
         RCH9uyNvSLeqPbZrXoq2GKMuJ+i5PSKKKL+Al5EkWZ1vuvfoPJHW5k6Qu/8cvt5XIP8X
         fIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979488; x=1689571488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=L9QxUKMYmr9fAdZtKURcQwFpXm6yF1qZMpVRNYnnVcA8ac7gHekW6OShiIuyM+H35X
         Za34MJgaVJd+HOGW/IrnCZqu5SCf71q2oh3xMu1rPpGRVjy/L8sQKU80a4jycJYFwEny
         DFtIzsejwqT/Nv9t19d15SxpLx2JhXt25IiiPEHcZqKiUvk0t3iOR7mxovNxeMKjeJm/
         JfntKN2R1mOvYTRFCy1nHi43ch5gOv2CN3YtivKIvfXgx0f16hoTsY1Q0uVftFwdyeab
         G7OxiZm3ECsBtD/EuChtcB9o2bcg1ReSniH7GyFM8yoF1CBU0fmDvhIBAVSqg/UF7hHb
         +5uQ==
X-Gm-Message-State: AC+VfDwn7xSDDB+OaoojjCu5ksObNlBCIR9+QGqeSVNwDm8qpV2kmKeT
        JP/f5KjOmPV3Dv8SaA5wssOKkC/0FhI=
X-Google-Smtp-Source: ACHHUZ58OfhWAnmWtcWCxFG7XWjFe5oWwkaKzBAtkDPOeBDN7eDEEKAo/3ECvi6sd1BPZrPFohl3XA==
X-Received: by 2002:adf:ec0e:0:b0:309:44ed:ccff with SMTP id x14-20020adfec0e000000b0030944edccffmr3252117wrn.1.1686979488443;
        Fri, 16 Jun 2023 22:24:48 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:47 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 9/9] MAINTAINERS: add Mediatek MTMIPS Clock maintainer
Date:   Sat, 17 Jun 2023 07:24:35 +0200
Message-Id: <20230617052435.359177-10-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as maintainer for Mediatek MTMIPS clock driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..581234dfa735 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13137,6 +13137,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
 F:	drivers/phy/ralink/phy-mt7621-pci.c
 
+MEDIATEK MTMIPS CLOCK DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
+F:	drivers/clk/ralink/clk-mtmips.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.25.1

