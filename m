Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E02600434
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJPXmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJPXmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AAC13D68;
        Sun, 16 Oct 2022 16:42:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i131-20020a1c3b89000000b003c6c154d528so4451762wma.4;
        Sun, 16 Oct 2022 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8WgOnqzsVIcwM2hwBH1ea3tXcJUTMam+tnMayl18pQ=;
        b=loCBswe7W5OffBB4isgFvCHt5qA62IhRzDSaInfeKsrWfq3Q8wPL9j5TlLOSl4fcP8
         HT+b3Fc9UMFDm+6HP6uC0aeitQx5VnCdBbJnstvpuHYxLdx8j0c4FMAf4ec+mrAnYusl
         RcRfVd8yyb9Qcw0f+ODXTFfMKFsWpsqfVWJTh4ulhU4cnqp41wtVFTSbbrlIcmTPLCcd
         VuvanJewga4E0gs3MDwt+++OOEBWR8981SJ7RBKacwVLCni9ZVyITghKUu1KGvvWEYMJ
         E+n+YLcPTv9Eu3ZP8IjQ9y4VrDDXqdt5ZhMpxL11CNXUcZT2H4mLUKJE/I+348XRhhkN
         3g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8WgOnqzsVIcwM2hwBH1ea3tXcJUTMam+tnMayl18pQ=;
        b=IfHJKx57l+k4VyGq3n6y/2ME6cD9zohNx1nAfAjxhw4p91nYXX+0h+XnqnYNxZyJ6c
         cv53j3cC+tlXCUQS/mpv7rG1xsyw8oJp5BKg0+/HFLC7uCP7RKmDkIfXM3Fr1LJ05lHK
         UusyYm94rVuVIkQU4puMz5kCIljI9wK090cOlFZBst9rrkLct/Re5g8wIlHC4+h8d4fJ
         ntGd/9Gfyo6Y42VadiaIpvBci3ipt5yigYusbWeOPXoVXhJ5E1GDdvQ+OoF9SItnwChU
         8IMwMvjEh7DKcSJHtsB4zJOUQrHlCkbKmy6ttRtMKVKOCrdATcPa8nuQmdyPMOm/lVc8
         5u0g==
X-Gm-Message-State: ACrzQf37DXQjGtaYbvCDRL5/p3jG/bFJVHTSweMl2PwqVU5BJGzrdc39
        DDFvhuGoHvrq6i8ktvDz7vo=
X-Google-Smtp-Source: AMsMyM5eik2T/bnArxDDhgOKiZOZwBmt6hxrOloBDQjAaYF5dkvzOM9fC17hAXAVG/PcuQhpJC8Kxw==
X-Received: by 2002:a05:600c:4e51:b0:3c0:55e0:7719 with SMTP id e17-20020a05600c4e5100b003c055e07719mr5569381wmq.3.1665963736070;
        Sun, 16 Oct 2022 16:42:16 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id bv20-20020a0560001f1400b00231a5fa1ae2sm6950749wrb.20.2022.10.16.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:15 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 01/13] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Mon, 17 Oct 2022 00:43:23 +0100
Message-Id: <20221016234335.904212-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 is another X-Powers PMIC similar to the existing ones.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index b7a8747d5fa0..db9845add060 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -84,6 +84,7 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp152
+          - x-powers,axp192
           - x-powers,axp202
           - x-powers,axp209
           - x-powers,axp221
-- 
2.38.0

