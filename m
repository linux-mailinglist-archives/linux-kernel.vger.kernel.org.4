Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAB73175F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344283AbjFOLmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbjFOLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DE3296B;
        Thu, 15 Jun 2023 04:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3836390B;
        Thu, 15 Jun 2023 11:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB9FC433C8;
        Thu, 15 Jun 2023 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829143;
        bh=20h86SF8vqjjV7pZqhVFq96wt0LfBRYx5d1gMdmcW4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOsT58IZrCQ+i4FuPOfCGJ0kVykifhgRGGL8XogkAGdKDZGTKMQn8h1mrEK1pA2Ih
         yc80yNFqMFmfy2zASmveBb8Jhg59+cRECJbBxfxPQ1Mgutmx7nTBAZmxu9KpzM23rZ
         cLe/PRYs1UO0wXqUbSVyszGypJqYL0F1NI752AcfEhDfHtm9lrUJjKwtM3v8pgNiXQ
         vNysbW0oMeQJR61keOF9uFpjlAk2unn+ibGWafW6A1NQDKkXVvtPnYj8NDRzzwjY/w
         LujJVLfBJSi0Te46DLajA1Fw6HQ5CsD/kld5MfCPs5aBhbc76WHxbChUBU+I50F6y1
         vfspzIqhwVBaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Arefev <arefev@swemel.ru>, Ping Cheng <ping.cheng@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        jason.gerecke@wacom.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/10] HID: wacom: Add error check to wacom_parse_and_register()
Date:   Thu, 15 Jun 2023 07:38:48 -0400
Message-Id: <20230615113854.649370-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113854.649370-1-sashal@kernel.org>
References: <20230615113854.649370-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index d29773a799b4f..33e763e746a0b 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2425,8 +2425,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
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

