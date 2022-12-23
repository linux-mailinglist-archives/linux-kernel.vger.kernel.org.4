Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B8654C54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLWF4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLWF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3802FF6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671774955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KBOBd99fUJastenAf++fTvV9fk5DffNPNG/DcWaJa1o=;
        b=MxtzBgRZP1FH5X/1WSb6O0syacyT28Olk+5HvE//ok0ohiCvxaxWziPgflGgaUxoCjUBFP
        vT77/TfRpXZFt+vj5hNuRCBp34RyGzCAGle8Hlq2ZlSrd+c/fRsGtNFW9+siVESD8i9bkC
        CJRyeTGXq1ubyFQeY8NzyP2yKIgeqx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-b1s9w8mBPtWMrVK1NJNRow-1; Fri, 23 Dec 2022 00:55:53 -0500
X-MC-Unique: b1s9w8mBPtWMrVK1NJNRow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 855E918811F5;
        Fri, 23 Dec 2022 05:55:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBE3C40C2064;
        Fri, 23 Dec 2022 05:55:50 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] Vendor stats support in vdpasim_net
Date:   Fri, 23 Dec 2022 13:55:44 +0800
Message-Id: <20221223055548.27810-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series implements vendor stats in vdpasim_net. Please review.

Thanks

Changes since V2:

- rebase to Michale's tree (linux-next branch)
- remove unnecessary blank lines
- twaek the error code handling

Changes since V1:

- typo fixes
- move the duplicated get_vendor_vq_stats() in
  vdpasim_batch_config_ops to vdpa_sim_config_ops
- use -EOPNOTSUPP instead of -EINVAL in vdpasim_get_vq_stats
- introdce a dedicated variable to record the successful cvq request
  and track the number of requests correctly

Jason Wang (4):
  vdpa_sim: switch to use __vdpa_alloc_device()
  vdpasim: customize allocation size
  vdpa_sim: support vendor statistics
  vdpa_sim_net: vendor satistics

 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  30 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 218 ++++++++++++++++++++++++++-
 4 files changed, 243 insertions(+), 10 deletions(-)

-- 
2.25.1

