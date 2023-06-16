Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07018733B54
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbjFPVHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjFPVHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:07:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D53AAE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:07:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso1683553e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686949633; x=1689541633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFFb3YxfGmJK2b87DqbF/ilD0Ztmd558ixt8ExIHkww=;
        b=ihaNUkKwifBCoU6PT2SM5pEpEi1ielXvwNdbMGfl5EdHaKXO+Qo9rrmITND1HE41Cm
         J+zFGjIHeL8KG2Sb/3/KUNcCNL6Ches1yz+OzZpi0OC0i3YtnpY9ePDLglKYcKPy2BN0
         O5vKG42sQM4U+AC/vNCvRUZ6QnHG0SrRwH/xxZJaTJ1ZOkFTzx5tv7t62VKeNhKAhiyU
         /8jqNfAML6QhtNuRbNNGNNNLMlxoZOqdiwuQ33uUR6zm72QrpLqML1ieE8VpBGijhH5v
         2gXlwP+7kOPRx9j3RRbil4ehgyStIJAD4uOLvoSO47LR1HnMkg/tio1UtA6rN3FTcHz7
         uTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686949633; x=1689541633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFFb3YxfGmJK2b87DqbF/ilD0Ztmd558ixt8ExIHkww=;
        b=FrhmMF5QvSF6Mm71kyBaCnvNhVcKTnhLTJFERFFFhJDN7QiGdiZADiJG47dLCEu2sP
         QKV2cqOtUGzJIshaI9GE8p/+bgUIfba6qsBl6QcSaflygiwK218JHiJJgS7KeF/oiOGy
         7qKfFPXFTuq4FYBpdTgAA2hPUrkiPo6j3YyleKqY/Xii4cQytJzifu03VwZqniQ5LwIF
         HsDJGG9+BB5nz2cx9DTDBm1DAQYENoex4QDVeoCQFlxXexNfWhMI0g4iJWepLAtH62lp
         FchtmzNOKKp5AQTJB6iF+iRT+KAP8NgoK4wCNK+L5K/aiGxCKWNLW0GjZK4KMtx6nunK
         lmMA==
X-Gm-Message-State: AC+VfDw2CtJMyAdvXUm8sY/LYcfzLL8NdktJV1L8au/9edhOpoyu5zCy
        KTUGpFp7Gft/hus1vHIl8+lQBg==
X-Google-Smtp-Source: ACHHUZ5blRCZnKqsQFllh31kgK8mRTbs3vZ1iFksdiHDQ/EZMzyNTnk0F3AHdmS/Nd05QsBgej6RgQ==
X-Received: by 2002:a19:654c:0:b0:4f8:4aed:b489 with SMTP id c12-20020a19654c000000b004f84aedb489mr2364662lfj.18.1686949632960;
        Fri, 16 Jun 2023 14:07:12 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r12-20020ac24d0c000000b004f4ce9c9338sm3180909lfi.283.2023.06.16.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 14:07:12 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] Fix up the boe-tv101wum-nl6 panel driver
Date:   Fri, 16 Jun 2023 23:07:10 +0200
Message-Id: <20230615-fix-boe-tv101wum-nl6-v2-0-457d7ece4590@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/OjGQC/4WNTQ6CMBCFr0K6dkxbfuPKexgWUxygCbRkilVDu
 LuFC7j83st73yYCsaUgbtkmmKIN1rsE+pKJbkQ3ENhnYqGlzmWlSujtB4wnWKOS6v2awU0VVIh
 5j0ZrUxQiTQ0GAsPouvEYzxhW4qNYmNLB6Xu0iUcbVs/fUx/Vkf4xRQUSGuzyuilk2Zv6PlmH7
 K+eB9Hu+/4DZrLTptIAAAA=
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is two patches fixing things I would normally complain about
in reviews, but alas I missed this one, so I go in and fix it up
myself.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Fix a missed static keyword
- Link to v1: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org

---
Linus Walleij (2):
      drm/panel: boe-tv101wum-nl6: Drop macros and open code sequences
      drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking

 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2420 ++++++++++++------------
 1 file changed, 1193 insertions(+), 1227 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230615-fix-boe-tv101wum-nl6-6aa3fab22b44

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

