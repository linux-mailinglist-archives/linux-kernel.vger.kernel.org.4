Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7D618C05
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKCWss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiKCWrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C37D2314D;
        Thu,  3 Nov 2022 15:47:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3133077pjc.5;
        Thu, 03 Nov 2022 15:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr+G/nLorVX5Vqazl4B1H/q9zJhWXCGt3rPc5wil7FI=;
        b=cuiHE4k5vbsIZ/O7THWlv1XnPdq7smFhNeL5Ki3VCD/5mXTK8hr6cAexhoy0SVSAH1
         r/t8delHF9PweR6zd3U+m7hjLAuJ+hb10eiGDLoMqjuZ7G6dn6x9eCJyB1ZyqDDBaV4k
         oFFwQZSEA6NZCQUzqy54xsamRHBRkEPzdeCb4TLBV1XXYxqEMbR/+Jv8C0kG6H6mriei
         +CN2TimmLNPY9f1Lx2MYJ7NdAVM3rLAm0b8Em1sa7jsPAMOOT3SbahYIU8T9MnHPraPC
         Q4f02EcsYuRAi1sxarhCHgJTf4oOuaLc58LB1cdPc0dp5b3KL1jttHJLWyNQgdQV0yMk
         8HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr+G/nLorVX5Vqazl4B1H/q9zJhWXCGt3rPc5wil7FI=;
        b=hYOud9qMpWbe99orHCDEasgFXUiIh6mBWyb9qET+YRyozUK9bvkLAx2+19JjE36sas
         VgJ3aQvDiGcyBID5mTty8a+bsOeatpWcRzMK1W8K821KsMMKqvnZ3IYgqzufoKyVryBA
         rv4wBq6fYcLk9zGg5S9IZeNGJwLMUt/QdEqbWFPq68df/jE/WdTdKHG2gihSrJcoHsuu
         GiCckEszcslQNwSg6z1ISw5cW6blIJcHqImGfR4yZvcujUyW1wJmD7i2zfsy3hZNK2WC
         snikZdgqD//CoSpaNPd88LFkuE3dbaz7bN466n7lgSRmvxhwggZBssS/bPw7v2nlAk35
         +kXQ==
X-Gm-Message-State: ACrzQf2DzD6dJJL0f3TUhks20vqjBvlm9cUpXqYWPhyXBYSeEh0zMW0S
        z8mP28H5KRhWV5NmwXIzmZI=
X-Google-Smtp-Source: AMsMyM6kOhgxzSyaqgoC4vbAnGm9KpBZ9npgzgXOAYjrITlIeApLUjEIXCgyUfy+qJEfNsyPwQlsLA==
X-Received: by 2002:a17:902:b281:b0:186:9596:742f with SMTP id u1-20020a170902b28100b001869596742fmr32051893plr.49.1667515662609;
        Thu, 03 Nov 2022 15:47:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:41 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 12/13] omapfb: panel-tpo-td028ttec1: stop including gpio.h
Date:   Thu,  3 Nov 2022 15:46:55 -0700
Message-Id: <20221103-omapfb-gpiod-v1-12-c3d53ca7988f@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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

The driver does not use gpios, so there is no need to include gpio.h.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 3c0f887d3092..c18d290693c1 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
 #include <video/omapfb_dss.h>
 
 struct panel_drv_data {

-- 
b4 0.11.0-dev-5166b
