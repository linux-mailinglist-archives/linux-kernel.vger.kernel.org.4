Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6206F7379
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEDTnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjEDTnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0758A93FB;
        Thu,  4 May 2023 12:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3736563711;
        Thu,  4 May 2023 19:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60135C4339C;
        Thu,  4 May 2023 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229339;
        bh=X7FKrMlibVA+cIy6xm4u67ib08PyLcz/1lFg2G+n3PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwUyA9MRdLAWoXbWDNlknvPYZz5nQeFpIlcg5rMBFmfAGNHdo0M5zHOdxokCm7xX1
         Omv0Eqx1yyamr1F+1KckMO0rTUuFtD0HuhIkJgdF3cGTIJR1N53mntOaQ8uykqP/DY
         awZFmBsMS88hE67TK5fcamBjVaL+Z5S73O4qb1Wi2sxho9mTpIdeWs71lwOAye0Aj0
         X3lmUJAKqdjuAbvzBGjoH7GgSMePjzEmUlEbnYqZZxZuYh6G/YCMhVLFOGagvqo/Y3
         0ctGA5AXx9iC/0OJXr3XE8GOrvYt1ymOsHEN9fDhkIy42GtRyefaHMMkGJ5Sl367fn
         TNLU76IE5oHRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tony0620emma@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 12/59] wifi: rtw88: fix memory leak in rtw_usb_probe()
Date:   Thu,  4 May 2023 15:40:55 -0400
Message-Id: <20230504194142.3805425-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194142.3805425-1-sashal@kernel.org>
References: <20230504194142.3805425-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <dzm91@hust.edu.cn>

[ Upstream commit 48181d285623198c33bb9698992502687b258efa ]

drivers/net/wireless/realtek/rtw88/usb.c:876 rtw_usb_probe()
warn: 'hw' from ieee80211_alloc_hw() not released on lines: 811

Fix this by modifying return to a goto statement.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230309021636.528601-1-dzm91@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 2a8336b1847a5..68e1b782d1992 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -808,7 +808,7 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	ret = rtw_usb_alloc_rx_bufs(rtwusb);
 	if (ret)
-		return ret;
+		goto err_release_hw;
 
 	ret = rtw_core_init(rtwdev);
 	if (ret)
-- 
2.39.2

