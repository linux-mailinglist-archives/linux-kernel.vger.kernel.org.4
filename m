Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1A722A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFEPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjFEPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:11:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC0173A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:10:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso12502845e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685977820; x=1688569820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EV6BEOUnr2VyeVz7cBaVxhxNpGZy8Oum7xe1cgF/ZR8=;
        b=G2eLQmH90GYtOTiU+urKVmW16CkdBhxrc3ninRslVe5DfiNJ/M83cPrCu0CSVuvV+Y
         DB5pBDn9vzt1Yudd5q3OAzUC3YwgDypnZtHx8FfNW/O6uaTYy6Awqqm/IsqqZEXlSqmy
         zBCNN2wFcdW5MGM028qrPsmDmzowZV6uyDyNE0BsXHtcN45VBP4+FTHch5nqFCyWILkS
         82ntoxzZdnkWBGJNDVh/Z2ly8cq6/L1h37ARSqUvdENGtfRX9N95OR8PFRUVukjYGmbS
         GvpyiBid0XQ0NesW3WulZLSq7D+WzU/wV6kmJopjBGQiJqI6wzVFEXVdXsylbVGTmdrA
         IgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685977820; x=1688569820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EV6BEOUnr2VyeVz7cBaVxhxNpGZy8Oum7xe1cgF/ZR8=;
        b=ifTZfkqdRh8JgK6qsacD/wwDleblKsJzZmX2NYd25EibkMK6OMq0kNXxqgTrprKJ8f
         jKQGM9uOCJShH2SscTtk4m/e/NYEbztL93/QYqkCN2JxlJhF/rijFlwfnexaejHWcCY3
         iZ8al+uleVlHMxi8vrE24USm77YFL5QtcJ0rf4L+lDoHbo0GBAuT8b69HchcHBxhSNWa
         Pe4VeGuFUUg4UGkaJsTg+8sQj7UlSbm1/hTTBk39/pI30fmCkebUBORtIry1CMVi0wag
         Iwa4cxLCvtNOeFUv7WhyqMLOq3SmGUrsh6pR9JXzickaEbE7QpDrokGdRXimQ1ImDpUm
         bt/Q==
X-Gm-Message-State: AC+VfDy/7OLmLfYKwynnzomBmlVcWvvszn4NnRSK1sO3Y6/U+qf0mxXZ
        patYMQ1E3ko9ilpdmetw+fHcOg==
X-Google-Smtp-Source: ACHHUZ5+aU/ZOAxsKiY+JK1rkcOIyJPyhpE1Ik7mmpFeQUPq1cpkK+xP98Uq3+93HhhKUjslQRz3iA==
X-Received: by 2002:a1c:7716:0:b0:3f7:e70c:8ea4 with SMTP id t22-20020a1c7716000000b003f7e70c8ea4mr1130215wmi.34.1685977820098;
        Mon, 05 Jun 2023 08:10:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b467:b060:6671:840c])
        by smtp.gmail.com with ESMTPSA id s6-20020a1cf206000000b003f60a9ccd34sm11094339wmc.37.2023.06.05.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:10:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] MAINTAINERS: add Andy Shevchenko as reviewer for the GPIO subsystem
Date:   Mon,  5 Jun 2023 17:10:15 +0200
Message-Id: <20230605151015.564547-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Andy has been a de-facto reviewer for all things GPIO for a long time so
let's make it official.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..62e33c4da40a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8799,6 +8799,7 @@ F:	include/linux/gpio/regmap.h
 GPIO SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 M:	Bartosz Golaszewski <brgl@bgdev.pl>
+R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
-- 
2.39.2

