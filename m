Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D267DE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjA0HV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjA0HVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:21:25 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07445F7D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:21:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s3so2687453pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmGBuaaFya9fjHaVRkQi3+t1kboL7BgR1HMtnCvIs5I=;
        b=jnxfpJD9Clo4XLoau4e23z5SVJasEcc3aO3xweIPWwSVDe58fuu9GQZ1/fFdr0ffvQ
         9842PFs+1UW9Ham8Dkbke4DND+J03w4W5QDJHqv6tVh83xQ1CYfTQRBGaQbezg12OzXJ
         CbInCQuQkIbkz7A0lfRJhLxqrkNuRmOeW5n4TiaDB58WsT4FED/Fl/klEVvTBdRwbISS
         JAT0fyUTj4+JfqxMn/MJqP6dFZMTjfZzM9EiKnHoWPMoiQTSfLOxFjVRdA1akbrLbZU8
         wYQimvwf9w620R3ZKMGN3MQ6zeUwLFnJaDPtmDYi6tvlvdZZD6Qt1vKuBviuzUOR0V7W
         gfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmGBuaaFya9fjHaVRkQi3+t1kboL7BgR1HMtnCvIs5I=;
        b=J2ZcXHA9ltIKapx+iUcZZQ8pq0PfgL7nSQm+negYMs/IIAPo+bR+emiHHoWO1iYZkh
         t1D8wAAjyryMp5599eoBqkPa2OIEukLBwAio9xyKB2LGHtugQMemSQFF/SLSCONzKru2
         fX5NFD/RNwB/cv6HnQ1l/Tb4ZW9CIjbRC3CDDMSy/S+UMwRRCDPxfCmcGasNhw8ukml4
         BGB/To8lZLTZcJ4zRTMjrPRJOjBZv8Nf9EUgoX+ib/+aRT1Jt2mcATmxcEBd51+ERNeY
         0wSapOlV3broG1icTPjHD9d2g2YzbwPCYvctCkKrL0T1qG1md8I5GLoGqIzCNfRE/YJQ
         CApw==
X-Gm-Message-State: AFqh2kp37wa29fEC7t7EF8mMOFF14hiKceZABqXbUdZK7pKm+1/a9oZU
        KmR2cUQ2droADxcG+ucTsR41i88e92Y=
X-Google-Smtp-Source: AMrXdXvrGJrvzKxl3yzhD5BTewXSX9uFJxhksE+xaDNzp52WY+SJAgX0L0ISf2v+zAojpVS47jcADw==
X-Received: by 2002:a05:6a00:2147:b0:58d:e2b0:e480 with SMTP id o7-20020a056a00214700b0058de2b0e480mr29954790pfk.17.1674804084338;
        Thu, 26 Jan 2023 23:21:24 -0800 (PST)
Received: from localhost.localdomain ([102.140.88.94])
        by smtp.gmail.com with ESMTPSA id s23-20020a056a00179700b0058a0e61136asm1974296pfg.66.2023.01.26.23.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 23:21:23 -0800 (PST)
From:   Yan Cangang <nalanzeyu@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yan Cangang <nalanzeyu@gmail.com>
Subject: [PATCH] tty:pty: move wake_up*() after tty_vhangup() in pty_close()
Date:   Fri, 27 Jan 2023 15:20:17 +0800
Message-Id: <20230127072017.2146403-1-nalanzeyu@gmail.com>
X-Mailer: git-send-email 2.30.2
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

wake_up_interruptible() may wake up the session leader blocked on pts, at
this time the tty_signal_session_leader() in __tty_hangup() has not been
executed.

The session leader's subsequent IO on pts will fail, but the session
leader did not received SIGHUP as expected at this time.

A observed phenomenon is that when the ssh connection is disconnected, the
background jobs managed by bash did not terminate as expected. This
problem is more easily observed on low-end single-processor systems.

Signed-off-by: Yan Cangang <nalanzeyu@gmail.com>
---
 drivers/tty/pty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 07394fdaf522..fbcf2caa8fc1 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -64,8 +64,6 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 	if (!tty->link)
 		return;
 	set_bit(TTY_OTHER_CLOSED, &tty->link->flags);
-	wake_up_interruptible(&tty->link->read_wait);
-	wake_up_interruptible(&tty->link->write_wait);
 	if (tty->driver->subtype == PTY_TYPE_MASTER) {
 		set_bit(TTY_OTHER_CLOSED, &tty->flags);
 #ifdef CONFIG_UNIX98_PTYS
@@ -78,6 +76,8 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 #endif
 		tty_vhangup(tty->link);
 	}
+	wake_up_interruptible(&tty->link->read_wait);
+	wake_up_interruptible(&tty->link->write_wait);
 }
 
 /*
-- 
2.30.2

