Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7051E6CBF83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjC1Mo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC1Mox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:44:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EE93C3;
        Tue, 28 Mar 2023 05:44:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536af432ee5so227762287b3.0;
        Tue, 28 Mar 2023 05:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680007463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYM0LDWTymu0bPPL77EcCh7NegRUDjN6g7FPTmBma/w=;
        b=JjUm88X4RKhTtd8pJK8O1h2ETqz0s9W+HLALN2xHbiPTPfx1d8GbfHK/c+50Xmbiac
         Ys39w7Ej6CYzi+oVWrgRXPPeQEBJX9vBzHBeQAd9wzYeOdpgH15oJSwE0jfgGwIbLGg7
         DIuD9nQBp3cRYtL3ShOuygmcXUEP2gHyrhDv7xD9REhX0s2dInRyXhvV94ED3A3ejcTL
         IiCblLp/u0v1OJBS31IHUN7MnBDYm95/eE+XjeBUSOepAfcJtqFAa3E8FSsfu8QSyG2B
         Pxa5JTOCnsKpRW90ZZJC4222jn4OVmCHyZwFh/f3MJnDJbtniqa6Gniaf1zfcuo0Kj95
         1ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYM0LDWTymu0bPPL77EcCh7NegRUDjN6g7FPTmBma/w=;
        b=j+Kp/W4Xsb9OpKFDz1/IpYlbQqbO6jN0QT1AlP7HyeLuH0j/HqrM4vuSolH010RIgn
         gC32g0loUsWemPH53bcUjCknhPal/v6PucblO05vo5XIvPQ6eTpalWoKsMGHtlrR/dDx
         7HbeULeIGLfHIAiyxB5gE/TtDW2oeGEJBgI+mSxernxE0BWuuvbSaIFcO9tzgSMGpKpc
         raQGMp5jkudNunGWTWkQpD3D0Wh2EaPbTc+yamLz7EpLyeXJ067vGT3nutvoAqYu6bTP
         FxF0BVHMN6JiK3sZU6H9MSjrWvtfAG6Ldia4h0r6Q/jsSM54emGHlqmRs3pTOWS/602V
         oFjw==
X-Gm-Message-State: AAQBX9cpUTgcREwayZZDJvLmrCaYEVnN9oI7gz4ytsHzVX18VaJ5fd02
        BM3+1yZEc8m/WHcKb/NJQTATXJ99BEw=
X-Google-Smtp-Source: AKy350aAesljbwFJTOWnmnvUuqGvqeYc/psTJV5UFSUS1mOGIiScDqwFviK0fhCbJqKaZamJKjvPYQ==
X-Received: by 2002:a81:5a83:0:b0:544:7850:b62f with SMTP id o125-20020a815a83000000b005447850b62fmr14323652ywb.18.1680007463076;
        Tue, 28 Mar 2023 05:44:23 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id n38-20020a81af26000000b00545a08184d5sm2382152ywh.101.2023.03.28.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 05:44:22 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: dvb-usb: dw2102: Fix uninit-value in su3000_read_mac_address
Date:   Tue, 28 Mar 2023 12:44:16 +0000
Message-Id: <20230328124416.560889-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In su3000_read_mac_address, if i2c_transfer fails to execute two
messages, array mac address will not be initialized. Without handling
such error, later in function dvb_usb_adapter_dvb_init, proposed_mac
is accessed before initialization.

Fix this error by returning a negative value if message execution fails.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/media/usb/dvb-usb/dw2102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 0ca764282c76..8747960e6146 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -946,7 +946,7 @@ static int su3000_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 	for (i = 0; i < 6; i++) {
 		obuf[1] = 0xf0 + i;
 		if (i2c_transfer(&d->i2c_adap, msg, 2) != 2)
-			break;
+			return -1;
 		else
 			mac[i] = ibuf[0];
 	}
-- 
2.25.1

