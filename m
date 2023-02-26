Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BDB6A32DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBZQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBZQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:35:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32B1589B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677429274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AORosMQj3A7DS3Nk/fBRbnzvD4PblGqGAWvsizAa8P8=;
        b=YGm/6kgWz96USy3U4u6R1DAy+r5k4X5KptyHlfg4RMRhII/dzqs6SNm0VR/B/Rki6vnul2
        qCi+AHD8bAncyzpTn1FLa4qEv0Y3iBZQD6zPvf86/7qXdYfebqb7uyIvP+pZuGUUkkubLb
        sciEHqg04dMuTm2T8ZrM+IBrw3mVO0Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-isXqnl1SPFesbMalR5vntQ-1; Sun, 26 Feb 2023 11:34:33 -0500
X-MC-Unique: isXqnl1SPFesbMalR5vntQ-1
Received: by mail-qt1-f199.google.com with SMTP id g13-20020ac8124d000000b003bfba5d76a3so1718838qtj.15
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AORosMQj3A7DS3Nk/fBRbnzvD4PblGqGAWvsizAa8P8=;
        b=UASK+4GfWNE3gUofBbpoiic7uDeW6+A0wgoPb5Uqvf6oD52BVWWlTJLDHZ/uWVNr9x
         hrV3nYDkEeb0lYWdxJlojh8525bZvAYefyO8o24RY7/F0KCj8aV/tLNIyBgDrjSEgN4Y
         nb6B8qxV8secNktUK+a/6jIL1twj+p538v7DXE6sWrxH1Twy96cN49tzZpOOij/rXRGy
         h5dDhny7KaRzQwPZoAO+4Ph64XzVPLtnWOikB7H/42S/CcSKQ8jDDpwOqpHbIfv9oRWY
         jB0qOhpbcBqKYxki4a5ZcDRy2ZVat2I4d1nfsDHWZd8ixcNiyiakLdMd/AU38c/D343R
         0bcw==
X-Gm-Message-State: AO0yUKX8ad68jA/MuBaHaOCruPNhMDhwW54Vpl2xJKtPsuw4qSV28DLF
        RuDuIMalu2IxPbi6UxJ8R8b391BUeHIIaDRSoKSq0UrVvvpIJY3uGsHiVMjcYyrP8hXvXtFhhEi
        fOzCVYxE83DcKsHdcYDc+y8H1LJK0EQ==
X-Received: by 2002:ac8:4e84:0:b0:3bf:d9a9:25fb with SMTP id 4-20020ac84e84000000b003bfd9a925fbmr876271qtp.10.1677429272647;
        Sun, 26 Feb 2023 08:34:32 -0800 (PST)
X-Google-Smtp-Source: AK7set87gS29lQpRvxFPSHfdfKAfctYcKloYbTI3zUudY16bh9F5kOGQv9rhoki2m/9HRW6el0/hNQ==
X-Received: by 2002:ac8:4e84:0:b0:3bf:d9a9:25fb with SMTP id 4-20020ac84e84000000b003bfd9a925fbmr876253qtp.10.1677429272361;
        Sun, 26 Feb 2023 08:34:32 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g2-20020ac870c2000000b003b868cdc689sm3171728qtp.5.2023.02.26.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 08:34:31 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     wei.liu@kernel.org, paul@xen.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] xen-netback: remove unused variables pending_idx and index
Date:   Sun, 26 Feb 2023 11:34:29 -0500
Message-Id: <20230226163429.2351600-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

building with gcc and W=1 reports
drivers/net/xen-netback/netback.c:886:21: error: variable
  ‘pending_idx’ set but not used [-Werror=unused-but-set-variable]
  886 |                 u16 pending_idx;
      |                     ^~~~~~~~~~~

pending_idx is not used so remove it.  Since index was only
used to set pending_idx, remove index as well.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/xen-netback/netback.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index bf627af723bf..1b42676ca141 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -883,11 +883,9 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 		struct xen_netif_tx_request txfrags[XEN_NETBK_LEGACY_SLOTS_MAX];
 		struct xen_netif_extra_info extras[XEN_NETIF_EXTRA_TYPE_MAX-1];
 		unsigned int extra_count;
-		u16 pending_idx;
 		RING_IDX idx;
 		int work_to_do;
 		unsigned int data_len;
-		pending_ring_idx_t index;
 
 		if (queue->tx.sring->req_prod - queue->tx.req_cons >
 		    XEN_NETIF_TX_RING_SIZE) {
@@ -983,9 +981,6 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 			break;
 		}
 
-		index = pending_index(queue->pending_cons);
-		pending_idx = queue->pending_ring[index];
-
 		if (ret >= XEN_NETBK_LEGACY_SLOTS_MAX - 1 && data_len < txreq.size)
 			data_len = txreq.size;
 
-- 
2.27.0

