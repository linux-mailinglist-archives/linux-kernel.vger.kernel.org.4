Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13F0617080
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiKBWMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKBWL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:11:56 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEB8C765
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:11:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y6so13257607iof.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMa3MR4IUQceb8ba6rkMvJ9Gew5CiKKMun80HjD3sO0=;
        b=NgarWTE/Pma1qNwb5MSu5Ed/3/owSCgA8B3RlKb8UXMp3BsqKQivMY3LAck971dflk
         Oms4bx4d9v2OcM3wrFNq6MbBAm0RdtKrktSzhA7hgaN+NH0MZbObtE/alXTheSkIAlhG
         0hCk+cHOtas1NfNI+HC5k43CnBMqGwu/N3eZo5YxF2//q8z9vB3U47o9Bp7gtCaBA+cl
         7MTpwCixLD/hraVoWDwQyw9im86lBf5wiPkNwUEUe9I+26N4Qtm67eqIiHaQ/Ps1hiCG
         EGjNbHhWR8OEWK67jRev5uuDqDjmftRq/D9Jt/OQsdeT+2sSCc5R42/0JW9HPmXif1i4
         vbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMa3MR4IUQceb8ba6rkMvJ9Gew5CiKKMun80HjD3sO0=;
        b=oGOZOpzFhon7iMIteGrddODF5Iap8IUxnsDyfXU7i3l2CEkKlALtWWYs6deo1EhjpZ
         th5N7AYQGE6uckDBC+ZULveDga1+CL6SZlkSmEPTbJzd67hOx43Z8CuncMW3+2s1jND1
         iKGVUwHESGh8cAVZTp8fdIHqWlmpS9KDaw0bteWtFSfRr0AU2VJulQYqfA8Nk/EZ+JTf
         5+YmXD7Pqmx64nYN587alOe3ovugpgtxZL90UplqWGhY29xYTymVJ035HQRi5SotZYlE
         OZfaSCAxGC38Sog+AP7GITM8cYzngsjXquorkvyRh8c2mUgDUIU5dIdBkt3t1fjs9gCw
         gctQ==
X-Gm-Message-State: ACrzQf2LwBBCOx1DK98UAMSSI/Nr0toSa1tVDxV8/HkSCGIC7rT1P6R2
        vvfg13MrXd5SidNwMWRv6470Lg==
X-Google-Smtp-Source: AMsMyM7AwPmJPXbBCWoe8Az33TrO6a0MPrpGMujWlN7dCOtRDkavM++aS8TNlgC8JxQ1NGv6QHFqpQ==
X-Received: by 2002:a6b:7e0b:0:b0:6d1:1d92:90e4 with SMTP id i11-20020a6b7e0b000000b006d11d9290e4mr12102439iom.79.1667427113106;
        Wed, 02 Nov 2022 15:11:53 -0700 (PDT)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id f8-20020a02a108000000b0037465a1dd3fsm5073974jag.156.2022.11.02.15.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:11:52 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 8/9] net: ipa: use a bitmap for set-up endpoints
Date:   Wed,  2 Nov 2022 17:11:38 -0500
Message-Id: <20221102221139.1091510-9-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102221139.1091510-1-elder@linaro.org>
References: <20221102221139.1091510-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the 32-bit unsigned used to track endpoints that have
completed setup with a Linux bitmap, to allow an arbitrary number
of endpoints to be represented.

Rework the error handling in ipa_endpoint_init() so the defined
endpoint bitmap is freed if an error occurs early.  Once endpoints
have been initialized, ipa_endpoint_exit() is used to recover if
the set of filtered endpoints is invalid.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa.h          |  4 ++--
 drivers/net/ipa/ipa_endpoint.c | 38 +++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index 557101c2d5838..f14d1bd34e7e5 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -66,7 +66,7 @@ struct ipa_interrupt;
  * @defined:		Bitmap of endpoints defined in config data
  * @available:		Bitmap of endpoints supported by hardware
  * @filtered:		Bitmap of endpoints that support filtering
- * @set_up:		Bit mask indicating endpoints set up
+ * @set_up:		Bitmap of endpoints that are set up for use
  * @enabled:		Bit mask indicating endpoints enabled
  * @modem_tx_count:	Number of defined modem TX endoints
  * @endpoint:		Array of endpoint information
