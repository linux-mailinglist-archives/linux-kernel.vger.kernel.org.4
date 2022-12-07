Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64267645C3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiLGOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLGOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:18:25 -0500
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0D055C8F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:18:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 48F7CCAF6FD;
        Wed,  7 Dec 2022 17:17:05 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BuBuo8qc0Q1E; Wed,  7 Dec 2022 17:17:05 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 1D4A35DA93C3;
        Wed,  7 Dec 2022 17:17:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 1D4A35DA93C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1670422625;
        bh=BqTTG9cNpPmOuspsQF/4wpK11jWURW6JTgvWlbiB7PE=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=j042Nc9YtovYiQP94mTxU+nIHIW38wbi20/088Fwx20sv+FwqJSYTubmrWNQjeknV
         l2jZGM/Yk/EMwVH7re5+w/glUO4riQW7xR7/cUZxOEVc8TJmnNbyeBMNaotGYE4v/7
         XMJMxMrw+4Ifja+wjrrUK29AR9APggdcsF6xINXTEPJt/JFNqWcWMqpjDRoOBQPYR+
         iuzloNnqhiBNZi6iBfuoyH8A9O9QBF8HhJuL3tsZomZrIGiNaroSZ7xREuDhanKSqY
         /XKU7YuwkqXjrZvGdp9m99fbgZrecLQE8sgiJo61sfg9XDUAdGo92QFo+s7Zd4+bq8
         ERrNFH+qJ6Ilw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AKv5-U0ME5QI; Wed,  7 Dec 2022 17:17:05 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id BD0F05DA93AF;
        Wed,  7 Dec 2022 17:17:04 +0300 (MSK)
From:   Aleksandr Burakov <a.burakov@rosalinux.ru>
To:     Frank Haverkamp <haver@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aleksandr Burakov <a.burakov@rosalinux.ru>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH 2/2] misc: genwqe: card_dev: Array index overflow fix in ddcb_cmd_fixups()
Date:   Wed,  7 Dec 2022 17:18:08 +0300
Message-Id: <20221207141808.22922-2-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207141808.22922-1-a.burakov@rosalinux.ru>
References: <20221207141808.22922-1-a.burakov@rosalinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

&cmd->asiv of size 96 can overflow because its index (asiv_offs + 8)
can be equal to 96 (0x58 + 0x08) that is out of range.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
---
 drivers/misc/genwqe/card_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_de=
v.c
index 55fc5b80e649..d58ce2622307 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -867,7 +867,7 @@ static int ddcb_cmd_fixups(struct genwqe_file *cfile,=
 struct ddcb_requ *req)
 	struct genwqe_ddcb_cmd *cmd =3D &req->cmd;
 	struct dma_mapping *m;
=20
-	for (i =3D 0, asiv_offs =3D 0x00; asiv_offs <=3D 0x58;
+	for (i =3D 0, asiv_offs =3D 0x00; asiv_offs < 0x58;
 	     i++, asiv_offs +=3D 0x08) {
=20
 		u64 u_addr;
--=20
2.25.1

