Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6106E2539
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDNOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjDNOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:07:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF43A88
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o1so23557240lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681481182; x=1684073182;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw4R9yF5pQV1g0wZt/lit2ez2JDvjqS5l1RKTEe/yxA=;
        b=S/CAvV5qAVCU/68x1axECLEAe/g7GF0gwATiwlXa/MXUYeHCZe6NLyB2CvuL7D7TeD
         vAB2nrq0EfVCHofdXLe6V5V2vSBcZL3sgML7Kdk6d+wjIqBS97Y2ybS2M+I0w36P0AHT
         tUgAwsHOM6wm05erIWgSb1oQD4AkKWot8mhpRjRY5voxnvWZgd1VP93stZH8FPCjB1KC
         hp3M8Q6/HOkefIK0xXasqkEAcK9mEYtnmwyM4PPGB3SBWXUs9PIX8bE1WAzICenwIF9w
         NDQsSHv2kwWk8HYEsuwKxdLVz/OxiJhe/IgUHS+GFSZE+rzMH0NnqMpoH9WJdkO0pB2P
         Lq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481182; x=1684073182;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dw4R9yF5pQV1g0wZt/lit2ez2JDvjqS5l1RKTEe/yxA=;
        b=Iil9rXIkKcbclW8DHbG0Wb0aSf21sg3c/SXguJ1vUwrJfSy6epfsD8LQ7reThsVgz7
         1wgmQR7Vrg3eM7z+mUpoFJalFgG2cr8sQuQ4NH8TPhhWSIeDgiLVXG370LU0XHx1H8ZG
         tZ8StIc55wDhdrqPi/c1XisAFz9QD9syJnHkoKXdk86ODnRV8KG/K/L3XiZCTbdjUX7f
         ZcSIdOjO4iuzz5LROsU1KfH13vEoFMn/wHssf+dx9w4zW7B8RKpzOvCtY9swDGvuawqS
         E3oEQm6CVuKgV+RXtlMCHVrI4/xm7VLx2MfsIz3dFbS63KJcezzXsFDIx03++90ZJUxW
         rhwQ==
X-Gm-Message-State: AAQBX9fqTIGgOqE+wTtzi3rdFS8rd0vJBkuCr7HmqbdwLnDkXwFt2756
        /pDbpkLUlNFIOkMYq3in85Y1VQ==
X-Google-Smtp-Source: AKy350YI2myKORD+1bBf9V0MVzMF6Dl8kIb0e8hd0klWyNZrgM7mWlvudofzXiQ82QcQd3mDvU9acA==
X-Received: by 2002:ac2:5488:0:b0:4ec:7973:1ac with SMTP id t8-20020ac25488000000b004ec797301acmr1600070lfk.22.1681481182231;
        Fri, 14 Apr 2023 07:06:22 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b004d856fe5121sm808794lfq.194.2023.04.14.07.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:06:21 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] pinctrl immutable irqchips
Date:   Fri, 14 Apr 2023 16:06:16 +0200
Message-Id: <20230414-immutable-irqchips-2-v1-0-6b59a5186b00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANhdOWQC/x2NQQqDMBBFryKzbmASI5ZepXSRxLEZ0NTOtFIQ7
 97o8r3P42+gJEwKt2YDoZWVX6WCvTSQcihPMjxUBoeuRW+94Xn+fkKc6iDvlHlR40yHbcSxv2L
 vLdQ0BiUTJZSUj3iglabDL0Ij/867+2Pf/zipgBZ+AAAA
To:     Marc Zyngier <maz@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the final set of immutable GPIO irqchips conversions
for pinctrl. All done by trivial thinking.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (6):
      pinctrl: pic32: Convert to immutable irq_chip
      pinctrl: pistachio: Convert to immutable irq_chip
      pinctrl: plgpio: Convert to immutable irq_chip
      pinctrl: qcom spmi-mpp: Convert to immutable irq_chip
      pinctrl: qcom ssbi-mpp: Convert to immutable irq_chip
      pinctrl: qcom ssbi-gpio: Convert to immutable irq_chip

 drivers/pinctrl/pinctrl-pic32.c          | 36 +++++++++++++++++++++---------
 drivers/pinctrl/pinctrl-pistachio.c      | 35 ++++++++++++++++++++---------
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  | 38 +++++++++++++++++++++++---------
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 24 +++++++++++++++++---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  | 35 ++++++++++++++++++++++-------
 drivers/pinctrl/spear/pinctrl-plgpio.c   |  8 +++++--
 6 files changed, 132 insertions(+), 44 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230414-immutable-irqchips-2-503b0f780741

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

