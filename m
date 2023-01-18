Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF76723E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjARQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjARQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:45:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2AF56EC4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674060247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fCDpJ99OAg1IiFvWVbDolIfYU7fU7hPLAuBJ/mgUf8E=;
        b=TlpSQ1xtdkTvVsbEvP9Cc5m6+bAYqTXkRptfDHqPai2A9F82FZdaRQfMtrp3cqrG7lz6Zv
        HuyhKHVuw1RNehq2rl3mJjvjcGRM9lXZMgXD0wO4+Ctrh3ZIqsU1cGD1FUpV/r8I5sRwtg
        yr0rZPem8px52El4U3cdhsFd0VWCtyw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-iMvvI5XLM1WcD9VqHzw9Jw-1; Wed, 18 Jan 2023 11:44:04 -0500
X-MC-Unique: iMvvI5XLM1WcD9VqHzw9Jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99AA11871DA5;
        Wed, 18 Jan 2023 16:44:03 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E932140EBF6;
        Wed, 18 Jan 2023 16:44:01 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com
Cc:     leiyang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
        sgarzare@redhat.com, jasowang@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
Subject: [PATCH 0/2] Fix expected set_vq_state behavior on vdpa_sim
Date:   Wed, 18 Jan 2023 17:43:57 +0100
Message-Id: <20230118164359.1523760-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of set_vq_state is to indicate vdpa device the state of a virtqueue=
.=0D
In the case of split, it means the avail_idx.  This is mandatory for use=0D
cases like live migration.=0D
=0D
However, vdpa_sim reset the vq state at vdpasim_queue_ready since it calls=
=0D
vringh_init_iotlb.=0D
=0D
Also, to starting from an used_idx different than 0 is needed in use cases =
like=0D
virtual machine migration.  Not doing so and letting the caller set an avai=
l=0D
idx different than 0 causes destination device to try to use old buffers th=
at=0D
source driver already recover and are not available anymore.=0D
=0D
This series fixes both problems allowing to migrate to a vdpa_sim_net devic=
e.=0D
=0D
Eugenio P=C3=A9rez (2):=0D
  vdpa_sim: not reset state in vdpasim_queue_ready=0D
  vringh: fetch used_idx from vring at vringh_init_iotlb=0D
=0D
 drivers/vdpa/vdpa_sim/vdpa_sim.c |  2 ++=0D
 drivers/vhost/vringh.c           | 25 +++++++++++++++++++++++--=0D
 2 files changed, 25 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

