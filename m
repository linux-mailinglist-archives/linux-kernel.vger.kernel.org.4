Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8E626456
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiKKWRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiKKWRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:17:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325B4D5CE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:29 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g7so1519878ile.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUjShxaIiHk85i1hB/Op8E8p5ddWSfs+Wma1PGPikFA=;
        b=ePqtQ+3P8xuuUT2qMIKVj3C58MIuBmAs/JSpDeoIZH5GlTWvZLlDgO5Zn8lN0zcT6z
         z1oLNPXvLCXeUkQg4MmGUdSiIhyVldO9sDmm+CvSz07Ay/JgI1NLlzr8cVJGqDXEhSkX
         HGs2sAOB78+EAFx8uY/q45a7BEcVdMq0sgzQRo+3tVUSv0Tz/zkAzz4OeGvB50pmZWx0
         w/oQ+GbO6izGOnFR8/OV5iSolfskdwZcsG5ULxDO4AFQSOGhIf3hhpsobEkpE5oBpV9o
         AmDn1ligKQCSTbyZ2YTuL+LMjHwtiqLTs5hKjXCaylKQ3c7VTdRlFEWRM4FKgzBaKAmj
         aQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUjShxaIiHk85i1hB/Op8E8p5ddWSfs+Wma1PGPikFA=;
        b=daB5znOBNKwQQ+tp9z8q4AW1nPXxkHAWtQzx5hV2wvbuS+Lo0R0XggUSIRaSuBOfWi
         t1DqkCMbnOXJuCq0YMQYTxbHOj2mpE85oBXhTlFAx20pxgeJ8nwhlVeNi/lFFPegsIQw
         BsPIqx13apIRO0a7NQE0H8AL/h895fStoiq9+FuoK9rTMwzzoWf7Nc+oD7cQ0WlzhDIU
         4BGJARjs1VRJ2OcqEFAkCK55SY/ohbgoVv4+nNoTT4IRgFQKVnJDu6gn6B6/vUd8BUjd
         Vd6kplbSpxtwUMyXG1YlELvXvuG/6lxB3qAIVbXk4MB+/pwZKi9zuX19QgcgQbY+Q7xd
         5DHQ==
X-Gm-Message-State: ANoB5pn4TdMF05Pp6DSDuwdRAjfYmeuVAKL68KUYchIqwb7RoTW7tX3E
        ePbm0sPImB969q3/VGnPXiE=
X-Google-Smtp-Source: AA0mqf5V6I7rjValfJCm7SobEW6Jv5WqPA7gaXTsAHy/Mu5XugSgmpAIf00M1U5bpvrsVOEizJfqdg==
X-Received: by 2002:a92:d12:0:b0:300:c3d4:e9f5 with SMTP id 18-20020a920d12000000b00300c3d4e9f5mr1868728iln.317.1668205049139;
        Fri, 11 Nov 2022 14:17:29 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id c5-20020a928e05000000b002f611806ae9sm1113457ild.60.2022.11.11.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:17:28 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 4/7] test-dyndbg: show that DEBUG enables prdbgs at compiletime
Date:   Fri, 11 Nov 2022 15:17:12 -0700
Message-Id: <20221111221715.563020-5-jim.cromie@gmail.com>
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

Dyndbg is required to enable prdbgs at compile-time if DEBUG is
defined.  Show this works; add the defn to test_dynamic_debug.c,
and manually inspect/verify its effect at module load:

[   15.292810] dyndbg: module:test_dynamic_debug attached 4 classes
[   15.293189] dyndbg:  32 debug prints in module test_dynamic_debug
[   15.293715] test_dd: init start
[   15.293716] test_dd: doing categories
[   15.293716] test_dd: LOW msg
...
[   15.293733] test_dd: L6 msg
[   15.293733] test_dd: L7 msg
[   15.293733] test_dd: init done

NOTES:

As is observable above, define DEBUG enables all prdbgs, including
those in mod_init-fn, and more notably, the "class"d ones (callsites
with non-default class_ids).

This differs from the >control interface, which in order to properly
protect a client's class'd prdbgs, requires a "class FOO" in queries
to change them.  Note that the DEBUG is in the module source file.

This yields an occaisional surprise; the following disables all the
compile-time enabled plain prdbgs, but leaves the class'd ones
enabled.

 :#> modprobe test_dynamic_debug dyndbg==_

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index a01f0193a419..9d48689dc0ab 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) "test_dd: " fmt
 
+#define DEBUG
+
 #include <linux/module.h>
 
 /* run tests by reading or writing sysfs node: do_prints */
-- 
2.38.1

