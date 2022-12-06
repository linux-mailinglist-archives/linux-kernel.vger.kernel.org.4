Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8550A643A36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLFAga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiLFAfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:46 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2215F218B2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:17 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e189so8776144iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeSlyGC+4QjekIyFRyMcJltxNINQMnR283Y5rstfp1Y=;
        b=h0LKM+koUxD63ixKVAQGoM915fvUhbF7qjLYPjNPraE7iyUC4PuTyXY69CvRpHBfkh
         MPaliefrvoVUMN2EmN0IAEK+2qd30mBjitC4tqGFecZrzEDqweA5+iVV7JJeh+el1mdO
         Yh7zXsaDZdT4H6MfVxtqSZrvopdzEAzDWQ+048m9rtr72OpC4xCCjNeJjOYMhwnTJmz2
         2enlyFSGdg8QBLRnoTeSfC5ZefQGJ6HhJbJdI8xuGT+jExB3qq2MPyWNhtdQS3y9Cx96
         6TaqVksxqER88wpsnUtXuvhDQFcypouO0c5LdTxeYDf0wO2ban1P93KJ94prI1G7Ndg5
         466Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeSlyGC+4QjekIyFRyMcJltxNINQMnR283Y5rstfp1Y=;
        b=XoDmU4LkRYqnjZwy8UInHHkgMIVZ6sBgdmaSolql9h2qrFb1d7FRRdma3dLP1PmWQ3
         rP5rFXORa/013s4SRmW+4J42R/BdPCUwBN/ZGBeeky1aS/8MJo2Sz/6t4L9pl/8IgIdy
         eXqFV6tRGt2kkFs9uv+yQ/OiLKTuLNQCfqlISFq6ScxFG+xYFP6KCdtM/g/2R9c45QRS
         uDHqBYpTrpzMQ8mCtOyZJUKODt5Dvoo1OgJ1dG+ITbyvygvW1zJIBIa9Of6e0fZhGx8W
         gSL5gmJnpxS6n5WNZZpu1BI9Z2nRlILqEbGYGsUtCyV+XQClN7XZSn+VNzVWGEgQH8x6
         /EyA==
X-Gm-Message-State: ANoB5pkjXTkDq5KcenxxCjm4yNRgP2GiCSMj0j+G7wJRa6MeF3eLW2fQ
        R2c5gPVxywqjwqTAzyUfiIOLF67DWbkO3Q==
X-Google-Smtp-Source: AA0mqf4cdoYhV1MOscSXod9QpdhchGdE4ccKTAbn4ZBthUwankegsGGFYP+dAt7iIm0NmrBrdU4E4w==
X-Received: by 2002:a6b:7c09:0:b0:6bc:d42c:ce6 with SMTP id m9-20020a6b7c09000000b006bcd42c0ce6mr31063086iok.172.1670286916237;
        Mon, 05 Dec 2022 16:35:16 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:15 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 16/17] dyndbg: mess-w-dep-class
Date:   Mon,  5 Dec 2022 17:34:23 -0700
Message-Id: <20221206003424.592078-17-jim.cromie@gmail.com>
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

for loadable drm, helpers, and drivers, dependent-load is failing to
apply changes, needs more investigation.
---
 lib/dynamic_debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 46684aa7284d..3ef1c0a1f0cd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1248,14 +1248,14 @@ static void ddebug_find_kparam(struct ddebug_class_map *cm)
 
 static void ddebug_param_load_dependent_class(const struct ddebug_class_user *cli)
 {
-	unsigned long new_bits, old_bits = 0;
+	unsigned long *new_bits, old_bits = 0;
 
-	new_bits = *cli->map->dc_parm->bits;
+	new_bits = cli->map->dc_parm->bits;
 
 	vpr_info("%s needs %s, 0x%lx\n", cli->user_mod_name,
-		 cli->map->mod_name, new_bits);
+		 cli->map->mod_name, *new_bits);
 
-	ddebug_apply_class_bitmap(cli->map->dc_parm, &new_bits, &old_bits, cli->user_mod_name);
+	ddebug_apply_class_bitmap(cli->map->dc_parm, new_bits, &old_bits, cli->user_mod_name);
 }
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
-- 
2.38.1

