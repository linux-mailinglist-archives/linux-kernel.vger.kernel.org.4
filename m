Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651516698D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbjAMNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241832AbjAMNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:38:42 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E153C3A0;
        Fri, 13 Jan 2023 05:33:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id D91101863FB1;
        Fri, 13 Jan 2023 16:33:23 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YD6YgPiEQKEc; Fri, 13 Jan 2023 16:33:23 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 936301863F94;
        Fri, 13 Jan 2023 16:33:23 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C0a-tRBm6QT3; Fri, 13 Jan 2023 16:33:23 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 095ED1863C69;
        Fri, 13 Jan 2023 16:33:22 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] iio: chemical: scd30: Add check for NULL in scd30_i2c_command
Date:   Fri, 13 Jan 2023 16:33:20 +0300
Message-Id: <20230113133320.7531-1-abelova@astralinux.ru>
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

Check rsp for NULL-pointer before dereferencing.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e510190e0139 ("iio: chemical: scd30: add I2C interface driver")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/iio/chemical/scd30_i2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd3=
0_i2c.c
index bae479a4721f..84baf67fc0ce 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -101,8 +101,10 @@ static int scd30_i2c_command(struct scd30_state *sta=
te, enum scd30_cmd cmd, u16
 			return -EIO;
 		}
=20
-		*rsp++ =3D buf[i];
-		*rsp++ =3D buf[i + 1];
+		if (rsp) {
+			*rsp++ =3D buf[i];
+			*rsp++ =3D buf[i + 1];
+		}
 	}
=20
 	return 0;
--=20
2.30.2

