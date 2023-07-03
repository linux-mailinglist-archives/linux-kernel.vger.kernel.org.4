Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175FC745D01
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGCNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGCNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:21:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCC0E3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:21:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so65304731fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688390515; x=1690982515;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tinG0/XqkHHzI3FCP2o6G+zrStuwejYrOQFggB4/KKI=;
        b=Akv376SiheqT7/HD212s99wJLv9JXMTr9kmlGBpWnI4y8zKrM2IHTYMQIj3nB2iNhK
         VBSi/XV1bivCL1R1B9yFgxz2ShMDnaySOMEIwphtfvcBnY/hbhodRtGxpErpQgytv9kh
         lqs/Lc1VGxRR/s/Tr8nnNsoiPfpP4v88P++WA955l79d2vhnLm2tGUofBe7uGlntf/Ul
         xzyk42q7Uk/yLiUKZGwgCzOJFOINeaMdCbqOJC1lhohTZ8vfoRHmDUMez/ZiHxBzEYjQ
         6Yrd0JyCXg2SB/6bLJKa/iAWUtVxf9qr4QDktVY15KbKymPXL6cN15pJ1/aKDmthWE1r
         HI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688390515; x=1690982515;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tinG0/XqkHHzI3FCP2o6G+zrStuwejYrOQFggB4/KKI=;
        b=Xe4Ek36iDt26V3vv52zCKobd30VbVGkowgwaSsIsBcmvUbpQeRffBYKpczV/HTEg4Y
         HHOX/acvgZxymdXVBSm83AZjh4ggSKpxkPEJWe4pqylH3/1hGgJsOqr0vfUMcxnlEIni
         D9U9aTFEUqidafBw+g6Iw/pX0rfTHxpA7lrV8XuHRl6JJ9KfhzMZp52TJl+l1Tq1UnVC
         Uc08BoyHMU4ZwAd0+tHIrK2Yy6EFkoIHc02lNlIPSfvrlLvUt1RrE/lBKlNzbK3jyMBE
         omKAJnc+cdc/1RO5Bk3J+NaBfq/iCISBG1WwiVtKRhkRLNoIuQWLqXdMfxQXM2GkN4MF
         zkfA==
X-Gm-Message-State: ABy/qLZ238WDkvgLNGeazXlWP3cng5kkfqyM4S2WI6KwSW4aMeo9E7PR
        ts1ZfxCyb2An59uQuCfCA/Ev0w==
X-Google-Smtp-Source: APBJJlHyfemJUeV2FAvERXLUeaCPUSlvq4XuIXhD6FBKsVkUD/9X+Reh8IAmeeY48HFE1sybjSdCQA==
X-Received: by 2002:a2e:90c7:0:b0:2b6:cf5e:5da0 with SMTP id o7-20020a2e90c7000000b002b6cf5e5da0mr5791563ljg.40.1688390515464;
        Mon, 03 Jul 2023 06:21:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e9f0a000000b002b6b7a98c4bsm3535238ljk.77.2023.07.03.06.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:21:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
Date:   Mon, 03 Jul 2023 15:21:48 +0200
Message-Id: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGzLomQC/42NzQ6CMBAGX4X07Jq2lB89+R7GwxYWaAKtabFqC
 O9u4eZJj7Obb2ZhgbyhwM7ZwjxFE4yzCfJDxpoBbU9g2sRMcpnzUhTQmRdoRzBHwcXzMYEdSyg
 R8w61lFoplqYaA4H2aJthG08YZvLb4+4pCfbe9ZZ4MGF2/r3no9iuP0pRAIcam7yqFS86XV1GY
 9G7o/M924xR/mORyaKKqq2oIVWc+JdlXdcP7DD+LBgBAAA=
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is two patches fixing things I would normally complain about
in reviews, but alas I missed this one, so I go in and fix it up
myself.

Discovering that a completely unrelated driver has been merged
into this panel driver I had to bite the bullet and break it out.
I am pretty suspicious of the other recently added panel as well.

I am surprised that contributors from manufacturers do not seem
to have datasheets for the display controllers embedded in the
panels of their products. Can you take a second look?

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Rebase on drm-misc-next
- Convert the two newly added Starry panels as well.
- Break out the obvious ILI9882t-based panel into its own driver.
- Link to v2: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v2-0-457d7ece4590@linaro.org

Changes in v2:
- Fix a missed static keyword
- Link to v1: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org

---
Linus Walleij (4):
      drm/panel: boe-tv101wum-nl6: Drop macros and open code sequences
      drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking
      drm/panel: ili9882t: Break out as separate driver
      drm/panel: ili9882t: Break out function for switching page

 drivers/gpu/drm/panel/Kconfig                  |    9 +
 drivers/gpu/drm/panel/Makefile                 |    1 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 3037 ++++++++++--------------
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  |  759 ++++++
 4 files changed, 2067 insertions(+), 1739 deletions(-)
---
base-commit: 14806c6415820b1c4bc317655c40784d050a2edb
change-id: 20230615-fix-boe-tv101wum-nl6-6aa3fab22b44

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

