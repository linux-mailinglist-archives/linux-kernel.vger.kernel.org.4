Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C16B38D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjCJIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCJIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:35:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8A16153C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:09 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so17429209edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678437308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4eERmpGRWxN7WGTZJirAqZLtcWVZejiRDlj9T4wObg=;
        b=QEHT/Kmafou4c+fPJ4W3mksw8ajqdo2XLzLsHGizvtqOzI7nCHZoz67aRqVygsWNYI
         vYYEJVdHtWJ1ByZTTanLjVOpcB4EeOamopmdXVZzv4SrO/Nlgr6bIN6/EtCuiop81i1+
         qbQPTif6bWMIjblA5muXgURhXELE2Ost6+EW/qo+b21PoubO9ZVRj9NnZg5BfYr/R6L7
         9//z+geQJ6je0xWKAAvis5k/814C4zAeonRRvnkO6XbvwFWSvgwC0cuTio/4Eb8F6V+J
         69/G56a6W86SdCANiBZ4DXUuH1IvLz8bI837HzWqvNxi0cF/PvApv3mg6MV1AYZB19VG
         Da+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4eERmpGRWxN7WGTZJirAqZLtcWVZejiRDlj9T4wObg=;
        b=W65Q7oEmN7bEbJVpZud7sSSG5VBZnY3UXL0pZ1GGw5Nq7qSocRQVpuf99Rgz51FKKh
         EzWfjprnPtvQfkQgEpsUPLwI6MaWsx2y5FiO21wF/PdDOwQpZVg2VpNbyClSE4GZHVO8
         ed3toFUrppB8a70q929m/lhKRYTkVlXB3XlTHiA/y0XHPIDk2iUVXrto1cVk6V0356Fh
         aIrsuyz+wFOnLLdCsv0Lu1SqKh1ZdI6tqz+VYz86RXrZetfUAA6LxYUmeAHKEwlsnsHr
         RnlXSfRM3VFACwgN5QnJxtLjirVjt+1BE3LVuwoY0OrbYtFimPEpyRTpWjPjplR54PYE
         GDbg==
X-Gm-Message-State: AO0yUKUddXTMjNp4p6afXf1rgsHIhKi/K85YAIvy1sL+JEn/4YQmGe1C
        a/QDkDnwiU9ENsskHWQ8pQ7YGgRpPWE=
X-Google-Smtp-Source: AK7set/gGW4PyYu6LY3aIJ3Hp9Re7e7hvAsjhgO+H1xmMX+PpYMlrAWORpE4aOBw42Vsz+6YXngpSg==
X-Received: by 2002:a17:906:d9c2:b0:8b1:7b22:90b6 with SMTP id qk2-20020a170906d9c200b008b17b2290b6mr23302762ejb.37.1678437308487;
        Fri, 10 Mar 2023 00:35:08 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbd3.dynamic.kabel-deutschland.de. [95.90.187.211])
        by smtp.gmail.com with ESMTPSA id h10-20020a17090619ca00b008ce5b426d77sm697888ejd.13.2023.03.10.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:35:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: rtl8723bs: isAllSpaceOrTab() is not used
Date:   Fri, 10 Mar 2023 09:34:47 +0100
Message-Id: <20230310083449.23775-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310083449.23775-1-straube.linux@gmail.com>
References: <20230310083449.23775-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function isAllSpaceOrTab() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c     | 15 ---------------
 drivers/staging/rtl8723bs/include/hal_com.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index ff0e41bf72b0..da68557c5b20 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -877,21 +877,6 @@ bool GetU1ByteIntegerFromStringInDecimal(char *Str, u8 *pInt)
 	return true;
 }
 
-bool isAllSpaceOrTab(u8 *data, u8 size)
-{
-	u8 cnt = 0, NumOfSpaceAndTab = 0;
-
-	while (size > cnt) {
-		if (data[cnt] == ' ' || data[cnt] == '\t' || data[cnt] == '\0')
-			++NumOfSpaceAndTab;
-
-		++cnt;
-	}
-
-	return size == NumOfSpaceAndTab;
-}
-
-
 void rtw_hal_check_rxfifo_full(struct adapter *adapter)
 {
 	struct dvobj_priv *psdpriv = adapter->dvobj;
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 31fdb5c45de3..839d93d8a1df 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -149,8 +149,6 @@ bool eqNByte(u8 *str1, u8 *str2, u32 num);
 
 bool GetU1ByteIntegerFromStringInDecimal(char *str, u8 *in);
 
-bool isAllSpaceOrTab(u8 *data, u8 size);
-
 void linked_info_dump(struct adapter *padapter, u8 benable);
 #ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
 void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter);
-- 
2.39.2

