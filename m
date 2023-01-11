Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43D66663D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjAKTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjAKTkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4011EE0A8;
        Wed, 11 Jan 2023 11:40:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso10550390wmq.3;
        Wed, 11 Jan 2023 11:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqjyIjqa21DKlLc9aiLyfHVjAwLQSQqAdSY+ejwIkis=;
        b=cyZj3gnrvmF8CnpQxy9/fPUf4R722i8raRiSVDtidZIzrJ6zAHa8P9TQTyQvB6Qp9i
         Mzq19yoP8G+5PhJl9UfKr6Hgy5oPu1chk6+ZLnkyoeCpbNycrTMAOvCCAobNvLUY38en
         YNTuuYKbGI4J2xwwVchiD2que80nEawIqs8NLOenb+ndIN93950B2EXXec1DdPVus4pb
         FXYbQHghxWEmsL053HHODj4vm+by7AZLaxhKz1mm/Kgy39KaECIMekfmqF7Y9p3DTdr+
         ngDSSQPDMT7jk163/nhXbFqBT7eDNhy7s9fF0jF7wJ6kjD6+V/QJPgPmaIYxRW0oetor
         n5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqjyIjqa21DKlLc9aiLyfHVjAwLQSQqAdSY+ejwIkis=;
        b=sbWIAifyNADCTxjSvAFU8NRo5DORgqUfRHKirJgION4BGSEy2V6vjVZheW0/nmMfx2
         JBT1vdZH3VIDrNrv3PVZim+WYWPbRzALrWUWzlq/KLKKW/RapP4lUcRAZWjrcbdx5S+t
         /RIl7liPy2/vhWAR6mLuDG82v42UO5vgrc2ASjyTWhGE8r7KgC+QSstlK9aKAE2L7zHG
         HbuiYLm5a00RHvwzNFlEx9E2kN3HKkmKmIf056inZ1+obyEt5xzCYcyAHD9V8lKnhi3f
         OI1PrS3NNq/KIHGZkAjcwgSK7ZJrQ1ZK8WB/69+n7BGyNtAAUHfHxDm6NmNbrDW1h97p
         ooVg==
X-Gm-Message-State: AFqh2krhanEd6xYDjQa7gyRnC+uLAFhlbDFIEM5RfMOFpcW3aVHm9hBT
        ESulV5UgKmM4wR7LXXSTykY=
X-Google-Smtp-Source: AMrXdXs56CDgvt1nUOLqLqObRvQcTxebbICW2BYjPDtCRRSWfu/8YL2yfyo7sbrGuI8gr7QcbEVZTQ==
X-Received: by 2002:a05:600c:42d5:b0:3d6:e790:c9a0 with SMTP id j21-20020a05600c42d500b003d6e790c9a0mr63567225wme.10.1673466007570;
        Wed, 11 Jan 2023 11:40:07 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id p11-20020a05600c358b00b003cfa3a12660sm7815451wmq.1.2023.01.11.11.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:40:07 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [RESEND PATCH] clk: Warn and add workaround on misuse of .parent_data with .name only
Date:   Wed, 11 Jan 2023 20:39:57 +0100
Message-Id: <20230111193957.27650-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

By a simple mistake in a .parent_names to .parent_data conversion it was
found that clk core assume fw_name is always provided with a parent_data
struct for each parent and never fallback to .name to get parent name even
if declared.

This is caused by clk_core_get that only checks for parent .fw_name and
doesn't handle .name.

While it's sane to request the dev to correctly do the conversion and
add both .fw_name and .name in a parent_data struct, it's not sane to
silently drop parents without a warning.

Fix this in 2 ways. Add a kernel warning when a wrong implementation is
used and copy .name in .fw_name in parent map populate function to
handle clk problems and malfunctions.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 57b83665e5c3..dccd4ea6f692 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4015,10 +4015,21 @@ static int clk_core_populate_parent_map(struct clk_core *core,
 			ret = clk_cpy_name(&parent->name, parent_names[i],
 					   true);
 		} else if (parent_data) {
+			const char *parent_name;
+
 			parent->hw = parent_data[i].hw;
 			parent->index = parent_data[i].index;
+			parent_name = parent_data[i].fw_name;
+
+			if (!parent_name && parent_data[i].name) {
+				WARN(1, "Empty .fw_name with .name in %s's .parent_data. Using .name for .fw_name declaration.\n",
+				     core->name);
+				parent_name = parent_data[i].name;
+			}
+
 			ret = clk_cpy_name(&parent->fw_name,
-					   parent_data[i].fw_name, false);
+					   parent_name, false);
+
 			if (!ret)
 				ret = clk_cpy_name(&parent->name,
 						   parent_data[i].name,
-- 
2.37.2

