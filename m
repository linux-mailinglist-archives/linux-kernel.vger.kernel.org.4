Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B531D6D763E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjDEIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbjDEIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:04:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBE4EE2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:04:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-4fa3c1a7a5aso203720a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680681882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knNBWU1tEPnpVgHr0NHSaq41CVWca8alYZPbI02km30=;
        b=UVfLyJ4U1LTTsw9/l2Ezvobf38cBIinJ6k1Wn4FHs5A3VFvzepgpOTTipJ0mhKt9hy
         04xhVwg5jn/MCno6zaKR2LEZR2MPT7jh77ipxI9CTKy8vyzax6saAN0iASPnRcHvz0/5
         VO+QDjmssHzCOHccG3SHDVEgcNrTHc3CPRJ6PyV7XAd31otafioMGfdCn/nhZp26xGWS
         4tCpHmaFlK2XwywMhmtoMQvP8cUPNoA54gCjNZel/0bCPAoMB8rpB2hStnNFZCScSHvj
         7/sQLhYpujqe4RydsR2eIB7JxXDh0H7gnhFMXBsXwpAfSWMOBmkJGh7Naivou/PW+6hS
         nDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680681882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knNBWU1tEPnpVgHr0NHSaq41CVWca8alYZPbI02km30=;
        b=lNmKQQoQPzkhtGWXaf0SduKfkJbCLUKAeoq34WvPaM9wE/OipVXBeo0jvm1M0OIU5U
         oyl4tutS8Doz1dbMBUSa6GVRLpU+bXOQ0xluZBNq6oOmqDOeH/LTabQcTp1JW/6mJ+aK
         5RbKWT+/vitsGO9ih4gBGkmgDRSb9g6Z55hopQOBR9JSavcME6IsY7pVbHj6aKqphiE/
         6ewsJE7JXXyYk7oj8Wp+4qx7N8o4gH5kVSNYpdBu0bOymWvLy3hBl3MPocl5x5QThKpe
         YZ7IkfjCvWluIj+ut3p0AeorfWBw9lz9a05YWLfgl3X7bz7T5vYEyaENGwhsVud+yc3p
         o5Gw==
X-Gm-Message-State: AAQBX9d8MJ6x1n+1/MlJV9Pw9ZPaZdZUpJ1kmUIoRkyG5X2suC48nEN8
        u9Ns020saBPEvY3yUt2K+FfFVg==
X-Google-Smtp-Source: AKy350bgJJjBqVOKkAvuIHFoVn9ZmTBnPLaEXXwVS1XU/9ZvvW5IptbzaN4hC9/iTQUPBMsKyVCmDQ==
X-Received: by 2002:a05:6402:202a:b0:4c6:10a7:c422 with SMTP id ay10-20020a056402202a00b004c610a7c422mr1122764edb.18.1680681882390;
        Wed, 05 Apr 2023 01:04:42 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id z21-20020a056402275500b00501d73cfc86sm6845839edd.9.2023.04.05.01.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:04:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/3] ARM: samsung: soc for v6.4
Date:   Wed,  5 Apr 2023 10:04:38 +0200
Message-Id: <20230405080438.156805-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405080438.156805-1-krzysztof.kozlowski@linaro.org>
References: <20230405080438.156805-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-6.4

for you to fetch changes up to cb56f508e541036ad41cb9a5afb46339b2f83b9f:

  ARM: EXYNOS: Use of_address_to_resource() (2023-03-22 18:47:01 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v6.4

Cleanup of OF-related functions: use of_property_read_bool() for reading
bool and of_address_to_resource() for mapping MMIO.

----------------------------------------------------------------
Rob Herring (2):
      ARM: exynos: Use of_property_read_bool() for boolean properties
      ARM: EXYNOS: Use of_address_to_resource()

 arch/arm/mach-exynos/exynos.c  | 8 +++++---
 arch/arm/mach-exynos/suspend.c | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)
