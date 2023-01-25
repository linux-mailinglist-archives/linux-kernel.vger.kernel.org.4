Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA34667BCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjAYUh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbjAYUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:37:54 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A85AC179
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:37:54 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id m20so14653ilj.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdA5N9O88azw6KSZzcLHvp1KXfVV+O4YGK6Kf3ryNjQ=;
        b=eWr9Vnp1+TrIoDGMaE2O9wuMFg5AYKoezP9q+vbYB4d57F7KXB+syVX40kW/8TZwTd
         Rde29PkHcq9bnLyJEk496ReeconavD9eWjB5cMI2GrShu2CiVBSS2XRDeG5OWZcK/Yc2
         3HYIsT92B+4WmbYRJorIrShHbI/GYycQozfXncPNbT0PlReegakxI9iZaWShkQa8iv0J
         w8gQrNl/FWKM12zKxCKEmQFcL+h4purdLYw4vqPlkjvszKA77diAxdkwHSrQg7UN9un9
         KLFl1zMdDrIFrNTl6o6uoBdO2ixbTUktmoBSSkhEMSwzu8RD9Bu5guAV4KfoV41hwKpF
         RBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdA5N9O88azw6KSZzcLHvp1KXfVV+O4YGK6Kf3ryNjQ=;
        b=GsLuMKBgWwjratpfV0zZQjhA3mu69Q4DKgGshBbrF73r3BPJ32aqR4NVFg+llrn3vt
         QIESEXkWCnQ0CPcVVu7SRAfeyBSovyEGowsvoWCZcTngj5HndjgqKCTbaIwnWsfl8F7/
         dvarZy7uwPHMxuPp4wpNho390f6qT7qj+/mICDXEPuU1eHVhEN3eT22MV+VYH7vJIp1X
         AovE8vkPQAUet4ET55/55PcrKjerMFt/a5XgnTyIjYGxCVZTRTCW5JBhPjSFcRcAxbfc
         Rj/kVfg7BEM3e7dlAKkmXh/FwpzNsk0hcd4kzXGBwS++3c3pNkavKPpcdeV5qpxR3zRg
         vdvQ==
X-Gm-Message-State: AFqh2kpeb22XOHf7x12um9gD402XVrZKxnrRkD0wRazhYGDBxhI4hbal
        5xuZOVaZqz3IEcPC86EeWLRqt9Ya2To=
X-Google-Smtp-Source: AMrXdXtECMt3WOqQfbkmXVAsKNWzr5+QibSjG0wEYpIeQ2O0A8wTCh+BdCPfnEZboLgNa3QJmsDODg==
X-Received: by 2002:a92:ccc4:0:b0:30d:8d09:2545 with SMTP id u4-20020a92ccc4000000b0030d8d092545mr24461474ilq.8.1674679073036;
        Wed, 25 Jan 2023 12:37:53 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:37:52 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 01/19] test-dyndbg: fixup CLASSMAP usage error
Date:   Wed, 25 Jan 2023 13:37:25 -0700
Message-Id: <20230125203743.564009-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125203743.564009-1-jim.cromie@gmail.com>
References: <20230125203743.564009-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

more careful reading of test output reveals:

lib/test_dynamic_debug.c:103 [test_dynamic_debug]do_cats =pmf "doing categories\n"
lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

That last line is wrong, the HI class is declared.

But the enum's 1st val (explicitly initialized) was wrong; it must be
_base, not _base+1 (a DECLARE_DYNDBG_CLASSMAP param).  So the last
enumeration exceeded the range of mapped class-id's, which triggered
the "class unknown" report.  Basically, I coded in an error, and
forgot to verify it and remove it.

RFC:

This patch fixes a bad usage of DECLARE_DYNDBG_CLASSMAP([1]), showing that
it is too error-prone.  As noted in test-dynamic-debug.c comments:

 * Using the CLASSMAP api:
 * - classmaps must have corresponding enum
 * - enum symbols must match/correlate with class-name strings in the map.
 * - base must equal enum's 1st value
 * - multiple maps must set their base to share the 0-62 class_id space !!
 *   (build-bug-on tips welcome)

Those shortcomings could largely be fixed with a __stringify_list
(which doesn't exist) used in DEFINE_DYNAMIC_DEBUG_CLASSMAP(), on
__VA_ARGS__ a 2nd time.  Then, DRM would pass DRM_UT_* ; all the
categories, in order, and not their stringifications, which created
all the usage complications above.

[1] name changed later to DYNDBG_CLASSMAP_DEFINE

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8dd250ad022b..a01f0193a419 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.39.1

