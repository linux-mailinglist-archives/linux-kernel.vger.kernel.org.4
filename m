Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D361895C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiKCUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiKCUGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:06:23 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C57821824;
        Thu,  3 Nov 2022 13:05:19 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13bef14ea06so3471725fac.3;
        Thu, 03 Nov 2022 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QJqmk5I6DAgiLsobZTGa57P2bCxeBPQdNtIGsZHnmfo=;
        b=fhg/fjhDvPlrIUzjSmWqpspjw+rGGlKIeolmzQWRiNGUdii5IMjJx1jz6sN1AVjccA
         Fo7mo3HkOMRJBFiWrECJYtfzGpBrvxUd+h02JAqrV6NEZdKghONQDyxTikE6kVCa56WD
         /E3tkjjQLUVBnzKmwBckmnzvpkiBJky00erYc0viedcQID+Ua/TvESwDB03S2ND8eF0O
         va8n8xHHuFuAntxHJRIAvhZla7bXk7z4i3Blaxbdja6qfkASmvnIolYyHYIdIC7HNXO9
         JPB2c9y7idm53B5OFPBSVtFZ1CLAcTqSWtoONJSbqEFOBwVKURkyo33ndJLs3U2cnwKX
         6pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJqmk5I6DAgiLsobZTGa57P2bCxeBPQdNtIGsZHnmfo=;
        b=f5PZ7DWquz/KTbe9Jdt8EsCe7FmxqqSGG+rJdZAJdUxhCteFuZFSO9mtrfiwfmSysV
         p1NBlcQieFqv6Q15yWIDRoBt5Ap17iul6X0h/Epm7RgWBJ8iW9E7UdOUQUJ3Y5458iyd
         HmKtr2VSm1BOUsSHLUZ6hpw1+jH3X4LY8zz0Kh2uO34S/nyj3ZkB0Rwjw97blcF/AjO+
         LNORlNu9Xn7faYxpJWSA7uQ46cfq7gDf0Wp2TTlPKWr68sAJbpwyaEUBDdJV6tcQY+mf
         70rc7EBa1q3W5G5oTFMeFc3yu6RCqwQnI+yA4BqgiEgiiBe0MGXiiEfL66l4wkacTouw
         2UhA==
X-Gm-Message-State: ACrzQf01g/idCz1flwbA5TF70r+obmpBQgkzbT1lXO5533+Qybwx5/mf
        CuO/TW/8JB7lD1R/x/i3w1kvkRubFls=
X-Google-Smtp-Source: AMsMyM7EfiNrp3ewtr+mhaU+GV1tgaMCY+ryP1oN2nP0SoFejOu/QzoP2U6LFoUFqTKpfKb1cMVAXg==
X-Received: by 2002:a05:6871:891:b0:13b:86bc:7b51 with SMTP id r17-20020a056871089100b0013b86bc7b51mr19830284oaq.174.1667505918579;
        Thu, 03 Nov 2022 13:05:18 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r3-20020a056870e98300b0013bc40b09dasm842286oao.17.2022.11.03.13.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:05:18 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] staging: rtl8192e: Fix divide fault when calculating beacon age
Date:   Thu,  3 Nov 2022 15:05:07 -0500
Message-Id: <20221103200507.14304-1-Larry.Finger@lwfinger.net>
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
  220 |                       (jiffies - network->last_scanned) / (HZ / 100));
      |                                                         ^
In file included from ../include/linux/skbuff.h:45,
                 from ../include/linux/if_ether.h:19,
                 from ../include/linux/etherdevice.h:20,
                 from ../drivers/staging/rtl8192e/rtllib_wx.c:18:
../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtllib_wx_get_scan':
../drivers/staging/rtl8192e/rtllib_wx.c:261:70: warning: division by zero [-Wdiv-by-zero]
  261 |                                    (jiffies - network->last_scanned) /
      |

In fact, is HZ is not a multiple of 100, the calculation will be wrong, but it
will compile correctly.

The fix is to get rid of the (HZ / 100) portion. To decrease any round-off
errors, the compiler is forced to perform the 100 * jiffies-difference before
dividing by HX. This patch is only compile tested.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index da2c41c9b92f..7013425102dd 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -217,7 +217,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 	p = custom;
 	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
 		      " Last beacon: %lums ago",
-		      (jiffies - network->last_scanned) / (HZ / 100));
+		      (100 *(jiffies - network->last_scanned)) / HZ);
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

