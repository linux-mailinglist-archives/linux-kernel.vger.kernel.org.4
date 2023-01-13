Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CFB66A354
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAMTb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjAMTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:49 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B187F0A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:49 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q190so10874200iod.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpVmv1h4fPy7xv9D1lk2U93L73H6vXkFF3YkrgZSyFU=;
        b=gFUquBpFFu+HxDwgXo2T7EYvrJWxXCrd1buhezZ09V2hbi5S1BKEdRMtdlhLOAkV6h
         CbplhtQMj3XxYm+uO9scNEFGWh2aBYnlDKwjfmx7FSV3CjXdyt5JaYzgnzr4BNRzCu/8
         5NdHHcLhPyaJCq2v5glPcalnBcf4QlnLw2MpnwmWdhjCVdneaDRkYuUWA95X6ts+D9PW
         VqvO5JmqXxi5U+aEfJWiKN1mel1MkAd939pDrEn8+rQnvfiDPXni5X3IBtN1XvL8hDmI
         FzQpFi6FmrIld0rYG6M09QnDte8qZp4AS3K3aJyNa1hv83c/39gnId7Czd6yKPLDyIvr
         PSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpVmv1h4fPy7xv9D1lk2U93L73H6vXkFF3YkrgZSyFU=;
        b=MasbqsbmopZusZO17wpP1qWJfzVGnPsd85cuxtPbjYmglbqDDRGbzVna2FWqVu6v/N
         GqyssvC6lk/LNnebuSWE08GrzN0jIOeVjFbiZ5kztiHHMOraflvhtpwCECnVWbFqGXLS
         3b0JOezvnfNhjk7s2z1ppZO8uL5lIfxbFjdmMo/E3UVOQVKB3nWlo4NqGO1KFobM5fBZ
         y1RGjDp+M8p1a+Ff8d3eqlKA0UdAlsn0IzSApUvay89EGf/xaDA8LH1GnncEUw73owG8
         6TZrYSdTgtZmTVu7v36/bKc3WSEAg1WXJEhEELCGhWKH458xczvzEurHRYz7ANx0pqnG
         hLPA==
X-Gm-Message-State: AFqh2kquC19rrBtur3XghwitCxBG76XMs7JWo4VqMXSgHEGzw/jWhf70
        qf5cdkcYac6YBq5Tnd+4YXZlyTFlFxd9ug==
X-Google-Smtp-Source: AMrXdXvn4tS2uVrgMipElARhcLYnJJmJiUsrVzXuu5YXxTVLwT5HxYgCx4hh/+ZwI64J3mnDtR0ncQ==
X-Received: by 2002:a5d:9801:0:b0:6e4:eab7:8c67 with SMTP id a1-20020a5d9801000000b006e4eab78c67mr53011199iol.14.1673638248128;
        Fri, 13 Jan 2023 11:30:48 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:47 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 06/20] dyndbg: drop NUM_TYPE_ARRAY
Date:   Fri, 13 Jan 2023 12:30:02 -0700
Message-Id: <20230113193016.749791-7-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index bf47bcfad8e6..81b643ab7f6e 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -104,11 +104,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.39.0

