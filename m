Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F667382D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjFULTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjFULT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:19:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BF1BE3;
        Wed, 21 Jun 2023 04:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4538F61509;
        Wed, 21 Jun 2023 11:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1618C433CB;
        Wed, 21 Jun 2023 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687346332;
        bh=awRUEIsBz7jICYn6S0zzZ2KjEVA3QGWX7J+A7/FWXeA=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=M77EO/MFnPqoH7ShIjHrFSpp9rIdVnvHODeAGlQca24+4N+VEK9/GuEgtS4BbY6Yz
         mq2L+SO7XauWUWOdIQoOZfQDsj6rhInBISI2QWKyEQBUb3JPlqkf+0dpz8m9+Vhd/4
         eaSSzVRMzX5T3ugRC/rMW5AmAOomD6czNcMT6lm4Zb2HgY12VCVs2TfPl7EMklD3EQ
         daCTu8LKGSqVMys+wkD6QQLK46rnPpzHMEjy8otVaA15tBgRC1x293cy4VpJnwbYdS
         HxANm45a6cK5UonnP6FW/0r+3YXsjdVupkNxvSE6UtI3xktQps6BE3RvSs6neL3XRW
         FFzwkn0pwmyrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 825D6EB64D7;
        Wed, 21 Jun 2023 11:18:52 +0000 (UTC)
From:   Ludvig Michaelsson via B4 Relay 
        <devnull+ludvig.michaelsson.yubico.com@kernel.org>
Date:   Wed, 21 Jun 2023 13:17:43 +0200
Subject: [PATCH] HID: hidraw: fix data race on device refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-hidraw-race-v1-1-a58e6ac69bab@yubico.com>
X-B4-Tracking: v=1; b=H4sIAFbckmQC/x2NQQqEMAxFryJZT8FUxoVXGVykbbRZ2JFEHEG8u
 3WW730e/wRjFTYYmhOUdzH5lgr4aiBmKjM7SZXBt75re48uS1L6OaXILrwxIIYJkRPUIpBVqVR
 ifpqFbGN9hlV5kuN/8xmv6waz9WPwdgAAAA==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903;
 i=ludvig.michaelsson@yubico.com; h=from:subject:message-id;
 bh=H+F1GtqsL31H9za8Cp+DCcNUqK2U4w+0+a9OPk49764=;
 b=owJ4nJvAy8zAJWab5fnkyINtxYyn1ZIYUibdmRlX2tG4s3tDGdfyaQ+1fizccmSzmKnMjKvTT
 51TYl94IECno5SFQYyLQVZMkWVzAfN/0QUZS4SfcsvAzGFlAhnCwMUpABMpEmT4pyN1vSThYWFb
 Oss69VsFraGikyKTnh3ao7tnT6jToYPV3Qz/q2W85zi8F1t3TW73EdkjXJ0+M9enGVU5GYSZVlj
 G8IjwAgB2p0pI
X-Developer-Key: i=ludvig.michaelsson@yubico.com; a=openpgp;
 fpr=78D997D53E9C0A2A205392ED14A19784723C9988
X-Endpoint-Received: by B4 Relay for ludvig.michaelsson@yubico.com/default with auth_id=54
X-Original-From: Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
Reply-To: <ludvig.michaelsson@yubico.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludvig Michaelsson <ludvig.michaelsson@yubico.com>

The hidraw_open() function increments the hidraw device reference
counter. The counter has no dedicated synchronization mechanism,
resulting in a potential data race when concurrently opening a device.

The race is a regression introduced by commit 8590222e4b02 ("HID:
hidraw: Replace hidraw device table mutex with a rwsem"). While
minors_rwsem is intended to protect the hidraw_table itself, by instead
acquiring the lock for writing, the reference counter is also protected.
This is symmetrical to hidraw_release().

Link: https://github.com/systemd/systemd/issues/27947
Fixes: 8590222e4b02 ("HID: hidraw: Replace hidraw device table mutex with a rwsem")
Signed-off-by: Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
---
 drivers/hid/hidraw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 93e62b161501..e63c56a0d57f 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -272,7 +272,12 @@ static int hidraw_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	down_read(&minors_rwsem);
+	/*
+	 * Technically not writing to the hidraw_table but a write lock is
+	 * required to protect the device refcount. This is symmetrical to
+	 * hidraw_release().
+	 */
+	down_write(&minors_rwsem);
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		err = -ENODEV;
 		goto out_unlock;
@@ -301,7 +306,7 @@ static int hidraw_open(struct inode *inode, struct file *file)
 	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	file->private_data = list;
 out_unlock:
-	up_read(&minors_rwsem);
+	up_write(&minors_rwsem);
 out:
 	if (err < 0)
 		kfree(list);

---
base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
change-id: 20230621-hidraw-race-b51b11bf11ed

Best regards,
-- 
Ludvig Michaelsson <ludvig.michaelsson@yubico.com>

