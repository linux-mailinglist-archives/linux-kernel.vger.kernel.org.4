Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEC66676C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjALOfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbjALOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B755851
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673533498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SrDB6EA8NNNFhTzkM56F3hF1/wHtjuu8E32CyYSXTVE=;
        b=EPRBj5cxHXxnuFPeHc9zrnUnH9ulLJSBO04CocBjJd2+JM6i64wZ5FmJ53GaLy60n1b6K6
        kSyaLrnfMup5XeHqCL5CJgeUympbIY284733Medj6RIACk1QaVFxs3flYVlVnCBJmB7unP
        rD2biZed8BJeGVQe6vLDhTp4tVZwVm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-hhMfym0WPbav3vcTjI46Mg-1; Thu, 12 Jan 2023 09:23:03 -0500
X-MC-Unique: hhMfym0WPbav3vcTjI46Mg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2751D18E5388;
        Thu, 12 Jan 2023 14:22:22 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79BC62166B26;
        Thu, 12 Jan 2023 14:22:20 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, elic@nvidia.com
Cc:     linux-kernel@vger.kernel.org, parav@nvidia.com, lulu@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        sgarzare@redhat.com, si-wei.liu@oracle.com
Subject: [RFC 0/3] MLX Adress Space ID + Control VirtQueue fixes
Date:   Thu, 12 Jan 2023 15:22:15 +0100
Message-Id: <20230112142218.725622-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Proposal for fixes detected when using CVQ in a different ASID.=0D
=0D
Only tested with qemu and vhost_vdpa.=0D
=0D
Eugenio P=C3=A9rez (3):=0D
  vdpa/mlx5: reset iotlb at dup_iotlb=0D
  vdpa/mlx5: conditionally delete cvq iotlb in destroy_mr=0D
  vdpa/mlx5: take iommu_lock at dup_iotlb=0D
=0D
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-=0D
 drivers/vdpa/mlx5/core/mr.c        | 20 ++++++++++++++------=0D
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 ++++++------=0D
 3 files changed, 21 insertions(+), 13 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

