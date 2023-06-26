Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDC73DA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFZIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjFZIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:44:01 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B341A6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:43:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4008d810c28so21475431cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687769038; x=1690361038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3P9OZJWzMEw+HCOB/2/9OKBcaBnbB33CMEBt6EtuOg=;
        b=NzJLbmTbs2cRWIXCuozi6jBQ2e1FyIyN0caD6N25S24shFOJHBMhlFPvmJrLxrTl+w
         BIpxU78dMHsLwl25CQo9g8xyyHZ/hT7PNdzx2ljIgjwfhdbPuZUJVwF+5c/X7/Wo/u3w
         4XVzj5LLV1s3POGgMEDzyn9ChPZ7gpvV+grYOMblm9286TplG2iXydjQRX04F5EjDoa7
         YrBvOjNCvPmRDqsR4zYZHa7BXMdLbkOrUFeaajWb1sEKxStKEwvaOd/M+q8BOVMDHdDF
         zNzxm0WpEuBjQ/WDkMlEV+krYm4EMcnAbK/NkIEc1M08PNH0ta/rNTmcfXCM3OKJXNO3
         QEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687769038; x=1690361038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3P9OZJWzMEw+HCOB/2/9OKBcaBnbB33CMEBt6EtuOg=;
        b=UGzjpbc7wcZrWN3J5HLZpIG5TxfQvkIF4qJL8R34iTdgYVJvw+qIB29MHoq6Zszf+B
         fRyUnZeeIM653K8zZzeygxj1JB+w+yGRnUnKlYj8NwYlKaQhnSxlImTQ4CmB4uP0LWT9
         Izl0c4gtZG0VvzIIMEgWtBm9AI4P0OTSEX9p9HC/JM7WAtY4LaytehADAs2TK+h5Sx/P
         SI9i2IyPciX9nG7XOC7u62bpid7dzIEsu9y+DDJX8rM4e15gh6rSWEtH7CKH7Q67/N6i
         FrFTVdhaf2++OjAkm5bG9uPXfWDBNs7R9x5DN89aaFnBDv7HFGw6Fg4eZasphzjxTTtk
         2gzg==
X-Gm-Message-State: AC+VfDwULFDz1ha0bf7y/LZA9rpdnCkZ8JQKyhDB/oax6XKwmHqShcZB
        VcPSN4VvKDOkl3yepOlsftI=
X-Google-Smtp-Source: ACHHUZ4+iTkBcVtKyis5jDcOlnkP7phLAgP0DEhfbF/w8zPszMxagkPQM8MT14U670wv27ZToEgmHA==
X-Received: by 2002:a05:622a:20f:b0:3f9:c539:c9d5 with SMTP id b15-20020a05622a020f00b003f9c539c9d5mr36477606qtx.68.1687769037696;
        Mon, 26 Jun 2023 01:43:57 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id m23-20020aa78a17000000b0066a67637cfasm3340667pfa.26.2023.06.26.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:43:57 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] staging: greybus: fix a possible data-inconsistency due to data race in get_serial_info()
Date:   Mon, 26 Jun 2023 16:43:39 +0800
Message-Id: <20230626084339.998784-1-islituo@gmail.com>
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

The variables gb_tty->port.close_delay and gb_tty->port.closing_wait are
ofter accessed together while holding the lock gb_tty->port.mutex. Here is 
an example in set_serial_info():

  mutex_lock(&gb_tty->port.mutex);
  ...
  gb_tty->port.close_delay = close_delay;
  gb_tty->port.closing_wait = closing_wait;
  ...
  mutex_unlock(&gb_tty->port.mutex);

However, they are accessed without holding the lock gb_tty->port.mutex when
are accessed in get_serial_info():

  ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
  ss->closing_wait =
    gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
	ASYNC_CLOSING_WAIT_NONE :
	jiffies_to_msecs(gb_tty->port.closing_wait) / 10;

In my opinion, this may be a harmful race, because ss->close_delay can be
inconsistent with ss->closing_wait if gb_tty->port.close_delay and 
gb_tty->port.closing_wait are updated by another thread after the 
assignment to ss->close_delay.
Besides, the select operator may return wrong value if 
gb_tty->port.closing_wait is updated right after the condition is 
calculated.

To fix this possible data-inconsistency caused by data race, a lock and 
unlock pair is added when accessing different fields of gb_tty->port.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/staging/greybus/uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 20a34599859f..b8875517ea6a 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -596,12 +596,14 @@ static int get_serial_info(struct tty_struct *tty,
 {
 	struct gb_tty *gb_tty = tty->driver_data;
 
+	mutex_lock(&gb_tty->port.mutex);
 	ss->line = gb_tty->minor;
 	ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
 	ss->closing_wait =
 		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 		ASYNC_CLOSING_WAIT_NONE :
 		jiffies_to_msecs(gb_tty->port.closing_wait) / 10;
+	mutex_unlock(&gb_tty->port.mutex);
 
 	return 0;
 }
-- 
2.34.1

