Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F96ED452
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjDXS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjDXS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:26:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E264EE8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:26:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b73203e0aso30020960b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682360789; x=1684952789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66WxfLfuhbs9JlxLvUHTuxIFMIAQEgP1uu2TwgdORPQ=;
        b=CsY/aqrVrIHlMrOL3WBNlj0hg+3PmnDFg5Zxzwkc48hVFGOvIh8iYyLDL/YqqVulu5
         H5e/ugiyZSlW/mg/4WnZa3LCdRkrRi+uOVcGTD0sYsc8q8gOjJcqRH0HbRUw2Fprlbto
         Qa5HplhBXD5DpBShI6fv38jr08et5meyiDTrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360789; x=1684952789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66WxfLfuhbs9JlxLvUHTuxIFMIAQEgP1uu2TwgdORPQ=;
        b=NkIXkgGJHGaEAp0TavBqLJ5nVNAOresffbeHJ7L+wU9KO2M2qODPUPRS4yfmW1Aspw
         qX42pVxKj64oOjtvnidrc7ZpXBhLlgcNR8sCHlB8PDDxvwdDaeaCMBpSFSoZcES87tGj
         PuCBxPJRFpAR5Pu511bA5hiEndnF/0+t5vIY3ZG0w3XwL56tcaJJHxdckIKkj2Ime4Vq
         hIvUv4XYJEWjLxSF7Ge5Edt+AkX4p1y/d55c/U86KRn/0Kl9pazzMbBIzgRjkMRURInI
         SU9YbPKTn/VEq8hBK08B3vcgAUwmOrCvIPioF000X8Mwbxbby9N2K420hMtr6Nmn4LGb
         a2Og==
X-Gm-Message-State: AAQBX9c4ed5Ve6zkV164Uvmav+aeCB5lE739626CZpmsRM+mA2HtSvNN
        yllAWmyI09X25wQExdWKHddoUEBAwgAG+EVYePg=
X-Google-Smtp-Source: AKy350bEq0EHY2h+3sz8ItLipjHpbQ8aK9PklWBMg9lgZntqCErZgwtIT3L+CgqNAxiUkzTl6Mrw7A==
X-Received: by 2002:a05:6a20:428e:b0:f2:bb0:4622 with SMTP id o14-20020a056a20428e00b000f20bb04622mr15709509pzj.12.1682360789125;
        Mon, 24 Apr 2023 11:26:29 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:3f0c:c4ee:4add:682d])
        by smtp.gmail.com with ESMTPSA id w25-20020a62c719000000b0063d245ddc91sm7667083pfg.81.2023.04.24.11.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:26:28 -0700 (PDT)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: sbs: Fix INHIBITED bit for Status reg
Date:   Mon, 24 Apr 2023 11:25:58 -0700
Message-ID: <20230424182559.92271-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHARGE_INHIBITED bit position of the ChargerStatus register is actually
0 not 1. This patch corrects it.

Change-Id: I08630b264eddd09b94c8f6d299724c39218e958a
Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 drivers/power/supply/sbs-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 75ebcbf0a788..a14e89ac0369 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -24,7 +24,7 @@
 #define SBS_CHARGER_REG_STATUS			0x13
 #define SBS_CHARGER_REG_ALARM_WARNING		0x16
 
-#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
+#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(0)
 #define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
 #define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
 #define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
-- 
2.40.0.634.g4ca3ef3211-goog

