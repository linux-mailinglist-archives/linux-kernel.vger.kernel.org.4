Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00920691824
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjBJFz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjBJFzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:55:25 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32A664D93
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:55:23 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id ea13so2794522pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 21:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5R8hvmo1SVb1s6mNEy4BWSCFUG+Ltq9LTM/O0gN9JTA=;
        b=Qvu8XDbwAoU+4V0C/PwipW+1Uf5O/8FwlfMwq61WCx6k5e/bBImJSRtpnx4kusuXM5
         2LM9XBvyBARZAc/Is5l9DS3fofjPTZeKdT3Mz2MktglLapOFWnSjNHAubZPRlqKsqlII
         PvKbuSBp5IdwIZX9JQDq8NfR2hgZYaNrDwq845SrbkkuuQinR7KB5LOu7LgJ0i63NjM1
         rjexybfIVnz1X4Sk3/J1WgjK5nNhahp0QfChy/HGJCkBBtEJ9TPMfbVbD5gPJO62GtDX
         rVmx/8Dukt4cA/DHCEoymCRaVigogMEbIj+69yFQWagauFyBepe6AAaekfDIIT23OgYJ
         xlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R8hvmo1SVb1s6mNEy4BWSCFUG+Ltq9LTM/O0gN9JTA=;
        b=dIRfkf1SS4AhCYMNbSFr//K15TQVV706gTNHUwpB8+BfLIvC8pe7MF3vcgE7H6882a
         sIJ+kwC0QIl8QQXMOj1lw8+U/qYklm5iI0KtHtMfOdmJDs8rKJNtBO4PpQgDVae+T5ZL
         rWTz8OL5YkOrYA750u95Q8Ee/pMp/dFFv8F26l3/QTEksoQynRt3gdDDHnF+1QqWiIdu
         p4eNmosQmF+1KVo1Bf0ei3xJza96IOjEKnsGEzwASvl8wBAAbJkJuN8hGtmFkr+8l6gV
         VPyYmk4LHdkO3fFOwYfltBMakaHy95SL9x/uauU5kp72bMPmPs+jloHrnWMIGI9bqfxC
         x9YQ==
X-Gm-Message-State: AO0yUKVgJPWhKptoHPeM+w3tKPVKTBPqKCda4fcsp3Wzdtd2R5XD/Ex9
        EapEw47v0G5wVArbMlqVia2IQA==
X-Google-Smtp-Source: AK7set+xT5c3xbXiG/94Jkde+1ghokb32sfN6po8ViWkWFxdA0hCSqgnFQTaTbNpUcDHbuVAgMPKdg==
X-Received: by 2002:aa7:843a:0:b0:5a8:4e65:80a9 with SMTP id q26-20020aa7843a000000b005a84e6580a9mr5515134pfn.5.1676008523556;
        Thu, 09 Feb 2023 21:55:23 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b005a84de344a6sm2500025pfn.14.2023.02.09.21.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 21:55:23 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v3 0/3] Add Ufispace NCPLite platform device tree
Date:   Fri, 10 Feb 2023 13:54:48 +0800
Message-Id: <20230210055451.72153-1-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes for v3:
- add "Acked-by: Krzysztof Kozlowski"

Changes for v2:
- modify node name to generic one and check with dtbs_check
- send-email without confidential mode

Jordan Chang (3):
  dt-bindings: vendor-prefixes: Add prefix for Ufi Space
  dt-bindings: arm: aspeed: document Ufispace NCPLite
  ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
 4 files changed, 363 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

-- 
2.39.0

