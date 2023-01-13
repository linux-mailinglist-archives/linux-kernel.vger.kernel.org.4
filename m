Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706066A336
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjAMTbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAMTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:45 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8DB8793B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:44 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id u8so11259174ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7E8mOROiZFak1hyuDLHZO4dWBPRJx+AzyZtVyPnB1c=;
        b=NFGI8G4J3JHcHWVJJCje1tn4wX4/c1V8buxhNGuHGLE8ioehj37HI2hvsXan7Iauj1
         bWiQH6MGv9cOKH5nmWV6A+0M/JOqI0hhwUzgAIHVc5Kq0RqrRPFL5FJCLxbDqrdlIy+y
         UUz3LreilLsYdvT8RHh+wNBRnYKAmYuInZ33RrJREgW7fnV8RvLua8XDtq3KyvlUrm4h
         8nNE8/1pZpXH4qvP22FNR5anq3q07NAS+Qk4kXZcZ8Y+PIru3803BdzsGR/Fy6TJXhBo
         8GDAghcOV4YeYkquVwMQN64IO3O1+wd5nUVrgmYkTBsezoi8F8QrkhWN/Gv4GLGp7Xhi
         DtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7E8mOROiZFak1hyuDLHZO4dWBPRJx+AzyZtVyPnB1c=;
        b=gRWmpaf6LfEG2PEplyGEk1irNBnLDfjwDWBkHXVDyenqsk6gMJ2PFxkirmEEnBtzRI
         aA8Z6LgsRi9tmT/gdFTtL+VWTv5h2MfKvhAPrz4/SI9abld+0hxpegvDJLqpTa6KfnJJ
         anjngXi2xNSFz8xpYYT9u8ODsWWxxyd2fSJMxSVlLAwKfnOGcOx22dqNOGW7AiU8SxcT
         U/fjHi2fwpupFzy2uuwwI3qon2QiEcRHtkE529w8JTyLp+FLh25hhzCAaPb1IQlkZjz0
         rwT8ERz+QAF4s0hqmC4Bw+VxosNNZM3IgJG/Ds5wVJzAmUIJYbQaOB1nIwfGSTBDhszo
         Ur4g==
X-Gm-Message-State: AFqh2kq6S+OMmaeXZ50gdj0oeQ0YVYtEYq1a8OwgqoMSpa7gPTPOwEZQ
        KjI3zVowfy1/IkJ3KJtElE/ZQduFh965mw==
X-Google-Smtp-Source: AMrXdXvPH129dWnUpJa8DkRWJYweDtctq7cHertzhMd9iaMmt2QU3y+ioZ4YvEafYXsPdjHT7P3j0w==
X-Received: by 2002:a92:d10f:0:b0:305:dee9:bcc6 with SMTP id a15-20020a92d10f000000b00305dee9bcc6mr53274901ilb.17.1673638243665;
        Fri, 13 Jan 2023 11:30:43 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:43 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 02/20] test-dyndbg: show that DEBUG enables prdbgs at compiletime
Date:   Fri, 13 Jan 2023 12:29:58 -0700
Message-Id: <20230113193016.749791-3-jim.cromie@gmail.com>
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
those in mod_init-fn, and more notably, the class'd ones (callsites
with non-default class_ids).

This differs from the >control interface, which in order to properly
protect a client's class'd prdbgs, requires a "class FOO" in queries
to change them.  If this sounds wrong, note that the DEBUG is in the
module source file, and is thus privileged.

This yields an occaisional surprise; the following disables all the
compile-time enabled plain prdbgs, but leaves the class'd ones
enabled.

 :#> modprobe test_dynamic_debug dyndbg==_

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index a01f0193a419..89dd7f285e31 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) "test_dd: " fmt
 
+#define DEBUG /* enable all prdbgs (plain & class'd) at compiletime */
+
 #include <linux/module.h>
 
 /* run tests by reading or writing sysfs node: do_prints */
-- 
2.39.0

