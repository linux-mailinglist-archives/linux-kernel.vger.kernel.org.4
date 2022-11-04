Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC9618D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKDB2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDB16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:27:58 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5385423392;
        Thu,  3 Nov 2022 18:27:57 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-12c8312131fso4172088fac.4;
        Thu, 03 Nov 2022 18:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aUilUaHJkRjMTuKpx9KuulcmPnQFwe0ZTOEMgpM9EUs=;
        b=Qiuj1zxH72t4rljyyB3fSEkfn0epewXXoN357R0R6Usp3EKlWrx8iU6hpHUzfKpX1N
         jWUvsrLP7T+/T1HTqFmsPXuwFA3OhGOVpq/6hknV2wHSHf8vxvD0SjqSU9ikQYMusbVh
         Ibvt/VUaZO27SjIcQQsqhhHansMDWkRhoZJ25wlaEJFLerIHLY9Z6gt6gBWracbEq52v
         WyLK4J9IOWlBKdFWafyeUCtKH3Grw4/GJa2RKMtb5uDabXtgzXtRP9PcMO11bAgO+rcE
         8vVYN3Y5hRUttjbnXz/13kwYZdkqigq9lG1nsPlZIePUhTXp23fp7wrjIrx9Cim5/XWG
         SHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUilUaHJkRjMTuKpx9KuulcmPnQFwe0ZTOEMgpM9EUs=;
        b=cFiQjEvUumk5ghW4GWmY+37rM48BwHcDg8M2BNAClxyUxVo3wjuXkw2x+MRS8bOKgD
         wUcOU/gKupzfEc9gaVEkEZ2nnw6vYJUHZq6PlMGI9vuwroVobBtl2FbH/Mu8uv9PGTe5
         tnuv4rXrxOMezr/l1FtHTwZwr3wtcZqHv6OanqkyTC1N1VsVJhnoxY0nveJMnm2ZONZK
         zeoWl9WlLkdpoQWI0uH7E93yEcxScziMAz67+hgOyR+xfHVQFfUB8cV76AUPMe2VHTaD
         LqOBcFNpnBNpeWpN7YIMnCODbpdq79p6DH6VsfldU/mXGDZQEOgn/Ah5GbzNHUi3tA7K
         9Row==
X-Gm-Message-State: ACrzQf3FeyRszoUeUQ6DM8M0Zh/RidMcxTk8v5GBFLPUwffAfWQnoNQD
        8lxaEga3lngW+qkMsECFl1U=
X-Google-Smtp-Source: AMsMyM7mnS5ut6p2YgNYUONLq0d80He/REUIRQ+G4m7m1O1dcQUT/Jn8NnVdFxbGwgr+wi1xKLrmPg==
X-Received: by 2002:a05:6870:3414:b0:13c:787e:15ba with SMTP id g20-20020a056870341400b0013c787e15bamr19114631oah.164.1667525276643;
        Thu, 03 Nov 2022 18:27:56 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id b6-20020a9d6b86000000b0066c75a2643asm924675otq.66.2022.11.03.18.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:27:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] staging: rtl8192e: Fix divide fault when calculating beacon age
Date:   Thu,  3 Nov 2022 20:27:50 -0500
Message-Id: <20221104012750.2076-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the configuration parameter CONFIG_HZ is less that 100, the compiler
generates an error as follows:

../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtl819x_translate_scan':
../drivers/staging/rtl8192e/rtllib_wx.c:220:57: warning: division by zero [-Wdiv-by-zero]
  220 |      (jiffies - network->last_scanned) / (HZ / 100));
      |                                                         ^
In file included from ../include/linux/skbuff.h:45,
                 from ../include/linux/if_ether.h:19,
                 from ../include/linux/etherdevice.h:20,
                 from ../drivers/staging/rtl8192e/rtllib_wx.c:18:
../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtllib_wx_get_scan':
../drivers/staging/rtl8192e/rtllib_wx.c:261:70: warning: division by zero [-Wdiv-by-zero]
  261 |      (jiffies - network->last_scanned) /
      |

In fact, is HZ is not a multiple of 100, the calculation will be wrong,
but it will compile correctly.

The fix is to get rid of the (HZ / 100) portion. To decrease any round-off
errors, the compiler is forced to perform the 100 * jiffies-difference
before dividing by HZ. This patch is only compile tested.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - some commit log lines are shortened
   - add space after * operator
---
 drivers/staging/rtl8192e/rtllib_wx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index da2c41c9b92f..217426ee2e92 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -217,7 +217,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	p = custom;
 	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
 		      " Last beacon: %lums ago",
-		      (jiffies - network->last_scanned) / (HZ / 100));
+		      (100 * (jiffies - network->last_scanned)) / HZ);
 	iwe.u.data.length = p - custom;
 	if (iwe.u.data.length)
 		start = iwe_stream_add_point_rsl(info, start, stop,
@@ -258,8 +258,8 @@ int rtllib_wx_get_scan(struct rtllib_device *ieee,
 				   escape_essid(network->ssid,
 						network->ssid_len),
 				   network->bssid,
-				   (jiffies - network->last_scanned) /
-				   (HZ / 100));
+				   (100 * (jiffies - network->last_scanned)) /
+				   HZ);
 	}
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
-- 
2.38.0

