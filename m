Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A66C099C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCTEWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCTEWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:22:40 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B651F5EB;
        Sun, 19 Mar 2023 21:22:38 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id d13so10909512pjh.0;
        Sun, 19 Mar 2023 21:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679286158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLXhUvKnHXgKEr0Ttn0oR6j5Cn4+cPvwzE2+42+f0uk=;
        b=m89a8PcQWBojMD5M5NayAY/thDhTqrI5mhDMQ/qZJ9at2HakC7UQPG79sshlGjC4Nf
         LyI9HfW/wuU079hZCVuqTANn102cXlk+v2u6MvXGRpC8rj+x7rJTSy4Y96mJFQVJDOtQ
         twbkcuuIlBuAwCPWf3oqkNPyR/CnwUegdEAL/tDmvGQYEohyBA/yOl+v3tlOkIv++g1C
         J6ifPa7GsPOiLHgGP2ZPQbjWzJrT0ZLjNMNi2p2BXZ7c7E6lY6zajAGZsO0JFoa3IJGi
         /zdo8Q2aE3HF3+b45ed6f5SYSqRU7om2pssuIs8SlYiMCJoBu+KMPxRErmoUl7cb3vLQ
         eJwg==
X-Gm-Message-State: AO0yUKV3/VmKcjJGflSAwROgDuF1fxriC7nrj5cTgZz+e+oIOLvVRC0T
        Umi5ksFkJiWZJMRY5tViVY+hWUAJjxuDkSBI
X-Google-Smtp-Source: AK7set9Fvk1ODFIfFQLYA9seh+p96kxjQ9q+WLDoH0md+Cb8Gpl0tEztzniSyvfZKPYzbnXNJDTWTw==
X-Received: by 2002:a17:902:e849:b0:1a0:616d:7618 with SMTP id t9-20020a170902e84900b001a0616d7618mr17458753plg.51.1679286158333;
        Sun, 19 Mar 2023 21:22:38 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b0019e5fc3c7e6sm5505632plg.101.2023.03.19.21.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 21:22:38 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>, sunke <sunke@kylinos.cn>
Subject: [PATCH -next] usb: xhci: do not free an empty cmd ring
Date:   Mon, 20 Mar 2023 12:22:23 +0800
Message-Id: <20230320042223.676505-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was first found on HUAWEI Kirin 9006C platform with a builtin xhci
controller during stress cycle test(stress-ng, glmark2, x11perf, S4...).

phase one:
[26788.706878] PM: dpm_run_callback(): platform_pm_thaw+0x0/0x68 returns -12
[26788.706878] PM: Device xhci-hcd.1.auto failed to thaw async: error -12
...
phase two:
[28650.583496] [2023:01:19 04:43:29]Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
...
[28650.583526] user pgtable: 4k pages, 39-bit VAs, pgdp=000000027862a000
[28650.583557] [0000000000000028] pgd=0000000000000000
...
[28650.583587] pc : xhci_suspend+0x154/0x5b0
[28650.583618] lr : xhci_suspend+0x148/0x5b0
[28650.583618] sp : ffffffc01c7ebbd0
[28650.583618] x29: ffffffc01c7ebbd0 x28: ffffffec834d0000
[28650.583618] x27: ffffffc0106a3cc8 x26: ffffffb2c540c848
[28650.583618] x25: 0000000000000000 x24: ffffffec82ee30b0
[28650.583618] x23: ffffffb43b31c2f8 x22: 0000000000000000
[28650.583618] x21: 0000000000000000 x20: ffffffb43b31c000
[28650.583648] x19: ffffffb43b31c2a8 x18: 0000000000000001
[28650.583648] x17: 0000000000000803 x16: 00000000fffffffe
[28650.583648] x15: 0000000000001000 x14: ffffffb150b67e00
[28650.583648] x13: 00000000f0000000 x12: 0000000000000001
[28650.583648] x11: 0000000000000000 x10: 0000000000000a80
[28650.583648] x9 : ffffffc01c7eba00 x8 : ffffffb43ad10ae0
[28650.583648] x7 : ffffffb84cd98dc0 x6 : 0000000cceb6a101
[28650.583679] x5 : 00ffffffffffffff x4 : 0000000000000001
[28650.583679] x3 : 0000000000000011 x2 : 0000000000e2cfa8
[28650.583679] x1 : 00000000823535e1 x0 : 0000000000000000

gdb:
(gdb) l *(xhci_suspend+0x154)
0xffffffc010b6cd44 is in xhci_suspend (/.../drivers/usb/host/xhci.c:854).
849	{
850		struct xhci_ring *ring;
851		struct xhci_segment *seg;
852
853		ring = xhci->cmd_ring;
854		seg = ring->deq_seg;
(gdb) disassemble 0xffffffc010b6cd44
...
0xffffffc010b6cd40 <+336>:	ldr	x22, [x19, #160]
0xffffffc010b6cd44 <+340>:	ldr	x20, [x22, #40]
0xffffffc010b6cd48 <+344>:	mov	w1, #0x0                   	// #0

During phase one, platform_pm_thaw called xhci_plat_resume which called
xhci_resume. The rest possible calling routine might be
xhci_resume->xhci_init->xhci_mem_init, and xhci->cmd_ring was cleaned in
xhci_mem_cleanup before xhci_mem_init returned -ENOMEM.

During phase two, systemd was tring to hibernate again and called
xhci_suspend, then xhci_clear_command_ring dereferenced xhci->cmd_ring
which was already NULL.

So if xhci->cmd_ring is NULL, xhci_clear_command_ring just return.

Co-developed-by: sunke <sunke@kylinos.cn>
Signed-off-by: sunke <sunke@kylinos.cn>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/usb/host/xhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6183ce8574b1..8b79ad2955e5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -919,6 +919,10 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 {
 	struct xhci_ring *ring;
 	struct xhci_segment *seg;
+	if (!xhci->cmd_ring) {
+		xhci_err(xhci, "Empty cmd ring");
+		return;
+	}
 
 	ring = xhci->cmd_ring;
 	seg = ring->deq_seg;
-- 
2.34.1

