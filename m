Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68CE65ACB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 02:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjABBFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 20:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjABBFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 20:05:35 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49181130;
        Sun,  1 Jan 2023 17:05:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c9so12933777pfj.5;
        Sun, 01 Jan 2023 17:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYBKKC/jPoqul56NsIbpe8i4DLoSimJ5/S9jG+9Ahpc=;
        b=AUorMnWK23C8aMm/iw65ya4Uuj47/wFDYMOSZ9TnCrAm4EvbNmeMiuiEGXA4hfUNTh
         iuzgGcZqODJm6icBEICPrcPsQzUCUjaSWSTpRxpW9U0el/at1f/Zf7c/edT8WoAraJ67
         90K6xTsYHS0JPHBIN82imR/5mCsoPoUwYxbMf2JL71IpG0wZegg+cBjCHURKbbkM6VVD
         /tayZaOSXN6Mjy3JWBKttf9hS8nGiSLvGRIKV+3G2M9mW+t7mUvrf3RY6mQJDlIMDc9d
         ZFD71mKMQREJcWWROwBcEgCuAMW9OhUhnKVUpTm3L0t/g38JTACHHifq9YaPYD3sVUWg
         bipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYBKKC/jPoqul56NsIbpe8i4DLoSimJ5/S9jG+9Ahpc=;
        b=lDesD1+ckus9lNeUcP0d6WTMut6VFtav1YcKJ3RUz1V54MknvYKMKIdegrn1HXF0an
         iWHTmI+wyi6suwONNwa8bprTnWtHTNZHayu+8JW2eGolUlSk9xhkVjNFcYWDjyujeImz
         i+omxi9nJw+eGz+TEewGxhOPgZPxpTsYESOLyOCdPxvcIPx11eTWIBYIw2RUcqiutsPq
         qvz2i194qwLupPAT2kF2GXSCviLuQ8blwFtZeZhRxnNfaCxy2gUx+GDbDw83gMfEOWld
         Dxa6fMvEMzKfpEUIUnNQNX8IDQ9pxanoQlf+N37fReBETo6CYjTxd2xcE7qv8LcZKFew
         fHCg==
X-Gm-Message-State: AFqh2kovIafHqtySd8qOln+QRhV3v6wITucbA9ES4kVX1/Y2cMYGk0iK
        Bj6u1PYUhR3lIro0eyjVecCWRLzw+0HevQ==
X-Google-Smtp-Source: AMrXdXu2gXkwcqq6IDK0l9bkYLffunlQ9x+AKoW1upzpobTcnMbeUV+5/52lzNDPyi5AtpA4sVBeBw==
X-Received: by 2002:a05:6a00:21c6:b0:576:a74a:13c3 with SMTP id t6-20020a056a0021c600b00576a74a13c3mr51258932pfj.1.1672621534250;
        Sun, 01 Jan 2023 17:05:34 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id 12-20020a62170c000000b005769436a23dsm17229409pfx.218.2023.01.01.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 17:05:33 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] drivers: tty: vcc: Fix use-after-free in vcc_open()
Date:   Mon,  2 Jan 2023 10:05:28 +0900
Message-Id: <20230102010528.2868403-1-yoochan1026@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug assumes that the hacker can physically access the
target computer.

A race condition may occur if the user physically removes the
vcc device while calling open().

This is a race condition between vcc_open() function and
the vcc_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to vcc_remove() function
to free the "vcc_port" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
            vcc_open()        |        vcc_remove()
--------------------------------------------------------------
    port = vcc_get_ne(tty->   |
      index); — (1)           |
                              |   struct vcc_port *port =
                              |    dev_get_drvdata(&vdev->dev);
                              |   ...
                              |   kfree(port); — (2)
 vccdbgl(port->vio.lp); — (3) |

This type of race condition is similar with CVE-2022-44032,
CVE-2022-44033, and CVE-2022-44034.
---
 drivers/tty/vcc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 34ba6e54789a..31f274c4aa25 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -41,6 +41,8 @@ struct vcc_port {
 
 	struct timer_list rx_timer;
 	struct timer_list tx_timer;
+	struct vio_dev *vdev;
+	struct kref refcnt;
 };
 
 /* Microseconds that thread will delay waiting for a vcc port ref */
@@ -104,6 +106,7 @@ static const struct ktermios vcc_tty_termios = {
 	.c_ospeed = 38400
 };
 
+static void vcc_delete(struct kref *kref);
 /**
  * vcc_table_add() - Add VCC port to the VCC table
  * @port: pointer to the VCC port
@@ -586,6 +589,8 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto free_port;
 
 	port->vio.debug = vcc_dbg_vio;
+	port->vdev = vdev;
+	kref_init(&port->refcnt);
 	vcc_ldc_cfg.debug = vcc_dbg_ldc;
 
 	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
@@ -673,6 +678,14 @@ static void vcc_remove(struct vio_dev *vdev)
 {
 	struct vcc_port *port = dev_get_drvdata(&vdev->dev);
 
+	kref_put(&port->refcnt, vcc_delete);
+}
+
+static void vcc_delete(struct kref *kref)
+{
+	struct vcc_port *port = container_of(kref, struct vcc_port, refcnt);
+	struct viod_dev *vdev = port->vdev;
+
 	del_timer_sync(&port->rx_timer);
 	del_timer_sync(&port->tx_timer);
 
@@ -752,12 +765,15 @@ static int vcc_open(struct tty_struct *tty, struct file *vcc_file)
 		pr_err("VCC: open: TTY ops not defined\n");
 		return -ENXIO;
 	}
+	kref_get(&port->refcnt);
 
 	return tty_port_open(tty->port, tty, vcc_file);
 }
 
 static void vcc_close(struct tty_struct *tty, struct file *vcc_file)
 {
+	struct vcc_port *port = vcc_get_ne(tty->index);
+
 	if (unlikely(tty->count > 1))
 		return;
 
@@ -767,6 +783,8 @@ static void vcc_close(struct tty_struct *tty, struct file *vcc_file)
 	}
 
 	tty_port_close(tty->port, tty, vcc_file);
+
+	kref_put(&port->refcnt, vcc_delete);
 }
 
 static void vcc_ldc_hup(struct vcc_port *port)
-- 
2.39.0

