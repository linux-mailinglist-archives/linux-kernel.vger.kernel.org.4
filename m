Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7646F92BB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjEFP3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjEFP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:29:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC218DD8
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:29:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f14f266b72so1047934e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683386985; x=1685978985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8hWHGuwmr5mvcRO9xWp0sVfGZwfYtl73f18uwHlJMc=;
        b=mNiQ0UDS2BUcvU4LntQeVmsiQUODFkPh8PySaX6ucBq7F5zKYFGH5BIL21VYHsS/Rb
         Ad5fGY92zFbpAHSC72PDkEukkm0w6dfI8dRd1g82wyUJu2Z3Kx7btxOZSpUfpiylCGi+
         RKP2R1pTVir2VeqCumdztRmrt3CV4ui0t6GVMu7B4E6JDFYM7hRR85TjzWdaU154eopl
         BrB4meyYy2XHysDZBB0CMAVgGR9NlI8G9v1faKidLOJqS48ZeD6SEXN2lD8SqHnBITJW
         ddbCKpkw03apGuuPuM3UMWMQ+dX0CCi9WFyL0p/hM+g2uGpTzWAUQAt9MAAMPGKmk2Ja
         CAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683386985; x=1685978985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8hWHGuwmr5mvcRO9xWp0sVfGZwfYtl73f18uwHlJMc=;
        b=WXBSy6ruvlxmRfSLrrl+gsS3UWgLHRneXIbdNnnTlBspXipViGf7UQpqjQlWRFSwBT
         z2aw+l+5Fue/lxJRnZQhk04rDNtYGlhjtM2MIG3ZeYkMh8WgHCvHFpccP6dtp1ulUVar
         SVQzAkgFSk2t57MbTSBAiRy2d9G+fkvCqqCygRcmGu4nq3rFUtOYPjvRIW/hHAl4UOSg
         cUjjFZjyNvvsNq+bKFZ458KurTZzqZ9UZGxY62pSmBM0c3B6V66tcMRBcxN85y9ehGhd
         8Zoz76T2RaWxjX3qGvfLzy/69K4sDEcglNXxqTQiIouS3OaBrz1lySlhr9ADxrKVWlq3
         O6gA==
X-Gm-Message-State: AC+VfDzy/VL2TesS54IdJmnTD8OsoAYWJQw7SHDxqDcry3gfxHjZEkj6
        DqwN2eWN3HTt9oQ1n8HsMo8k9Q==
X-Google-Smtp-Source: ACHHUZ6miK2s5Xpjs644BMeWUfktmkUFGbsUk9aP5jX14WBNbOM2Oc42j/yd+sDB4hGnBVdj/8QJVw==
X-Received: by 2002:ac2:5dfb:0:b0:4f1:3ef5:35a6 with SMTP id z27-20020ac25dfb000000b004f13ef535a6mr1250503lfq.8.1683386985531;
        Sat, 06 May 2023 08:29:45 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v5-20020a197405000000b004eff32d6a21sm680814lfe.121.2023.05.06.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 08:29:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] Add SEAMA partition types
Date:   Sat, 06 May 2023 17:29:43 +0200
Message-Id: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdyVmQC/0WNQQqDQAxFryJZG5gZ0dZeRVxkNK1ZdCqJiCDe3
 bEbl4//Hn8HYxU2eBU7KK9i8ksZfFnAMFH6MMqYGYILlatdg8b0JZxJF1myaxib4Lx/xLZ91pC
 zSMYYldIwXeHtX+Os/Jbt/9f1x3ECx3j3K38AAAA=
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This type of firmware partition appear in some devices in
NAND flash, so we need to be able to tag the partitions
with the appropriate type.

The origin of the "SEAttle iMAge" is unknown.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      dt-bindings: mtd: Add SEAMA partition bindings
      ARM: dts: bcm5301x: Add SEAMA compatibles

 .../devicetree/bindings/mtd/partitions/seama.yaml  | 50 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts      |  1 +
 3 files changed, 52 insertions(+)
---
base-commit: caad71e7d226920623d78be2e6283516decdc502
change-id: 20230506-seama-partitions-b620117b9985

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

