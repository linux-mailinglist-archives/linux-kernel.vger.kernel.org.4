Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E86962EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBNL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjBNL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:59:37 -0500
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A832448A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:59:31 -0800 (PST)
Received: from unknown (HELO mail3.hale) ([192.168.100.5])
  by gw.hale.at with ESMTP; 14 Feb 2023 12:59:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail3.hale (Postfix) with ESMTP id 164AEBD58B;
        Tue, 14 Feb 2023 12:59:30 +0100 (CET)
Received: from mail3.hale ([127.0.0.1])
        by localhost (mail3.hale [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9Xe9aaCKKkwJ; Tue, 14 Feb 2023 12:59:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail3.hale (Postfix) with ESMTP id A3DBBBD594;
        Tue, 14 Feb 2023 12:59:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail3.hale
Received: from mail3.hale ([127.0.0.1])
        by localhost (mail3.hale [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ITBH4HmjZrTq; Tue, 14 Feb 2023 12:59:29 +0100 (CET)
Received: from entw47.HALE.at (unknown [192.168.100.117])
        by mail3.hale (Postfix) with ESMTP id 8F777BD58B;
        Tue, 14 Feb 2023 12:59:29 +0100 (CET)
From:   Michael Thalmeier <michael.thalmeier@hale.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: ttynull: implement console write
Date:   Tue, 14 Feb 2023 12:59:21 +0100
Message-Id: <20230214115921.399608-1-michael.thalmeier@hale.at>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a699449bb13b ("printk: refactor and rework printing logic"),
con->write is called without checking if it is implemented in the console
driver. This does make some sense, because for all "normal" consoles it
is vital to have a write function.
As the ttynull console driver does not need any console output the write
function was not implemented. This caused a "unable to handle kernel NULL
pointer dereference" when the write function is called now.

To fix this issue, implement an empty write function.

Fixes: a699449bb13b ("printk: refactor and rework printing logic")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
Changes in v2:
- Reference correct commit SHA-1 ID
- Add Fixes tag
- Link to v1: https://lore.kernel.org/all/20230214102317.382769-1-michael=
.thalmeier@hale.at

---
 drivers/tty/ttynull.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
index 1d4438472442..6e9323544a7d 100644
--- a/drivers/tty/ttynull.c
+++ b/drivers/tty/ttynull.c
@@ -40,6 +40,12 @@ static unsigned int ttynull_write_room(struct tty_stru=
ct *tty)
 	return 65536;
 }
=20
+
+static void ttynull_console_write(struct console *co, const char *buf,
+				  unsigned count)
+{
+}
+
 static const struct tty_operations ttynull_ops =3D {
 	.open =3D ttynull_open,
 	.close =3D ttynull_close,
@@ -56,6 +62,7 @@ static struct tty_driver *ttynull_device(struct console=
 *c, int *index)
=20
 static struct console ttynull_console =3D {
 	.name =3D "ttynull",
+	.write =3D ttynull_console_write,
 	.device =3D ttynull_device,
 };
=20
--=20
2.39.1

