Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84D1608EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJVQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJVQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:51:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0314718B09F;
        Sat, 22 Oct 2022 09:51:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so9343274wrt.11;
        Sat, 22 Oct 2022 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf0wqcQ2vn6wyNNf67PgKqcbfJEkj1r+s1XXcU5BuM8=;
        b=kJxAwMNfYz/zzK2W5CaZWyGfe8CQEbdzdYVfSJ5JHL/uNKW/GH9uK8I+cS/tqg6+Bg
         Ew7XBekCycbPQBhhseYk1eXrldkwl1nRv5zCJw8kRRwsCpAzUkvGjfjE75Jga4oFP1nv
         nbEJq9MJ4VVXEDuT26SLwTrYdAtt4l8aF8KMbjg2DOfkh4Ub9tuStmreXKcaAAtNtCnl
         N9eU2ZoP51pBdHZpklm9h68+I4XLKBKv6/J1GjY0I+cnw7GvGbw0Z3i8RCCXByzBGllU
         I0bkhNjQm6C0euiXWXepzMJl6xFHDGT3BiCaiCLZCVJUkg/tonRUCP7RbHqAMbPU2Nda
         Bg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf0wqcQ2vn6wyNNf67PgKqcbfJEkj1r+s1XXcU5BuM8=;
        b=Bfv10DrXDE3fDyV+g0HLqqf3rUh2+amCoYTlJWxSMki6Ov0zeMsg+b+taOB66yU3/o
         mEQ4XH/nx0+bUOFERB6GEjn8VyUjB0+eyUIg/zA6WcDBkMfmeBJ8D7YCXNey8Gkw10+7
         dKN9cE80IwE5UFWAPO37DLr+5sICOKavXyj1Q7WEM0ZggJDbNN/x7nvqUfMrIQhQMU4Q
         HQ4PGZ+A9nN3LA41bhPL2CYwas2FDzj24VjD1UcjXqEjOR9iUfhcCoHkV0++P5fpWsHY
         6jMx7o8ySuNbDc9V19GgjqkA8KlhPokJAyter36laXhPi5gFJjYAT1GNy3iaeo967sZT
         AjBw==
X-Gm-Message-State: ACrzQf2ePrNhkDEzsnW4SMlIPVH9L7ROeTXv6itqK42rjcHmpjlQZ1Xw
        JmV3UJPr33pqVCRbRDouiJk=
X-Google-Smtp-Source: AMsMyM57AfPFx/Eo3cRVqdue/JYf8BFg7s60Ki/YGcDwtrtpFlVR1mRoG9h72GyAfBXzbMWMdjFH7Q==
X-Received: by 2002:a05:6000:2a3:b0:230:c9d4:3f9b with SMTP id l3-20020a05600002a300b00230c9d43f9bmr16139844wry.254.1666457458614;
        Sat, 22 Oct 2022 09:50:58 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.133])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b003c7084d072csm3196787wmq.28.2022.10.22.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:50:58 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: serial: ingenic: Add support for the JZ4750/55 SoCs
Date:   Sat, 22 Oct 2022 19:50:46 +0300
Message-Id: <20221022165047.4020785-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221022165047.4020785-1-lis8215@gmail.com>
References: <20221022165047.4020785-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These SoCs UART block are the same as JZ4725b' one, the difference is
outside of the block - it is in the clock generation unit (CGU).
The difference requires to make a quirk for early console init.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index 9ca7a18ec..315ceb722 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -20,6 +20,7 @@ properties:
     oneOf:
       - enum:
           - ingenic,jz4740-uart
+          - ingenic,jz4750-uart
           - ingenic,jz4760-uart
           - ingenic,jz4780-uart
           - ingenic,x1000-uart
@@ -31,6 +32,9 @@ properties:
       - items:
           - const: ingenic,jz4725b-uart
           - const: ingenic,jz4740-uart
+      - items:
+          - const: ingenic,jz4755-uart
+          - const: ingenic,jz4750-uart
 
   reg:
     maxItems: 1
-- 
2.36.1

