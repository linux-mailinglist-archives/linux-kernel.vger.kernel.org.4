Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78AB6F2D50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjEADK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjEADJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C25BB1;
        Sun, 30 Apr 2023 20:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B5EE61781;
        Mon,  1 May 2023 03:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283D7C433EF;
        Mon,  1 May 2023 03:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910193;
        bh=IQgHuOoRnkEGD1Jb5Lkm537dUiI0uLn05CysAyCGk+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQ01+CKwjXIr5Y9JVM0lCXf2vqLYp2a6RBQjf5XACW2qde4gnej/CUIKAWqP/932+
         lsLwCWtNYInTymZH7thg+f5OWeF6Xs2gW2CcFZOitky6b43StRWYquhtdwZLB2NUZh
         3t3r8bJDM/dY6AlElNi768fa52v8DwdkxZo0zoz8TV+1egw/FBF3GpwFbJbFE9Ffdo
         y/vqffEmUas/+UWSqLaIXtHBMvu/1khCqPLD9ZQo25FT0lkAPclYuktf0NoI/7+C3C
         1fRmUexxH7mid0FXFV/iG+hl+hD0tHk2EeD7x03WvY0gCyeRAAM7QjP+U1Om9eC2lS
         VShSGJfuAbVng==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kang Chen <void0red@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/33] ACPI: processor: Check for null return of devm_kzalloc() in fch_misc_setup()
Date:   Sun, 30 Apr 2023 23:02:07 -0400
Message-Id: <20230501030227.3254266-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

[ Upstream commit 4dea41775d951ff1f7b472a346a8ca3ae7e74455 ]

devm_kzalloc() may fail, clk_data->name might be NULL and will
cause a NULL pointer dereference later.

Signed-off-by: Kang Chen <void0red@gmail.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_apd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 3bbe2276cac76..80f945cbec8a7 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -83,6 +83,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
 		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
 					      GFP_KERNEL);
+		if (!clk_data->name)
+			return -ENOMEM;
 
 		strcpy(clk_data->name, obj->string.pointer);
 	} else {
-- 
2.39.2

