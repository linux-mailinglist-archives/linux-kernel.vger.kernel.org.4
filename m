Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED0742702
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjF2NKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2NKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:10:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06B2D66
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:10:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa96fd79feso6603865e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688044228; x=1690636228;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VItU8HW70st6V8J8MISUt/JOqLi21m2A756zbojdNMc=;
        b=HdGsFrpTob1y2/e3wRPz1UeRcwZ0DiwPVms16eSe+/HyHniDYA37WEHZ5Y60PNhJja
         b3X5DoNIn9ax/gqP85NsCpRO6iCYz3ax4tY/OuZTElwYDJP+MRh1b4jyQOLKBR+I/B+G
         bFWWxphQGCblRS7Oit5liqCTVwkRscCLvF2CGAt2pj30nn1MlB5XpW5EYQeflwAuTtts
         Ktx3MDvY8A/waPvTuUIlAolac1+8xCE8zhTgON8766QweJoAhp5Z+K92ZBvzt5ASqXBp
         kOr/cNoe4WcHp/Mocj8x9Uc9R+n3fvgFjF3ySmYnkCSaJs29Ilpn4d3QY5OJfSkllWYz
         VG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044228; x=1690636228;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VItU8HW70st6V8J8MISUt/JOqLi21m2A756zbojdNMc=;
        b=KDL5sqFTJh0vkYOP+MHfsktQtnnpXGvdFlf/vKIyyAuHKcQJqgUvRL4qJFcKdTmF3N
         xMq8qMzRui26W/3hGWkW36KovuCcu5B9jsd3RRHZDpoh/MWUW/qRgpxd/SLuxciZWgJd
         H4gDj4uhZCyK9b9v9cn1XuCoTuXkauS5/obZBDSQKDZnhddjj0nAHCRxI2kiT6QM4urJ
         cs6SenG/NGnVjRPQhn+W9irproJBUNbdQBItUHPFdVgNlndXixGXBRUDQq7J+YzSCQzu
         O6cc0v7W6/Lp9OxKM5nm06OUnXTSgFhSftNhDDzcKP0M0HO2OsOY1/YmNnsTc7ydrj1o
         ge9Q==
X-Gm-Message-State: AC+VfDx0GVK7YndxCqpd4ctcaliqIhTOB0UzX4VIru1CCZish99B8bcC
        ErBQvH3hzauegfOHOqSLbrmmWQ==
X-Google-Smtp-Source: ACHHUZ6HE00YizRhBI6hxzj6Lkxz0YnEWYDsqVRUDcXxb+GkugvQIGw672zIBlmxTlcrREh+AQA3iQ==
X-Received: by 2002:a05:600c:3644:b0:3fb:a2b6:8dfd with SMTP id y4-20020a05600c364400b003fba2b68dfdmr5943020wmq.32.1688044228139;
        Thu, 29 Jun 2023 06:10:28 -0700 (PDT)
Received: from [127.0.1.1] ([77.205.21.223])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fa95890484sm11885899wml.20.2023.06.29.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:10:27 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
Subject: [PATCH 0/3] Configure usb0 as peripheral on am335x boards
Date:   Thu, 29 Jun 2023 15:09:54 +0200
Message-Id: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKOCnWQC/x3N0QrCMAyF4VcZuTbQVjemryJepDVbA7OWREUYe
 3c7L38OH2cFYxU2uHQrKH/E5Fla+EMHKVOZGeXeGoILRzeEM74tOiTD2lzNrLSg72kid0rBjz0
 0GMkYo1JJeacPshfrPlTlSb7/t+tt237l5FNSfQAAAA==
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
        Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688044226; l=994;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=o90YNbzVP/LtweeHx56MaIg0Ldsz+J7DwexvicBarJ8=;
 b=AkYcWqHrfTA7UmVjPbGJl1k9MoNSK9+UPOxWTKhBe2tkAshcsZrXg9h0wowm5XQHP2/GaOXQm
 6QiH9JI9XE/APq0qK+xLmtjs4RRe4o2leyX5+xqtLf53mFnOqqN+K8/
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series configures usb0 dr_mode as 'peripheral' for am335x-evm,
am335x-evmsk, and am335x-icev2. This USB port is mainly used for
RNDIS and DFU.

Initially, a series was submitted to overlay dr_mode in u-boot specific
device trees ('<board>-u-boot.dtsi'):
https://lore.kernel.org/all/20230621-fix_usb_ether_init-v2-0-ff121f0e8d7a@baylibre.com/

It was finally decided to modify linux device trees.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Julien Panis (3):
      ARM: dts: am335x-evm: Use usb0 as peripheral
      ARM: dts: am335x-evmsk: Use usb0 as peripheral
      ARM: dts: am335x-icev2: Use usb0 as peripheral

 arch/arm/boot/dts/am335x-evm.dts   | 4 ++++
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++++
 arch/arm/boot/dts/am335x-icev2.dts | 4 ++++
 3 files changed, 12 insertions(+)
---
base-commit: 3a8a670eeeaa40d87bd38a587438952741980c18
change-id: 20230629-usb0-as-peripheral-15afa04c2185

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>

