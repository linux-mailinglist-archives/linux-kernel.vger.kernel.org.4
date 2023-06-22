Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C8473A2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjFVOOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFVON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:13:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D651BD5;
        Thu, 22 Jun 2023 07:13:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-54faf8db79fso2975290a12.0;
        Thu, 22 Jun 2023 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687443229; x=1690035229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6szGr6L3i5FMz3phg8XsP+aqzdYx92eWbT4G3zQDHo=;
        b=adR5ukuVOqtAHxCW1/2gcsyU8AcnMgeN0HpZwi2J9gVz4YE0wOy6BcJfG6nZc0eOaB
         czGVjDX6ndsY7QS5ZKegJZcn7Ln5qOcITnxgusUpMqq7Qly3s6V0iUw5nNlrWWJFt7JI
         Ff283Ji0FWpr6uLCtWsKbuIyxlIr65xcN9NKvgcG8SRi9DSjPrLCotnXFDa1pQLRRxdy
         Tp43/7YP+iG7c34E2CBf8qNDiBlVeNIYxbFYL+0WXPbWtSiOqqOOnfRxP9JMbMUF15MM
         30NlIRUtQqH0eKw7dNnd/Y8TZyu0+ChAnlI11TpoHRVlWRYwgAsZlt4J44h3kxjl1LIs
         EOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443229; x=1690035229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6szGr6L3i5FMz3phg8XsP+aqzdYx92eWbT4G3zQDHo=;
        b=Z2uOXV6wootSbCpZTpMuj8rmH7phFM9l+iH1PQrfcG5JEaIQn6lJPVyVijSsUmXsXx
         cHW73D0gk6WEeMsQfBEE4DseAEQsLCiwDD9ynRap658XCZ8MKTn5n5sKEM1YRfT0xxYt
         zktC/YV8EIpFUyIy2PokqOsMe4UfB8u+Wns9qlEXepK8sxKXXybWhhrLM/gPl7Vkr8k2
         nY4YANUQ9lGUuewMuK9W6iXtyzhYb6FGv1L56v8ZShPkIO/oeJmohgnxJTQ1BvSd8BnY
         30jhT6ZWQ7d3l8pAkTHii0gHxRnMceFFhV+L+B9Q/41Ec+Yrvw3h4KOKJxqz1jzI/VYB
         lQzQ==
X-Gm-Message-State: AC+VfDzVJUTPFzN0IkS33rV8ULpffkFZxvki3fja7YrDZaHTflC3k8p6
        53VuoaB6w22jYKqP/tGxnss=
X-Google-Smtp-Source: ACHHUZ5vHyg2/Vz93cNtJWXlW0Cr2pAfwP67ir0M9Lf9E9Znb0Youi7lQxT6qXlm67BdxM+iu29DVw==
X-Received: by 2002:a05:6a20:6a27:b0:122:94d6:df11 with SMTP id p39-20020a056a206a2700b0012294d6df11mr7693183pzk.43.1687443228765;
        Thu, 22 Jun 2023 07:13:48 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i20-20020aa79094000000b0065a1b05193asm4604268pfa.185.2023.06.22.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:13:48 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3 0/3] clk: nuvoton: Use clk_parent_data instead and add a header file
Date:   Thu, 22 Jun 2023 14:13:40 +0000
Message-Id: <20230622141343.13595-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This set of patches addresses some of the issues that were identified in
the ma35d1 clock driver.

1. The external functions referenced between the .c files in this driver
   should not be declared within the .c files themselves. Instead, a shared
   .h file should be created to reference them.

2. Update all constant hex values written in uppercase to be lowercase.

3. For the declaration of parent clocks, use struct clk_parent_data instead
   of a string. Due to the change in the passed arguments, replace the usage
   of devm_clk_hw_register_mux() with clk_hw_register_mux_parent_data() for
   all cases.

v3:
  - Extract the unrelated parts from patch 1/3 and create another patch,
    patch 2/3.
  - In patch 3/3, remove the modifications about line reformatting, as they
    irrelevant and have no practical effect.

v2:
  - In v1, all these modifications were included in a single patch, which is
    not ideal. In v2, there were no changes made to the patch content itself,
    but the different modification topics were separated into two individual
    patches 


Jacky Huang (3):
  clk: nuvoton: Add clk-ma35d1.h for driver extern functions
  clk: nuvoton: Update all constant hex values to lowercase
  clk: nuvoton: Use clk_parent_data instead of string for parent clock

 drivers/clk/nuvoton/clk-ma35d1-divider.c |   7 +-
 drivers/clk/nuvoton/clk-ma35d1-pll.c     |   5 +-
 drivers/clk/nuvoton/clk-ma35d1.c         | 348 +++++++++++++++--------
 drivers/clk/nuvoton/clk-ma35d1.h         |  18 ++
 4 files changed, 259 insertions(+), 119 deletions(-)
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h

-- 
2.34.1

