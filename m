Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058E16BD1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCPOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCPOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E1B3729
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678975765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bLdC3wHFT7oUZ2jPsmMgtk2F4YyIOWga1n5deAIvgCc=;
        b=UkQUMhPDTWCfgv1StJj/Bbpl5FOup19Zuxv+3iFu5oivGCGdYO3bm2JzJ1+x+qvRPb+AdR
        5YasMlcoG1pGSadsRfF3INxoGi6CmBfZynYzH3Dz4ABmwnlEkPm7BpNKwDYH6pOS/4exhK
        i9cU6CJS19J4nfsEpuO3kyY09gY2iHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623--OgYG-KYO_O-epywtsEYcg-1; Thu, 16 Mar 2023 10:09:22 -0400
X-MC-Unique: -OgYG-KYO_O-epywtsEYcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A338811E7B;
        Thu, 16 Mar 2023 14:09:21 +0000 (UTC)
Received: from desnesn.remote.csb (ovpn-116-3.gru2.redhat.com [10.97.116.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4C8E40C6E68;
        Thu, 16 Mar 2023 14:09:18 +0000 (UTC)
From:   Desnes Nunes <desnesn@redhat.com>
To:     iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, linux-kernel@vger.kernel.org
Cc:     hch@lst.de, martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com, Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH v2 0/3] scsi: smartpqi: fix DMA overlapping mappings asymmetry
Date:   Thu, 16 Mar 2023 11:09:09 -0300
Message-Id: <20230316140912.1038404-1-desnesn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In summary, this series fixes an overlapping mappings asymmetry on the
smartpqi driver due to a missing pqi_pci_unmap() call, while also adding
the cacheline on debug messages of dma-debug debugging functions.

Other minor non-functional updates are also provided.

Desnes Nunes (3):
  dma-debug: small dma_debug_entry's comment and variable name updates
  dma-debug: add cacheline to user/kernel space dump messages
  scsi: smartpqi: fix overlapping mappings asymmetry on DMA

 drivers/scsi/smartpqi/smartpqi_init.c |   2 +
 kernel/dma/debug.c                    | 133 ++++++++++++++------------
 2 files changed, 72 insertions(+), 63 deletions(-)

-- 
2.39.1

