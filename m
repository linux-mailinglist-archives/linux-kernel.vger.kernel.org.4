Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81C6E7372
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjDSGq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDSGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:46:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12EC4EC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:46:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec88c67b2eso2578089e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681886782; x=1684478782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REFDeFFHoGYAMs7mXmFQo05Mywd2wMBmW68DbUZdoEA=;
        b=gVmp6A2LDZo9NDmz1uDoJ4drOkmrxw2o3UHLvKf/cgd0ceOIRpxRC1jEo97XCZ8g6C
         DllOfslF1rujtNJPOLfMRy8vmP2+4leUWug3yUnAjEVZRxInlYg8un39MJp3Ze+PZ1Sm
         o6R/5c09BOPOlRdNM+0+oi9ACbSjKVN5TKseizkDooAhBOnh6b9rm5aqx603dtnOd6HG
         EB3OTImqLHOhihj81uuAhZxLZw++Onttm59nXp4b6WVNqYCm2JnvQwC4V5CSQNXI7wbV
         R5Ja7g3HtZf3kmfcq5jBbZ/acPSssHZtuNw3M976JObSGr0Sh/G6vjuKDi+BKtZE84vN
         Edsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681886782; x=1684478782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REFDeFFHoGYAMs7mXmFQo05Mywd2wMBmW68DbUZdoEA=;
        b=cZCitcc7RMhWui0KKcij8N6tRUaCcNXJ42JaOvJaj1LJhnu7xGA8l05euv/ey8LBrc
         sRmaUFy2DfH4/I8EmQJS5eMlwUymaadVyNk9PZ5Io32O3A7LVie9YA0HSGvLAiO+CeBB
         Q26Ei6UDCelBXbs6zZIeWkNUlqxiyegCejKBCMxTcAx3RYjcejzBGBqHQqbCBQI8Kaqz
         2yVtiJZMEkcq6cvRgU/b2/sYvqsuDVyVGWDMTp9VXqlcNGv+5QOrohTeACW0wxqZZkpD
         bAge/z4hXrVfuHK5AWYXJvuukMRHPI2+UXEfiiJ1hU6SjazkgXYbe8WhOirGp9kC+zso
         IXdQ==
X-Gm-Message-State: AAQBX9evro2szwdqun+21GWV7gc1jDbcrD8K1RkzKzep844BJPHGqYuG
        cPcExUm/bP/DnkKZkBLF402Ogg==
X-Google-Smtp-Source: AKy350aD5eVr42g4rwqGrk2SydA231Wzv8flZqooGRthYtYxasSLbRiVZ17XIxAeRYYejoZ1eUVwPQ==
X-Received: by 2002:ac2:46c3:0:b0:4dc:6ad4:5fe4 with SMTP id p3-20020ac246c3000000b004dc6ad45fe4mr3697959lfo.32.1681886782056;
        Tue, 18 Apr 2023 23:46:22 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id e24-20020ac25478000000b004edce1d338csm438208lfn.89.2023.04.18.23.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 23:46:19 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     stable@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH][for stable [4.14, 5.10] 0/3] ext4: fix use-after-free in ext4_xattr_set_entry
Date:   Wed, 19 Apr 2023 06:46:07 +0000
Message-ID: <20230419064610.1918038-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a good example that emphasizes that the order in which patches
are queued to stable matters. More details in the revert commit.
Tested and intended for 4.14, 4.19, 5.4, 5.10.

Baokun Li (1):
  ext4: fix use-after-free in ext4_xattr_set_entry

Ritesh Harjani (1):
  ext4: remove duplicate definition of ext4_xattr_ibody_inline_set()

Tudor Ambarus (1):
  Revert "ext4: fix use-after-free in ext4_xattr_set_entry"

 fs/ext4/inline.c | 11 +++++------
 fs/ext4/xattr.c  | 26 +-------------------------
 fs/ext4/xattr.h  |  6 +++---
 3 files changed, 9 insertions(+), 34 deletions(-)

-- 
2.40.0.634.g4ca3ef3211-goog

