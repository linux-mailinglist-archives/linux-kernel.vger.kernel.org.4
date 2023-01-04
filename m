Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C465CCCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjADGJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjADGJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:09:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73D12637
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:09:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x26so15895224pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 22:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7z3aK6JYwkPs6rlnGUEdEtPieaIcdnszYZ0OhEZgdE=;
        b=A6I+o74xCrRkH0h+QHiX6jGt3VZxCmIfjp+jxfvdOhYCl6RW/k93Mmi0I0nO7daPzJ
         HG9L0rIiILKq/9Gn8C4SNJwqjFUMeEQRB7ZzwoeiX0QK/BzX6cKjiTZeXz6VVSB+rbg0
         2js3EAqQVR7NoJK0w5e6E9fqqUBt06R0g1pQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7z3aK6JYwkPs6rlnGUEdEtPieaIcdnszYZ0OhEZgdE=;
        b=4TV0Yj1MVAVygZKQgp3GW5Fx6Q1SaFFZJgKNJ4sjpBThcUR6OFVCildv37zTpNF9GU
         1S/UnxFDMRBnRCd2tMYDzjrPSvisI88HqMr53ArSSuSurI6s4vJmVe62Cgq0bA132d/y
         LckO6IfEFdzsCsS7waeIVM9GYBrXvGLewIf979L1Qi3YHEOmdmkT/xQ0ADoCtKjxkYBu
         lTKCaDnfyhMdY0qFT3wToDguZg0iBqVJ8zcRB5vESoUGwAcXdxZCh0fxzBAFmTzXcYKZ
         PokhQhunnOfqNGj7EeJtGuBjH+H2loG8nAbBdEOO+JIMcwCSNYVm3hTBgHSYnqNjcbpH
         oTMQ==
X-Gm-Message-State: AFqh2kp1tOt77GLSV+//7YFzrIVMVMu7LJ4ZRze/UcaalFzSqiA5D6dd
        pIs9E7h5DgHhiJssYiUZgLY/GQpQ5l1b30Aq
X-Google-Smtp-Source: AMrXdXt0PaJnwyroJBMafonPPYnzD/kMJKo9ipb60mRVcLKLwEEk/JuOmREFcOFP4O2lCg9Tli0dkg==
X-Received: by 2002:aa7:870c:0:b0:581:c9cf:3807 with SMTP id b12-20020aa7870c000000b00581c9cf3807mr22602868pfo.29.1672812540812;
        Tue, 03 Jan 2023 22:09:00 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm124660pfi.128.2023.01.03.22.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:09:00 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_typec_switch: Use fwnode* prop check
Date:   Wed,  4 Jan 2023 06:08:44 +0000
Message-Id: <20230104060846.112216-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using device_property_present() multiple times on an ACPI device
leads to kernel panics on Chromebook systems. This happens when there
is > 1 boolean property in an ACPI device which is created dynamically
by the BIOS as part of SSDT[1] on Chromebook systems

Since fwnode_* can handle simple device tree properties equally
well, switch to using the fwnode_property_present() function
version. This will avoid panics and make the usage consistent
when we introduce a check for the 2nd property in a subsequent patch.

[1] https://wiki.osdev.org/SSDT

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_typec_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index a26219e97c93..2536bda03bf3 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -254,7 +254,7 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
 
 		dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
 
-		if (!device_property_present(fwnode->dev, "mode-switch"))
+		if (!fwnode_property_present(fwnode, "mode-switch"))
 			continue;
 
 		ret = cros_typec_register_mode_switch(port, fwnode);
-- 
2.39.0.314.g84b9a713c41-goog

