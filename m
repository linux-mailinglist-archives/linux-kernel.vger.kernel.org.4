Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79A5F4280
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJDL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJDL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:56:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C113248F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:56:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z4so20784503lft.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=awlDJOwZPKSY5u+OaE9sW3tkpC8Xce3ufjEna4Auwe0=;
        b=juGB9XDLeDtxWA9Qf15ABu3s9cmSa/vekBmsm40CZZYOV57LoYPnNyGOLtuf0Y+hC3
         fCOwfytjEjTIbIDuhS9k+0zI9nXkkCGg/ViULV7BOuQHkH1g5f0AM6HZJxur3EHwRf8h
         ObaG1dLKS7mylBAPPsy6qmbzsVejb57p7EkKWySgEX5umhyZ2EWNaqeYPpUugHbpMR5S
         fRCKhPS1ntIwfyNys8yawwmRzKtkK5GYjvJggW4p4iVdCargu/5Jkg9pHgQw89OodEOv
         27MkiLANAjZvn+oXptgGwUdnCmJn7w9esJGR9RIB8j6KXc2LsuhKtU67RvQhy3pb7YBC
         z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=awlDJOwZPKSY5u+OaE9sW3tkpC8Xce3ufjEna4Auwe0=;
        b=M1NwOuR5rlRnzfc2XvktC2iY2rxvJy+aOOymw/dLZXs+f/BEjWi9NuQgak1/TfkzRA
         SREyXLd1augyjJGsNgGknDBDnPvV0lh8+A0Psl0r5j0z+0chqSKgQF4N3cG2+udHlyML
         ZqydCZ5jidplGg9cW2Y6PnyBY/4PGrrYb5rZ6E0Kw/Wis4kGVm7C8CVGtUSg19O6Z6Vb
         PmRooPx65wUzt4hI/5+NrMUCaR9igltXc+s2yeR7DaTXFWKWbxrZGFpIJJtv+liIp8RN
         9X1GARNF1lrp0CHkmLqsbZ7Z9fdFbMdDuAvtBriTdyjJTZrOF9y5v3C9q2CrUSn+aZWN
         bmBg==
X-Gm-Message-State: ACrzQf2rPOjlnlUWwYCnMNJeIhJXqG2V4qqQYzILBYXa7dClB6NB/+uK
        xJFBnjYHUExwrciHU21NO5HAEw==
X-Google-Smtp-Source: AMsMyM77lAova/vK6lHlTNE7AAkvvu4Xfs36TTtnqIfmn8CxGSLy+6vrKg1tqL/ynremV5PxyKMdsw==
X-Received: by 2002:ac2:4564:0:b0:4a2:504b:51a0 with SMTP id k4-20020ac24564000000b004a2504b51a0mr1296854lfm.12.1664884606599;
        Tue, 04 Oct 2022 04:56:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] dt-bindings: iio: addac: adi,ad74413r: improve example
Date:   Tue,  4 Oct 2022 13:56:36 +0200
Message-Id: <20221004115642.63749-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
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

Improve example by: dropping unrelated properties (status and cs-gpios)
and using generic node name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/addac/adi,ad74413r.yaml          | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index 2e8dad9278f2..58b3ae14ccaa 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -116,10 +116,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
-      status = "okay";
-
-      ad74413r@0 {
+      addac@0 {
         compatible = "adi,ad74413r";
         reg = <0>;
         spi-max-frequency = <1000000>;
-- 
2.34.1

