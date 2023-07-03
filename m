Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA2745C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGCMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjGCMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83876E5B;
        Mon,  3 Jul 2023 05:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12BCE60F05;
        Mon,  3 Jul 2023 12:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FE7C433C7;
        Mon,  3 Jul 2023 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688387864;
        bh=xE8FXAxkc+98q1QU4W/ZwNlsV+CRuDU4Ozer4CAamV4=;
        h=From:To:Cc:Subject:Date:From;
        b=e4Gki4SKoeFIHNhBDdp43WTmmhs67Z90hx3Gbp5OxiIM+VxYZ2YNzjuTmulL+uTnS
         hugfDCTyhZ3S0URDNTeT0ac9FNZ3aEAO1ib4xyhpZYGN8QzuQXTGzLXr+fkDPqmMjm
         FtY/C//GWwKdwOL4A8u1UTmpo1NazAca9iigX940vapsLqrCKM+3pr8mMfNMERmMLw
         Vuoax/l/WCVPLtogIR0OTtdSQkWTDWTKDPeKNPcOuMP6ZYi1WOP1DsqXGxLxMe1bZk
         AqfgoG5yyr15uGKRWXcozsSpteqhqxpGGqqTjUclquoq9teD5dO9BtMnw3RMmkcAQY
         rX298AQBd+jRA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Karthik M <quic_karm@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Aishwarya R <quic_aisr@quicinc.com>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ath12k: fix memcpy array overflow in ath12k_peer_assoc_h_he
Date:   Mon,  3 Jul 2023 14:37:29 +0200
Message-Id: <20230703123737.3420464-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Two memory copies in this function copy from a short array into a longer one,
using the wrong size, which leads to an out-of-bounds access:

include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);
                        ^
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
2 errors generated.

Fixes: d889913205cf7 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f5ebebe806e0d..b8a8d33cc4187 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1637,9 +1637,9 @@ static void ath12k_peer_assoc_h_he(struct ath12k *ar,
 	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
 
 	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
-	       sizeof(arg->peer_he_cap_macinfo));
+	       sizeof(he_cap->he_cap_elem.mac_cap_info));
 	memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
-	       sizeof(arg->peer_he_cap_phyinfo));
+	       sizeof(he_cap->he_cap_elem.phy_cap_info));
 	arg->peer_he_ops = vif->bss_conf.he_oper.params;
 
 	/* the top most byte is used to indicate BSS color info */
-- 
2.39.2

