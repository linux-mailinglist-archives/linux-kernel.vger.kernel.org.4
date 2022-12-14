Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F344E64C393
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 06:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiLNFoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 00:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNFoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 00:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B4E21820
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 21:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670996602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V9UP/CTSIMfZfsUiu6QtPzTE0dvjHLUoal5FVlievJ8=;
        b=YJuggj09PrXA+BZHV0sX5EROzLHY9gugXRCrTB/qMvx2CoEfuG5p8DDiUhVBFXlSmW/l0p
        BGmNvKrnBDvI3SEsplYCnUml3sPv5cFtz9PrNDCtM2NWi9Wh6kq58/7sqToO4hE+Y7xPA4
        z0g0wcVdPEpZ8qK7d699k4lqW4pKPgk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-GBCDswOGMGegpPClBqM9eA-1; Wed, 14 Dec 2022 00:43:20 -0500
X-MC-Unique: GBCDswOGMGegpPClBqM9eA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D65D0811E6E;
        Wed, 14 Dec 2022 05:43:19 +0000 (UTC)
Received: from server.redhat.com (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93EF72166B26;
        Wed, 14 Dec 2022 05:43:17 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa_sim_net: should not drop the multicast/broadcast packet
Date:   Wed, 14 Dec 2022 13:43:06 +0800
Message-Id: <20221214054306.24145-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the receive_filter(), should not drop the packet with the
broadcast/multicast address. Add the check for this

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225ea469..0f4739c31eea 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -62,6 +62,9 @@ static bool receive_filter(struct vdpasim *vdpasim, size_t len)
 	if (len < ETH_ALEN + hdr_len)
 		return false;
 
+	if (is_broadcast_ether_addr(vdpasim->buffer + hdr_len) ||
+	    is_multicast_ether_addr(vdpasim->buffer + hdr_len))
+		return true;
 	if (!strncmp(vdpasim->buffer + hdr_len, vio_config->mac, ETH_ALEN))
 		return true;
 
-- 
2.34.3

