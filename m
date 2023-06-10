Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4779E72AEAF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjFJUgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFJUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:36:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1026B2;
        Sat, 10 Jun 2023 13:36:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so30825665e9.3;
        Sat, 10 Jun 2023 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686429367; x=1689021367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VW3ufThgtzabcqR2lSzvJonEKJi+vdbcWOGvWLdXSuw=;
        b=G8gcoEFbSty+rM3z00E625GAC4MphjCRwG+0qvC9LclMM3BG1YXAZEV9JdXh+Dgng0
         EJhzQqG/AzFz9LuuI8wk13LuQEEFXArt3pchXmR86iRidKOS5j6i//hoHpPW3Ta1fBbO
         eorJElEmO2mQfmiXAWxK7y1zjF7pm3LM0awLiozRdtU680HpCHgvSXFo/Z3OhNA3r8RO
         blAyod9h7AUiwgfsCofNQOnGCxV8E4R1NwPQMFVgAJna9Ind7aDN6GFCys4u5pwO+QF6
         pAGb1aqygR65a6oin0FXCbyHEU90uwoCyVsBclz1DONTAfLcW424UNlO2H+pML98P7n8
         tZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686429367; x=1689021367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VW3ufThgtzabcqR2lSzvJonEKJi+vdbcWOGvWLdXSuw=;
        b=eMmX67uumQuptU6jugp1ApHHk5wBgZxLAD2spWKEvtzxjUhJRVvaVwLPZtGnb31zp0
         1XDo3DobQva5LDnqGXBQJis6U1BgN4zUGl8jTo2fOZ4nOIkvnDA5MxtfiWgZ7RXIVZry
         gK7I2+C1pUfduZJaoPeUv8WzYtpn6/S7x7z3RqdDa19dwDn5re6mme24u8Sp1H6UhmoB
         MEJAMhxQmBxMPJ8wbGIf/6DwT569p2j+8s7Veusic4TUpGqkzDpBXC6wYAfJDIJsghTI
         I6n4rcYPyEHt1/sRol3RMmXhVVnpC4km16wkkNpHMPcclldEs7erjVBiq+wb1vXQ++PJ
         l/lw==
X-Gm-Message-State: AC+VfDyszAbCsSOwT5zfBI0RW5zwi0VOBXhNfUHxDuK5KBIp+CHnymbE
        sc3zM8ExICedl8Mh88dgmw5EkGSKncGGhjGa
X-Google-Smtp-Source: ACHHUZ66lmd9V4cfx9DRFPFSHhBP4rWQz3UvrI5a7rsIQWgHgIRx9tzV+r8oz64wo77KNfyZtD1sfg==
X-Received: by 2002:a05:600c:211:b0:3f6:906:1195 with SMTP id 17-20020a05600c021100b003f609061195mr4112575wmi.35.1686429366811;
        Sat, 10 Jun 2023 13:36:06 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003f42a75ac2asm6572867wmc.23.2023.06.10.13.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:36:06 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] Add D1/T113s thermal sensor controller support
Date:   Sat, 10 Jun 2023 23:35:41 +0300
Message-Id: <20230610203549.1127334-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Allwinner D1/T113s thermal sensor controller.
THIS controller is similar to the one on H6, but with only one sensor and
uses a different scale and offset values.

v2:
- Fixed SoB tag
- Moved binding patch before driver changes

v1:
- Initial version

Maxim Kiselev (3):
  dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
  thermal: sun8i: Add D1/T113s THS controller support
  riscv: dts: allwinner: d1: Add thermal sensor and thermal zone

 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 +++++++++++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 26 +++++++++++++++++++
 drivers/thermal/sun8i_thermal.c               | 13 ++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.39.2

