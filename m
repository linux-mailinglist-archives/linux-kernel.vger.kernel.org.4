Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA35717B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjEaJHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjEaJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:07:17 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1112E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:07:07 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5555765c6d3so3508268eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685524026; x=1688116026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6dEyi6AGYaP28foBidULwGN56hxXAodGv+YU14GBEY=;
        b=Uw4hPKMxgez7mchEcYKo2y8YNzmXe8VJrzDMRFmvOcvtS6wh0PgWgayIJVwxET1vlk
         7ULG5OXofFnYxHNWiaQJV49vwveRMHMf9bj0NcVR0fgQyAHhZEX/u3zZlQqjSTi1IUz0
         QEu6Ig7uAEqBqqzuEUSbsK1JhX1DuYL1Uh1OOroB2VTPP64BwMtt+WpOX1hduzhNY3El
         iywApcDy8g1tUf+RXWKh35a1oNIp1c3HTsYywr5MbC6z1xnqqiU3LqC6WBfGgM/z1bze
         NnQG9NZ6/7XNCdbk2hdRMlFITQI05hUBCHRZu8fiB6dE+NxfMKKJmBwS6+IfB/Wdv8Fg
         vIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524026; x=1688116026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6dEyi6AGYaP28foBidULwGN56hxXAodGv+YU14GBEY=;
        b=kdZVzO3wA9tpgEmuf1VVUKL3xqAyLl9UwEeVnEuDkDQjaCK3HIho0IenAMl7Qst41a
         5mDyNixvRfWQJz888Hrr8X8EcdQrJA7JlFRYW/FqBhrn/4Sv7DmWokDYUjhfS8IR8URc
         7xj5ZPLs6uPJjS6UV0OAZVAh+BE3zE7azRabxySHXvuedmpYGmIW2Ct+mgzYbFGIOgv8
         uGEhyBEAraWebZheQY6d1pdefv0Nnq4NuPIv+M8PULcvgXuOgeaJK8bsX2T+IssV/lXw
         AhmolblbxW6vU8b1OGe6o2yQyGC7c6QDSNTinFvQgdR2at1/2YSclcRtUbPLmHSs86Z5
         1lgQ==
X-Gm-Message-State: AC+VfDw+57OAZKLuI9PRex3N8ERAcFAlViw3a41sTJEJ3fv2eEE3+pfp
        AB6ag7TWaeb5c38tdqef3Mk=
X-Google-Smtp-Source: ACHHUZ50Ep+NjfhDZ1k3WX0bHLfzzHFO4lgKhgkjrkRCIYpFGYnhJOuLPi1i7e5c6mzo5U7tQ5ty1Q==
X-Received: by 2002:a05:6358:5290:b0:123:2b2e:529d with SMTP id g16-20020a056358529000b001232b2e529dmr1948123rwa.6.1685524026360;
        Wed, 31 May 2023 02:07:06 -0700 (PDT)
Received: from localhost.localdomain ([2406:e003:15d1:ec00::6e2])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0064fff9f540csm2104824pfi.164.2023.05.31.02.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:07:05 -0700 (PDT)
From:   Sicong Jiang <kevin.jiangsc@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     kevin.jiangsc@gmail.com
Subject: [PATCH] ASoC: amd: yc: Add Thinkpad Neo14 to quirks list for acp6x
Date:   Wed, 31 May 2023 21:06:35 +1200
Message-Id: <20230531090635.89565-1-kevin.jiangsc@gmail.com>
X-Mailer: git-send-email 2.38.0.83.gd420dda057
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

Thinkpad Neo14 Ryzen Edition uses Ryzen 6800H processor, and adding to
quirks list for acp6x will enable internal mic.

Signed-off-by: Sicong Jiang <kevin.jiangsc@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4406a5def..246299a17 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -171,6 +171,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21EF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.38.0.83.gd420dda057

