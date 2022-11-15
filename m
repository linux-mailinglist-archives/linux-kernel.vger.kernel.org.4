Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739B862A017
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiKORSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiKORSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:18:44 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE11177
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:18:43 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b29so14678841pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbvf8JuLv1wMhwhAEgB+CL5cUC6ypqc3XxatSCjumxA=;
        b=Qq5DRXeKk+Dfehs+QKh25gjeGXgZzP5u9Yrl0rzdJKr++GmRe+BW9uv9PknwgYq+wN
         lmsss78JaTx2k62G2wWPZKR1mwDFZC1TrBUT4LYTtYGpNm/9hMSXXn69pyHQCKrzbdmI
         ILPZM1BueXlqjz2yGF5b022O7pZFVtWev3i9+ixqpaS6lV6Id7ELvKpMXcGutc49zNId
         8MqPLA1GSkDi7dnBbYrTjlNe5Dx2fDH7M4KKfbGIq+HDlDddoZ9IhmjP8iijkuN+4+pZ
         KCpobaErf399Lzj2NEdZifdcDeNxCQdLcoHutGqDbLHFigjFqOQeZKVDB8xaapFUnrtA
         54pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gbvf8JuLv1wMhwhAEgB+CL5cUC6ypqc3XxatSCjumxA=;
        b=czklH/xD7Wzwl4wFqqroXUyo+ZnmtmIcvpN/uyCv7iSok/KDZUNmqh7w6sk+cGRlKM
         DSiLhjGEyovpEsK6Z0S9bGFMSKM2Z4szpPJAzxPGW48yVRjoFiFurFfWKJN/7q5PiMau
         PooPimfzo9YseypcM9YjP6EUF4CkCckrV77VwFSyKOLh9rl7Z9HGiwRacUMGqkdZEPID
         xWYzw5IH5xuo9PIsvW71/AtakgdC386Qk7mq/UE/qNQPup4sgHEsgZAKueArGI2mAmle
         nfxB45OjAn6j1cDunDxfL8Pcbfz0tpBlo1wpBgxDZKVvmXzGKIkdRnbtr7UmL86EGAgk
         3OAg==
X-Gm-Message-State: ANoB5pnJkyIHgFZMczuWORyiarOTLeSjQwFcTZqk/7kO9fqi74eBD6Vd
        31vwjEKUogNC8Rsh7G37JtJWtA==
X-Google-Smtp-Source: AA0mqf6CXttmjL0njM00T/oqWm5aHwTxcAuzjGT2/sUoJtNLZ/71IsWLwMnAV4ZoYdw5tH0YWHbxyQ==
X-Received: by 2002:a05:6a00:1bc3:b0:572:698b:5fa9 with SMTP id o3-20020a056a001bc300b00572698b5fa9mr4548976pfw.28.1668532722752;
        Tue, 15 Nov 2022 09:18:42 -0800 (PST)
Received: from smtpclient.apple (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b0018862bb3976sm10254235plx.308.2022.11.15.09.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:18:42 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: [PATCH] tty: synclink_gt: unwind actions in error path of net device
 open
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <387F9F7B-C3AF-45BF-94ED-59348990B407@microgate.com>
Date:   Tue, 15 Nov 2022 09:18:41 -0800
Cc:     "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, akpm@linux-foundation.org,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2A8DDC3-9D72-4CDD-92A0-2C27146C1BE0@microgate.com>
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
 <4DFE07D7-B041-4C1C-8182-020066D4A5C2@microgate.com>
 <387F9F7B-C3AF-45BF-94ED-59348990B407@microgate.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resent in plain text, sorry for the previous HTML.

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

