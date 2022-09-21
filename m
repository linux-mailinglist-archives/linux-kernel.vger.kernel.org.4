Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB235E54F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIUVKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIUVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:10:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A025926E;
        Wed, 21 Sep 2022 14:10:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so11363599lfr.2;
        Wed, 21 Sep 2022 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RfoS4oNSl3iLm9QkSJWnFYEHwL243tVfavoKrg1T0Yk=;
        b=ZLrVi3gkesY3f5rBqcgro6CMPhda3lfN+tvhwrlra74SdGidbOb0IITpJNFdVxHbRb
         cr0T/Ak7pmh8hciLZteZ2Vd43eXLDC8YRxUPH/N39duj/2dSq2o4JIh22IaouWxO645z
         tOJjARv599o/6owL6+Aj63mtYNX9znFnl3StMvONNzu/LDdLwIkuQbiEul7ngFFagYuP
         lP9vGPA4YzjDzdv4KFhWEZrq1TUwuPHQLI6rxVMaVhT6AyIcpQvdS457nyZgXb7+3b8g
         rKdV4tgVlTACzKmD+sBTC0z3NyLqCJp4aotEjnfvLZ5kHSXSaJyA7fbrMAkMBmVgJT8/
         zvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RfoS4oNSl3iLm9QkSJWnFYEHwL243tVfavoKrg1T0Yk=;
        b=z6NocYYOL0KArN3iQuBl+ofz4hjx13nQVVGbmT5b7fZc0tgmEdDzGNqGVHNOwWMbeg
         eRxxQqkvR7Qxz8Kmw3V9tYaDEP/7hFtS6Rm9HVMuDkR6IPGEKrgqeJRDv1fXn8/wNAKt
         q2vc5Tk5QA7mfvNlW0T6tCtVF43Rp1Fo+FKDZ7fWBBDJpbBMsjgZxCrj9bt9RKt2kyGl
         vW34KQE2JtqlqsCsrSgPjrA/E42pdcbxVf9zLFRDG0ykjoXrHn0UQpPPpj7Q+qxCzJ7e
         IbAsx+HmCVUaewHLMaB6k4Ga49gCY+9Dxuz3Hlr9yAtit6EJFdT0OIOcWeDcKWZr+qXp
         0RRg==
X-Gm-Message-State: ACrzQf3Ix9hVxA2UfKE/lEVlWQatTx8Vaf5mDY1GlHodgtiQjpyxI8wI
        qwZqbLlPm2yGYenm4Q9gSYmNUc6kSx/9mw==
X-Google-Smtp-Source: AMsMyM5Ki08t3TG6Pk2qQd8w4vkm6laOpa8ltLFD+v+d+zb9XxFVHDhHFN5aPkWp8FaP1wpeOj82Pg==
X-Received: by 2002:a19:4315:0:b0:497:7488:7a76 with SMTP id q21-20020a194315000000b0049774887a76mr12056lfa.286.1663794601048;
        Wed, 21 Sep 2022 14:10:01 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-10-176.ip.moscow.rt.ru. [46.242.10.176])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b0049adbc24b99sm599260lfe.24.2022.09.21.14.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:10:00 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v4 0/2] Add AMD DaytonaX BMC
Date:   Thu, 22 Sep 2022 00:09:45 +0300
Message-Id: <20220921210950.10568-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920165404.14099-1-aladyshev22@gmail.com>
References: <20220920165404.14099-1-aladyshev22@gmail.com>
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

Add initial version of device tree for the BMC in the AMD DaytonaX
platform.

AMD DaytonaX platform is a customer reference board (CRB) with an
Aspeed ast2500 BMC manufactured by AMD.

Konstantin Aladyshev (2):
  dt-bindings: arm: aspeed: document AMD DaytonaX
  ARM: dts: aspeed: Add AMD DaytonaX BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts | 319 ++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-amd-daytonax.dts

-- 
2.25.1

