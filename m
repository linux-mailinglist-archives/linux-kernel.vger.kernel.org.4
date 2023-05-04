Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7918A6F742B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEDTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjEDTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1669511DB3;
        Thu,  4 May 2023 12:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 981AA63733;
        Thu,  4 May 2023 19:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8FFC4331E;
        Thu,  4 May 2023 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229433;
        bh=xU5+GS7Z0ZOvuzry9gq4roNZWabzqWYxzl3qKvzYpew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7b4sj4xXhZ5+eYZPEJQz6+D1isnmoaGm2xsUtumGSaB2kkGz3RM2PovuEtDFctgo
         N1HM3eVfAc0vJOkZxT3RF39s2CwxSt1M7V29kSMOZB+PDh99plSTDKFKvuzoV0D82r
         n1EZh7QfGGLxJuHH7W5fGAgAoc/Kba1fJ//lUK07WPjvP6OcvtAOCenZjAmj5oTCYS
         9CLV+VSnnfH7gFyp0Vg8HYdLgh0+xzvoloLIOcdcjfWG+8Z1OZ8lXUlZsLhJuLT0pc
         XoRP2k4MvVOHVzcSVCo/iqNVixy5a0p4xBQbKJG7NzhWHuWqFQPPm6bL8e6OEK715L
         IhlPYvmEN+4qA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tony0620emma@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 47/59] wifi: rtw88: Fix memory leak in rtw88_usb
Date:   Thu,  4 May 2023 15:41:30 -0400
Message-Id: <20230504194142.3805425-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit 59a3a312009723e3e5082899655fdcc420e2b47a ]

Kmemleak shows the following leak arising from routine in the usb
probe routine:

unreferenced object 0xffff895cb29bba00 (size 512):
  comm "(udev-worker)", pid 534, jiffies 4294903932 (age 102751.088s)
  hex dump (first 32 bytes):
    77 30 30 30 00 00 00 00 02 2f 2d 2b 30 00 00 00  w000...../-+0...
    02 00 2a 28 00 00 00 00 ff 55 ff ff ff 00 00 00  ..*(.....U......
  backtrace:
    [<ffffffff9265fa36>] kmalloc_trace+0x26/0x90
    [<ffffffffc17eec41>] rtw_usb_probe+0x2f1/0x680 [rtw_usb]
    [<ffffffffc03e19fd>] usb_probe_interface+0xdd/0x2e0 [usbcore]
    [<ffffffff92b4f2fe>] really_probe+0x18e/0x3d0
    [<ffffffff92b4f5b8>] __driver_probe_device+0x78/0x160
    [<ffffffff92b4f6bf>] driver_probe_device+0x1f/0x90
    [<ffffffff92b4f8df>] __driver_attach+0xbf/0x1b0
    [<ffffffff92b4d350>] bus_for_each_dev+0x70/0xc0
    [<ffffffff92b4e51e>] bus_add_driver+0x10e/0x210
    [<ffffffff92b50935>] driver_register+0x55/0xf0
    [<ffffffffc03e0708>] usb_register_driver+0x88/0x140 [usbcore]
    [<ffffffff92401153>] do_one_initcall+0x43/0x210
    [<ffffffff9254f42a>] do_init_module+0x4a/0x200
    [<ffffffff92551d1c>] __do_sys_finit_module+0xac/0x120
    [<ffffffff92ee6626>] do_syscall_64+0x56/0x80
    [<ffffffff9300006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

The leak was verified to be real by unloading the driver, which resulted
in a dangling pointer to the allocation.

The allocated memory is freed in rtw_usb_intf_deinit().

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230417160331.23071-1-Larry.Finger@lwfinger.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 68e1b782d1992..05c7326443614 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -780,6 +780,7 @@ static void rtw_usb_intf_deinit(struct rtw_dev *rtwdev,
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 
 	usb_put_dev(rtwusb->udev);
+	kfree(rtwusb->usb_data);
 	usb_set_intfdata(intf, NULL);
 }
 
-- 
2.39.2

