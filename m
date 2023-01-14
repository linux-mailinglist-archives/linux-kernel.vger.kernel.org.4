Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843FB66ABDC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjANOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 09:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjANOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 09:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160CD76A4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673705073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6F2gTFb1ZrF9f6ES4DXTz8rBxEV3JQ1L7+17Uewwhrc=;
        b=MNunkNv98/+5GXpYW7IIh6Gp9G6R5eA3WYSQhRTpO/jZhGlYxPTYkA91rP4SHoi22RkIeD
        IIjrLgPY4KIuZOBo23y8ahLxHFfbfYx0cANdWTihHF6zpBn96ySQSxKHA4mSFiESwL0wpf
        3Znsq6OFy60zSKEf1iaLE6QlVWfDQwM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-y5a-iaLXP3SLAtb9VopGDA-1; Sat, 14 Jan 2023 09:04:30 -0500
X-MC-Unique: y5a-iaLXP3SLAtb9VopGDA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-4df09d38d4fso41188027b3.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 06:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F2gTFb1ZrF9f6ES4DXTz8rBxEV3JQ1L7+17Uewwhrc=;
        b=7ju/frYq42YJxHHdyojUkmKko09PC1NcFyNX6Oo2NRzefOKBhyO7X+n0KeAlQd0/Li
         kW/jb456RnDZWkQWGnXG6hOhMjBHhMAbm8KVjvZKTCILsUCNzw7x9sv6I6vYXxgM2svK
         qz3/PRcA3amrO/uZVhtqDftV/t1QcMkNfCKIakbJx5knD+UZ1p2FvjixETuAHsu+DaJ4
         mRLsHwOB3dLsN7I3ZvbM0YAYXB8qfcZBVV+LBmFsG1chxHhWEqtCJPXlt1EqP9gdm2Zs
         cOcvTl+m5CxUqgEbcb0BrMayalF2+LYhseXKZzq3Gyhr44WwTAY7fLkKAxxiwRT9I9KK
         2dOw==
X-Gm-Message-State: AFqh2kr/z2nHdsAMCfSE5uWBmsZa+yUs8nJ7bInauaLkHATG9WkfWfSs
        YEJzM9DHhDsz+h31o2Nzci4Jey5eSZAdcS7MbKxxQ+Ur6dhrjW2MrbcSvvZ0Z/onUIleCYesVQD
        b33IxOj7o/VL5GWHG4wm/f0Ti
X-Received: by 2002:a05:7500:398d:b0:f1:c205:b468 with SMTP id lu13-20020a057500398d00b000f1c205b468mr303197gab.48.1673705069470;
        Sat, 14 Jan 2023 06:04:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsVpjjeHbW3FsEjFjGQmccrBWIuIWhHpfGIsTLiovScnaV9wcQ0yrSXBbBjxnBKtOpqCbSnHw==
X-Received: by 2002:a05:7500:398d:b0:f1:c205:b468 with SMTP id lu13-20020a057500398d00b000f1c205b468mr303174gab.48.1673705069108;
        Sat, 14 Jan 2023 06:04:29 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id br43-20020a05620a462b00b006ec771d8f89sm14675789qkb.112.2023.01.14.06.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:04:28 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, vinicius.gomes@intel.com,
        jeffrey.t.kirsher@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] igc: return an error if the mac type is unknown in igc_ptp_systim_to_hwtstamp()
Date:   Sat, 14 Jan 2023 09:04:12 -0500
Message-Id: <20230114140412.3975245-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang static analysis reports
drivers/net/ethernet/intel/igc/igc_ptp.c:673:3: warning: The left operand of
  '+' is a garbage value [core.UndefinedBinaryOperatorResult]
   ktime_add_ns(shhwtstamps.hwtstamp, adjust);
   ^            ~~~~~~~~~~~~~~~~~~~~

igc_ptp_systim_to_hwtstamp() silently returns without setting the hwtstamp
if the mac type is unknown.  This should be treated as an error.

Fixes: 81b055205e8b ("igc: Add support for RX timestamping")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index c34734d432e0..4e10ced736db 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -417,10 +417,12 @@ static int igc_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
  *
  * We need to convert the system time value stored in the RX/TXSTMP registers
  * into a hwtstamp which can be used by the upper level timestamping functions.
+ *
+ * Returns 0 on success.
  **/
-static void igc_ptp_systim_to_hwtstamp(struct igc_adapter *adapter,
-				       struct skb_shared_hwtstamps *hwtstamps,
-				       u64 systim)
+static int igc_ptp_systim_to_hwtstamp(struct igc_adapter *adapter,
+				      struct skb_shared_hwtstamps *hwtstamps,
+				      u64 systim)
 {
 	switch (adapter->hw.mac.type) {
 	case igc_i225:
@@ -430,8 +432,9 @@ static void igc_ptp_systim_to_hwtstamp(struct igc_adapter *adapter,
 						systim & 0xFFFFFFFF);
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
+	return 0;
 }
 
 /**
@@ -652,7 +655,8 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 
 	regval = rd32(IGC_TXSTMPL);
 	regval |= (u64)rd32(IGC_TXSTMPH) << 32;
-	igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
+	if (igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval))
+		return;
 
 	switch (adapter->link_speed) {
 	case SPEED_10:
-- 
2.27.0

