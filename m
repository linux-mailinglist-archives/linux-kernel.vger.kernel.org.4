Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D567BCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbjAYUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjAYUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:14 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC210400
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:07 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so6355ilu.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Me70+Eki9NCto8VnvB3w3VfShg/xZ4FsWDiFg0Z63s=;
        b=mVFkvVr8zjNEnUBM3qayiN/sYTleHtLVOwYxZQJAp+N9az+P0vT8mdzqU7Q+uJgp09
         nG312QNUQGqZAx6dTjJ7eeeeIvP5Nv1j4mW8KEHEkGaMXrty/geGUEoenNwQq30WtQhL
         mBs7qmwxGSXT4HluKpIk6BnUMjQg+9zhBpxQo0ZlxPO64amgpdKB0wujsGPf80BJHNjq
         TtFsCLF3Lif9vJZN8Xa8tNRT809Ky4dlW1sYd1sGAixOrPgpFuj8QdFBMkDexeSnOT1x
         AahdZut6G6B43I3zuCN2GJiXy6Yxpx8oUzmcH/pxSK056cAcyANdCcMqsV7BLvF16uq8
         l8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Me70+Eki9NCto8VnvB3w3VfShg/xZ4FsWDiFg0Z63s=;
        b=gjnXtQqvTG8HaPcMTI9O5lLJPyXKJV9TvaPY9VTeYqFpJcgZeHrHlDiP+bKbdy4HyR
         N+zBguZ//offSflvMsmYlIGa1Nwus8INkKGl4gsaThkTHsgRlczdMFyjgTB4hNEwbIcJ
         OG5uziPzDpLzIgeBFK/gebp3HOrINbMhRUYT5BfM5CEMQcAXDzwR6ODPY8MlIXeZPE7a
         d7+OFUNSDvev4hso9vwIsEmpKg/f6IziAIezXWwiLztzz9+iacwB2phPZYErV5/SPcWc
         t0Yr1LQYgYuZCzo/4UdFbgGsWKIQZid74yVN9EhVKy4XZpGgvRiLQCgUrHFqURFAaJXh
         OuHA==
X-Gm-Message-State: AFqh2kofvMrdZvq9FnAKqacpOPVdDumRaNvuyKIRJ+L6vWVFJtmwdmlu
        tbnlo4CmQAB7Bqm+5r7T9hfJF/j8tMI=
X-Google-Smtp-Source: AMrXdXuZs9pLJmgSeXV35amurJhQQWarQOrtXrigQdJWMiWDm6TnP/8VZtyYssscTH45UCiqIcIMKw==
X-Received: by 2002:a05:6e02:1c84:b0:30f:514b:fac0 with SMTP id w4-20020a056e021c8400b0030f514bfac0mr11919393ill.8.1674679086921;
        Wed, 25 Jan 2023 12:38:06 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:06 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 09/19] dyndbg: constify ddebug_apply_class_bitmap args
Date:   Wed, 25 Jan 2023 13:37:33 -0700
Message-Id: <20230125203743.564009-10-jim.cromie@gmail.com>
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

ddebug_apply_class_bitmap() does not alter its 2 bitmap args, make
this guarantee in the interface.

NOTE: the bitmap is also available in the dcp arg, but the 2 vars
serve a 2nd purpose; the CLASS_TYPE callers use them to translate
levels into their underlying disjoint representation.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 10c29bc19901..b51f4bde6198 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -592,7 +592,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new bitmap to the sys-knob's current bit-state */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits, const unsigned long *old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
-- 
2.39.1

