Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA2653C00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLVGFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiLVGF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:05:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4119612D36
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671689080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xrsqGz7chPZ2KmKpMG8QR1W3lTlHGgi0D+G+V4JZPLQ=;
        b=iImIyes7xYAVCGxbwG5lv3vho/bTH2+VkThpxSV6CQQjwInQ4NM+DVttPfb1ooajaUGepS
        Rchkt1AEphWmp+GHiy7xigoxD2FpKbThgVQcn4GMJLCckC42QjkiZOWaA5EPQc7tZYTmvf
        FauQtTVWsJtAfYB8Q8daPZK4vplrcP0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-WY9h8Mx9PDWA6rvdtnC63g-1; Thu, 22 Dec 2022 01:04:37 -0500
X-MC-Unique: WY9h8Mx9PDWA6rvdtnC63g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F8C91C0514F;
        Thu, 22 Dec 2022 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-179.pek2.redhat.com [10.72.13.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89948112132C;
        Thu, 22 Dec 2022 06:04:29 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
Subject: [RFC PATCH 0/4] virtio-net: don't busy poll for cvq command
Date:   Thu, 22 Dec 2022 14:04:23 +0800
Message-Id: <20221222060427.21626-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

The code used to busy poll for cvq command which turns out to have
several side effects:

1) infinite poll for buggy devices
2) bad interaction with scheduler

So this series tries to use sleep + timeout instead of busy polling.

Please review.

Thanks

Jason Wang (4):
  virtio-net: convert rx mode setting to use workqueue
  virtio_ring: switch to use BAD_RING()
  virtio_ring: introduce a per virtqueue waitqueue
  virtio-net: sleep instead of busy waiting for cvq command

 drivers/net/virtio_net.c     | 79 +++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_ring.c | 33 ++++++++++++++-
 include/linux/virtio.h       |  4 ++
 3 files changed, 105 insertions(+), 11 deletions(-)

-- 
2.25.1

