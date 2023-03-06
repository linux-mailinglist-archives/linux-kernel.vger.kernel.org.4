Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1634F6AB641
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCFGLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCFGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:11:07 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A7CDBCF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 22:11:01 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230306061057epoutp025158ae14b0051bb9dc3dec696bb30530~Jv6Zd7RCb1415414154epoutp02K
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:10:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230306061057epoutp025158ae14b0051bb9dc3dec696bb30530~Jv6Zd7RCb1415414154epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678083057;
        bh=tLe6STtVB55OMBa0XzsOxgvLXflv5IePsTqGx15Sl2k=;
        h=From:To:Subject:Date:References:From;
        b=XfXjEZAh4DsNuKEjNp2oTxopSxO6AYxhqJdfhYiQb/cB4kC96p42M0p0iP8S5kQxa
         wMKgoSLbqXp7uyUT+K4KdxHpFijAmeFqhFxeeevFx+cE6hZIXXkPT/NBUCFYa640GV
         dV/JfKlA5iCyr+onWCdcfy/5sfq93GZRKY8g2eRk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230306061056epcas1p39a315be156e1f00493a0dd3152599d65~Jv6ZCWHNK1178711787epcas1p3H;
        Mon,  6 Mar 2023 06:10:56 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.225]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PVSr027NWz4x9Q7; Mon,  6 Mar
        2023 06:10:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.35.12562.0F385046; Mon,  6 Mar 2023 15:10:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230306061055epcas1p1f7718c46c10f84845e086f9ce9f9a41f~Jv6X2MU-C0043100431epcas1p1d;
        Mon,  6 Mar 2023 06:10:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230306061055epsmtrp20986271a5527cc82b18f01180741c275~Jv6XxpOxm1968819688epsmtrp2D;
        Mon,  6 Mar 2023 06:10:55 +0000 (GMT)
