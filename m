Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4634638B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKYNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKYNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:30:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F74523E92
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:30:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so4170324pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0f8po3oGM3AyA2xY13NNMcDFWQESZf/ZoND6qGqfcg=;
        b=hIfb04YR66SoWfN62oM3s21bvxKs1tiBUExmZ7hhHyPEfAsPrs1aHO33+wTX091uY9
         /0ZTIRcp6Gsfqf60+12xk9PQXHtZ+D5DWHIbjnc50U4juOV2D7RZli3OO77qrQReb1vQ
         V43B096wuGQrkSNeRIXacDV+0bR/v0SrelJL3ucwFP3xwPEPIzXs6RYtsXPzqSoFnEIl
         2SIF6L3qFQqeAdNewtofzukglB8pkbAMwYAvQxdgjoAxQG0K6JSAv+HCNcgfizESIn7U
         7x6nS7BFarhRuFF2bhr49E2ryaEXh6Twyey6ufMrH+bsrhMzaFIIWqsTGIsl0xGdpCW+
         6Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0f8po3oGM3AyA2xY13NNMcDFWQESZf/ZoND6qGqfcg=;
        b=tYqCQqMCziW2wbI1Iq3yvII3knPIvuR2y4VR4rUeqKOcXF7oOmYyyDztr+dsR58l5T
         KY+ty7/Rf3u3J411yQ890opgICLymzq91JyQOfuClJ1d/m5Qnc0DLmHr+Fq9pqrYvUkO
         jMjhTFljKnIxLweDM/ApSQ7f7mYVdNgE0ehWkDsKVHnU5FCGnIymIAhtigkalGbcrdPp
         2bRs9z8cyj/R7KhT0R2PS+ex6NlZET1MG8WPICirnXZoOFwzZlY+eHwx0rnahZQ+JHKF
         hEy9ky8zE0W2o/yWJoan2AnpmCMZQbM5di+An4llDdCdr1Lj0DatfP2RevZSuvbpIV2K
         nB7w==
X-Gm-Message-State: ANoB5plDLXjBBsr1l/3m2DnqVy4EGGkoFTWZwDkbdrEaKoI6akB8Lyin
        nVQ/x1PLWEKUUSAuyFAQfTUXsCugjR4DLQ==
X-Google-Smtp-Source: AA0mqf5IgZE1vhZn3LC0O+/Hr5RHzVVnpy8tovknaO0Qu5PeTaEqKfe4sUYy0yA17rIHnhmqu7+MDA==
X-Received: by 2002:a17:903:40cb:b0:178:b4b7:d74d with SMTP id t11-20020a17090340cb00b00178b4b7d74dmr18455477pld.83.1669383054458;
        Fri, 25 Nov 2022 05:30:54 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id u4-20020a63ef04000000b00476b165ff8bsm2640369pgh.57.2022.11.25.05.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:30:54 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yan Vugenfirer <yan@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net v4] igb: Allocate MSI-X vector when testing
Date:   Fri, 25 Nov 2022 22:30:31 +0900
Message-Id: <20221125133031.46845-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change, the interrupt test fail with MSI-X environment:

$ sudo ethtool -t enp0s2 offline
[   43.921783] igb 0000:00:02.0: offline testing starting
[   44.855824] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Down
[   44.961249] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   51.272202] igb 0000:00:02.0: testing shared interrupt
[   56.996975] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
The test result is FAIL
The test extra info:
Register test  (offline)	 0
Eeprom test    (offline)	 0
Interrupt test (offline)	 4
Loopback test  (offline)	 0
Link test   (on/offline)	 0

Here, "4" means an expected interrupt was not delivered.

To fix this, route IRQs correctly to the first MSI-X vector by setting
IVAR_MISC. Also, set bit 0 of EIMS so that the vector will not be
masked. The interrupt test now runs properly with this change:

$ sudo ethtool -t enp0s2 offline
[   42.762985] igb 0000:00:02.0: offline testing starting
[   50.141967] igb 0000:00:02.0: testing shared interrupt
[   56.163957] igb 0000:00:02.0 enp0s2: igb: enp0s2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
The test result is PASS
The test extra info:
Register test  (offline)	 0
Eeprom test    (offline)	 0
Interrupt test (offline)	 0
Loopback test  (offline)	 0
Link test   (on/offline)	 0

Fixes: 4eefa8f01314 ("igb: add single vector msi-x testing to interrupt test")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
V3 -> V4: Added Fixes: tag

 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e5f3e7680dc6..ff911af16a4b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1413,6 +1413,8 @@ static int igb_intr_test(struct igb_adapter *adapter, u64 *data)
 			*data = 1;
 			return -1;
 		}
+		wr32(E1000_IVAR_MISC, E1000_IVAR_VALID << 8);
+		wr32(E1000_EIMS, BIT(0));
 	} else if (adapter->flags & IGB_FLAG_HAS_MSI) {
 		shared_int = false;
 		if (request_irq(irq,
-- 
2.38.1

