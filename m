Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B75B3A75
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiIIOOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIIOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:14:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E200AB408
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:14:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nc14so4320440ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ySwWI942jaxyz5lWBkAOHKVuWAIl4C9M1/fPskGwiY0=;
        b=cHUZnXW68BAC3LoHZFdFKCiMv5iqTS+JZMsdn3lgXfdwK/hmcm+UCHqTqWAQ0miBtA
         PwZgy9mbViiwWhdi72v2lF0ae6j98smmgpgJp2Ew0qgy2/fMpqXUDL/ehhEyyjpVw8c0
         N9rlFFfQU0goGolBC8vNzmfHAxShvOzf023KT/szZxznJrQQEx9p0E6msT6N/w3+BzFj
         T+k+j5O8Y29ym9uewzVAmaLte0pC4xlyFNZ4l/mmZ/Ryg6O9pSHvxJi2ze6YbB1wgBSx
         sAuI1Sz2GMfDr1+mnx/VRi8flaxmu8cW2A7ntKyJMOtiwfdSF5uwUJAnekzvRZpFDQqJ
         kutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ySwWI942jaxyz5lWBkAOHKVuWAIl4C9M1/fPskGwiY0=;
        b=6Z52FyBt2qll+WdpCjaBN+PB7YLz15ntu1gdIDd/9k51SiID+jP5UEqv8/pFeIzf1C
         yXHBqBsOY2tN5gCiXe8vQKp9KZEqW/T5ijgGGkPwPuGhv6Z6zpb8B4isNsX/CzVi7IrC
         en2Ik1O+GYocdV12VNb2kaZ4lHRBKy3wLBW2aPwrSx1I+BJ1kMTHvNKOxkeqQqQItxp+
         xB+ukrpEp87OpXcZTfE+JNeYm4J+2KqbUrqKdsOlqmwzK6sF6EuauuQcrhfj0LWbGfEG
         83T23b/bWEy3AC+NV0Oq2fZCDTm+LhyR86Xmja/G/SooQMkquawt80JDBu07sBiX2uNW
         7lEw==
X-Gm-Message-State: ACgBeo1zvuYAdLcWj7LX+9P1kuMO8KbH0mAZekPuluZZmA8TrLPhk1Qh
        l2Kc2zOFl1Vjgn+LW0xWj7s=
X-Google-Smtp-Source: AA6agR5nXtIg6vdlK66fSHhsIm6fnp9wpUrbqDxdOS3dZr8g/6FzAhW1Su6/jr2mPLPn7UJ0+r4Yzw==
X-Received: by 2002:a17:907:2bf8:b0:770:837a:e3b8 with SMTP id gv56-20020a1709072bf800b00770837ae3b8mr9126840ejc.562.1662732840890;
        Fri, 09 Sep 2022 07:14:00 -0700 (PDT)
Received: from localhost.localdomain (wlan-244090.nbw.tue.nl. [131.155.244.90])
        by smtp.gmail.com with ESMTPSA id cn11-20020a0564020cab00b0044ea7b8f57bsm471146edb.1.2022.09.09.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:14:00 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: vt6655: fix potential memory leak
Date:   Fri,  9 Sep 2022 16:13:39 +0200
Message-Id: <20220909141338.19343-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In function device_init_td0_ring, memory is allocated for member
td_info of priv->apTD0Rings[i], with i increasing from 0. In case of
allocation failure, the memory is freed in reversed order, with i
decreasing to 0. However, the case i=0 is left out and thus memory is
leaked.

Modify the memory freeing loop to include the case i=0.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 3397c78b975a..a65014195fdc 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -743,7 +743,7 @@ static int device_init_td0_ring(struct vnt_private *priv)
 	return 0;
 
 err_free_desc:
-	while (--i) {
+	while (i--) {
 		desc = &priv->apTD0Rings[i];
 		kfree(desc->td_info);
 	}
-- 
2.25.1

