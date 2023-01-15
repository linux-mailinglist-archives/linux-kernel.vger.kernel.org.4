Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1411866AF12
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 03:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjAOC17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 21:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjAOC14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 21:27:56 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44243A247;
        Sat, 14 Jan 2023 18:27:55 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so38313348lfv.2;
        Sat, 14 Jan 2023 18:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzYqmUGWdkiR3nac7b6eSL5nUmL6qwhST1HTV4blflI=;
        b=fyri0enoH/SF3/a+qtxyARzTfbUg9eHnkUKa+pLSldjFf2wYQxTueZccRJVLzG2SEM
         vhoZvAMbtc4/jH9fUtf7PKfHu+Ur8wfq9w9dFzaxU8nxxzArQwWgkVryARvDMeI7IIoR
         4YXQprO4KDhqChp7DESRuhUBRFYfDIDm5UySq6JRR09V1JSaRXVd8ZZ3ExrRAuwir5ru
         5CthD0mkHt9+Bw0y1NkfErxAV9qfO8TJMmpkYbvVeq46inZyBvnbz7535LLHBq+0O4Bf
         fgPfaC/p9pc+hEebjtnFI/Xq8Vhd2ce8zdA0+xEA0hhQHr3XdfTHdtoMzWUkVGsyUYt1
         Np2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzYqmUGWdkiR3nac7b6eSL5nUmL6qwhST1HTV4blflI=;
        b=4FOKG58lZ3toB/xEREgRv4r2GK23jK2ondeQa3TSPYUVlUHDGdYV4LQ+MgBcZexu0M
         4Oh8a0+p+NXfF0+CY/eWB8dI28ze8dIc4gTeHVbBKJDL5iN7L6zYnYOq2QNo/r+a8OYL
         4INhJPwsuhFbXv1pZPfO+j6U3QLl+fTP+n0Ff0n+A1lc+FdwTHnkML/B9Q5uk5nXsRSD
         Raxv992ylakLTZ3zvFWHINLkc13HigQbhRDvqf1I1GyHMwJ5JtW4eIYC49Oi1o3mFi4A
         izCDBDCMrNQ4uhAhFS+hwjOkSfJ/HBXgwWm8GiGNB0vMWPWMR74jNOtTs1CSBM80b0oq
         EZ0A==
X-Gm-Message-State: AFqh2kowUgxMhncxaX7IOCskj12pfVn8ryjPoBxBZBsxI2mNJZzWOif2
        J9a9dorgRY+Zo6qgwNvnrsFlYzSgZ/qnF4RM
X-Google-Smtp-Source: AMrXdXvNXEOnpFLcMCJjUNODd/oXq02pdnP/px4PPidZ7iBZxQL0ANdvRk1KB6a0uJF/YKqhCw5gnA==
X-Received: by 2002:ac2:4f12:0:b0:4b5:b5d0:36e4 with SMTP id k18-20020ac24f12000000b004b5b5d036e4mr27909321lfr.13.1673749673498;
        Sat, 14 Jan 2023 18:27:53 -0800 (PST)
Received: from fedora.36 ([78.10.207.59])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24e90000000b004b5323639d8sm4510478lfr.155.2023.01.14.18.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 18:27:52 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Grzelak?= <mchl.grzlk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        cosmin.tanislav@analog.com, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Grzelak?= <mchl.grzlk@gmail.com>
Subject: [PATCH] dt-bindings: iio: addac: adi,74115: Add missing maxItems
Date:   Sun, 15 Jan 2023 03:25:58 +0100
Message-Id: <20230115022558.145076-1-mchl.grzlk@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running 'make dt_binding_check' gives following warnings:
iio/addac/adi,ad74115.example.dtb:
addac@0: adi,conv2-range-microvolt: 'oneOf' conditional failed, one must
be fixed:
        4282967296 is not one of [-2500000, 0]
        4282967296 is not one of [-12000000, 0]
        -2500000 was expected
        -104000 was expected
        625000 was expected

addac@0: Unevaluated properties are not allowed
('adi,conv2-range-microvolt' was unexpected)
        From schema: iio/addac/adi,ad74115.yaml

As every property with standard suffix has inferred type of array of
cells, adi,conv2-range-microvolt is required by meta-schemas/cell.yaml
to have maxItems >= 2. Fix these errors by setting maxItems to 2.

Signed-off-by: Michał Grzelak <mchl.grzlk@gmail.com>
---
 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
index 72d2e910f206..cdeb04184f5a 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
@@ -87,6 +87,7 @@ properties:
 
   adi,conv2-range-microvolt:
     description: Conversion range for ADC conversion 2.
+    maxItems: 2
     oneOf:
       - items:
           - enum: [-2500000, 0]
-- 
2.37.3

