Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD91567BCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjAYUiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbjAYUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:37:58 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B9DC672
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:37:56 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q130so9012297iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu6wCnYEan/k5ZGKZWmskafXPccsRtjhFvUPDR10PNY=;
        b=QblOiU3p6qGocJHDUkZNqG6XenIlCq8Mc1MVgbKKqX/NElqiyZKjtTFGvlFV6QpWUu
         qp96tYcZqvejp/3cBHVeodB5jm8HErPWFxBO8tPa9Hmx5UWZPGXWqzXrD7Zn01zJ8H3X
         +fDTQzru9nizXcs33usCBkihqDujBij7uOoHMuMGlJN92Z0C+r9tycE3OmMXYz9vOzSj
         nRx8e9F1PKwApC0Xr9wSCnLyPEExdZxyZkz3uwlMBphR769NRb13K8U+0jmkjKzmYXXJ
         pzmHnjbfDuo2ZT0GWBK8vxYVrO9KTEf9UiDm4d/lCs0+0qOKtyP6YWcVuvuh7o4bygu0
         dgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu6wCnYEan/k5ZGKZWmskafXPccsRtjhFvUPDR10PNY=;
        b=4hILsNImrhwNlSFDoCUX2UH2OfkEpwdKbufdIzt8u1JLes38ifY6i0i72037ybGqnz
         tkoUnCVccXY5tbRwUZ+zFRPdPQBaFJx/7Xnv73/0QaTux4pK329xKJ+7YIcoPD3HNM3m
         DK31AigpbK0hoy+xwFGjR+KqYad7dDTvYI/RWSFwqmAfcpxBvgtVbby6EJUjdjfQ3VrG
         Jy5TbHxnWu/iVfQvfofShqBgKZchsBh1K9rbAZ+sRepYDtyDgKxkjcVQ+CUL/Bgz83xn
         vqEqCPF5NKWyrT1jhANGfpQmfKMUjHPbZPSQwG8y/WYpgJlTqLWRow4CS2RSoJfhQlnF
         yoXA==
X-Gm-Message-State: AFqh2koWulPWrnbTz6NGCG/xJ0z9xjRXM3qLkMB/2hSqEeEULIc1XmMs
        FdD107mzq5/2V9C9pNoapF/C/Snf24U=
X-Google-Smtp-Source: AMrXdXuT3TLbSsxWuLK1gdZcJCjShH8KZiCuG095tCJVJInmc8aFczyqLL0SePoah1zeUmrzQw3QTQ==
X-Received: by 2002:a6b:b710:0:b0:6e2:d84f:ff27 with SMTP id h16-20020a6bb710000000b006e2d84fff27mr26097540iof.15.1674679075034;
        Wed, 25 Jan 2023 12:37:55 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:37:54 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 02/19] test-dyndbg: show that DEBUG enables prdbgs at compiletime
Date:   Wed, 25 Jan 2023 13:37:26 -0700
Message-Id: <20230125203743.564009-3-jim.cromie@gmail.com>
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
2.39.1

