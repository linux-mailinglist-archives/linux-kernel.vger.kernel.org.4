Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30E4701F62
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjENUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjENUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:04:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B110F8;
        Sun, 14 May 2023 13:04:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96622bca286so1862653866b.1;
        Sun, 14 May 2023 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684094642; x=1686686642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=de7gobUu/aaFSwWxRJPrplu7cwQHc3kQWe+54a2nM+s=;
        b=nB43jVA4F+HN5Zl4CgOiOfBiwFfbB3cFN/vVE7qRl67R9R4XsxEcG+nm1w2nOGmvJW
         AjTkHrYGXKI5rEL9X3TQXkX1cP789bMhlbwoQ7sqFKuIdNeE7trxkJUqZ9Dr/t8K3/R7
         KZG95c33+HANwDihaFElg/kKcZXrvfibZXy7lSC81g8DvYgDZgxHCoxhXfgudwMcAbaU
         f48hZrjIdYYshUovr0RjadqhR4WSdOPjc2s3YriXHE8fk7o/FGgz6zDsOZkdX0dbmr+o
         dN9BB1U05GT9ry9mGyLJL8K22ZHSAcBbOUJ/JmVFys47INYi6+zan01egK6jU8hHMSXP
         3gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684094642; x=1686686642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=de7gobUu/aaFSwWxRJPrplu7cwQHc3kQWe+54a2nM+s=;
        b=JUs04VO+nmQbxYeorwNaFg8ZCJTFXPI7wvKEO1aq+207jOjFxTDzTe3QbZhbutZd+6
         2gv+B/vjItHUtDqp3MocbgKyEMKXFU300Y0T63CuehIpBgLI1+AfTJl0CDuYwzmL+T6w
         Y9lnO30opkPAXSvnvd7PbW66G4FA/yEWM+m+kIzQVOhvQtsnPoGwGgG4jdGqetCPaYqf
         doPtbSyDwOqr+1mr2GRd/dU/q99bor/f17Lf6mfiL0eUfEBopKgI3+YuTz7CUb6Jzo7y
         Ia7kSOzn+sp27ghx3fdnuLXUHI1LTNXIPly5++UGKP+Y50khR95DIa5oVrxDVoJRxAWc
         KoUQ==
X-Gm-Message-State: AC+VfDy7hoAU4m6QUz8jDtTFW3N0UvX1JhzXiczSPogoThj00a4C+Klr
        OXFakhe23O/HfvyWmDtSA9klEHApKt4=
X-Google-Smtp-Source: ACHHUZ6dxCX/7IC1jwL7BgUQqUsFopo7D42QITYDk+7P1hWLKnJzg1xiLQKDww2GIA97vP1j5eNDiQ==
X-Received: by 2002:a17:906:478f:b0:96a:3b67:40bb with SMTP id cw15-20020a170906478f00b0096a3b6740bbmr15538548ejc.40.1684094642165;
        Sun, 14 May 2023 13:04:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7ade-5d00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7ade:5d00::e63])
        by smtp.googlemail.com with ESMTPSA id h22-20020a1709070b1600b0094f07545d40sm8543706ejl.220.2023.05.14.13.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 13:04:01 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pkshih@realtek.com,
        tony0620emma@gmail.com, kvalo@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH wireless v1] wifi: rtw88: sdio: Always use two consecutive bytes for word operations
Date:   Sun, 14 May 2023 22:03:45 +0200
Message-Id: <20230514200345.502807-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner sunxi-mmc controller cannot handle word (16 bit)
transfers. So and sdio_{read,write}w fails with messages like the
following example using an RTL8822BS (but the same problems were also
observed with RTL8822CS and RTL8723DS chips):
  rtw_8822bs mmc1:0001:1: Firmware version 27.2.0, H2C version 13
  sunxi-mmc 4021000.mmc: unaligned scatterlist: os f80 length 2
  sunxi-mmc 4021000.mmc: map DMA failed
  rtw_8822bs mmc1:0001:1: sdio read16 failed (0x10230): -22

Use two consecutive single byte accesses for word operations instead. It
turns out that upon closer inspection this is also what the vendor
driver does, even though it does have support for sdio_{read,write}w. So
we can conclude that the rtw88 chips do support word access but only on
SDIO controllers that also support it. Since there's no way to detect if
the controller supports word access or not the rtw88 sdio driver
switches to the easiest approach: avoiding word access.

Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Closes: https://lore.kernel.org/linux-wireless/527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net/
Reported-by: Rudi Heitbaum <rudi@heitbaum.com>
Fixes: 65371a3f14e7 ("wifi: rtw88: sdio: Add HCI implementation for SDIO based chipsets")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index af0459a79899..06fce7c3adda 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -87,11 +87,6 @@ static void rtw_sdio_writew(struct rtw_dev *rtwdev, u16 val, u32 addr,
 	u8 buf[2];
 	int i;
 
-	if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2)) {
-		sdio_writew(rtwsdio->sdio_func, val, addr, err_ret);
-		return;
-	}
-
 	*(__le16 *)buf = cpu_to_le16(val);
 
 	for (i = 0; i < 2; i++) {
@@ -125,9 +120,6 @@ static u16 rtw_sdio_readw(struct rtw_dev *rtwdev, u32 addr, int *err_ret)
 	u8 buf[2];
 	int i;
 
-	if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2))
-		return sdio_readw(rtwsdio->sdio_func, addr, err_ret);
-
 	for (i = 0; i < 2; i++) {
 		buf[i] = sdio_readb(rtwsdio->sdio_func, addr + i, err_ret);
 		if (*err_ret)
-- 
2.40.1

