Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11435FFACE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJOPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJOPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:11:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F344684D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:11:41 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojip7-0006sp-4g; Sat, 15 Oct 2022 17:11:37 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/10] staging: r8188eu: don't include rtw_led.h from rtw_cmd.h
Date:   Sat, 15 Oct 2022 17:11:12 +0200
Message-Id: <20221015151115.232095-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221015151115.232095-1-martin@kaiser.cx>
References: <20221015151115.232095-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtw_cmd.h does not need any definitions from the led layer, there's
no reason to include rtw_led.h.

When I tried to remove this component

struct led_priv {
   struct adapter *padapter;
   ...

I saw compiler errors because of this chain of include files:
drv_types.h -> rtw_cmd.h -> rtw_led.h

rtw_led.h uses struct adapter before it sees the definiton near the end
of drv_types.h. (It seems that a simple struct adapter * prevents this
problem.)

The best option for fixing this issue is to not include rtw_led.h in
rtw_cmd.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_cmd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 20a65beed166..2f4595f13e86 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -6,7 +6,6 @@
 
 #include "wlan_bssdef.h"
 #include "rtw_rf.h"
-#include "rtw_led.h"
 
 #include "osdep_service.h"
 #include "ieee80211.h" /*  <ieee80211/ieee80211.h> */
-- 
2.30.2

