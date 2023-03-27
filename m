Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0116CA8B7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjC0PMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjC0PMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC452D78
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679929920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DYh+IUQKnsNavgY4j1iAAQrUA1J5asaTGD0FKGxhaXM=;
        b=gjHxpna9/zhZjkVHx93GnnCf0r6QnrxSXchpybpWL4AlXh9x5qo0kptOc1Wss9ucxg7S4O
        5NNSVSGwTS6DhAj4WiKNMHBzx5PXtrNlxp8oSMN/kY4LtPIFIJ4CEjnV0oVVXpOdECiLiq
        vUbHeW0zFI0G9nHHF3IlJXS8DebVpu0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-jynXIIuSPb-o9plMoSetCQ-1; Mon, 27 Mar 2023 11:11:56 -0400
X-MC-Unique: jynXIIuSPb-o9plMoSetCQ-1
Received: by mail-qv1-f70.google.com with SMTP id v8-20020a0ccd88000000b005c1927d1609so3643097qvm.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYh+IUQKnsNavgY4j1iAAQrUA1J5asaTGD0FKGxhaXM=;
        b=ZcY062/Bvy8PCTMv6qot4e7LunGfKa8bZimAtYuyYw4KhYY2G8ySJuHPESAy4q87zR
         JHKA3uOyLu5OZbshkEHC7/0kPLeD+t+tygxr4xwB5uEWUWzvhydf4itDSVi4IppateEf
         cNNikriGSfh0nkyeaniJIeHVyCn3+Lkfn9qPyuvFUd95o43WWryuBFM5vxumGigFZs/b
         noI9l78w77EtU+/bKTqUajbAhPPDaAJhnhlnv5DfUJ7es6yrUN6ECzHQPTZNEdrc4lzF
         XZw1ir1sOPJRlEjimZvMrjgco7yM6bS1T5hsaZ0nntmgbruhwAZvYYvhuqw6lCQVF1xd
         x/Hg==
X-Gm-Message-State: AO0yUKUE+gCPseJ7ep+l4r3Fz55XfHonSG7fCVlcCvjft/fzA/1p16jR
        jK8wTnlg3/p+fbJtHRku0gKeV1rJlH8m8ewRqyIxY2jto77DtiER7aPoEFkIsFC+OWxdZEOa0Du
        lZH13uaSLTuQrJaeiplS9bsBY
X-Received: by 2002:ac8:57c2:0:b0:3e1:6c7e:2ee0 with SMTP id w2-20020ac857c2000000b003e16c7e2ee0mr22110176qta.11.1679929915683;
        Mon, 27 Mar 2023 08:11:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set9BAzNnvmMx3UPAztYRtfcEZS/JC0Zbgk59lkyKNRW1O3h/77E7anPa59QcSLU+bg9VrGKy2w==
X-Received: by 2002:ac8:57c2:0:b0:3e1:6c7e:2ee0 with SMTP id w2-20020ac857c2000000b003e16c7e2ee0mr22110133qta.11.1679929915395;
        Mon, 27 Mar 2023 08:11:55 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l6-20020ac848c6000000b003bfb0ea8094sm8328255qtr.83.2023.03.27.08.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:11:55 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] brcmsmac: ampdu: remove unused suc_mpdu variable
Date:   Mon, 27 Mar 2023 11:11:51 -0400
Message-Id: <20230327151151.1771350-1-trix@redhat.com>
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
drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:848:5: error: variable
  'suc_mpdu' set but not used [-Werror,-Wunused-but-set-variable]
        u8 suc_mpdu = 0, tot_mpdu = 0;
           ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index 2631eb7569eb..e24228e60027 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -845,7 +845,7 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 	u16 seq, start_seq = 0, bindex, index, mcl;
 	u8 mcs = 0;
 	bool ba_recd = false, ack_recd = false;
-	u8 suc_mpdu = 0, tot_mpdu = 0;
+	u8 tot_mpdu = 0;
 	uint supr_status;
 	bool retry = true;
 	u16 mimoantsel = 0;
@@ -975,7 +975,6 @@ brcms_c_ampdu_dotxstatus_complete(struct ampdu_info *ampdu, struct scb *scb,
 				ieee80211_tx_status_irqsafe(wlc->pub->ieee_hw,
 							    p);
 				ack_recd = true;
-				suc_mpdu++;
 			}
 		}
 		/* either retransmit or send bar if ack not recd */
-- 
2.27.0

