Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFF701680
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbjEMLtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEMLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:49:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40C10D5
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:49:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so97101915a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683978580; x=1686570580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiSbSUosuiUZqcS7c/GQgLfHatjAKKg2yNJfrvJFGcQ=;
        b=B5dZsgqCdQYJvBqGfHIpCDUvgxGam71ot87mOSUr0/tfzT8jM+bIz3yHlLZQY2wgkV
         cYJD8PUSpUNYvyU3wbVDQXwNpYD0qpFpPROmKsYihdBwcq5wZoI0bfhN8sttQeXefp+n
         z5UMK9Z/0N+Yn+awIDU/yqNDDTEaWBi9I2htvUbZ9WOGCQ2E8tPp/V9adn6ZoKvzm8e2
         mxGtlsssxprUOn1cBiTCnLhg5ALVRfw/+O1u1ac8dMYyxIkhf+nIgD/UNmyvmXgR1u5w
         BVW6LWUOHdiUu/OdTezHqhdVTc6wtQvr5EmgwWE6njl4+eXAdw/Bl16njMkBmon3RYYc
         4RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683978580; x=1686570580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiSbSUosuiUZqcS7c/GQgLfHatjAKKg2yNJfrvJFGcQ=;
        b=HD2NmNmJmeS7juHQgVySwnoDXWz8TRw8XXhZEMIUWmt1Jjg3i3dv2jbyGtGqjODNTb
         XieQUinXZQRLija3LyMqNrmpTNYu9kWD2uclrx5IPtDAUMJ6ZjEjO9ocaSwkFgryl/vR
         /a5QS8ld2I/bIaXaZWoPBoN4OhLhG7RSgWBGF+mWBFg9mVKUUFRB9MXUbRBJgA10/nkC
         DkFnA1cO8T1s4Bj5PK2h/kD1kYCGXg172yCIT0BgYladJ6dieWuReneyD2jdqdbVf+Ie
         qnTZrXwvCYnCnlOD29r2TsW6XzaLP15XOBdBjpfXDbgLBpJGJcmgbz49Z4/spGJZq4y3
         +leQ==
X-Gm-Message-State: AC+VfDynzwi9snjk1Uvh61C6B5Ao3hQQkPC+zPlQeK6lSMj+y6VmLqsD
        XJnVbmAFuXF7VPBK4wO2TQoUgg==
X-Google-Smtp-Source: ACHHUZ5sSHT7qRhmXbBrwI11dOVCUtFfCHNEv4gFh2QnxQ87UJKKz1+Yf4dbmDsgeemez0wJK8BPfQ==
X-Received: by 2002:a50:ee0c:0:b0:50b:c56c:43d0 with SMTP id g12-20020a50ee0c000000b0050bc56c43d0mr25205160eds.1.1683978580503;
        Sat, 13 May 2023 04:49:40 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3aa:fd4:f432:676b])
        by smtp.gmail.com with ESMTPSA id n25-20020a056402061900b0050a276e7ba8sm5030638edv.36.2023.05.13.04.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 04:49:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Escande <thierry.escande@collabora.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfx: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
Date:   Sat, 13 May 2023 13:49:38 +0200
Message-Id: <20230513114938.179085-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If sock->service_name is NULL, the local variable
service_name_tlv_length will not be assigned by nfc_llcp_build_tlv(),
later leading to using value frmo the stack.  Smatch warning:

  net/nfc/llcp_commands.c:442 nfc_llcp_send_connect() error: uninitialized symbol 'service_name_tlv_length'.

Fixes: de9e5aeb4f40 ("NFC: llcp: Fix usage of llcp_add_tlv()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 net/nfc/llcp_commands.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 41e3a20c8935..cdb001de0692 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -390,7 +390,8 @@ int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
 	const u8 *service_name_tlv = NULL;
 	const u8 *miux_tlv = NULL;
 	const u8 *rw_tlv = NULL;
-	u8 service_name_tlv_length, miux_tlv_length,  rw_tlv_length, rw;
+	u8 service_name_tlv_length = 0;
+	u8 miux_tlv_length,  rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
-- 
2.34.1

