Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9D67BCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjAYUiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjAYUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:10 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E037714499
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:04 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id p12so1463ilq.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RODNscjc/Rt2ZTSAcIwz/VoCR1rWE14Nx64cYwURel8=;
        b=iVUOqYzgJAMBp/vKcsOc/3dxzpTDj3YIoTkV3FTVQEPVPzyeOtbyzfEfGyIyRj5RYx
         4IQs2cPzx9CeQDiOcgp5WRitwoC/kRoOzCf6wADx84e8pIC4/Y+wjhabjvqSpcZea4OB
         KQWsCGRTnw70X9M9hpaBiEvZOS091NZV/egtGkzcF2CmI/UmUQ5RxpeCxpyCHucaoyo4
         3t6KmdAfFWEIotvswSf54UX/sv32sKnlwsF7bxUghIIje8H8BxLIJ+Z0A2xcafwiEFxV
         zMx6PwNNNYKpdY1DMjJQsav/a0vkNbxSPXyxxtKqWKtF20mpFHtzDBRcpB64GWqmXUt7
         eIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RODNscjc/Rt2ZTSAcIwz/VoCR1rWE14Nx64cYwURel8=;
        b=Eh4U7T7q4pRFWh2uGZ8fP0qw01GfsccLspSAWcmA9MtUIGB5hfP4k6LE8+cHR1yaB9
         JOE6RHMp7ZH3VLcdt9N8/YM76kG/nMbqgYtMmXmktLew1ON5WE3jWa6O8ZQvUABrlPsT
         iCZ/51yHdovJYWKenbZwXjA4swZASOKy4eTS84XMvjXib5voZSohZ75R4OnP4WnnkDfX
         0jRRGcJ8VgZ1Ey5UkntdnLu8XhrhDAEHVXQgNo10Q2C7P8YBhXHLcYre5NAhPQjUcmRX
         nmYVZi5FigtR76Z/Q1GlDuF/qliCwU1U5RmbA6suedV5/ucfcyjkMntJIONG6yoPJfuo
         iXLw==
X-Gm-Message-State: AFqh2krUUv60/xXaRS2CJB7IuT8v8ztaMbwjcK0/ciddrdLvffVKnPFJ
        jkAx+0flTWN9zRcyrV9BUlo6VAsCu6A=
X-Google-Smtp-Source: AMrXdXtdLLHNja8c10Pzwty2Gj1lQ6vwVCeNim0SzN6sX2Qpcc44eemPLvtkfADILpBvoa4cu9/12w==
X-Received: by 2002:a05:6e02:1aab:b0:30e:f07b:84ac with SMTP id l11-20020a056e021aab00b0030ef07b84acmr38533727ilv.19.1674679083872;
        Wed, 25 Jan 2023 12:38:03 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:03 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 06/19] dyndbg: drop NUM_TYPE_ARRAY
Date:   Wed, 25 Jan 2023 13:37:30 -0700
Message-Id: <20230125203743.564009-7-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

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
2.39.1

