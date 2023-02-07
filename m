Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4634168CD7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBGDdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBGDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:33:53 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2415554
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:33:46 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 897E72C02A4;
        Tue,  7 Feb 2023 16:33:41 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1675740821;
        bh=B9TvaMmkUAniP3h7ay7qPQ4OgQJ2sokxLiIjsCV1DuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=sW7koW0nwth9NyRW5311JyXeB9OLNc69bIrJ921uh8lMBSeGe/88fc3ZTTSEpaHXx
         wHMQKc+Zv9/TT0muQJYu73gAWL8CAl6nUWV+wLX5M92XiXc/SMOPmmaZ6sQwcQ+uef
         exOuGIiaXUZrkGPOn4/xsuoo1oGD0Da0tF5x7ax6UkKiigNnheICK/iXdG6SKoMnTc
         wtoj4YJVHteUKm8u3pshCoeQ8jUnfBdkiQ8yWIVTqY5OlwLzWZYYLPtdYA7P6Fh9VD
         5FK25jj3abYP/RixX7aEGbEbRsGgBWqUj4ujCxwQj9hCAwwmho3uFABwaX3Y2ZRvXQ
         Brz3Nft3MnxCg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63e1c6950000>; Tue, 07 Feb 2023 16:33:41 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by pat.atlnz.lc (Postfix) with ESMTP id 5DB5B13EDC1;
        Tue,  7 Feb 2023 16:33:41 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 5A30433E965; Tue,  7 Feb 2023 16:33:41 +1300 (NZDT)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] usb: max-3421: Fix setting of I/O pins
Date:   Tue,  7 Feb 2023 16:33:37 +1300
Message-Id: <20230207033337.18112-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=a6lOCnaF c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=m04uMKEZRckA:10 a=mwjI7TqugprM___TUpMA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To update the I/O pins, the registers are read/modified/written. The
read operation incorrectly always read the first register. Although
wrong, there wasn't any impact as all the output pins are always
written, and the inputs are read only anyway.

Fixes: 2d53139f3162 ("Add support for using a MAX3421E chip as a host dri=
ver.")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/usb/host/max3421-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hc=
d.c
index 352e3ac2b377..19111e83ac13 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1436,7 +1436,7 @@ max3421_spi_thread(void *dev_id)
 			 * use spi_wr_buf().
 			 */
 			for (i =3D 0; i < ARRAY_SIZE(max3421_hcd->iopins); ++i) {
-				u8 val =3D spi_rd8(hcd, MAX3421_REG_IOPINS1);
+				u8 val =3D spi_rd8(hcd, MAX3421_REG_IOPINS1 + i);
=20
 				val =3D ((val & 0xf0) |
 				       (max3421_hcd->iopins[i] & 0x0f));
--=20
2.39.1

