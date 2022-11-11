Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A3E626453
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiKKWRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiKKWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:17:29 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945253EDA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:28 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z9so3163714ilu.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnDAYVoy4dFPmqfPd9DbquIT23rvABloUcd8Ca4aFl8=;
        b=JjcHiyHmfmxyRqn6o5bx8ZYLnlQ26KiAXfoYiLFgLfgau6/EinKC8wm5yCn1acE1tb
         j3iRVshBq+xpfyai69g01wCtl0bEPC8mBV+ax5QAaRKkttYGNneT8qxbcF6f40qGVovs
         kdgyV7naU6JcjGWSmoJQHwq9PjSus6P9yp2xIYx2D8xjvvctH+Pu7VEPPoM3GQ74+NRz
         RPhcmBfCZzpProberL0zi7rqVU0OY5yYg2Jdn6yPnuogVhITmOlK32dV4GM9ffYLGCuP
         FtfANyJG2xxXAW3cotsp4m1VfFQGdWpeqyei0Asl/cGW4JhDHRDNRbSYLctRyxEEurq8
         8gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnDAYVoy4dFPmqfPd9DbquIT23rvABloUcd8Ca4aFl8=;
        b=qKW5/FbbsH+XpAI9YWEjWkkB0nY9qy+ZBVQxYdzcvF/wtDKNyibwRzoqilV0VlF6E2
         sK6v8TLz6f36edzn/cp+VXqHzqNXwLG8pdrg0VP0ZDnUSLmXTNBmxSTfrv2px+HiVAgw
         E06znPPwHu/JoPI/n4Tm8KwA7oaViAHGmEOsDfk/U/d+JyHf0HEk0/x0bJHJxFPvms6L
         eW2NBItMxvNFqZEJ+s2XJQ8mrdRdRB9XTbyuILZwFS4yWWpPB82JzQQIvMEJQOe45sX+
         IrFWI5CE73JUaeFeOL3CBTnOi2z1pNMKb517n14tvrerXOEsMC2WW9PNRXdIhph7J6Ho
         tRIg==
X-Gm-Message-State: ANoB5plamBG/1CwH22NiAnac+t0hM3IGWDDA+JOH6liMiCXEtvS/VwK1
        2Un5p9qO1jUrMYQao5Mak24=
X-Google-Smtp-Source: AA0mqf4NToRmxfOzT1fndFvl3p4YzV4oeApsABqumC3ZK1ZZdtnwEMW/nD3d20Rhfz71IUFbIPymDg==
X-Received: by 2002:a92:c044:0:b0:2f9:1b41:d2bb with SMTP id o4-20020a92c044000000b002f91b41d2bbmr1933218ilf.152.1668205048051;
        Fri, 11 Nov 2022 14:17:28 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id c5-20020a928e05000000b002f611806ae9sm1113457ild.60.2022.11.11.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:17:27 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/7] test-dyndbg: fixup CLASSMAP usage error
Date:   Fri, 11 Nov 2022 15:17:11 -0700
Message-Id: <20221111221715.563020-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111221715.563020-1-jim.cromie@gmail.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20221111221715.563020-1-jim.cromie@gmail.com>
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

This patch fixes a bad usage of DEFINE_DYNDBG_CLASSMAP(), showing that
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
2.38.1

