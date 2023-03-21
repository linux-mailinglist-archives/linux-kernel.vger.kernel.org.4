Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA03C6C2A46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCUGPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCUGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D905B185
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679379270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M8OnIdfA0wmBLFZVipgL/bCDozNrLAZZSjIdqzAfvHs=;
        b=BAvI8LeO+gPJdtAUuaXzVvvm46cxuQZHsJwicQNYUQUXziuUzJpfcXiWuqCWsmepvHeu1e
        tXjZ1ndjnu35uUWxW91PL83eTqzXHhtYOuQRA50i61aOA3LU0Y69lOdqNE9i6yyliMK7DU
        lkrMEp31d1iYNojesVQJiY1aRhd4rTE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-BCV4DupjPoS9AAPeY9fa1g-1; Tue, 21 Mar 2023 02:14:22 -0400
X-MC-Unique: BCV4DupjPoS9AAPeY9fa1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 278B129AA2F0;
        Tue, 21 Mar 2023 06:14:22 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53799C15BA0;
        Tue, 21 Mar 2023 06:14:21 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: mpt3sas: Don't print sense pool info twice
Date:   Mon, 20 Mar 2023 23:14:19 -0700
Message-Id: <20230321061419.3139051-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_base_allocate_sense_dma_pool() already prints out the sense pool
information, so don't print it a second time after calling it in
_base_allocate_memory_pools(). In addition the version in
_base_allocate_memory_pools() was using the wrong size value, sz,
which was last assigned when doing some nvme calculations instead of
sense_sz to determine the pool size in kilobytes.

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2ee9ea57554d..14ae0a9c5d3d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6616,11 +6616,6 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 	else if (rc == -EAGAIN)
 		goto try_32bit_dma;
 	total_sz += sense_sz;
-	ioc_info(ioc,
-	    "sense pool(0x%p)- dma(0x%llx): depth(%d),"
-	    "element_size(%d), pool_size(%d kB)\n",
-	    ioc->sense, (unsigned long long)ioc->sense_dma, ioc->scsiio_depth,
-	    SCSI_SENSE_BUFFERSIZE, sz / 1024);
 	/* reply pool, 4 byte align */
 	sz = ioc->reply_free_queue_depth * ioc->reply_sz;
 	rc = _base_allocate_reply_pool(ioc, sz);
-- 
2.38.1

