Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD27740845
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjF1CWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjF1CV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:21:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E411FC1;
        Tue, 27 Jun 2023 19:21:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b51488ad67so28962145ad.3;
        Tue, 27 Jun 2023 19:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687918907; x=1690510907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6pki8IEhRMBJIPFkBySip5mXparEvV54SUuzJnRAiY=;
        b=DIuY3LeaXqAs0U5LXmV819WFNCPWVfpcBqzfshj256tQN1iF1vPKiVqskOC/sjPAXZ
         aNyN0D4YaSM27j7WK96wpJqaq07OjglkeVKSHbPdk/iItS4drvRdGfNSx1q8EqbqY3az
         CWVUH9psLGTdvmPdAO5yXBUtMEYGdRP+acPSBa7aN4eWbq53z9+ZLKr96V3+QhD+1Om2
         VrTYqWrNDAQnvg8Ppn7OoSNQnHlQzBsmbKxzAd7h8Pcjm8uMGnDRzjni2gie4DD66l7d
         jP4qfs8e0HTYJX4xFPL2e7SpS9zsfTorLdGKYJYm96kKS/CD7X5QUTll+VlVRvpbPyGw
         MxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687918907; x=1690510907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6pki8IEhRMBJIPFkBySip5mXparEvV54SUuzJnRAiY=;
        b=CSRfonkmUP7GcCeHYuRAEeXaNw5PljV96jhE03cXpz3pfaJZXgntieO79TkllCAlkU
         P0fo06UAFmxuOOG0KdJTqGritrEHOwHTajE2WP0JYgB2IbBNt7iWLbRsmt41Iga+lIVc
         AC64owU/hPnPvrwkTZnpGvnMX4yZoQZCy7gfysAyfQlJglRRAdSM7e8dmtxVsskwDQgD
         XvsOZ6w9nvTj/xK0zZ9qz8zZH7KruEq7D9wCWHcJl7YTHhn2ecB0TjvY0SIKhbfKv+w0
         PWfONLhKLqN2XviE2KQuULBJC6wNlDDz+T0AnTEHmy/GT1HZdvJnDCNHd8E6n3NdHhjG
         TnyQ==
X-Gm-Message-State: AC+VfDzQi8taEz8K/Z+QSOnXVgsSd2cgyblhQDD0Y/Ec/vTqO4AE9ioW
        kBpOQmrm0aur+2LO2D6hnN4=
X-Google-Smtp-Source: ACHHUZ74WhaD5KRSqRGNyvV5e8E8Fau6Z6n7lMPTOq0xCfn7v55QJkKgM6YpSe6w6orzoIoJeC5qfQ==
X-Received: by 2002:a17:902:7402:b0:1b3:9d13:34b3 with SMTP id g2-20020a170902740200b001b39d1334b3mr9116715pll.37.1687918906781;
        Tue, 27 Jun 2023 19:21:46 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902968200b001b7cbc5871csm1822165plp.53.2023.06.27.19.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 19:21:46 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     srini.raju@purelifi.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] wifi: plfxlc: Fix possible data races in rx_urb_complete()
Date:   Wed, 28 Jun 2023 10:21:21 +0800
Message-Id: <20230628022121.1010517-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The variable tx->submitted_urbs is often protected by the lock tx->lock 
when is accessed. Here is an example in plfxlc_usb_disable_tx():

  spin_lock_irqsave(&tx->lock, flags);
  WARN_ON(!skb_queue_empty(&tx->submitted_skbs));
  WARN_ON(tx->submitted_urbs != 0);
  tx->submitted_urbs = 0;
  spin_unlock_irqrestore(&tx->lock, flags);

However, it is accessed without holding the lock tx->lock in 
rx_urb_complete():

  if (tx->submitted_urbs++ < PURELIFI_URB_RETRY_MAX)  --> Line 108
  tx->submitted_urbs++  --> Line 110
  tx->submitted_urbs = 0  --> Line 114

And thus data races can occur.
To fix these possible data races, a lock and unlock pair is added when
accessing the variable tx->submitted_urbs in rx_urb_complete().

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/net/wireless/purelifi/plfxlc/usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 76d0a778636a..44152a615c0e 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -69,6 +69,7 @@ static void handle_rx_packet(struct plfxlc_usb *usb, const u8 *buffer,
 static void rx_urb_complete(struct urb *urb)
 {
 	struct plfxlc_usb_tx *tx;
+	unsigned long flags;
 	struct plfxlc_usb *usb;
 	unsigned int length;
 	const u8 *buffer;
@@ -105,13 +106,16 @@ static void rx_urb_complete(struct urb *urb)
 		return;
 	default:
 		dev_dbg(plfxlc_urb_dev(urb), "urb %p error %d\n", urb, urb->status);
+		spin_lock_irqsave(&tx->lock, flags);
 		if (tx->submitted_urbs++ < PURELIFI_URB_RETRY_MAX) {
 			dev_dbg(plfxlc_urb_dev(urb), "urb %p resubmit %d", urb,
 				tx->submitted_urbs++);
+			spin_unlock_irqrestore(&tx->lock, flags);
 			goto resubmit;
 		} else {
 			dev_dbg(plfxlc_urb_dev(urb), "urb %p  max resubmits reached", urb);
 			tx->submitted_urbs = 0;
+			spin_unlock_irqrestore(&tx->lock, flags);
 			return;
 		}
 	}
-- 
2.34.1

