Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED0617D59
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKCNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiKCNBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D8165B9;
        Thu,  3 Nov 2022 06:01:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n12so4929301eja.11;
        Thu, 03 Nov 2022 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUBAY9RkKGfldJzKkUPMH+SpSXldSNu9mGfTJqOMhzI=;
        b=HM+HRemRtj8TCpc5AYAzgpc3h1lY5Okl9tDXClUzQIGUDpIWJh+40NxIw13C/icSOy
         VGF6he2ELBdMytqEQTqxlH0KDUrbGUUI2YhlS+HTLJV37LJmXZcyi0E0lzrEVZ7DyJ22
         6UevGqiXn98Kec8O7E996LD2s1wMmPKl+YegFnlxLJwPpU+AVaYHHETDZat5I2hd+THr
         u/LP8tWIFVowUAPlEKHEId6LypVexoIUVlpNSyTJryS68v3VeVomijWkPjcZcTU3DFWw
         zCnKa7b3ZN+Bf1ai8qFG4h5T7Sb2/USVFucecd4G76QciMeymNOxMJ0anQPIGS9olPdC
         R9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUBAY9RkKGfldJzKkUPMH+SpSXldSNu9mGfTJqOMhzI=;
        b=F8y0hKFe6eMg6RJ1EX8wpP2vS3WPUHy0I1vtcIWxW0DJx3QvbEoGBV5IvU1kJU7nXE
         nk+8VQ2p1296ad+NA/53wsk3f8RIC85nJBxmxRYQ5tfiqFiZY8lKYeaUq7KlVpFyIYf6
         MxHreIOWBcnVN3YI+Ta+LaaUox/06q5OGpYwtommBsb87Nr84BJPDWqKuCYtEUofjv92
         B8I7peixytK9hRSZXa79yeAB1fRbDLseKsCypK+bUER5XQEhqSUj0dnVPfe+lGjOPOZp
         a7snWUzZA06dDJlPqpXW3c88/9/jjaUVGMwNbDUELFtAqyvxDYSbTQjUWJrBjPp+syZW
         F7Xg==
X-Gm-Message-State: ACrzQf0YUSySTJsmnk66Ze9WGMLSZDPdlhIeyzfZdpB2oGmPxXXUr7+h
        rCcTxGR/pt+jJ8Kfk8SGkZ8=
X-Google-Smtp-Source: AMsMyM6tnZSsywLu2mBZdD3detCeb9zm853u0hF8RP5rwYXHbl8dGx/FNg381+YbN3ghDfOtKa2f+Q==
X-Received: by 2002:a17:907:720b:b0:78e:c0e:a434 with SMTP id dr11-20020a170907720b00b0078e0c0ea434mr29407004ejc.741.1667480490539;
        Thu, 03 Nov 2022 06:01:30 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:30 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v4 10/13] dt-bindings: iio: temperature: ltc2983: describe broken mux delay property
Date:   Thu,  3 Nov 2022 15:00:38 +0200
Message-Id: <20221103130041.2153295-11-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

The 'adi,mux-delay-config-us' property is broken. It was supposed to
be in us, but the value is actually written directly to the register.
Describe the fact that it is broken and how it actually works.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 676801b036cf..467e165e9b0b 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -29,6 +29,9 @@ properties:
       Extra delay prior to each conversion, in addition to the internal 1ms
       delay, for the multiplexer to switch input configurations and
       excitation values.
+
+      This property is supposed to be in microseconds, but to maintain
+      compatibility, this value will be multiplied by 100 before usage.
     maximum: 255
     default: 0
 
-- 
2.38.1

