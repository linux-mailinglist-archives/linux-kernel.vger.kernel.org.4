Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3E73C705
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjFXGDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjFXGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:03:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E562735
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50d897af77bso247454a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586616; x=1690178616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K68HLYGlwDJwOH5YshS9zMlYCIWsN1SU5D25IQezQP4=;
        b=Hqfw0pbMjHFV1Qi99e173VzNOVsDdWr/RlHZDV0WjUsx1FBPIp54UfpRVnqOZxMX4L
         Yv4UfGni7FfBz+nTBL19U8RMZ4Sk3Ezp0Xku2EuMu31mSyUGRXlwWnwoxZlgYB5YsszB
         lzhrinkuaUhE0rrVS6KwNLox9a9oSazufcx04LGEGiwwNMhXkhIqc8rmlOpFbQT8DvRu
         Irbk+GcMD9ZpqI4aYLjDHCd4AVgtx9lHbVl8KTaxrVHX1CQRvHVKRyVJ3BzBSJdwWdUh
         ueSp34Oz8sTliGNHzlmriAC2f5dcNBRRSiEj5rTKhMDBdzscrcCcX1BmlpgGqxa3qhOj
         i9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586616; x=1690178616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K68HLYGlwDJwOH5YshS9zMlYCIWsN1SU5D25IQezQP4=;
        b=dE/DaA7vW4fBtCF38zbsguwpi+x/HPnUY0vhNqdhZYOzXVWYf0YV9j1OdesDqjP68Y
         /u/z6+NGg2ru5Lw5faZMIM7jGxR5MjCp0456ly2y/TDV22aQJ29/ZDgJxmg7jhKc/kIQ
         k7jwmfaFxOakM9iZxMqioI1oVpyvTkfZKi/Avg7FBTD+voENThavEsRyoNI1vl2b8cM4
         3z0bpKsM7LkuLnm8UY6Q/dx0CtxgBCYd/QVESlp4gQWALiSA8ZtvTLTT5hOtUfTOd1Vy
         ypYy//QpWUTD4lIOHCDGxHnzMnZsqcK8MfvGoGpHNioTqMG1V3MKI9UiogDCnu7qZBSw
         ZGvg==
X-Gm-Message-State: AC+VfDym8G18M/P6/VsCzeqkwMRUUscaVn33X28/0BIDGU1JcDxhPUTE
        ZjBB5iAwd1AJkYgjvLXA4TQ=
X-Google-Smtp-Source: ACHHUZ4x24+82MKIUPnXjT3fanEpg34sciprXTpyX43bYNt1EkIBd1xHorHUtlTgSdh1p9aL9qjRCg==
X-Received: by 2002:a05:6402:2684:b0:51b:cf76:c548 with SMTP id w4-20020a056402268400b0051bcf76c548mr10975335edd.2.1687586616181;
        Fri, 23 Jun 2023 23:03:36 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7d90f000000b0051bc5adc942sm315479edr.47.2023.06.23.23.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:03:33 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:03:31 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8192e: Remove unused timer SetupTimer
Message-ID: <4bbbd60d84e15fdb7bffde98a687ed168a4dfbbd.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused timer SetupTimer and all the resulting unused code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TS.h     |  1 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index 37760d0bc35d..75ee2056d361 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -19,7 +19,6 @@ enum tr_select {
 
 struct ts_common_info {
 	struct list_head		List;
-	struct timer_list		SetupTimer;
 	struct timer_list		InactTimer;
 	u8				Addr[ETH_ALEN];
 	union tspec_body TSpec;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index c61fdf73c572..00f6a66c2265 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -8,10 +8,6 @@
 #include <linux/etherdevice.h>
 #include "rtl819x_TS.h"
 
-static void TsSetupTimeOut(struct timer_list *unused)
-{
-}
-
 static void TsInactTimeout(struct timer_list *unused)
 {
 }
@@ -142,9 +138,6 @@ void TSInitialize(struct rtllib_device *ieee)
 
 	for (count = 0; count < TOTAL_TS_NUM; count++) {
 		pTxTS->num = count;
-		timer_setup(&pTxTS->TsCommonInfo.SetupTimer, TsSetupTimeOut,
-			    0);
-
 		timer_setup(&pTxTS->TsCommonInfo.InactTimer, TsInactTimeout,
 			    0);
 
@@ -168,9 +161,6 @@ void TSInitialize(struct rtllib_device *ieee)
 		pRxTS->num = count;
 		INIT_LIST_HEAD(&pRxTS->rx_pending_pkt_list);
 
-		timer_setup(&pRxTS->ts_common_info.SetupTimer, TsSetupTimeOut,
-			    0);
-
 		timer_setup(&pRxTS->ts_common_info.InactTimer, TsInactTimeout,
 			    0);
 
@@ -197,7 +187,6 @@ void TSInitialize(struct rtllib_device *ieee)
 static void AdmitTS(struct rtllib_device *ieee,
 		    struct ts_common_info *pTsCommonInfo, u32 InactTime)
 {
-	del_timer_sync(&pTsCommonInfo->SetupTimer);
 	del_timer_sync(&pTsCommonInfo->InactTimer);
 
 	if (InactTime != 0)
@@ -394,7 +383,6 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 static void RemoveTsEntry(struct rtllib_device *ieee,
 			  struct ts_common_info *pTs, enum tr_select TxRxSelect)
 {
-	del_timer_sync(&pTs->SetupTimer);
 	del_timer_sync(&pTs->InactTimer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
 
-- 
2.41.0

