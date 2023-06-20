Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E942D736F36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjFTOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjFTOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49701716
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687272722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ELfQweYC/8dcGoZH9AqfrEpzRTMlTZCKvStu6Pf4W0w=;
        b=f0J3Y1poW/SlPh66cw+iHLrjZo37PgCBHAXxjVBekPafLQQoz/a32OlBOllV5K7WyvEXW/
        GjrM2fMY6B0HhHmR8euVJhWc00/j1DoSFdQUT0FQNKA7p9BfARRTEcQJNB2Lqb1wbMFv31
        wgdzn8rGZpdeGJi9v5NtuWO0O56h628=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-bNBdKun_PNWBBkWTQYd94g-1; Tue, 20 Jun 2023 10:51:56 -0400
X-MC-Unique: bNBdKun_PNWBBkWTQYd94g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B55B1104459E;
        Tue, 20 Jun 2023 14:48:57 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.43.2.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 895012166B26;
        Tue, 20 Jun 2023 14:48:56 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] bnxt_en: Link representors to PCI device
Date:   Tue, 20 Jun 2023 16:48:55 +0200
Message-Id: <20230620144855.288443-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link VF representors to parent PCI device to benefit from
systemd defined naming scheme.

Without this change the representor is visible as ethN.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 2f1a1f2d2157..1467b94a6427 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -468,6 +468,7 @@ static void bnxt_vf_rep_netdev_init(struct bnxt *bp, struct bnxt_vf_rep *vf_rep,
 	struct net_device *pf_dev = bp->dev;
 	u16 max_mtu;
 
+	SET_NETDEV_DEV(dev, &bp->pdev->dev);
 	dev->netdev_ops = &bnxt_vf_rep_netdev_ops;
 	dev->ethtool_ops = &bnxt_vf_rep_ethtool_ops;
 	/* Just inherit all the featues of the parent PF as the VF-R
-- 
2.39.3

