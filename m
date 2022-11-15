Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6779662A07D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiKORil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKORii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:38:38 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D387A44B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:38:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d192so1622931pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjjpop0ABTUK8wEWWnJsGnFMFsvrpAwv9BKAttU+K1w=;
        b=4se8itCtUZHM27ehLWS8uQVxC9Qp4SBwom3Hg5S7Nkox0T6gAnbcCVhzrzqN7ajPLC
         DOLyoVvMySvieVzCKjiFKLEdzF7GLUdq6uMXBEtqtYmYf0Dd/ysSomr0AarYDsFmZAct
         69Zh1SuSgTGz32uX18mAOYdEVuT2XxGimY5aXiMtWvqoaSA6eO4ypVGgOE36uJvvbrn2
         kYIfg8sswL4Z9KnHVdq0vbAqJkzUvm/CzKMR7ct/LWKKI/U+vi+CdxpgD7YBepN3Nv5x
         XLkII+cgzxBZ1PZEEw9W0Q8TVlTWnxzc2lG3MGwM+pEueO7s92bAYwU6dUaDF5reg4bV
         XKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjjpop0ABTUK8wEWWnJsGnFMFsvrpAwv9BKAttU+K1w=;
        b=N6QBG7GIXb78TPkfszvYWDrLal58Az6PVTPqcjrPbHHgs+FHcGGjJRVzXZFOPqEpha
         AlL9q3BrXGWpASvuIXxSEDhw+yFv+Emm0ixkeocW6FWJgj9VJOVovfZd2PwQyW2fRMaR
         h7iLxF3EWB/WgXPcbbQTe8VB47NfSwlXroZtjuuQpKcFjfBgdUuXpZnB1IPz61foQxDg
         Vq7HlAUuERfCHc2/4hm8Y2prF2WAfTqDk780RT23PlZ+bfGpONYk/ej+Bk1maycg6H1t
         AhbS5tyGZqstAUNrJYHpsQd/+cBtZG9QVqF0ceHWXfjlXF8AST9smJP4rcKcyT4m8VwB
         FL6g==
X-Gm-Message-State: ANoB5pkH7hHZt8kYMmTwR6gbYWoQ2K2d4CDBAdf9MzQp7f1Z/wx310/H
        SlxWJVRBpZUvGOz0b7muxQOz0A==
X-Google-Smtp-Source: AA0mqf41pnTmMbl2CTDOsIxLREUdqTWPm7lk+oSQXUqOsLFrit1Trk9HoZstF+TxZqUMa5DA020sMA==
X-Received: by 2002:a63:a512:0:b0:439:8dd3:c3c2 with SMTP id n18-20020a63a512000000b004398dd3c3c2mr16666204pgf.481.1668533913691;
        Tue, 15 Nov 2022 09:38:33 -0800 (PST)
Received: from smtpclient.apple (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id s34-20020a635262000000b0042988a04bfdsm8052345pgl.9.2022.11.15.09.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:38:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: [PATCH] tty: synclink_gt: unwind actions in error path of net device
 open
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <Y3PIA04FCxqv3eKn@kroah.com>
Date:   Tue, 15 Nov 2022 09:38:32 -0800
Cc:     Zhengchao Shao <shaozhengchao@huawei.com>,
        "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        akpm@linux-foundation.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7599F007-8985-4469-BE00-52BD1530210E@microgate.com>
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
 <4DFE07D7-B041-4C1C-8182-020066D4A5C2@microgate.com>
 <387F9F7B-C3AF-45BF-94ED-59348990B407@microgate.com>
 <Y3PIA04FCxqv3eKn@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resent again, last attempt still altered the plain text.


Zhengchao Shao <shaozhengchao@huawei.com> identified by inspection bugs =
in the error path of hdlcdev_open() in synclink_gt.c

The function did not fully unwind actions in the error path. The use of =
try_module_get()/module_put() is unnecessary, potentially hazardous and =
is removed. The synclink_gt driver is already pinned any point the net =
device is registered, a requirement for calling this entry point.

The call hdlc_open() to init the generic HDLC layer is moved to after =
driver level init/checks and proper rollback of previous actions is =
added. This is a more sensible ordering as the most common error paths =
are at the driver level and the driver level rollbacks require less =
processing than hdlc_open()/hdlc_close().

This has been tested with supported hardware.

Signed-off-by:Paul Fulghum <paulkf@microgate.com>

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 25e9befdda3a..72b76cdde534 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1433,16 +1433,8 @@ static int hdlcdev_open(struct net_device *dev)
 	int rc;
 	unsigned long flags;
=20
-	if (!try_module_get(THIS_MODULE))
-		return -EBUSY;
-
 	DBGINFO(("%s hdlcdev_open\n", dev->name));
=20
-	/* generic HDLC layer open processing */
-	rc =3D hdlc_open(dev);
-	if (rc)
-		return rc;
-
 	/* arbitrate between network and tty opens */
 	spin_lock_irqsave(&info->netlock, flags);
 	if (info->port.count !=3D 0 || info->netcount !=3D 0) {
@@ -1461,6 +1453,16 @@ static int hdlcdev_open(struct net_device *dev)
 		return rc;
 	}
=20
+	/* generic HDLC layer open processing */
+	rc =3D hdlc_open(dev);
+	if (rc) {
+		shutdown(info);
+		spin_lock_irqsave(&info->netlock, flags);
+		info->netcount =3D 0;
+		spin_unlock_irqrestore(&info->netlock, flags);
+		return rc;
+	}
+
 	/* assert RTS and DTR, apply hardware settings */
 	info->signals |=3D SerialSignal_RTS | SerialSignal_DTR;
 	program_hw(info);
@@ -1506,7 +1508,6 @@ static int hdlcdev_close(struct net_device *dev)
 	info->netcount=3D0;
 	spin_unlock_irqrestore(&info->netlock, flags);
=20
-	module_put(THIS_MODULE);
 	return 0;
 }
=20

