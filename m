Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440F25B5387
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiILF3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiILF3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:12 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF9248C4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:10 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b17so4016577ilh.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RsTMiP9rOdYWd/CJgD5lf62E3pBpPHn3iKvnTstCS5k=;
        b=W9eQyswY9d9anzLo9n6+2UK5jd3zMCdtrygDAwAMSM7s0OU1949CgrWCW8nXchSyiL
         Rog3WeOHPKLi6deSZZsGF6nKh2qwU427KlJN3lgjMNhMhEA207r8rQIWQMlJAmvRiuQq
         zMWFezmy7K7fs/TLe6IvtHaUnMRiNKtiTq84uBmku0pVplN+YeWuv5BK6Zv8wx3Ii8Aw
         oyz/EnibqRPHntszYzw90+D5NTdmo/PcbaVPw6zgiZT5VnjiJa7WL43/vlBm5Kglnbsj
         k2uDPVf6h0P/D1ZZv02s6Gu/jJWVdpMqlAXICXVv59sh0KVnzWtAFdhLIcXQ1FGPUOV2
         JWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RsTMiP9rOdYWd/CJgD5lf62E3pBpPHn3iKvnTstCS5k=;
        b=4o0mY7IwlVU28PiaViQjDriwbMxuRGzExcxALex7G/mIhntZ9aGtgb3pnsUSW4CIe2
         p8D6cXdvSa5EqXnJLTdW9Q+wkeNqyEshvZB30/SfBEuYqrgl1iJuF8yqhOt3b+glf1Kn
         g8thmCchCaMVYCx8R8Lr1zhBZgvtsiIS6tko/IUO8VDyOienbKnXxk0zHRE/d3FE4MV+
         mEmDmsl7kLyv+IUfmaPSGEIzmkKNnAMGsMR6DG4dE1o/TxWEjZv0Sx9/ybHytRC8HNTK
         LEBfzNjp1evBmqDUelByW5ToN7rK7F3S2PFsbIGKTX0rTQf8VUJjj2fBU14hxmss+yzU
         prjw==
X-Gm-Message-State: ACgBeo2RoKW1DtLko3VricRYlGEaWYCYlvQk40Iv/NdXE5EUdz/VfFRz
        T1EKsrij2ADWgxkXV0ZU3eg=
X-Google-Smtp-Source: AA6agR5KpMxoafFECoggp6f+wIRK77w1QiltMXIK40Ocyg037/uILmvU26N7K21NwVRWoJyGf7uoPQ==
X-Received: by 2002:a92:6912:0:b0:2ea:fa2e:462d with SMTP id e18-20020a926912000000b002eafa2e462dmr9379940ilc.155.1662960550217;
        Sun, 11 Sep 2022 22:29:10 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 5/9] drm-print.h: include dyndbg header
Date:   Sun, 11 Sep 2022 23:28:48 -0600
Message-Id: <20220912052852.1123868-6-jim.cromie@gmail.com>
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

lkp robot told me:

  >> drivers/gpu/drm/drm_ioc32.c:989:2:
  error: call to undeclared function '_dynamic_func_call_cls';
  ISO C99 and later do not support implicit function declarations
  [-Wimplicit-function-declaration]

           DRM_DEBUG("comm=\"%s\", pid=%d, dev=0x%lx, auth=%d, %s\n",

Since that macro is defined in drm_print.h, and under DRM_USE_DYN*=y
configs, invokes dyndbg-factory macros, include dynamic_debug.h from
there too, so that those configs have the definitions of all the
macros in the callchain.

This is done as a separate patch mostly to see how lkp sorts it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 2d2cef76b5c1..f8bb3e7158c6 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm.h>
 
-- 
2.37.3

