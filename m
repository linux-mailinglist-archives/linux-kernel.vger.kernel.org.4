Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51715B5389
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiILF3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiILF3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:16 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069E6248CF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:11 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 138so5127073iou.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=i5t2bbZH1qhLqkOMOWZd9/3/gcmt6p6QRrw1EPy3Aj4=;
        b=qOh/R9lECFRWqs7dMZp6LrjZUUMurRbhAZWpZcjLAW+XOtO1yvv7fBHHkJlyTkEucK
         bNKga9KrZesxfbiOu7HM8ANgJZHDoqwdfsPZFrTfCG9+8ck3qVQfNh50M6VT9fPXdTT3
         yCIwfUy2bmo3w9zPxVHJ5CyInYMBcFLrr5XF9nQLAuyFYD2kfNrIikXSEvV1Y6pVVYkw
         Diz05DSsd348fuMY0DVxkeWIalSgUwLsHBeFt4iaaeXKtlv1GwIJSDEFcGI5kG/Zi8Ah
         gY2azQthIsvm3qIMoheAO62ri04by6YxAvUELnbEbTUTrYpOPK37gYr3K6qm534XdYWw
         zPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i5t2bbZH1qhLqkOMOWZd9/3/gcmt6p6QRrw1EPy3Aj4=;
        b=BSFDUFANhUVTNSNp2W3ajHi5aHW5Nswtdoys+gteBYjewgIny/aU1FKkpjjL291aSF
         GktNGafnn075cBFD3tdXoDyPHoWhgvoMLsGS7H7anIjLpBGWRr3rfMst2LwMR7J9Iuhv
         x/PKsa8QvCTxfdVm7X/8HhTFssQF4azXH6GOpp/Hhf9HCl47lyV90VVmw0ZKx6w/1WIG
         fHEnSYXbDzE1LeJstK0gm+k90qkMRhmk5S665Xq0A4Cv8eaZp2960X9cKgOHqDZ2Es3b
         dZH8VRPfqRaBQ+wQyodmxHIYefMsexWa1bLOQ5HQU4XgBauEfiisBwL7UXAMQd1Ko6zN
         WSZg==
X-Gm-Message-State: ACgBeo3+0TNsGMXYjBY7tcOntLq1RtjRMuHz6n1tX1R7lGjZjA6V9IIX
        sdQ0K3OIxdkvMppVbGIfUqg=
X-Google-Smtp-Source: AA6agR6nheDh2F55KS2HuAKuH7mmoLFpxaM+Y9nxKrP34wlXBlmFd+JSKxJMWlB4fe03p4UZt179JQ==
X-Received: by 2002:a05:6638:2729:b0:35a:4666:5dad with SMTP id m41-20020a056638272900b0035a46665dadmr379273jav.250.1662960551093;
        Sun, 11 Sep 2022 22:29:11 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:10 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 6/9] drm-print: add drm_dbg_driver to improve namespace symmetry
Date:   Sun, 11 Sep 2022 23:28:49 -0600
Message-Id: <20220912052852.1123868-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220912052852.1123868-1-jim.cromie@gmail.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_print defines all of these:
    drm_dbg_{core,kms,prime,atomic,vbl,lease,_dp,_drmres}

but not drm_dbg_driver itself, since it was the original drm_dbg.

To improve namespace symmetry, change the drm_dbg defn to
drm_dbg_driver, and redef grandfathered name to symmetric one.

This will help with nouveau, which uses its own stack of macros to
construct calls to dev_info, dev_dbg, etc, for which adaptation means
drm_dbg_##driver constructs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index f8bb3e7158c6..dfdd81c3287c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -468,7 +468,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 #define drm_dbg_core(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
-#define drm_dbg(drm, fmt, ...)						\
+#define drm_dbg_driver(drm, fmt, ...)						\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
 #define drm_dbg_kms(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
@@ -487,6 +487,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 #define drm_dbg_drmres(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
 
+#define drm_dbg(drm, fmt, ...)	drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
 
 /*
  * printk based logging
-- 
2.37.3

