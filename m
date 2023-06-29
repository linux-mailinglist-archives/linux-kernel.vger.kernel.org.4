Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA7741EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjF2Dym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjF2DyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:54:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517CC30D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:54:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so262453b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688010847; x=1690602847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2AHgNaBFK8JfNASOhLGds08CbGR9PY3Il9QtABWRh4=;
        b=et3Vu15oD0I0/VTYf3k59eeXyPxFA0clBBCUdHY1eXEFWGvj23bz+/zkFatUsDfBch
         IR+g/aHslPcC8iJreUR+tFMscRb6bLCjoLCrLTg+pc5CL/NHCvLT1Bez57oah4Kzbj9N
         G9klaQXXF9rXjC7VFINlryTVLbGlwBCQ2vrcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010847; x=1690602847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2AHgNaBFK8JfNASOhLGds08CbGR9PY3Il9QtABWRh4=;
        b=l7CdKGyvbxWq7R7sJqVZ8J8hirvi62xd5vhpxBeVEEsV9xIuHedo7c4ubGNLH5tiAM
         IzfmDKZ6KTjRwmjN0WsFqVP9Ew1S9peZJxpkuW8bnqMbCiNyhv4BV64L3r3oo5lsRWCf
         KnqVvyqC0oVe1DmxJxSVAZth2zqxoe3s+X08LFcab96QzxtrI7S90NaJzGSCpAX0HuKB
         0wH5Wxd+FM2Rrp/Ztfyygk3LmQDVPVJbSUrUN93XSxomam1tZMuoa+rFzgmrOJex/JFy
         XAY1inx/uurTi9yHDrgii5kXo0qttf55fNEraiqO7wUxwfAdJ+td6KHV/OTvTfYvVj1w
         tGXA==
X-Gm-Message-State: AC+VfDx5OMix7i4nzNelKkd6zuXlaHQO70gShrH7Qgtz2FF6t/vb5uFy
        4FCTgYYXZt0oqYvVYsAhZDN6kw==
X-Google-Smtp-Source: ACHHUZ6ERoeG3uQAKmubsGmF14KTacE2DDCjpJbY0mZaPsbsZ/WEjLnqr+/Rj0L6NaJstrbDu/M8GA==
X-Received: by 2002:a05:6a20:7d96:b0:12b:fe14:907e with SMTP id v22-20020a056a207d9600b0012bfe14907emr5996043pzj.20.1688010847675;
        Wed, 28 Jun 2023 20:54:07 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (242.67.247.35.bc.googleusercontent.com. [35.247.67.242])
        by smtp.gmail.com with ESMTPSA id r19-20020a634413000000b005579f12a238sm7019842pga.86.2023.06.28.20.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 20:54:07 -0700 (PDT)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     johannes.berg@intel.com, kvalo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kuabhs@chromium.org,
        netdev@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath10k: mac: enable WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON on ath10k
Date:   Thu, 29 Jun 2023 03:52:55 +0000
Message-ID: <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230629035254.1.I059fe585f9f9e896c2d51028ef804d197c8c009e@changeid>
References: <20230629035254.1.I059fe585f9f9e896c2d51028ef804d197c8c009e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling this flag, ensures that reg_call_notifier is called
on beacon hints from handle_reg_beacon in cfg80211. This call
propagates the channel property changes to ath10k driver, thus
changing the channel property from passive scan to active scan
based on beacon hints.
Once the channels are rightly changed from passive to active,the
connection to hidden SSID does not fail.

Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

 drivers/net/wireless/ath/ath10k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7675858f069b..12df3228b120 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -10033,6 +10033,7 @@ int ath10k_mac_register(struct ath10k *ar)
 
 	ar->hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
 	ar->hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	ar->hw->wiphy->flags |= WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON;
 
 	if (ar->ht_cap_info & WMI_HT_CAP_DYNAMIC_SMPS)
 		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
-- 
2.41.0.162.gfafddb0af9-goog

