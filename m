Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E05609D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJXItv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiJXItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:49:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21F220ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i3-20020a17090a3d8300b00212cf2e2af9so7389762pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLIdpQp6TVzjpS8r5yHeQWkGEgLDOWAXXPd+wr6BFps=;
        b=NbR/+wMAJQsAS4ZCKdqO+slx+4imwFJZNzwyLXfJPz7S5F4F9AHmCKCAvC3992TKJX
         P2VXGagRVkNQeqtFAu6h6GthBQLnzJgNUWB0h56lDk7XG9kwO7rqtmaBdNZHPITemAUW
         KcBl2uajkOEBlYyKbmFR84ceoVP7ZG8RhljhE/ici8ifbk6yZ8uxZqXX+PlkVxS8s2Ol
         LLrP1D+kjozTtOCtb4AKBErS9WgINjkGJ91XSI6x3em6bzYruThflg9sLZmsWr+1kV7f
         xBiTCdrWAThidPtDmU9M4vnlzNuXk+/vdolKTJ0WRW3GP2DbJPATiM2fLgGviDcEfBNv
         lOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLIdpQp6TVzjpS8r5yHeQWkGEgLDOWAXXPd+wr6BFps=;
        b=wGEpp3bVw7/13jx/HvFdc6LGuJVORTpdRZqmQmFXQuFuSeNoUmxr7xbcVya/eBHQ9U
         dD1KRIpCeZ76ht27lkIHh5DJrW0hU8+bTk7T+54GdNnYluSnhaO0g2UX1pMhRQF93PsN
         flx52s8RhSuOA2N8Vj7X4ceEiPdjtDFkTuGaZmTenPgL4beTdeF5NH31kk1hVsaLU29J
         MK7rAzoOoYWdJMRSyNuxuZ9rVVNfEvLGZB7s4CFnNwXm2wOR12tu/WjhnH0PcjXsC0JD
         sx2HHDo0QQ/1XkfR6wlZ3n2x7Bbmd6og/g+V3IUc1TVnEQ/3Vk7DmbzBFsc8pH2Rds1x
         O8zA==
X-Gm-Message-State: ACrzQf3ZrKAxPX1L+yg7G5kt5oxS9REg1XRXMfUMbQD88IsU3QztSrbG
        AtrIVds7GJ9+MhJApNOpgIg=
X-Google-Smtp-Source: AMsMyM7ZLCkRXSidqosRcQ06v3NCGHk+w05g/OrqK02EJHcJm83MwhUE1n8FqFuDno4QHlKchkDGqQ==
X-Received: by 2002:a17:902:8490:b0:186:a7f8:63b5 with SMTP id c16-20020a170902849000b00186a7f863b5mr4498076plo.57.1666601383534;
        Mon, 24 Oct 2022 01:49:43 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id r2-20020a63a542000000b00434e1d3b2ecsm17245124pgu.79.2022.10.24.01.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:49:43 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 4/4] staging: r8188eu: remove unnecessary variable in rtw_ap
Date:   Mon, 24 Oct 2022 17:49:25 +0900
Message-Id: <20221024084925.262289-5-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024084925.262289-1-tegongkang@gmail.com>
References: <20221024084925.262289-1-tegongkang@gmail.com>
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

Return 0 directly instead of storing it in a variable.
This can prevent cocci warning as follows:

  Unneeded variable: "ret". Return "0" on line 1031

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 24eb8dce9bfe..9eaf345e6a00 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1020,7 +1020,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 int rtw_sta_flush(struct adapter *padapter)
 {
 	struct list_head *phead, *plist;
-	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1028,7 +1027,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
-		return ret;
+		return 0;
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
@@ -1051,7 +1050,7 @@ int rtw_sta_flush(struct adapter *padapter)
 
 	associated_clients_update(padapter, true);
 
-	return ret;
+	return 0;
 }
 
 /* called > TSR LEVEL for USB or SDIO Interface*/
-- 
2.34.1

