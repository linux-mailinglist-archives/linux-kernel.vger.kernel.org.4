Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE141629035
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiKOCzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiKOCyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366A31A389
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s12so20017003edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3nU7X0djX9jQ80iI8+t0kZ5Fy4kB3s5F+snjwXKwEE=;
        b=qHw6yLdaXz/BrvdOtxs23rQqN6uoD9Yq57iWVm5qtsNwRyl0txxACn1YlsXr9XGR06
         X0/fXV7ooJLhtBLvSM9vlvjQz70IgAPiP/0OB1VajH1nuAHs49/uKU0sgovQglseTenS
         cekyB0G7jao5CsOa821xumiuslVIKSD42v79wdU6DODpP853aT4AHzZVUtVx0Ej2bJHV
         4Zq7TBRoXAIUXiPJadvqueUTT8uphzsjFZxUl9HcrUyAPwwJxbu8xIWq/6o3ZBcaS5gI
         7IqRN2ytMVjrpflB1xK/99Gncnx9qVl/WrqgWO5fksPIthHRzfoT484qu0KY8HfMpwkZ
         S+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3nU7X0djX9jQ80iI8+t0kZ5Fy4kB3s5F+snjwXKwEE=;
        b=S7WlEbuOLKdT0KvqpoUlktVMxvQ/S3ZojJpiTjOMvSuNEefkKmAiJOvP9cFQklHeKl
         ziXHWtP3MdXIEPpD7JoGAEd0+gA4lmoHsUNcuKpsfNx4o/bImRFybsKnIweXlWgjXPQK
         uMhVEVRFE9vUjpqy3cbm8q//p19Gj7vb7OhJaMAaThJ3KfOSzpg/0wXEpQtwrjRBAA5p
         aNJ5DWEf8AZhnV+vn7v6Oco/a79s5MM1hPm2Mh2HkPJeqIfHWokCRmSo7AghhnTzmiDJ
         qRFRKgna0dKlOKjM3kd+zHpFtc8du5OqTxDqrO3uopYpGAPiJD4dpeORif8c9Ral7Xt4
         8xpw==
X-Gm-Message-State: ANoB5pn7/yYfby+uA5tiKoHexxgayCc23K34TxJmuiK2Rx90uKxfNuTu
        0u7kYyS1IPu6+AADwJOlxWlE7g==
X-Google-Smtp-Source: AA0mqf5fY+yhWzH/Ndk7iEot+4/kLLx7PrL8ExjCcw5CMfSMJthgD//79QTiyAVrO97/Z5Zvj++zfA==
X-Received: by 2002:aa7:cf07:0:b0:461:f1c6:1f22 with SMTP id a7-20020aa7cf07000000b00461f1c61f22mr13826229edy.95.1668480879681;
        Mon, 14 Nov 2022 18:54:39 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:39 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 13/15] dt-bindings: irq: mtk, sysirq: add support for mt8365
Date:   Tue, 15 Nov 2022 03:54:19 +0100
Message-Id: <20221115025421.59847-14-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of mediatek,sysirq for mt8365 SoC.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 84ced3f4179b9..3ffc60184e445 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -25,6 +25,7 @@ Required properties:
 	"mediatek,mt6577-sysirq": for MT6577
 	"mediatek,mt2712-sysirq", "mediatek,mt6577-sysirq": for MT2712
 	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
+	"mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq": for MT8365
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
 - reg: Physical base address of the intpol registers and length of memory
-- 
2.38.1

