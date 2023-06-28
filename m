Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81957740B91
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjF1Ick (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjF1IaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:30:15 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC144AF;
        Wed, 28 Jun 2023 01:22:53 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4008d810c28so41011121cf.3;
        Wed, 28 Jun 2023 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687940572; x=1690532572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AfH/3M1MI/78IiqObqTGPZhCo/6frficXtfBUG01mvM=;
        b=JG8Ln/xENQUAhg5pM/bBg3Xc2mKBHBbInlZWJjKYqrdi/vhoN7Yc2ac0oMPhRBoJ7W
         yRfcOFVTKwZitqJhkPKEA6kcwARHC6BtYt+m6FBJLxjhLjnhmxFJ5GzfOSexVyuFqLvm
         v0pJdJIkobDHoRn190KwAcgmwqS+4cpj+RoEhXO8SZPuEa0ZWgpvQh0VsymIr/GbM91z
         +J7nDuXydrnaT23ivsHkA+zyHa6Q4ux6lUhspsk1lCaVV8T3zYSjnPjE2rsWEWDs4D5m
         Yi7VxfWGKXJgD3GJJbXUF9+K6Lrysp57F8Hh54sojCikfABGHG5luxlH6rV1OshMcYUr
         +Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940572; x=1690532572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfH/3M1MI/78IiqObqTGPZhCo/6frficXtfBUG01mvM=;
        b=EGoMKNRH0QWKukjoX1VV5tf3qbOMnUIoHeunLO+9cVlFhMlKSHmto6fwy56neM4uRd
         U2cUu25qITFgItrzxMRIOkwxoBVWclp6YybrmYLx3H4gDAtlDb7fU3ZszIjO0uTrCjoe
         HFvruudT9lTMd6fDwmtfdXH48NPsAMlXL2Vw3i7EYA/vsKWxXRoQudC7aCvayzy6Fo/7
         1pQAEsSEP/bl450nCVkoY0hnPxrRoPe8N8YzWTy2WjZ2Ow6dtQBOxDnkmNXKoCzVCHj2
         09vAROhP+M34/mBvvxXf4gc0BQl1G2UHxfmorX1ntUasFR/36ty0qf7EhUR3OV+L2vLa
         B+Tw==
X-Gm-Message-State: AC+VfDwpC5mwtGm+Jtu3pNZecMRITi5L8J/52hRdQFKYP+VokwDJYy5x
        JPsrXgCsXg6mbHvRy8AinHGBs3jofU5NfQ==
X-Google-Smtp-Source: ACHHUZ5pnQDNTECdgISJR0kDPKbUH3W5ZvqVvA3k0m/h+QnyvBTCn6jGI4qFNZv97UUyufGDuQIJTg==
X-Received: by 2002:a05:6a21:7881:b0:121:ef3f:ed0b with SMTP id bf1-20020a056a21788100b00121ef3fed0bmr24448649pzc.60.1687936831745;
        Wed, 28 Jun 2023 00:20:31 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id l187-20020a6391c4000000b00543b4433aa9sm6924313pge.36.2023.06.28.00.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 00:20:31 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] media: bt8xx: Fix a possible data race in buffer_queue()
Date:   Wed, 28 Jun 2023 15:19:51 +0800
Message-Id: <20230628071951.1011421-1-islituo@gmail.com>
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

The variable btv->loop_irq is often protected by the lock btv->s_lock when
is accessed. Here is an example in bttv_irq_timeout():

  spin_lock_irqsave(&btv->s_lock,flags); 
  ...
  btv->loop_irq = 0;
  ...
  spin_unlock_irqrestore(&btv->s_lock,flags);

However, it is accessed without holding the lock btv->s_lock in 
buffer_queue():

  btv->loop_irq |= 1;

And thus a data race can occur.
To fix this possible data race, a lock and unlock pair is added when
accessing the variable btv->loop_irq in buffer_queue().

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/media/pci/bt8xx/bttv-driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 734f02b91aa3..241c51951627 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -1617,13 +1617,16 @@ buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
 	struct bttv_fh *fh = q->priv_data;
 	struct bttv    *btv = fh->btv;
+	unsigned long flags;
 
+	spin_lock_irqsave(&btv->s_lock,flags);
 	buf->vb.state = VIDEOBUF_QUEUED;
 	list_add_tail(&buf->vb.queue,&btv->capture);
 	if (!btv->curr.frame_irq) {
 		btv->loop_irq |= 1;
 		bttv_set_dma(btv, 0x03);
 	}
+	spin_unlock_irqrestore(&btv->s_lock,flags);
 }
 
 static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
-- 
2.34.1

