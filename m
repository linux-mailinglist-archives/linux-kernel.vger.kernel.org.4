Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F86C8E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCYN1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671D7AA3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679750777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Iii/UTDXaMnO4Wo0x/DUKmtgVb8N0aI08+TcTOIFrv0=;
        b=SVKjURyhwlnaSD720uTrg+Qc+ocVbghOY+lV6cGLby6eRltfQPstj12n/WKHwEHc5KmIYt
        fjtcmmRKPBot0dcxL4ZIO5kqWahZWqR4I4DZwg2qGuO0Lk8KlYoHdPHVEIBEjfOt3bk3eB
        //gNSdNj1gM7kzyuOvDaSQqRyZfNVl8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-DknCjfuHNMiyLlYHbYWFig-1; Sat, 25 Mar 2023 09:26:14 -0400
X-MC-Unique: DknCjfuHNMiyLlYHbYWFig-1
Received: by mail-qt1-f198.google.com with SMTP id a11-20020ac85b8b000000b003e3979be6abso2770670qta.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679750773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iii/UTDXaMnO4Wo0x/DUKmtgVb8N0aI08+TcTOIFrv0=;
        b=1Z10jXgUfGc2PL5L7ncAe//68ZjYvWHK5FuS7xuX8KdKw36GUDkMmPrnG3GS6UZhWV
         ojorKUlqtrXOrt9kch9ExObh/C8pUbTfMQbYil7xU2sWjNiABLToHM8TLf3lEC6f0Opn
         m/L3um1tfIcYrq3dbqNrvXuHGtOugeHTl2LbLL39RVwkEzyzFVVFYPHUAzLM1iZNdXZB
         py8CxIoip+zp7+fAASNlRNqDd1i7Dd8wobTtR0hhvUTaewsV+2Abd4ngdPiFd2P3rHbX
         Vw3QIJBfPMsqXnn3kx+eXZ8gXBXrgLpeYVSVFO9LabcobZW3/qAvzIY7NuSbYEaFI9YE
         Afug==
X-Gm-Message-State: AAQBX9dj8yOTxdDtR8K7ij94wVTfqtTU5oydzd35KUKe1Fdyqd5Mlhh7
        kq5ROwZ1/neJDNsoKVb87uwH8K6bfxBt2klLyFSRTfcu2241RqjEiyEfcA8PpNCe4TZS/bGKUgb
        gpaZuRWk25St2yVjP3OpHVPOg
X-Received: by 2002:ad4:5bca:0:b0:5db:4d15:524d with SMTP id t10-20020ad45bca000000b005db4d15524dmr9054491qvt.52.1679750773653;
        Sat, 25 Mar 2023 06:26:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZlSGE95XTMsRO2eDXbclLRJ4kBq2KCSDNceqlNvQKjXpkqvXFlqtmH3evRGVGbNTwKl3s28w==
X-Received: by 2002:ad4:5bca:0:b0:5db:4d15:524d with SMTP id t10-20020ad45bca000000b005db4d15524dmr9054475qvt.52.1679750773419;
        Sat, 25 Mar 2023 06:26:13 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a040b00b007468733cd1fsm4212329qkp.58.2023.03.25.06.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:26:13 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mac80211: minstrel_ht: remove unused n_supported variable
Date:   Sat, 25 Mar 2023 09:26:10 -0400
Message-Id: <20230325132610.1334820-1-trix@redhat.com>
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
net/mac80211/rc80211_minstrel_ht.c:1711:6: error: variable
  'n_supported' set but not used [-Werror,-Wunused-but-set-variable]
        int n_supported = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/mac80211/rc80211_minstrel_ht.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 762346598338..b34c80522047 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1708,7 +1708,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	struct sta_info *sta_info;
 	bool ldpc, erp;
 	int use_vht;
-	int n_supported = 0;
 	int ack_dur;
 	int stbc;
 	int i;
@@ -1791,8 +1790,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 				continue;
 
 			mi->supported[i] = mcs->rx_mask[nss - 1];
-			if (mi->supported[i])
-				n_supported++;
 			continue;
 		}
 
@@ -1819,9 +1816,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 
 		mi->supported[i] = minstrel_get_valid_vht_rates(bw, nss,
 				vht_cap->vht_mcs.tx_mcs_map);
-
-		if (mi->supported[i])
-			n_supported++;
 	}
 
 	sta_info = container_of(sta, struct sta_info, sta);
-- 
2.27.0

