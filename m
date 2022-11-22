Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1A633C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiKVMNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiKVMN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:13:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EC219A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:13:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso13568854pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqqH+KtltAIS/pFAox0tP5CorP8judi8TGy+EIrJngM=;
        b=fMeFNd836ur3ELuYWhGiXArQ+Pgxh04yl63lypuVxjxGnWCrm0Ggu0W802uFRdlm1F
         L+FoXz6kE/vsydcsM9XYxzRB9WsLRj23v8yzoPoOnF2ki0qCxXRx4eUhKXb4/L/j0YDD
         I2EXy0hDhrN5QLyOHhfaGzqKGPDDXKJhWgxrdsaz2nigyygG9A2gtPZDznWNls54MO2Y
         A03UW4miHqWKB6TO5dh8Zf2wkgZcfKt0uoiI0bfk7PbgFJt9MdG8TJVJzM4RouHZIBX6
         LZZa+Rvs0Bd2OS8gCPsGAJyV5D7I3M3DFp7wQG94KOlQCLiCrGV7yUIoONHsZ6EHh02z
         XPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqqH+KtltAIS/pFAox0tP5CorP8judi8TGy+EIrJngM=;
        b=ZoUioRIifllDeSw1WaF630YSpp1LgYGZWWoN63hg11A9Yj9FfQlaL18/K7KM+WtAfH
         YWrYnH/lR8YBR3JSJhgieUbskO91xIpFZT9OasvrtjB5/WuU1/mirLlfn97Nd/M1qoAE
         +N55jvTTqB/vpdem7fmQH28SlB7AMuHoGErCb/hZSlmUK2EFnDnoEVuR6lqL07QUdlgn
         hF2VM7EcMcsejaDuZwmTlOm8O7Uauhjfo2/Y1tXpG4O1XC37sQWLUcof8+b89yrovzQJ
         YA79jOPtVlJ9RE/Vghq92DmPpRhfX4Fv3snvqVq4zQ/WWqVO9i4qUKiq/tBZSJrIyztd
         gMBw==
X-Gm-Message-State: ANoB5pkQC80NanjL72lr89XXwOfW7Fp9SXc59HwItdgMWhoR24Hhea9Y
        ASh6sRT6kuzxOt4Lf7AffdAPN8AV/+mhbw==
X-Google-Smtp-Source: AA0mqf6MKdOYF2Goa3/2/FWQI2WYKUzDrYu7jWUP2jTUJPr+UkwC7b0ul9u5Zi5tkHIrl0dUwfurRA==
X-Received: by 2002:a17:903:2093:b0:188:82fc:e284 with SMTP id d19-20020a170903209300b0018882fce284mr3723448plc.76.1669119204574;
        Tue, 22 Nov 2022 04:13:24 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id r3-20020a17090a940300b001fd6066284dsm9464602pjo.6.2022.11.22.04.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:13:24 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yan Vugenfirer <yan@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] igb: Allocate MSI-X vector when testing
Date:   Tue, 22 Nov 2022 21:13:12 +0900
Message-Id: <20221122121312.57741-1-akihiko.odaki@daynix.com>
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

Allocate MSI-X vector when testing interrupts, otherwise the tests will
not work.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
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

