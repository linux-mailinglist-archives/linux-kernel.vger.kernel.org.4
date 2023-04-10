Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7E6DC85C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjDJPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDJPVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:21:38 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E909028
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:21:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54c0dd7e2f3so218351467b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140091; x=1683732091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeocCtSUikm+3UQY42LBvVs5uGw1k1bfcKFiw+kKxDE=;
        b=Mvq8PjIlnmH5nzfuNLecBRtLnSq4jNivCUWpxNpAic6NNIr0k3kZKDmW+MUJmJJEI3
         5c2aCFk5TOXRrSujXSBEh1slRLkpWGToxfa7AJSZV3pl4u8loF2LRvrhMr0YnvfFRC8P
         iIGxn9PYk/tz/o7t9oNY3Ll4ylr04EKLbKVnt9ziLpt7vrnlEYW3TXddSRyCuksXgXWs
         1LYDvPq0Yntf+KxZi3aIwcD0AwoSnDMFWStFgmksnM+oG+KnsvkjiSup4qe8eV+38EdA
         aNIJdaxbv0mvj/8Dc/x3dJGSVqPphO6eYUJDm5O78QKId4PPArJOWMdP9iHseU0j+fFY
         wMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140091; x=1683732091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeocCtSUikm+3UQY42LBvVs5uGw1k1bfcKFiw+kKxDE=;
        b=CG+9bgl4YNpE11kJf9G9ed+u7rF11WWhE9gw/UQd+iFLRMEEHrGQvNi/Uuc18gcRSn
         3qTpKmePnua798FzRbmxyg/GieZnaJSJFSY5K9q7LejGjH2Y0T9lOBSRplaq1IkgnH8U
         vKXg4BG+7yNy9ytaj7uoU/fTrDxYWRlcetipAKiNQgbUXSzCXqz2PoveE3xXGYtB99pf
         EzBmWloynq2p6/Sh69ocg8JbmjNygeJAiEODO4qQV47JOb835ectUc683LofIgx6Exv3
         45Jv27p2bTI/vg1KrxeNjbS7SzNEWEnlD2TQWHnPU2RrPR8VHdKvRwt3OaFru08BYsjz
         Pv4A==
X-Gm-Message-State: AAQBX9eGMPuvRSBWjQ2/5GekJ8FN10j0+X+y6OxQJcLg8v2yee1lBMUI
        vUJx/+0zN66G300MVzVQpu+LbQ==
X-Google-Smtp-Source: AKy350YNNRyfN2yai3a7NpeXNHuhAPlG7J/Z/kLaPG96ir48Ah1BQV8RFxZqEfoSuTB8GIaOYsXl4Q==
X-Received: by 2002:a81:7d56:0:b0:545:81fe:d327 with SMTP id y83-20020a817d56000000b0054581fed327mr7839814ywc.37.1681140091338;
        Mon, 10 Apr 2023 08:21:31 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id bj6-20020a05690c044600b00545a08184e0sm2857378ywb.112.2023.04.10.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 08:21:31 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fred Eckert <Frede@cmslaser.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2] watchdog: ebc-c384_wdt: Mark status as orphaned
Date:   Mon, 10 Apr 2023 11:09:26 -0400
Message-Id: <20230410150926.3354-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The current maintainer no longer has access to the device for testing,
the original user of this driver indicates that they have moved on to
another device, and the manufacturer WINSYSTEMS does not appear
interested in taking over support for this code.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v2:
 - Remove "M:" line

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..a1f44c4d40a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22512,9 +22512,8 @@ S:	Maintained
 F:	drivers/media/rc/winbond-cir.c
 
 WINSYSTEMS EBC-C384 WATCHDOG DRIVER
-M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-watchdog@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/watchdog/ebc-c384_wdt.c
 
 WINSYSTEMS WS16C48 GPIO DRIVER

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