@@ -124,7 +124,7 @@ struct ipa {
 	unsigned long *defined;		/* Defined in configuration data */
 	unsigned long *available;	/* Supported by hardware */
 	u64 filtered;			/* Support filtering (AP and modem) */
-	u32 set_up;
+	unsigned long *set_up;
 	u32 enabled;
 
 	u32 modem_tx_count;
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 03811871dc4aa..3fe20b4d9c90b 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1802,12 +1802,12 @@ static void ipa_endpoint_setup_one(struct ipa_endpoint *endpoint)
 
 	ipa_endpoint_program(endpoint);
 
-	endpoint->ipa->set_up |= BIT(endpoint->endpoint_id);
+	__set_bit(endpoint->endpoint_id, endpoint->ipa->set_up);
 }
 
 static void ipa_endpoint_teardown_one(struct ipa_endpoint *endpoint)
 {
-	endpoint->ipa->set_up &= ~BIT(endpoint->endpoint_id);
+	__clear_bit(endpoint->endpoint_id, endpoint->ipa->set_up);
 
 	if (!endpoint->toward_ipa)
 		cancel_delayed_work_sync(&endpoint->replenish_work);
@@ -1819,23 +1819,16 @@ void ipa_endpoint_setup(struct ipa *ipa)
 {
 	u32 endpoint_id;
 
-	ipa->set_up = 0;
 	for_each_set_bit(endpoint_id, ipa->defined, ipa->endpoint_count)
 		ipa_endpoint_setup_one(&ipa->endpoint[endpoint_id]);
 }
 
 void ipa_endpoint_teardown(struct ipa *ipa)
 {
-	u32 set_up = ipa->set_up;
-
-	while (set_up) {
-		u32 endpoint_id = __fls(set_up);
-
-		set_up ^= BIT(endpoint_id);
+	u32 endpoint_id;
 
+	for_each_set_bit(endpoint_id, ipa->set_up, ipa->endpoint_count)
 		ipa_endpoint_teardown_one(&ipa->endpoint[endpoint_id]);
-	}
-	ipa->set_up = 0;
 }
 
 void ipa_endpoint_deconfig(struct ipa *ipa)
@@ -1978,6 +1971,8 @@ void ipa_endpoint_exit(struct ipa *ipa)
 	for_each_set_bit(endpoint_id, ipa->defined, ipa->endpoint_count)
 		ipa_endpoint_exit_one(&ipa->endpoint[endpoint_id]);
 
+	bitmap_free(ipa->set_up);
+	ipa->set_up = NULL;
 	bitmap_free(ipa->defined);
 	ipa->defined = NULL;
 
@@ -1999,11 +1994,15 @@ int ipa_endpoint_init(struct ipa *ipa, u32 count,
 	if (!ipa->endpoint_count)
 		return -EINVAL;
 
-	/* Initialize the defined endpoint bitmap */
+	/* Initialize endpoint state bitmaps */
 	ipa->defined = bitmap_zalloc(ipa->endpoint_count, GFP_KERNEL);
 	if (!ipa->defined)
 		return -ENOMEM;
 
+	ipa->set_up = bitmap_zalloc(ipa->endpoint_count, GFP_KERNEL);
+	if (!ipa->set_up)
+		goto err_free_defined;
+
 	filtered = 0;
 	for (name = 0; name < count; name++, data++) {
 		if (ipa_gsi_endpoint_data_empty(data))
@@ -2017,15 +2016,20 @@ int ipa_endpoint_init(struct ipa *ipa, u32 count,
 			ipa->modem_tx_count++;
 	}
 
-	if (!ipa_filtered_valid(ipa, filtered))
-		goto err_endpoint_exit;
+	/* Make sure the set of filtered endpoints is valid */
+	if (!ipa_filtered_valid(ipa, filtered)) {
+		ipa_endpoint_exit(ipa);
+
+		return -EINVAL;
+	}
 
 	ipa->filtered = filtered;
 
 	return 0;
 
-err_endpoint_exit:
-	ipa_endpoint_exit(ipa);
+err_free_defined:
+	bitmap_free(ipa->defined);
+	ipa->defined = NULL;
 
-	return -EINVAL;
+	return -ENOMEM;
 }
-- 
2.34.1

