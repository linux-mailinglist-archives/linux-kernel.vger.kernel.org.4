Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0A6C6E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjCWRAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCWRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08EDA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679590779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+upkbu9j0REGb3XQPl52CEvrtu/lB3040Vqf6c3jPBI=;
        b=RuJm1Ndpa5XhfXebE+ZD/0Bh47PVNOgibsucvW4q1ynvYcjv4gdu49LGhHWcxvouJlJhAd
        XxK10DEUjeWC4BEDn+9EmLSSlgRBdDTehCULdQepG8GZZzb5ISRAboasJtnoRN1JdBE7r7
        Bv1fou0ZPZqnCZguK2Lw2laZT/GgGb0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-EJET_Qb-MaygCPB2FJBPSw-1; Thu, 23 Mar 2023 12:59:38 -0400
X-MC-Unique: EJET_Qb-MaygCPB2FJBPSw-1
Received: by mail-qv1-f69.google.com with SMTP id g6-20020ad45426000000b005a33510e95aso11131427qvt.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679590778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+upkbu9j0REGb3XQPl52CEvrtu/lB3040Vqf6c3jPBI=;
        b=PH2WFXu/ra6LVVkTqVB5/xN+fnNscm+H6pxqJPwflRtwf8WrPJRW3HBpwH9K3E2nqj
         V2sGxkMjt/uK2TSUaYgpx0fQSJHwWQupGaP8IKXhHENwo0ur/P+OX0IHkt9UfDxIAbYN
         LFGZ9wgBnanKh5lC6d2Jtb0/2q6XH9il1j+B/97DF+HHU4WxxYBgfjJSy4HeZgd9RTVp
         XcXRm08zK4yRj2Q6LRMAIQqEjbG6k5UZFnf8VnCRVW4ulfgm9Ju0IGFw0bpXfYCmLnRb
         SK593KuPRqI8cVXkVbj/UXe5rMQsOlAVZeMMWFE3ZiNjf3GbdBuIsGcEvBgrYAmzVL26
         dz+A==
X-Gm-Message-State: AO0yUKXQsoIBtZP9JMerQztCr1jijWVNNK9ZUq3H63Ns210HYzfGzvXm
        Xc+/uIG5v2h0nHHNdPAZvZyMvFZIkH1MwOa/xYCfS1R2nbhuw3WjF9La3YMwPxARF4jzs1YczC3
        o8h2s0sK+6tzB6u640aQmtRYE
X-Received: by 2002:ac8:5fcf:0:b0:3d8:519a:91c9 with SMTP id k15-20020ac85fcf000000b003d8519a91c9mr11318276qta.8.1679590777754;
        Thu, 23 Mar 2023 09:59:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set8bCx/r2ljWME1lt8mzPqwTkV08BThI3LuMi5lnq3IRAqduegWWqYlgrB2h30Ce/+PHxdWpgQ==
X-Received: by 2002:ac8:5fcf:0:b0:3d8:519a:91c9 with SMTP id k15-20020ac85fcf000000b003d8519a91c9mr11318256qta.8.1679590777497;
        Thu, 23 Mar 2023 09:59:37 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i4-20020a378604000000b0073b3316bbd0sm13538309qkd.29.2023.03.23.09.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:59:37 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, error27@gmail.com, colin.i.king@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] staging: rtl8192u: remove unused ieee80211_SignalStrengthTranslate function
Date:   Thu, 23 Mar 2023 12:59:31 -0400
Message-Id: <20230323165931.2634587-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c:1961:18: error: unused
  function 'ieee80211_SignalStrengthTranslate' [-Werror,-Wunused-function]
static inline u8 ieee80211_SignalStrengthTranslate(
                 ^
This function is not used so remove it.
It may have been used in the past but that has been commented out.
Also remove the comment.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 38 -------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 5c73e3f8541a..ca09367005e1 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1958,43 +1958,6 @@ int ieee80211_parse_info_param(struct ieee80211_device *ieee,
 	return 0;
 }
 
-static inline u8 ieee80211_SignalStrengthTranslate(
-	u8  CurrSS
-	)
-{
-	u8 RetSS;
-
-	// Step 1. Scale mapping.
-	if (CurrSS >= 71 && CurrSS <= 100) {
-		RetSS = 90 + ((CurrSS - 70) / 3);
-	} else if (CurrSS >= 41 && CurrSS <= 70) {
-		RetSS = 78 + ((CurrSS - 40) / 3);
-	} else if (CurrSS >= 31 && CurrSS <= 40) {
-		RetSS = 66 + (CurrSS - 30);
-	} else if (CurrSS >= 21 && CurrSS <= 30) {
-		RetSS = 54 + (CurrSS - 20);
-	} else if (CurrSS >= 5 && CurrSS <= 20) {
-		RetSS = 42 + (((CurrSS - 5) * 2) / 3);
-	} else if (CurrSS == 4) {
-		RetSS = 36;
-	} else if (CurrSS == 3) {
-		RetSS = 27;
-	} else if (CurrSS == 2) {
-		RetSS = 18;
-	} else if (CurrSS == 1) {
-		RetSS = 9;
-	} else {
-		RetSS = CurrSS;
-	}
-	//RT_TRACE(COMP_DBG, DBG_LOUD, ("##### After Mapping:  LastSS: %d, CurrSS: %d, RetSS: %d\n", LastSS, CurrSS, RetSS));
-
-	// Step 2. Smoothing.
-
-	//RT_TRACE(COMP_DBG, DBG_LOUD, ("$$$$$ After Smoothing:  LastSS: %d, CurrSS: %d, RetSS: %d\n", LastSS, CurrSS, RetSS));
-
-	return RetSS;
-}
-
 /* 0-100 index */
 static long ieee80211_translate_todbm(u8 signal_strength_index)
 {
@@ -2095,7 +2058,6 @@ static inline int ieee80211_network_init(
 		network->flags |= NETWORK_EMPTY_ESSID;
 
 	stats->signal = 30 + (stats->SignalStrength * 70) / 100;
-	//stats->signal = ieee80211_SignalStrengthTranslate(stats->signal);
 	stats->noise = ieee80211_translate_todbm((u8)(100 - stats->signal)) - 25;
 
 	memcpy(&network->stats, stats, sizeof(network->stats));
-- 
2.27.0

