Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA05F053F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiI3GrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiI3Gqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:46:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB912C1D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:46:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1767506wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=L/8n41IpmfxMmQ3lf5X530nNE0M2sxxt0fpOlbTYxL0=;
        b=YHgw2jsOf2tW4yAD4cWPD/zRNaai+Adb1JoPQptP39eUNgjm4rHNu2v2JCm+AqMW66
         Ajks3ylBSo9SRrTvdhEiR9uCbNWyNmrW7pCRNDHUzwW2cTLrOozDe0Uc4Ocp5IwqEprN
         YKRp4yfoqJL3JdvLZSZ9Qi2YMj5qdCtNJB2kPZQq5c9oa9/5LQgJ7PoueF4gkBzVzKxd
         k7edx8jg2YKMLMuES3jYe+sOS2gUHmy+n5uAwaJGYny6bLZpb+uPUobPUGJZjLM5v0ZV
         7SAe1hHewGnCzT7iEOwTxaqb1bFdUbSN4+UP0ij/bGFsD/MqBHsgJKdnld2dc3jkURTg
         r/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L/8n41IpmfxMmQ3lf5X530nNE0M2sxxt0fpOlbTYxL0=;
        b=SBnvUwI6LhkAH5co062Q4uN6D93lD4CNmHAJrvy+8505z+BFrFU+yP0vyF5V4Brvhl
         PfyI55qfc9rqK20X7fbz/UeniOD8uVGPSI5eouCLKfz5oKTHLsOmXKtA1ismQxRG39YH
         xmqeQGY/yHejbobhew4403eb2HYq3UbRes5Izw0duGY23dKaS991hR4lNAheZA80M0iy
         6cLPilZHoH2qeh0Crb8Czq4GpL8tCe0XZp2lXpMvAMeOq+dH5CU8ahrPg2K9kEUHe9q7
         uePMLNGassqBmtSuDG9IKW6+xAYM64MHqdt37Vuum9iMfXSNIPVNIyrL9/HfYZUdH//0
         G/Qg==
X-Gm-Message-State: ACrzQf33kGWQYm87DZiDU3a4w7OsOHHfarWRYMUNWQ7MQ5VQ32CPHk4H
        hvJ1GXccd6tkW3WEKqPEJMIGWw==
X-Google-Smtp-Source: AMsMyM7bbAdFXi/LQXK72xIm9SeNUlkXbyNcqr/VEgMwdIalOO+JsR1raQl36c6WqNMK0liAZaqEpg==
X-Received: by 2002:a05:600c:3d8a:b0:3b4:a4e1:8661 with SMTP id bi10-20020a05600c3d8a00b003b4a4e18661mr4804216wmb.30.1664520394158;
        Thu, 29 Sep 2022 23:46:34 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c05c800b003b332a7b898sm1154818wmd.45.2022.09.29.23.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 23:46:33 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        tytso@mit.edu, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3] Documentation/process: Add text to indicate supporters should be mailed
Date:   Fri, 30 Sep 2022 07:46:29 +0100
Message-Id: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930064629.329514-1-bryan.odonoghue@linaro.org>
References: <20220930064629.329514-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently when submitting a yaml change I found that I had omitted the
maintainer whose tree the change needed to go through.

The reason for that is the path in MAINTAINERS is marked as Supported not
Maintained. Reading MAINTAINERS we see quote:

           Supported:   Someone is actually paid to look after this.
           Maintained:  Someone actually looks after it.

The current submitting-patches.rst only says to mail maintainers though not
supporters. When we run scripts/get_maintainer.pl anybody who is denoted a
paid maintainer will appear as a supporter.

Add text to state that every mail address returned by get_maintainer.pl
--nogit-fallback should be included when submitting a patch, giving an
example of the same.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/process/submitting-patches.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be49d8f2601b4..18a1f52e0563a 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -227,9 +227,15 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
 to code that they maintain; look through the MAINTAINERS file and the
 source code revision history to see who those maintainers are.  The
 script scripts/get_maintainer.pl can be very useful at this step (pass paths to
-your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
-maintainer for the subsystem you are working on, Andrew Morton
-(akpm@linux-foundation.org) serves as a maintainer of last resort.
+your patches as arguments to scripts/get_maintainer.pl).  You should mail every
+email address returned by `scripts/get_maintainer.pl --nogit-fallback` when
+submitting a patch.
+For example::
+
+    $ scripts/get_maintainer.pl --nogit-fallback -f submitting-patches.rst
+    Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
+    linux-doc@vger.kernel.org (open list:DOCUMENTATION)
+    linux-kernel@vger.kernel.org (open list)
 
 You should also normally choose at least one mailing list to receive a copy
 of your patch set.  linux-kernel@vger.kernel.org should be used by default
-- 
2.37.3

