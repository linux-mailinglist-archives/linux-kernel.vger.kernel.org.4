Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3350066A330
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjAMTb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjAMTam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:42 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7E85C95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:42 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x6so6615328ill.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1o5vBUqYZImz4NHOXgCRklT6MZZtgIKbNelpVgr1rc=;
        b=O/G/GtrLDkS5318MosjlluvMht6s+j6sda3zFLrbXEaHuhdy3Ep0v0dq4H3SemVWco
         mbHU/PLBxTIyQr+HKWkeWhY4F15ONxe3ZlSHXvkjdXkVdgIfMREA53VU9Jj14bpejFKb
         bG97tXcxSdnDGjeac8amfJc7ZA1EBBtZq/ZTtgGdh9eDV7Op2JPsuqt6Nm6/s8aZg4O2
         FCfHXEr5/orMZzKROvde4QwLWIJ9SONF9wRfIiL8omXe6zRYbhK7wZv6Z8LYhmBjLIvD
         QLMyIcPqJT6/6oY2ckvy7JVGWZfAFeSeLsASj6eYHjBcqYVZjVmtTWWnSN+jJDwI/oIh
         1txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1o5vBUqYZImz4NHOXgCRklT6MZZtgIKbNelpVgr1rc=;
        b=RfSuMLS8YQXVbOGHa0sx9tlmujEBhzHUAIWzKeJoU9MsGqfGjzejqDhKt5MIHu8Xzs
         1nsRgJbiCS9hgqkg9HRoz0/mkx8Ro7xmQUZPcMHW5NDOo9LibDTBUTT7VMCm1Y5qfm4W
         ssj+2uNSgFGIYNWTRtCQTgK8zvhT1ymdR6mLGtWHf4bc6gDjDaOh+KiA6B0khHld4N9N
         Yl9ap883DiBu6d9GVWimihq4rAWDITR/5M+rXwQ8Tbkq7cmUYbtVyWWxUHw/9XUNk+g8
         GaTnlZL07W1T5KwVUKgxveBzQ9ceF4ZTSp0kgroeofCM9d71wmfbja6E97mCVnMzCaT8
         hFug==
X-Gm-Message-State: AFqh2kpoBYphv3TrUsNBfmjSolLE3W1hD7SPwiX4hInDQNiEZW888IBI
        8ocj7n19xT8gVn+7oVTfBAK0bx4AUbXTRg==
X-Google-Smtp-Source: AMrXdXvjHFCUqwgnJISIfjiy5EhLkeG2cldtPBa2NhmQBpy3xoVlCgCyWUpN297fbq27qZozSPjmgQ==
X-Received: by 2002:a92:1306:0:b0:30d:bd88:8a2e with SMTP id 6-20020a921306000000b0030dbd888a2emr9127064ilt.20.1673638241114;
        Fri, 13 Jan 2023 11:30:41 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:40 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 01/20] test-dyndbg: fixup CLASSMAP usage error
Date:   Fri, 13 Jan 2023 12:29:57 -0700
Message-Id: <20230113193016.749791-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113193016.749791-1-jim.cromie@gmail.com>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
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
2.39.0

