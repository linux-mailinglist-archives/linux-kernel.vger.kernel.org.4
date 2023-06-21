Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F759737B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFUGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjFUGJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:09:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09A1726
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:09:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9883123260fso446617766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687327793; x=1689919793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KQyTonkUooBZsCr5w5RfeTc4RupKUs9CBjpkXfe2Zk=;
        b=ZO7zbGSnjCubhNA1aJxOIocol/slpspgaFBAu8h+g0kOo+kkW1gC1geXWAhvpJdqgP
         fIm7mM239zNKuVAAab7maoqlMR82pr3JLqsCBNEg37JsM6oOwB5XDBZqLDHPVn/rHVSu
         U7zOz2IzamWLBM7jeuDa5YYnjcnccPnMkETFmO/pXVqAxYp/IIVKCJWj9FuRfJKqtgkR
         Z760a/ZsctTmvN7IJHN/rOklNWIghh18ThTV2frxr4YtUMWv9w/l0vStw0znN7UG57H2
         pIlUaYrlvco4xsp2Gw40UOS9xJxeDGMCfDYJjGJZsPkj4d5/PLK9AOslTCV0kZkUG40G
         T4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327793; x=1689919793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KQyTonkUooBZsCr5w5RfeTc4RupKUs9CBjpkXfe2Zk=;
        b=MXhjweBF3YSCkegHlEYglvh2IJ1NNFwsLF7fPh2s/DGg+PjTPCm0CLA5KZcAY3oEQT
         /ilnSrsFTkENhjzMv1u7fWK0KS52zfUg2n8NxXs5jTsg9ns2q9vlVywTdfPV/ThdJKWC
         +/4jwxNY7ga7W2QquSyS2Vc4C/uaHqbT7JeoITVgh4sOOi3QFuONQtwv57H8EPLhdlP7
         uEafQABtIxXvrXIVgBYHCdGhe+0W83v4OKxEl51oRzxih0aDBuedF1R/4T7uF3mO3YKo
         5JteGBWUL4ylHhR63Mo4pn0mTu2EaollNRpU5C11mkSBGnb8xilios9FekIPM8hN7BDV
         ZpRw==
X-Gm-Message-State: AC+VfDx6XEZpxS8tM8v9jG9xApvaD2z5IGj3He5FC897rudkYw3RSBz9
        8OtZm52qvY4xBYj3GcHlNrai+w==
X-Google-Smtp-Source: ACHHUZ73bgT3/h24wRR46mzrJ4jW1YcuFSwCdWXXjZ+Pi4NbX0uCX3RQQ5dOf848Fn01ctCLdRnUog==
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id o15-20020a170906974f00b0098921e46c6emr3288108ejy.53.1687327793394;
        Tue, 20 Jun 2023 23:09:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906698a00b00988dbbd1f7esm2509815ejr.213.2023.06.20.23.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:09:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth drivers
Date:   Wed, 21 Jun 2023 08:09:49 +0200
Message-Id: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree bindings should be picked up by subsystem maintainers,
but respective pattern for Bluetooth drivers was missing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea9d87f39345..3d5e378b3f13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3637,6 +3637,7 @@ S:	Supported
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
+F:	Documentation/devicetree/bindings/net/bluetooth/
 F:	drivers/bluetooth/
 
 BLUETOOTH SUBSYSTEM
-- 
2.34.1

