Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB6874D9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjGJPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjGJPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:17:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F19127;
        Mon, 10 Jul 2023 08:17:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so2884288a12.1;
        Mon, 10 Jul 2023 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689002248; x=1691594248;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJT4JvcoBJI1s+TLldc7ex2Zu19/5zU0zWJ4jSuF7fQ=;
        b=pmXuMaQbXvrqlmfgRdT/icTqcMtGGSadfOR1aFDVa2hmwRQJh7XdxzEZCimqLBr3+I
         Y0tn76Gs6MSgSlBrVzjW+RObbL2fs5SsOzdlrJKs+97PiyFLAlGN+bvMVP+u9HtkKMVJ
         rtPBdnTfiqUq2vXcmMnW5QoWGFdsvTsE2I5bShwsvIx6q7H/6zHH/55c/LoZp8OstmlN
         zZhGxpzLNawl17YUov5YzYuJlyBpwo/rjzhiZvfnFmAfAPuj92BhTG1EEg6r2VSgp6CZ
         Vzpg53KkUTVmo3paKXQbPlzs7iRZtNoBkBkUx8HhmWQM6almY95PTkorzvwizhmA30T5
         m+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689002248; x=1691594248;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJT4JvcoBJI1s+TLldc7ex2Zu19/5zU0zWJ4jSuF7fQ=;
        b=GX6jrZv8bcKFb8Yr45sGi/wcgeWqbFtu/7EJs6aAoOLlgoVeuZCruloYmXsTKJIzHn
         W2q6iGnr1mFgCrLeSkluJn/k3ivS4Rtog6WjyW/6wiBMRW77tWkUBzFslb0K/VePiMx+
         qv2XC/L6iKXHj1N9FaTTQAVsWx72WJRFTyr3/4RZoDscEGv4DcM2F6jozJZWYFL1OH7Z
         zGJnGhEPXH0EC2pjHUrm64DeG7kvFRdmO5xZRGwQ5f5L3zHR/+9BLhNbV4JvBfTUPZ75
         9xUQ8IXWSeH1ho9ZtjlF20zinydoKGie7R6uis/r2c7UQDo6Fyr256oqkhwSnxeWHR+Q
         qaSA==
X-Gm-Message-State: ABy/qLatcS5/sjpdH/41wht8Mh1IyXchoNStBZeklJcfOxemrdUF0ft8
        zE0Y0GzFiCoXvUp7BUmdrCw=
X-Google-Smtp-Source: APBJJlHg0eWtcWQML0z6WBW+DpGgSe45FPKdsxLQOTSU9VPLSqjndj6bva01pbz+c8yYDl60tgSgGg==
X-Received: by 2002:a17:90a:4282:b0:262:ce9e:8a25 with SMTP id p2-20020a17090a428200b00262ce9e8a25mr22825372pjg.22.1689002248258;
        Mon, 10 Jul 2023 08:17:28 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090abf8300b002633fa95ac2sm6350772pjs.13.2023.07.10.08.17.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2023 08:17:27 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Hao <yhao016@ucr.edu>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH] Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
Date:   Mon, 10 Jul 2023 23:17:23 +0800
Message-Id: <20230710151723.15617-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

BUG: general protection fault in hci_uart_tty_ioctl [1]

The information of C reproducer can also reference the link [2]

Reported-by: Yu Hao <yhao016@ucr.edu>
Closes: https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/ [1]
Reported-by: Weiteng Chen <wchen130@ucr.edu>
Closes: https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/ [2]
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

