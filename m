Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E325D7193CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjFAHBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjFAHBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:01:07 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AF1A3;
        Thu,  1 Jun 2023 00:01:05 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-558565cc59bso430418eaf.0;
        Thu, 01 Jun 2023 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685602865; x=1688194865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufZlzhRbgrp2ECAGGL+klhy80faTIJsC40pw0AO7I/s=;
        b=YStVcwYM9hqQJgsRY155+ZbILLF0giQbOMCgHsvoLaIGmWRAYdASz8Wl56wm6r/H9q
         Jsj/WQiM1qH3TcQ32k8TkLSRqu/EPfPGo69MgOAqjwLEXFfu9kiPbjjoRrxO6AM5mP/b
         JRf3yrWLDEBmxdGQG85LcPICjjP592buGPWHAt6cYZtHlRkFsfex1eom5FrDjhAOQKYZ
         EiuhRLFexR1Tbbp9cvG7u2nCbY3HnzemsEadP/UNabsQqAlGqIVv4srG1ooiPdN1S/2x
         366sRBsmGhW/5Fkk13AJ8/X7XQnI/f0qU9j7TqZqRd8XsM09FdYYpgVBntPNvZ/Pcb1/
         cmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685602865; x=1688194865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufZlzhRbgrp2ECAGGL+klhy80faTIJsC40pw0AO7I/s=;
        b=IEmfNOJ8QSjG6+jJ8k1HqOOJsQyVaQCPSL2LKVTNpfM6geHQ2vTxYpoqRAxzmnIk5v
         9ac86qKb88soqS16xv3vzZ12L+UqbnLXFL40q6IzJG7vsDQBap4VPShoUwbyCH5M8qgV
         jgkigcTzrLOVgKn4mOqDkDEsve3eD2yU9FaFvlyiquTZpL992Oo1FsFEKhZHSk+0XL8m
         Dema80CMHbbbRnL5eI2dJ76afg0rBuuDZEXLAW5FEaC2sJ64ooNApSjSgKynm3gyCHpL
         F0jC/Mjlc1oYiC/MZFODxfTAPMNl+kjSc4vfKqYGO8u92yA+movepXeNMfX98M9Bu4Ep
         ZmfA==
X-Gm-Message-State: AC+VfDzw/Rr+63GHvowJUiwFWLwXnAhjL9zBXpm48mL1/DeaaM3B/MHc
        /p/g28978wIazvPsN01UR3fSX1d1hXwzsXoQfk0=
X-Google-Smtp-Source: ACHHUZ4baPIwOegGnCejHi+mh7aZuQhlsdJwMQ6jefUHQyPArJwNd9ujW+n/AO/1O63Z2BURJHViDw==
X-Received: by 2002:a05:6358:419b:b0:123:30e2:4cfd with SMTP id w27-20020a056358419b00b0012330e24cfdmr5972236rwc.18.1685602864726;
        Thu, 01 Jun 2023 00:01:04 -0700 (PDT)
Received: from dnptp-9.. ([111.198.57.33])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a2f2500b0024df6bbf5d8sm712591pjd.30.2023.06.01.00.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:01:04 -0700 (PDT)
From:   Yuezhen Luan <eggcar.luan@gmail.com>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jacob.e.keller@intel.com,
        Yuezhen Luan <eggcar.luan@gmail.com>
Subject: [PATCH v2] igb: Fix extts capture value format for 82580/i354/i350
Date:   Thu,  1 Jun 2023 07:00:58 +0000
Message-Id: <20230601070058.2117-1-eggcar.luan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

82580/i354/i350 features circle-counter-like timestamp registers
that are different with newer i210. The EXTTS capture value in
AUXTSMPx should be converted from raw circle counter value to
timestamp value in resolution of 1 nanosec by the driver.

This issue can be reproduced on i350 nics, connecting an 1PPS
signal to a SDP pin, and run 'ts2phc' command to read external
1PPS timestamp value. On i210 this works fine, but on i350 the
extts is not correctly converted.

The i350/i354/82580's SYSTIM and other timestamp registers are
40bit counters, presenting time range of 2^40 ns, that means these
registers overflows every about 1099s. This causes all these regs
can't be used directly in contrast to the newer i210/i211s.

The igb driver needs to convert these raw register values to
valid time stamp format by using kernel timecounter apis for i350s
families. Here the igb_extts() just forgot to do the convert.

Signed-off-by: Yuezhen Luan <eggcar.luan@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 58872a4c2..bb3db387d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6947,6 +6947,7 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 	struct e1000_hw *hw = &adapter->hw;
 	struct ptp_clock_event event;
 	struct timespec64 ts;
+	unsigned long flags;
 
 	if (pin < 0 || pin >= IGB_N_SDP)
 		return;
@@ -6954,9 +6955,12 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 	if (hw->mac.type == e1000_82580 ||
 	    hw->mac.type == e1000_i354 ||
 	    hw->mac.type == e1000_i350) {
-		s64 ns = rd32(auxstmpl);
+		u64 ns = rd32(auxstmpl);
 
-		ns += ((s64)(rd32(auxstmph) & 0xFF)) << 32;
+		ns += ((u64)(rd32(auxstmph) & 0xFF)) << 32;
+		spin_lock_irqsave(&adapter->tmreg_lock, flags);
+		ns = timecounter_cyc2time(&adapter->tc, ns);
+		spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 		ts = ns_to_timespec64(ns);
 	} else {
 		ts.tv_nsec = rd32(auxstmpl);
-- 
2.34.1

