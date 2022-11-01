Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB009615210
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiKATPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKATPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:15:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F31D0D5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:15:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t25so39554736ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URSBztTq5HXujid4PUnbsPAmYdL6Ka0hNq1mm6n6cno=;
        b=fqX5yYexYI0j5kK909nrQwP2vwkyAGRQl0POVblf3X8XEadNzCO8lJzlbIQ3rqONRl
         KEpwUe1BPjJETcDhiB0DF+sECLDvw43PywmMPEyv21fxleB6TXKwUFW/A+0wSWaACvwU
         frmADMZngwXzQQhG8jArGThluWuUIcuTGNazV6cOW87OK5P5ORYmRo5q2AA+GuJ0OqSI
         gYepMIRrCxZ+nRDm1zDqyQC/g+mQPVcw7We4M2HoIfEsIFXcgPn7/FMmERxUjeOY9cgr
         l5oSEkrQGpjkhDAevijaOEjkYbvLvbDmwiyt0U0G9Lnz2v6Me+1zTR15rOA8nybhvFwI
         bv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URSBztTq5HXujid4PUnbsPAmYdL6Ka0hNq1mm6n6cno=;
        b=3wXf+iKbmuigcpq3LjU8zfDC/OSL+bBTKSTHviPWNNdiHY8JYe1FGUDa1y8CSrqPYK
         epotC1seX7LXEuf9f7OZG826MY9bRPO8zhKrDX6rFwf59NQprmgDJN/QwGJAIAKCRulT
         Wq6SdmLuqKXclFHOsNuOgXkww8SlnX+g8JiU4j7OiV5ffImZ13waErAXG8CgZ5rMtooQ
         sH3dlWZ1OMPP5aBxCC/hXdR+ZHi/o9Em5b/WNb/q5YvjIRdgcsaXXBlh1MUlous8OK+5
         9x2oHLidUmswatyaYrwYudbOyXwcRtIUrcQlt0LD1yPRZ5bTWjJWN+hWwDMM6tPwNTH9
         LSnw==
X-Gm-Message-State: ACrzQf0IYa6MXrE/YYPJieTIWfITkK/X3i3uuqi18HWqwQ2QBeTA54OU
        a8K9wlpCGtN4KuvGfU9KIoQ=
X-Google-Smtp-Source: AMsMyM5CXH16D7IbYQTiafXplecV8l3pNJWjj7aQ8TMiJc9+p785pNwbUydD/vDmaOjJy7oyr4/a5A==
X-Received: by 2002:a17:906:974f:b0:7aa:f705:e580 with SMTP id o15-20020a170906974f00b007aaf705e580mr18916152ejy.530.1667330105418;
        Tue, 01 Nov 2022 12:15:05 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb7a.dynamic.kabel-deutschland.de. [95.90.187.122])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b007ade5cc6e7asm1643853ejc.39.2022.11.01.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:15:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: convert rtw_free_stainfo() to void
Date:   Tue,  1 Nov 2022 20:14:58 +0100
Message-Id: <20221101191458.8619-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221101191458.8619-1-straube.linux@gmail.com>
References: <20221101191458.8619-1-straube.linux@gmail.com>
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

The function rtw_free_stainfo() returns always _SUCCESS and none of
its callers uses the return value. We can safely make the function
void. Yet another tiny step towards getting rid of _FAIL / _SUCCESS.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 8 ++------
 drivers/staging/r8188eu/include/sta_info.h | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 51324e708697..b4aee8623099 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -242,7 +242,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 }
 
 /*  using pstapriv->sta_hash_lock to protect */
-u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
+void rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 {
 	int i;
 	struct __queue *pfree_sta_queue;
@@ -252,7 +252,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	struct	sta_priv *pstapriv = &padapter->stapriv;
 
 	if (!psta)
-		goto exit;
+		return;
 
 	pfree_sta_queue = &pstapriv->free_sta_queue;
 
@@ -356,10 +356,6 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	spin_lock_bh(&pfree_sta_queue->lock);
 	list_add_tail(&psta->list, get_list_head(pfree_sta_queue));
 	spin_unlock_bh(&pfree_sta_queue->lock);
-
-exit:
-
-	return _SUCCESS;
 }
 
 /*  free all stainfo which in sta_hash[all] */
diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index 55ea5edc2914..e42f4b4c6e24 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -303,7 +303,7 @@ int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta);
 struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int off);
 
 struct sta_info *rtw_alloc_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
-u32	rtw_free_stainfo(struct adapter *adapt, struct sta_info *psta);
+void rtw_free_stainfo(struct adapter *adapt, struct sta_info *psta);
 void rtw_free_all_stainfo(struct adapter *adapt);
 struct sta_info *rtw_get_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
 u32 rtw_init_bcmc_stainfo(struct adapter *adapt);
-- 
2.38.0

