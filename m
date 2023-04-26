Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004A6EF29D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbjDZKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbjDZKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B891721
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f178da219bso69130255e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506178; x=1685098178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQ2ocTAU3w1gKmLb5aCBlSTPYDVel56Zbysqh02DwsU=;
        b=XnF9TRXDlY/DK+hthG/Blg3DT8/nuQKX0ruzN6TorxzikeyruZ4/vxjMDGX0QPwc0M
         f5VIsH1DBzXJt+aeESPe5YF5bE1UbkpC5sySC1kwvM2eQcoK75y8hlRjZcbeuD7Q7I+V
         NHy3+6UB2aQnRLL4EAG/m4/ozufa8QXrF7UiOMf6CK/0USkr8aBUUfk4RzNFJNlQ9p1W
         CiPCGZ4cdVCdbYDC1lGMrRUIm2M92MFZbqq6H89X+c8T7Za6uFQNveLsT3uiU34A+GX1
         z7p2ZOn0dBcgCLIOPRtJ0mv1Yzhi3kfNMf+wOnFsHY6XKLjT0KkGd27R3Y+YnZpiirgP
         Mo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506178; x=1685098178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQ2ocTAU3w1gKmLb5aCBlSTPYDVel56Zbysqh02DwsU=;
        b=g2whpBo5acsr/v6KqIKtSxKqFoJsmgozmHT07+U0ycHpkHyxbNSQtAWLnSsXkykH+W
         O6hbUHSNr94muWtmMioQrRjqT4lE//NGnurHt9HVWf4H2RMtya9/CBzmIXPR5XwUV25q
         yuLXlgqCIgeu3PmUWUOlGJrNq52ExZmEOG/cx5qOkdSEL9bvvbdp0Jbk++gm/Lmup94/
         2/pER0arlE97g/Hy7/DBpirnJqPO+Utf+dytD6nNpqX84T4iuJWprsD9utIOkzOLK/ci
         veQsQ1z4wN6px3WKvyaCriSTv2NhNsTUOj69PXN7GwyxskcCOS/73GuwPxIsAhnCV5EZ
         Hgzw==
X-Gm-Message-State: AAQBX9cvwgmpBk/yO7VvSenJf23iYzuIkdUm+d8WO3FbpCOjOE+UWcl4
        Qzwi4HR4viTrCBJHenXIkBqsBw==
X-Google-Smtp-Source: AKy350YS0RMYAbp2tq4KoRMWXe/tmDg25LdX/lZEi3WR4NrxuEmIAgG0m3L0wS2o8+Zw6pLwGW/q8Q==
X-Received: by 2002:a1c:7918:0:b0:3f1:6942:e024 with SMTP id l24-20020a1c7918000000b003f16942e024mr13035866wme.27.1682506177702;
        Wed, 26 Apr 2023 03:49:37 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:37 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 26 Apr 2023 12:49:01 +0200
Subject: [PATCH v6 01/12] arm64: defconfig: enable MT6357 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-1-8d6b1cfe7f29@baylibre.com>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=mrWNpoe4C/7P/FRc2t6J8feM9yfT9dI6dxq0LTHYw3M=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG/qSDMgZ3r8fdgRPPg4FrVKd77rLRBKVCAHwRF
 uAyw4nuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHURSnKEA
 DG5y+5y/X+JV48T/DjWBISDlJgDT4FA7qzOZH0cDY5DVdhamwKYCcU8847ERf0DwGj78G0QefmdgKo
 szfrdw+b29JrZ888Ofi+sh1oHb3QpeVfhi7/AJVXB3Sf+Uh2bjQLV8bhKIUVXtundZymBw4HQ06WTD
 5Bb/SmiwL8Ws0HtoYCX0Co9CjrgTsSAVXoS36Qx5hef1YFTOhf4d8ZtxPIJTn98YHS8Ii81K+Ac5Zd
 Iltu2Yl66GRonTMhTd99RUatBOnnYlimiXom1CRUewG4PhMud0w0PUB+13fpLXTr82WiNa5IEeJqlS
 6PzGEYfCyHGfVcnAF7vZqJesFcdiAlcS1So1N9MVfOZOHpyQT6cL1NQCfG0e8k67EtrDv6LXuPEkwM
 KX7MgrCcXV5UsoW/9hJNqXX5ccC/MyB4g0x2Hr7ci/WRCY8optCd60IB00JxfxLLjmJzKeKbCrQZ3N
 /QCwnwwVB+qfz3MS3trWn2KcqB1oKS+4AjKjhsUR4RE7gVZvGJUrQl0QVcRmetH9rHkvjnsLDAfX3k
 udG7WVzdtKwr9xioRfJrjRnjTNpUFYcLi1BRT1p0MR+eO6Ht2ELKmU4ajGl7hEnuIYEKaiwwImowPs
 SRaJ66Hznhnhi8z9HRTrRZPUN9z+Nwg+60xYAqpHM8e5wHeV4lVDg6EQAC3g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the power regulator support of MediaTek MT6357 PMIC. This driver
supports the control of different power rails of device through
regulator interface.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..e4cb65889ae6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -685,6 +685,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6315=m
+CONFIG_REGULATOR_MT6357=y
 CONFIG_REGULATOR_MT6358=y
 CONFIG_REGULATOR_MT6359=y
 CONFIG_REGULATOR_MT6360=y

-- 
2.25.1

