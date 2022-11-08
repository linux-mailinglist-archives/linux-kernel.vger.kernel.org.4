Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A82621E06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKHUtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKHUtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:49:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58741FCF5;
        Tue,  8 Nov 2022 12:49:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o4so22890656wrq.6;
        Tue, 08 Nov 2022 12:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqjyIjqa21DKlLc9aiLyfHVjAwLQSQqAdSY+ejwIkis=;
        b=gr0qlsWBHZmn1TyGBv/Z2N6uvwlBvwWE79g5ZjVqCw3H/O524aPJcFptGEjZIc02z2
         Dytm5S0Ysx9sum45onti0DITcgI+h2JgGu8QhV54SYB7sdcsThJuqrjkdoJOVQG1gjHD
         SunfIdy0Byh3BewQSRIpkIiPTA24q1v5JfBD4139JxnoaWZXy7t8Kze/MVhJ31LMMeKZ
         LiKNb++ayCxz8og1e3BXVN1Nc9IMKlkKYIGV6c6J4tf0obyiUF1pji+maGTmvs6ciFZC
         OMvLo4jYyP8bNi/UvBq6m2vjesV4Bm8pzYA52sbRNjS5tRfqfg3x3SUv7SvqdfpiWE2b
         LMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqjyIjqa21DKlLc9aiLyfHVjAwLQSQqAdSY+ejwIkis=;
        b=DnbOXxjEBIaUyNuy9LN7P1Eokp86v/xxIK3L2/pS0QBot2aezKh3FvGch2/XIwOqTq
         EoRi78xLvc5uUcjYTD0b6UIQTJtj4LDWJF1NJBoaCcrgiLI/ZzSJED5FMU7XHFwyAhLr
         a2tWHlCoOxPUYsHZzWq0caGRcc7vNfU6nNKkwBIp17pA4EhB5Y+VnmNGLXOJXw+p8RjB
         PwktRL0nkNcymHURGfR71jByeVKZSwkJQ6hbNWRB+zZqZ3sB/8nfrubQ9WX77RTJOcFj
         pkkCvDIAnNFqjg+kLMpwqHkl03uWtM2KOj1Lu2xOsLKbm4/cZQK6rhlHCWz+gxJg4JGf
         detw==
X-Gm-Message-State: ACrzQf1GgEyBsOE6HBeGNxzvWdn7dzm4z2sBKzpVQX2YnPXe7Kph9MB8
        GmsN5A5smzlJiqu7Dw/ht6w=
X-Google-Smtp-Source: AMsMyM7Ps/b7SlUeqy/KYdhJEp8/q7b0v7pN+IutpGDcykOvoIfsUsTWf8Jw+KICQXlFgaB+pMfO+Q==
X-Received: by 2002:a5d:650b:0:b0:236:8ead:3ec2 with SMTP id x11-20020a5d650b000000b002368ead3ec2mr37169474wru.434.1667940582813;
        Tue, 08 Nov 2022 12:49:42 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id q12-20020a5d61cc000000b002238ea5750csm13390370wrv.72.2022.11.08.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:49:41 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] clk: Warn and add workaround on misuse of .parent_data with .name only
Date:   Tue,  8 Nov 2022 21:49:18 +0100
Message-Id: <20221108204918.2805-1-ansuelsmth@gmail.com>
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

