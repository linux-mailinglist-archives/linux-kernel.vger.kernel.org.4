Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1756770F07C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbjEXITf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjEXITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C04132
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684916333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tr17fslrkCiphsGkEGKeZVhavScCHFO7w1RXhH4sGc0=;
        b=WxxqVTlATJ40JI/7vB9FNakcabu+r6NOM57ShygFbQN2CKBM5o7c+fi+j/n38BPMws613V
        4NPjyk8Gjesm1fDrYIthtbvd1502Os9MO/FGFARKyMluBPQrAFYZ1k4z9S3jwBGsPyPe0P
        pBHLmwhUd6WZr813H+Dnp7yQTP1Pk8c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-2JRr0exkNyGTgTbJbqvnjw-1; Wed, 24 May 2023 04:18:50 -0400
X-MC-Unique: 2JRr0exkNyGTgTbJbqvnjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD9EC3C02B62;
        Wed, 24 May 2023 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-76.pek2.redhat.com [10.72.13.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 356C6140EBD7;
        Wed, 24 May 2023 08:18:44 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com
Subject: [PATCH V3 net-next 0/2] virtio-net: don't busy poll for cvq command
Date:   Wed, 24 May 2023 16:18:40 +0800
Message-Id: <20230524081842.3060-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

So this series tries to use cond_resched() in the waiting loop. Before
doing this we need first make sure the cvq command is not executed in
atomic environment, so we need first convert rx mode handling to a
workqueue.

Please review.

Thanks

Changes since V2:

- Don't use interrupt but cond_resched()

Changes since V1:

- use RTNL to synchronize rx mode worker
- use completion for simplicity
- don't try to harden CVQ command

Changes since RFC:

- switch to use BAD_RING in virtio_break_device()
- check virtqueue_is_broken() after being woken up
- use more_used() instead of virtqueue_get_buf() to allow caller to
  get buffers afterwards
  - break the virtio-net device when timeout
  - get buffer manually since the virtio core check more_used() instead

Jason Wang (2):
  virtio-net: convert rx mode setting to use workqueue
  virtio-net: add cond_resched() to the command waiting loop

 drivers/net/virtio_net.c | 59 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

-- 
2.25.1

