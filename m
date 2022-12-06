Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286C6439FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiLFAfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiLFAfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:00 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A21D67A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:34:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id i83so2365682ioa.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUjShxaIiHk85i1hB/Op8E8p5ddWSfs+Wma1PGPikFA=;
        b=UDeZIHBGQBsCU0w4VXJG37tmrasGx1Dh9Qwq+O4uCjtxK+MPvhZuQyVCKPv4D9akJp
         /5O66uycj+Lyqo01MDBZiQ806EVORd1nWremz8Kwz5nj/nZcdoACkWLP0idrRrOU3aUX
         T8jl/q5h9yafdeD4F+eTZTBDPmnyNkLBmuqetZfYGvI7PHAF9Yqn6T+GoP+myimtxtct
         A6aWll/7A1f+D1gs54dd3ueUWWFHw9Mwok7gxTxXRWVtlogL1CA7UCyFil/fcP9DZhzI
         ZEPtC0AI9fytZMtU1IaV2yQN4W3Hzmd23R4MLnnosQN9J4gHdpMkwtwNrEsRmbaP0ENZ
         RPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUjShxaIiHk85i1hB/Op8E8p5ddWSfs+Wma1PGPikFA=;
        b=0eR4Cl+pNZ3Gax2uhiD1VvWYQzA9UFeNCKC7thQm2lOCZUWGqSAidP9MaRPi9RlHTA
         pynyZSWDiw/sLELDR1V7b1Ey/gTAgd4UKxiDHN27KCBwaVpmWOeMqvdsyW72VrJ5IIz/
         LS3cI7bdoX7y096Qovl7tyjniXowqg+e5lQl5gndNQJa5WwWDixK01ifZL1MbimAfM7N
         nbc5TX+BllC+beeQeySshQPtvrtQ26s5xYBTK1vkgZpDl92+bpYdy9i3WOTc1Rc73x0l
         hl3TqH+pgmOq6Pg+ceHOf4eOa2piIKihomoV5rnKNEafCWIVzHwLh6N0ZsUxy9iVvXCo
         WodQ==
X-Gm-Message-State: ANoB5pnQp2i3U3ubW3VhWNWQQ/5jxFssrrpj+GRct4Y8BLcqZEwPwZPM
        sAJsBVKiErddu5dMuQUWM19clan6ERfuQg==
X-Google-Smtp-Source: AA0mqf7swNN+G21iFyCypndlcCL4yUgCNnd+ZZlZ5MAssEa9Q0G/HyRDRQIEt4sj9LPee3m7RoWhwQ==
X-Received: by 2002:a5d:8452:0:b0:6bc:ebd:4df9 with SMTP id w18-20020a5d8452000000b006bc0ebd4df9mr28045510ior.84.1670286898535;
        Mon, 05 Dec 2022 16:34:58 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:34:57 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 02/17] test-dyndbg: show that DEBUG enables prdbgs at compiletime
Date:   Mon,  5 Dec 2022 17:34:09 -0700
Message-Id: <20221206003424.592078-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206003424.592078-1-jim.cromie@gmail.com>
References: <20221206003424.592078-1-jim.cromie@gmail.com>
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

