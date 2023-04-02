Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1976A6D36BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDBJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDBJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:52:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7972C2C9FA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:51:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so106293379edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680429104; x=1683021104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaeBDPkSiTEyNdN0rUscDp5HyS5CgrVs8mEE78XtpGY=;
        b=m11NQ93My1CKSjCNRpFIoKODHOqd0MpOWOR7t4H6N1NO7dt1q4UiU98zUOXEi9iCwA
         awQ6J4BXGgVAEfH7b4sYbC10/RVwMeTSjRM5JdG7gpxSYC4ZxxBMZSee5HKAG47mca17
         ltIG5/7kpiUHLHtiHXA2qNUEQ8cP6clXZM8we4dH5rG3dYJIl0hhS3EJeQPObh/M24Mh
         BTbITuCR0msP4rZ1Z/4LU479HmI+BC+U45/0A08gsx0zOEtDAzI9OwJRs+Lndmw7uazh
         D9N+HPMlkPqf19ornTNxVJExAjHKwpl+20TGPYEESHRtFCaw6BKEDM22rsF2GOrVdchl
         M1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680429104; x=1683021104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaeBDPkSiTEyNdN0rUscDp5HyS5CgrVs8mEE78XtpGY=;
        b=O4webkITj6FfTwQvVmx+9iq5aDgyL1z6+Ca6QJ3NsJDRI1qlZVFCgi8zu5Q2jQ/6sc
         SY+r1zbbTgWzjiwPo20navyrHxIIPct1oi6dm5Ol9HDT6xOJVQ/mNH7DF6AJCHnrr6Ym
         YQxjrvIPNvO1+/6kZax/dg8SnIeFfw0TMULSQsyWYvVhQBTnZuFD9X2/0DdV9H0i7411
         7e6B8T4Cj7Ea7QFUzN+DmEgll0276gnfnLJjr+HEQRJlaURicnJopTyyVR743Doz/4Ld
         Fs2jQcwclmk8pLVfsWpM6LsTL6ipGKQ+6Y0m/HPabJTcwtDfDSlDDJs39FIJ73pOcA3C
         Ht9Q==
X-Gm-Message-State: AAQBX9e74pQh367ONjsT093ZyLSRuJZ39QCeigY0KUneTLRmTgeYNtPI
        urvbCJlD7SzanrgqRYWDiQs4CgocYbk=
X-Google-Smtp-Source: AKy350ZqQ0Kj2HWD+AtYdnNQ8V2cqxvVTdwF6CPMkzO2spgWeg9jAVZj/ZCVRcwzVdoJWiLuNlmglg==
X-Received: by 2002:a17:906:2098:b0:8d2:78c5:1d4e with SMTP id 24-20020a170906209800b008d278c51d4emr9637967ejq.5.1680429104567;
        Sun, 02 Apr 2023 02:51:44 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id gl25-20020a170906e0d900b00929fc8d264dsm3103867ejb.17.2023.04.02.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 02:51:44 -0700 (PDT)
Date:   Sun, 2 Apr 2023 11:51:42 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] staging: rtl8192e: Remove RF_Type from
 .._dm_tx_update_tssi_weak_signal
Message-ID: <95744a9d271723b44b92465809d092f90edf9bc9.1680427945.git.philipp.g.hortmann@gmail.com>
References: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680427945.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RF_Type from _rtl92e_dm_tx_update_tssi_weak_signal and
_rtl92e_dm_tx_update_tssi_strong_signal as it is unused.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1->V2: This patch did not exist before and was added because RF_Type
        was used here but left uninitialized by later patches.
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index b5f4d0230da7..258ea66ab2fd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -475,8 +475,7 @@ static u8	CCKSwingTable_Ch14[CCK_TABLE_LEN][8] = {
 #define		Tssi_Report_Value2			0x13e
 #define		FW_Busy_Flag				0x13f
 
-static void _rtl92e_dm_tx_update_tssi_weak_signal(struct net_device *dev,
-						  u8 RF_Type)
+static void _rtl92e_dm_tx_update_tssi_weak_signal(struct net_device *dev)
 {
 	struct r8192_priv *p = rtllib_priv(dev);
 
@@ -495,8 +494,7 @@ static void _rtl92e_dm_tx_update_tssi_weak_signal(struct net_device *dev,
 	}
 }
 
-static void _rtl92e_dm_tx_update_tssi_strong_signal(struct net_device *dev,
-						    u8 RF_Type)
+static void _rtl92e_dm_tx_update_tssi_strong_signal(struct net_device *dev)
 {
 	struct r8192_priv *p = rtllib_priv(dev);
 
@@ -610,10 +608,9 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				return;
 			}
 			if (Avg_TSSI_Meas_from_driver < tssi_13dBm - E_FOR_TX_POWER_TRACK)
-				_rtl92e_dm_tx_update_tssi_weak_signal(dev,
-								      RF_Type);
+				_rtl92e_dm_tx_update_tssi_weak_signal(dev);
 			else
-				_rtl92e_dm_tx_update_tssi_strong_signal(dev, RF_Type);
+				_rtl92e_dm_tx_update_tssi_strong_signal(dev);
 
 			priv->cck_present_attn_diff
 				= priv->rfa_txpowertrackingindex_real - priv->rfa_txpowertracking_default;
-- 
2.40.0

