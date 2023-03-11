Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D86B5B19
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCKLV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjCKLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:20:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D67140537
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cn21so552744edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIoO6eL+tDM4AN7UrOlT9SrG65ZLyWOyL92QpqRTor8=;
        b=GvHggC9Rk4fo+TGm5lRLiXN3qBJV2sERDmgNKuAJmI+cZmCiobS/4GR/3IYlSKb7+3
         FJc4YTD5lkdKXivSJd1LviB8ZZxvTLwwoEf7S0TCub5RhcJZOhJmmJNzLV00a+ZDKVDv
         raO3I81Nf6ZZy+3OgBAZVf/mtjB4E/QcnPIj/GcvC0cdA1yIdwjY/bbfUacewkBJ77fz
         Yqg9Q4gkUTD98JLJOPhLouKIPahsQTBRJapNQd0dmKQy3L1CIBwfOr6vnWp9F0fnQY0/
         xVW1w273OFdu+3c9Po7ZvKX4abRvX1PGmKg9vxIGq5rdH+5pkrBNEk7ma5LrzJUIOjbo
         /wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIoO6eL+tDM4AN7UrOlT9SrG65ZLyWOyL92QpqRTor8=;
        b=3F26bUXmJ4s2jTPzgt2joP8v6pkxs3PX75TEZxH6sQeoU/z4zkTHR/pL98Cc9zIYWS
         d/ZrllSfEmzvK1imETNuc3FMgGK/1RS0KaXvXMcneHiTqhqL5xPHUgFRCqhkeHGJyGY3
         bTfMQjTehd6n3vKY2IGXQkdHAP0bZ+LSK7zqCctpUrBpeCxFs18+YjB66YlFyzp9Y4lK
         3AeOUiY7Pb9PBB66BJVZMWKW3jlbqSF30bRuMF202lHaH+tkZn+nyjiGDcnG7yw2eCvG
         74hu+Sh4PGCF/mUuFksydG+/JjSsQnpboIjG/9Dl/i6cbRT0IWsu0dkazP32/oTyiBq5
         PyTg==
X-Gm-Message-State: AO0yUKXJExHLyDqYoyGduVNZdPm0CbPdyY+/fwtj5dg07oGuG//g6bU7
        k+vPLEJXP5TMfK43ArzIRLD6dw==
X-Google-Smtp-Source: AK7set9jkO2NlkNHaYb5x/nRZfwPNzWxyfqanMxs1WiUEpkgYaf2NFWZ9/s7vVPeNa53couZfE0xug==
X-Received: by 2002:a17:907:d308:b0:8b1:3a1c:3174 with SMTP id vg8-20020a170907d30800b008b13a1c3174mr29519973ejc.77.1678533461907;
        Sat, 11 Mar 2023 03:17:41 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w5-20020a170906b18500b0090953b9da51sm971529ejy.194.2023.03.11.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:17:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] mailbox: bcm-pdc: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:17:39 +0100
Message-Id: <20230311111739.252080-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111739.252080-1-krzysztof.kozlowski@linaro.org>
References: <20230311111739.252080-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/mailbox/bcm-pdc-mailbox.c:1474:34: error: ‘pdc_mbox_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/bcm-pdc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 8d3a4c1fe761..8c95e3ce295f 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -1635,7 +1635,7 @@ static struct platform_driver pdc_mbox_driver = {
 	.remove = pdc_remove,
 	.driver = {
 		   .name = "brcm-iproc-pdc-mbox",
-		   .of_match_table = of_match_ptr(pdc_mbox_of_match),
+		   .of_match_table = pdc_mbox_of_match,
 		   },
 };
 module_platform_driver(pdc_mbox_driver);
-- 
2.34.1

