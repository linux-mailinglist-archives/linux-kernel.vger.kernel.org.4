Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AD35BA1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIOUaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIOUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:30:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6032B8B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z97so28655514ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OipeXrKVU1BCY0WjlS+Kuojt9dLqNbUbahDVdYj30x8=;
        b=mkQTbaiVCfxFHMGkSMiDq2B0j4wI7cUA65gFgr12puDxoaN1ZTeoAReUDGZxV3OA2B
         wWG5GBIXcY6Ttqkbc1iAXFWCe+cXNzdIXshyYk8OoR5lQgPFf4dv0JgbXjd745cRWP14
         gneqlmF4Msg58rqdMeOpMwiLdm1dHZJh62MPz5/4M89qZ4wJpb6PY8a0SpWIXBYjDkVY
         VdQciox2/UEeeUNiHuB1rPf6/enpOKq562MUva6huD8LZHV1dBuAJihQUR8UqmTcaU/p
         sAJ0/ri8wddyl/NJ/Ow7GSMHz2EZ6HYkIEoFny0++WFY0g6oMP6KTmF6q1TGuphJKAv8
         U+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OipeXrKVU1BCY0WjlS+Kuojt9dLqNbUbahDVdYj30x8=;
        b=C+KAFfcpNHrJlJ1neWjl6hMMQIdd4eOGpLEjS73QD04OouUG8kBUhU7FgPq4gDZUQi
         Ls0G6fojvWVeDB47iO8GB5EYGqTErgoulcT+2rLoAmnGZMpFjKU25G7RMJmzTY8VMdQs
         MMqr5W4Uqf6ZngDpiD8uJoKG82U1wo+rlmd3bhFftox9AzABqM9aJfFYz1ujahRaAMBK
         PUF9dQHuGwkNdgj7g+YBrq7scTIdfNrvAdXw1lA2ip/BQyKfGaUS8NLw1MFgUx4YKDsy
         tffw+Ihsk8QhkML073rYyghwY3rUVb2Vi0PKN2I3xjMkcOfdGi+ifDNkhAWMQlRCtcut
         E+kA==
X-Gm-Message-State: ACrzQf26t2vp9VrjHqQEKBJvUFT4waQVcdiwlNH+vU7j9T1dqw6AIOjW
        f5fuvyaimZyXKdNhmNU3vNM=
X-Google-Smtp-Source: AMsMyM4jFu/KytAdYQKVUma6k3L7U3Vgc2mj0hUp08Ns2veNAewKttBuNZLs9d1DH1nAwCBbGSxb9g==
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id h17-20020a05640250d100b00452899e077cmr1348375edb.0.1663273797603;
        Thu, 15 Sep 2022 13:29:57 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id ci25-20020a170906c35900b0072b3406e9c2sm9607295ejb.95.2022.09.15.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 13:29:57 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH 2/5] staging: vt6655: change vnt_receive_frame return type to void
Date:   Thu, 15 Sep 2022 22:29:33 +0200
Message-Id: <f727ea04703858920f6da694676ec323469e7b97.1663273218.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663273218.git.namcaov@gmail.com>
References: <cover.1663273218.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vnt_receive_frame's returned value is not used anywhere.
Furthermore, it always return true. Change its return type to void.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/dpc.c | 8 ++++----
 drivers/staging/vt6655/dpc.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index c6ed3537f439..9f2128f5d3c3 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -115,7 +115,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 	return true;
 }
 
-bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
+void vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
 {
 	struct vnt_rd_info *rd_info = curr_rd->rd_info;
 	struct sk_buff *skb;
@@ -133,13 +133,13 @@ bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
 		/* Frame Size error drop this packet.*/
 		dev_dbg(&priv->pcid->dev, "Wrong frame size %d\n", frame_size);
 		dev_kfree_skb_irq(skb);
-		return true;
+		return;
 	}
 
 	if (vnt_rx_data(priv, skb, frame_size))
-		return true;
+		return;
 
 	dev_kfree_skb_irq(skb);
 
-	return true;
+	return;
 }
diff --git a/drivers/staging/vt6655/dpc.h b/drivers/staging/vt6655/dpc.h
index 40364c0ab7f6..f67c1ef23171 100644
--- a/drivers/staging/vt6655/dpc.h
+++ b/drivers/staging/vt6655/dpc.h
@@ -16,6 +16,6 @@
 
 #include "device.h"
 
-bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd);
+void vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd);
 
 #endif /* __RXTX_H__ */
-- 
2.25.1

