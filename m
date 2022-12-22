Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380C1653B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiLVFCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiLVFB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA06168
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671685271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9cfksyyN802rhXnNAv/0J7MXVcDFI/OT76q+tAGfEdA=;
        b=UHYlfGg28rZIhQsDXMfvfz3f2zoIKHi/pJdr3qjS7FOu9/2nK4nnZ4MLjfltjYx/xj0u2F
        b4ioSCyHM6IpOTssV2YBR4e/P87jzfVoa0QH2KgVoHZiwFIjXh/QAUzFDczpd0I3IfLP9v
        DL5hCoe8zzN+AscwtbbJ3NJ954ROG74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-cBFe4bMDPSy0StRvkpFsOg-1; Thu, 22 Dec 2022 00:01:00 -0500
X-MC-Unique: cBFe4bMDPSy0StRvkpFsOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CB6E3C02B74;
        Thu, 22 Dec 2022 05:01:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-15.pek2.redhat.com [10.72.13.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE3440C2064;
        Thu, 22 Dec 2022 05:00:57 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/4] Vendor stats support in vdpasim_net
Date:   Thu, 22 Dec 2022 13:00:48 +0800
Message-Id: <20221222050052.20785-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  33 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 221 ++++++++++++++++++++++++++-
 4 files changed, 248 insertions(+), 11 deletions(-)

-- 
2.25.1

