Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06AD743F16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjF3PmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjF3PmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:42:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773E1B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:42:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso18391175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1688139734; x=1690731734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mb3ZyytePmgU5kXtBpOaRC5ZBHhiy7A4A4l54PC6cxA=;
        b=mbzR+eTISbWi7Y5Tsf5ak7r4fJt1OPPu7ahtEdhOEJP6KyhnEi+PItlXGZSzDui7Xl
         lwndVSYLHmk1WL4+s6KCnd5mvzjWuXFspaBo3GK5Vo8Ekm/qUsbxsICnkhdUX058NpNl
         fVusEGlk9xmWFQWn8LWnT0uJGV//uUXMKWdiKf/8MOggluQArEUuvGLA3EjMmg08qkpJ
         KjD/pB0llsOA7XbEtGY0RCitaWdW4i4HWjfXW/g1hFeB5GDxGk4EBumoB+k7MJ/OaOJl
         cQyF14RHuGBBdbbRwvzVwsJoVwVo1Nc6h30zAQyn2bJQ4hxWAGXaynNR7LG2/dpNE4Bk
         rfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139734; x=1690731734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mb3ZyytePmgU5kXtBpOaRC5ZBHhiy7A4A4l54PC6cxA=;
        b=OZWunOFgtO7R8tYXP3rAd3nrjEFtp5EcZyG1m5oe7ZMdVNtWAOaVZoKutoQYU+b43k
         BI3SIvGO1AVxsj7KKh2GbQ73Ue9VHlBcuwqU6ZcZIHHiz0vQpUajKwysWKOzc2+//H2F
         VYIVNtyd8T3R1TkLCJh6r37bQWq8JPEWvLhksFLAXTE9JJFOB6MejTZc3OkjQTZKCxBm
         94tglYU+6FbtCOsu/47YGc5ANXBiWd0uLTltQNZiQ1RnTNniVp3uaxZLcC0dBWWrdHyC
         u3O5X84tkOEpVS6srYbo6baRD28cTx3GN+YSBBDL66fFYslW0qY8l63Kp7w0nVJ1wjSr
         f0pA==
X-Gm-Message-State: AC+VfDyWCVfrxT3dNpRdspbn3X9JCoE2UOEqP2sYeGQGJXIos5ixOtqU
        vdLrIhk8GXEXA311qlR0OuEFIPovIMqmrOUHDK9D1A==
X-Google-Smtp-Source: ACHHUZ5Sa0UH0MFROBtcTH3CC4NpkODJDVsFDjTUA1Qkfq1bMAcTPTfqFFIv+UF1mNDqRY7tZ51fZg==
X-Received: by 2002:a05:600c:3d9b:b0:3fb:c257:9f48 with SMTP id bi27-20020a05600c3d9b00b003fbc2579f48mr3220754wmb.16.1688139734419;
        Fri, 30 Jun 2023 08:42:14 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003fbaf9abf2fsm7690279wmk.23.2023.06.30.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:42:13 -0700 (PDT)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] igb: Use TAI clock to reset PHC value
Date:   Fri, 30 Jun 2023 17:41:38 +0200
Message-Id: <20230630154138.4041809-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHC is usually synchronised in TAI (from PTP). By resetting it with
the kernel TAI clock we avoid having to correct the PHC from REALTIME
(usually UTC) to TAI (37s as of today).

RFC: While this patch looks trivial and it does make linuxptp/ptp4l
complain about a driver bug:
  timed out while polling for tx timestamp
  increasing tx_timestamp_timeout may correct this issue, but it is likely caused by a driver bug
  port 1: send peer delay response failed

Increasing tx_timestamp_timeout to 1s does nothing different so I guess
the driver does indeed freeze with this change but I can't figure out
why... 

Do you have any idea/pointers? Thanks!

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 15e57460e19ea..65e5de2ccb279 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1526,12 +1526,12 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 
 	/* Re-initialize the timer. */
 	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
-		struct timespec64 ts = ktime_to_timespec64(ktime_get_real());
+		struct timespec64 ts = ktime_to_timespec64(ktime_get_clocktai());
 
 		igb_ptp_write_i210(adapter, &ts);
 	} else {
 		timecounter_init(&adapter->tc, &adapter->cc,
-				 ktime_to_ns(ktime_get_real()));
+				 ktime_to_ns(ktime_get_clocktai()));
 	}
 out:
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
-- 
2.30.2

