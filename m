Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF873FB37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjF0LiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjF0LiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC3310FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687865842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tdurvxft1YKsdJG5IOcbskrBx73tXYW6QLBL2YhfQC0=;
        b=CxQ8vuDQ+CNg2Jd/OzleKRY/CLcN2lLy04oug9Q3yUd/Soqu4nUekZUke8KRdr5NoxJw0C
        nBT2Xz8B+zGHtf98j9OTt3dP4FSi8Tr+xEmZ1eTroZduJSPkjRImYspAuFZN0EDd2dqq95
        M2RaS/dKsupGdTawLo9aBmBYBv+OaMQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-KcYV-GFPMhK3r4fVNxggkg-1; Tue, 27 Jun 2023 07:37:19 -0400
X-MC-Unique: KcYV-GFPMhK3r4fVNxggkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0A781C06EE7;
        Tue, 27 Jun 2023 11:37:18 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55BA7F5CD0;
        Tue, 27 Jun 2023 11:37:15 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v1 0/2] vduse: add support for networking devices
Date:   Tue, 27 Jun 2023 13:36:50 +0200
Message-ID: <20230627113652.65283-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably.

[1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

RFC -> v1 changes:
==================
- Fail device init if it does not support VERSION_1 (Jason)

Maxime Coquelin (2):
  vduse: validate block features only with block devices
  vduse: enable Virtio-net device type

 drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.41.0