X-AuditID: b6c32a36-e59fa70000023112-41-640583f0869b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.E3.18071.FE385046; Mon,  6 Mar 2023 15:10:55 +0900 (KST)
Received: from VDBS1328.vd.sec.samsung.net (unknown [168.219.243.40]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230306061055epsmtip23446b39ce0663917d007ed594eac87ad~Jv6Xl3ZZB2959729597epsmtip2X;
        Mon,  6 Mar 2023 06:10:55 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
        amit.kachhap@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, js07.lee@samsung.com, js07.lee@gmail.com
Subject: [PATCH 1/2] arm/mm : omit [_text, _stext) from kernel code region
Date:   Mon,  6 Mar 2023 14:51:54 +0900
Message-Id: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmge6HZtYUg3VLeS2mfNjBavHzy3tG
        i79z3jFZPLr5m9XiTHeuxZQ/y5ksNj2+xmpxedccNotL/ROZHDg91sxbw+hx+dpFZo/ZDRdZ
        PHbOusvusWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5AM6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZkx82sBXc46k4vfEsYwPjIa4uRk4O
        CQETib1P/rKD2EICOxglnp2Q6WLkArI/MUose7CXGcL5xiix++9TRpiO7d8+sEIk9jJKXG15
        wAjR/otR4uuuMBCbTUBL4sbvTWBFIgKvGCV+tSxkAkkIC3hJfLrzgQXEZhFQlbiyfxMziM0r
        4CLxespKNogNchI3z3WCrZYQOMcu8eVQF1TCReLh+h9QtrDEq+Nb2CFsKYnP7/ZCxcslNvRN
        Y4JobmGUWLT9LVTCWOLd27VAUzk4mAU0Jdbv0ocIK0rs/D0X7ANmAT6Jd197WEFKJAR4JTra
        hCBKlCTePGhhgbAlJC487mWFsD0k/s78ygbxfKzEpg83WScwysxCWLCAkXEVo1hqQXFuemqx
        YYERPGaS83M3MYKTmpbZDsZJbz/oHWJk4mA8xCjBwawkwstTypIixJuSWFmVWpQfX1Sak1p8
        iNEUGGATmaVEk/OBaTWvJN7QxNLAxMzIxMLY0thMSZxX3PZkspBAemJJanZqakFqEUwfEwen
        VAMTx7V3cmXmszj2NRutqlxpfbcuxvHKzqr5JtWpn/Z8Yzk/3/YKTw3jMX8Wf+mfIhE2q6sy
        l8rcsVJ/N6F5asi5fQ1uJj+v6/CFTgn7uzivcfZmR8Gl8jxLJidlxp1OkbPNyVq/28zRtub2
        hLxbzwy8llm7TORq6pN5KrgjpvpUtv9ZH3ee+7d6WhI7Rfo4epoYIoKTGK9Xtsk9lYg4+U35
        ygKh4tYS7r98/c4TdZmWrHq1LHaH+5LHUTxsxroRUzh1z7JVMMjv7eXIv/ktucxs965SixLm
        BTFBz95tO/p/5dZHR1fcjio9Fq/sJrJMOO/+HbFvGj//XxBft7X5ukNhRPyF32Vndr5tfFhx
        p02JpTgj0VCLuag4EQCGGc9I8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXvd9M2uKwd/r8hZTPuxgtfj55T2j
        xd8575gsHt38zWpxpjvXYsqf5UwWmx5fY7W4vGsOm8Wl/olMDpwea+atYfS4fO0is8fshoss
        Hjtn3WX32LSqk83jzrU9bB6bl9R79G1ZxejxeZNcAGcUl01Kak5mWWqRvl0CV8bkhw1sBfd4
        Kk5vPMvYwHiIq4uRk0NCwERi+7cPrF2MXBxCArsZJe5/OcIGkZCQeLTzC0sXIweQLSxx+HAx
        RM0PRokFS36xg9SwCWhJ3Pi9CaxZROALo8TFWaeZQBLCAl4Sn+58YAGxWQRUJa7s38QMYvMK
        uEi8nrISaoGcxM1zncwTGLkXMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDjMt
        zR2M21d90DvEyMTBeIhRgoNZSYSXp5QlRYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC
        6YklqdmpqQWpRTBZJg5OqQamwgy+o8/jVSo1Fq12lztw0Mp/R/gxW6WlLz9Kb9A4bMK5QXf6
        57f2U765rfS5W9TUeKLIt6JOb1aadJPYpostF9bVe53+eurzXJFPlrnql6sWcYi6vlrebxqw
        6ftvvV+65yay9a8IzSiWNrbikyme/OyHwGp+5cfl5QYnFxtl3czwFrvDzn8s5rbebx4Xzn1z
        jPL5V30LPmSrmhbK3dS/7c6vY1FCDrcsazXurlmhfSfuA+P37I1H/NbND5NW6LA845w/r+fx
        i9d8DYvYQ2af3FHlI3N4hubSB4kr3yQeuvHxa1d80uQKdk/euInnWQqf3K/4/+vopMVpsQKn
        NvT/TvPsmJj5zezOSrsNSm3ySizFGYmGWsxFxYkAa9NSCKICAAA=
X-CMS-MailID: 20230306061055epcas1p1f7718c46c10f84845e086f9ce9f9a41f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230306061055epcas1p1f7718c46c10f84845e086f9ce9f9a41f
References: <CGME20230306061055epcas1p1f7718c46c10f84845e086f9ce9f9a41f@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource reservations in /proc/iomem made for the kernel code did
not reflect the gaps between pagetable and text.

In particular, if the CONFIG_STRICT_KERNEL_RWX option is turned on,
the wrong area is shown as the kernel code area.

Fix it by removing [_text, _stext) from kernel code region.

Before:
04000000-2f7fffff : System RAM
  04008000-04cfffff : Kernel code
  04e00000-05369a27 : Kernel data

After :
04000000-2f7fffff : System RAM
  04100000-04cfffff : Kernel code
  04e00000-05369a27 : Kernel data

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 arch/arm/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 75cd469..3059860 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -865,7 +865,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 	struct resource *res;
 	u64 i;
 
-	kernel_code.start   = virt_to_phys(_text);
+	kernel_code.start   = virt_to_phys(_stext);
 	kernel_code.end     = virt_to_phys(__init_begin - 1);
 	kernel_data.start   = virt_to_phys(_sdata);
 	kernel_data.end     = virt_to_phys(_end - 1);
@@ -1139,7 +1139,7 @@ void __init setup_arch(char **cmdline_p)
 	if (mdesc->reboot_mode != REBOOT_HARD)
 		reboot_mode = mdesc->reboot_mode;
 
-	setup_initial_init_mm(_text, _etext, _edata, _end);
+	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 	/* populate cmd_line too for later use, preserving boot_command_line */
 	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
-- 
2.7.4

