Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B147317AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbjFOLoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbjFOLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF84499;
        Thu, 15 Jun 2023 04:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B529B61892;
        Thu, 15 Jun 2023 11:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E62C433CA;
        Thu, 15 Jun 2023 11:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829205;
        bh=4unQ5CooluLlrhjnz4V4S0iXgBW2jpLyCCQZc6t9YZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ViNi0fDjU9u1/Zfs3/A99ZNLAYo8lT2srhRRh2byNytCjTqIl9UxKRtYrY849f517
         I2ff6ubl18VZAzG54A+311/kt949x4h+CzIzoo0bsolNA0EN3b4t7+CMbjy/lwx2XV
         6u1FQBMSZkptYSxXtJixALpRkmX8S5ZfdzN11sLVfy6fZL4iq02evjOrw9e3lRt81N
         BSS6CmKgJAwSKJTuGu0jBOyo5XbamsYkRl34DIGMVMoOVaXTtyiWQsHn2RV0D3Vhfq
         8Pvxn7Y5iyiisuBXVbz7TfT2GYZezAFEsX44JVMVx5fvtRrBniFD+C/Uc/A0v09kA8
         QjwjoXR5ETfXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Arefev <arefev@swemel.ru>, Ping Cheng <ping.cheng@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        jason.gerecke@wacom.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/8] HID: wacom: Add error check to wacom_parse_and_register()
Date:   Thu, 15 Jun 2023 07:39:52 -0400
Message-Id: <20230615113956.649736-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113956.649736-1-sashal@kernel.org>
References: <20230615113956.649736-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.286
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Arefev <arefev@swemel.ru>

[ Upstream commit 16a9c24f24fbe4564284eb575b18cc20586b9270 ]

   Added a variable check and
   transition in case of an error

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_sys.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4e4a3424c1f9f..c50b26a9bc445 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2390,8 +2390,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
+		if (error) {
+			hid_err(hdev, "hw open failed\n");
+			goto fail_quirks;
+		}
+	}
 
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
-- 
2.39.2

