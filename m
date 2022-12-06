Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE7643A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiLFAfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiLFAfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:11 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D3209A5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:05 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id i83so2365809ioa.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqHcG8IoVHCeAot1jnlaRtsmWaAjiGKlPaDXWaVNPkE=;
        b=A7/mvKMv6LDl78r2Rj9xCkoZIwaeMy/ak9988vd6t5HDbBlwgk4bnRXzsudLAya22e
         haZhic/e+DQ6ZU/O2o3COuZA+Tzcadp58eb9SsftWKK6LUK10YF3WSh9dCW/OLAGGozu
         VAE1G/L8wXaH4sZsupUAL0tB3cmyIK+vpVcmF+NHT2Y+9GDML0mztfJz9MxRvv4TMQN4
         T/IeL73CFbxzkW0yRaI7gJpfPyQrpCS0yPDp213t+4jJNtEeXs06wc0Hx5SxdQ1QfUiE
         K43T7/O2AaYd/OcJZZ6D1mOnXsinMxcOzmdaih4LwfQFT4iaO4ZskuIC19ZKqCH2ZR7S
         54JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqHcG8IoVHCeAot1jnlaRtsmWaAjiGKlPaDXWaVNPkE=;
        b=N7u3I/LyZ+MTL2UnRdZA5aKNVHOILO+iWQD2U2I/432umBb4DlwShpHf9/VyT97zWQ
         3UkYpDdnZwxo/AmFw8aj/dqPaYihPO3qwdGLE504kRZbakdRGcn9ZGcjrZLnbe5Kurb1
         lT+OjlsDDtpJzDlJGULX7r+hP/5hOPOkf0tug/RLOVQAOlshAfVqzdSGIeWYFe5QoWTo
         pz6X7p4p4MLyHGFstOx0NrWLVloTKc1eXxxYRX1OFFP/Qg2qdr2Sl44mm2TWInwCpvOR
         wEis7IhwkkB7m+VJeB96vIacwug1x8GE6gkr6JaWAPhgIULXEvK3dlWU3M2wmoO7SH3g
         WwUw==
X-Gm-Message-State: ANoB5pkmGYviZe4iE4v/uSNGoYFoPRO7PMeLsdXS6c69+X0Tj3tPKpN8
        tkhxK4zHQwVjUfW1Va8lda8y6mRah5o1PQ==
X-Google-Smtp-Source: AA0mqf6ta4lRaVtAryCiD4AXOuuI/qROZfTtCI3fA7lbb5hI7xxbgG9Jg0K0wH37Zdga/RopadHZZQ==
X-Received: by 2002:a5d:954c:0:b0:6e0:17f6:4c2a with SMTP id a12-20020a5d954c000000b006e017f64c2amr2157044ios.129.1670286904403;
        Mon, 05 Dec 2022 16:35:04 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:03 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 07/17] dyndbg: drop NUM_TYPE_ARRAY
Date:   Mon,  5 Dec 2022 17:34:14 -0700
Message-Id: <20221206003424.592078-8-jim.cromie@gmail.com>
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
2.38.1

