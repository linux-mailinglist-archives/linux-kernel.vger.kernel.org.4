Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE040625ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiKKMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:55:29 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494A7BE7C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:55:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id D69661864572;
        Fri, 11 Nov 2022 15:55:23 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lrwncELfyS6b; Fri, 11 Nov 2022 15:55:23 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 7F5C618637F2;
        Fri, 11 Nov 2022 15:55:23 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MgC1RnOcxzqF; Fri, 11 Nov 2022 15:55:23 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 17CC418642A3;
        Fri, 11 Nov 2022 15:55:23 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] HID: hid-lg4ff: Add check for empty lbuf
Date:   Fri, 11 Nov 2022 15:55:11 +0300
Message-Id: <20221111125511.28676-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an empty buf is received, lbuf is also empty. So lbuf is=20
accessed by index -1.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f31a2de3fe36 ("HID: hid-lg4ff: Allow switching of Logitech gaming =
wheels between compatibility modes")

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/hid/hid-lg4ff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 5e6a0cef2a06..e3fcf1353fb3 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -872,6 +872,12 @@ static ssize_t lg4ff_alternate_modes_store(struct de=
vice *dev, struct device_att
 		return -ENOMEM;
=20
 	i =3D strlen(lbuf);
+
+	if (i =3D=3D 0) {
+		kfree(lbuf);
+		return -EINVAL;
+	}
+
 	if (lbuf[i-1] =3D=3D '\n') {
 		if (i =3D=3D 1) {
 			kfree(lbuf);
--=20
2.30.2

