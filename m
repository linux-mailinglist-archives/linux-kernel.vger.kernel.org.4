Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80B74CDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGJHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:08:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBDE9;
        Mon, 10 Jul 2023 00:08:37 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38e04d1b2b4so3186606b6e.3;
        Mon, 10 Jul 2023 00:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688972916; x=1691564916;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRffpOTNrk7dJQa/vcMl/GzDO2mvO/jwkJDpoRGjyYk=;
        b=KD8Qgv1BeZ8e6crtV/35C0AWOe4D0LXeKO8bJUZ3P7IFenhEOvAsQrO9O7pqTKBikJ
         CLHfwxXs795UKuWRvxBtlKdhiywPk6DcbGf23fTj4We+i81UwIF3bLl8WYy3GUlexxx6
         60NLqNTNQVWCxyhNgYxkTjraRJMPGiukIoH9KihTikwP9aPsecE0l2/BXIp8xDhqrRYf
         zCK/RNCMLoZkZLo5+cVhJTsIoMSkNdfRYKYHNK29CfMQkPHUQoWrV0LGqjHj0bFPm+QP
         mbE/BUNFHTobSrkaKCGpTniEIkmWoHiE+w1NIeO+CchhFtc1AV658nL1jxtqnsiYfGIm
         HtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688972916; x=1691564916;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRffpOTNrk7dJQa/vcMl/GzDO2mvO/jwkJDpoRGjyYk=;
        b=YMbj9bDukFqUhMbHnwy98uJ6MBkRp5V6+yB0j8gVUoFyygGTXMno/aBW242QHwFz4T
         LsOZ9m/HrVbOREEmGDXcFpZZZsU7GancKIGi7i3oq80oid7nr1qmcTT5FO7oZggRPId5
         Wb/VZ7fdgt6jmfQ369RnygvuXq2m+z9uDA9U3LnIOUJHeFLao2Zf5xkPlp1+u07MY64v
         bC+Zj/D/MrsiYnGx5ipyIR1DSuHgSRQPvC0Zm/JSULho8tX80NZyzUx8P9rprgRq17D0
         09+G2ebOtOUDUO+wPZQRvMzUcxs312TqKr20jW7Y3u/hC/u25ErBw1nsRici0Jzw8PLJ
         qimA==
X-Gm-Message-State: ABy/qLYeCZb4aLUJPmNRAKJZdUXJM6uJD74OQ7CyQez3qcpQqVd1/fWH
        LrurqDLqiJrAKEkl32joJqU=
X-Google-Smtp-Source: APBJJlGp8Q/DJY3BU7LHF5D9EuLW6pEQZpxwfdc0Msg8NYZhJNEVVbTzRjAOfBARd9hr9Rn4jAhYEQ==
X-Received: by 2002:a05:6808:1190:b0:3a3:f45b:aa5f with SMTP id j16-20020a056808119000b003a3f45baa5fmr6107983oil.52.1688972916400;
        Mon, 10 Jul 2023 00:08:36 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id i190-20020a639dc7000000b0055c4c9cc013sm1207925pgd.49.2023.07.10.00.08.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:08:36 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Hao <yhao016@ucr.edu>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH] Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
Date:   Mon, 10 Jul 2023 15:07:45 +0800
Message-Id: <20230710070745.5505-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to check HCI_UART_PROTO_READY flag before
accessing hci_uart->proto. It fixs the race condition in
hci_uart_tty_ioctl() between HCIUARTSETPROTO and HCIUARTGETPROTO.
This issue bug found by Yu Hao and Weiteng Chen:

BUG: general protection fault in hci_uart_tty_ioctl
https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/

The information of C reproducer can also reference here:
https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/

Reported-by: Weiteng Chen <wchen130@ucr.edu>
Reported-by: Yu Hao <yhao016@ucr.edu>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index efdda2c3fce8..a76eb98c0047 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -770,7 +770,8 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		break;
 
 	case HCIUARTGETPROTO:
-		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+		if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
+		    test_bit(HCI_UART_PROTO_READY, &hu->flags))
 			err = hu->proto->id;
 		else
 			err = -EUNATCH;
-- 
2.35.3

