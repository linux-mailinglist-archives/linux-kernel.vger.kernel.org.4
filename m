Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5460B573
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiJXS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiJXS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB11A055
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E413E614B6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC2EC433C1;
        Mon, 24 Oct 2022 16:30:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ma9rewKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666629011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xdL1NVuJwtwsuL0TB2J6TklwZ2b5cGwYyuTwheXB4Uc=;
        b=Ma9rewKQP/7xELPv+VqvGFOaqWxWVTLP17e+Pk0QexyRAN/pvYdtEjhtOm24bRtGnZnfyq
        JXPnkPphElQLPFRX7O0QDzRi5GqlZJvxM/+9wn+c20izEtYLUNLkAgTN/ogvyXIznlb6yr
        35rUbSgenBB25dPrWc8DCUm8g3ueCEs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 29887f1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 24 Oct 2022 16:30:10 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8192e: use explicitly signed char
Date:   Mon, 24 Oct 2022 18:30:05 +0200
Message-Id: <20221024163005.536097-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With char becoming unsigned by default, and with `char` alone being
ambiguous and based on architecture, signed chars need to be marked
explicitly as such. In this case, passing `char *extra` is part of the
iw API, and that extra is mostly intended to be somewhat opaque. So just
cast to `s8 *` for the sign test. This fixes warnings like:

drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index f9589c5b62ba..4563e3b5bd47 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -456,7 +456,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
 	}
 
 	for (i = 0; i < len; i++) {
-		if (extra[i] < 0) {
+		if (((s8 *)extra)[i] < 0) {
 			ret = -1;
 			goto out;
 		}
-- 
2.38.1

