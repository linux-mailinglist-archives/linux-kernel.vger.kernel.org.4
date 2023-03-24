Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE69E6C85FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCXTdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXTdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83EB18ABE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679686334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmog+eqeL1SDypZCzqd1CF1SNeR9m6Jv2tAiuczhIFg=;
        b=DpW7Q2yJ/c1eN15IhxE3nOrUVp0jkPCI3uhPWBxQNNUSjaFDmmLR8FWFyU3calP9oQqnqO
        E/Iog8Niah2KE6PieX8AMlzmf0US9NsWWPP1SiNVPZthHnjdilPZLKvwkkgdc5D+qEy5tB
        BC3H91CJ7qVJXimXaZ1mHoA5zdpNJu8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-bmakHO2nP8-c7LpM9yNtqg-1; Fri, 24 Mar 2023 15:32:08 -0400
X-MC-Unique: bmakHO2nP8-c7LpM9yNtqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09B372999B43;
        Fri, 24 Mar 2023 19:32:08 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.17.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DABB218EC7;
        Fri, 24 Mar 2023 19:32:06 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2] scsi: mpt3sas: Don't print sense pool info twice
Date:   Fri, 24 Mar 2023 12:32:04 -0700
Message-Id: <20230324193204.567932-1-jsnitsel@redhat.com>
In-Reply-To: <20230321061419.3139051-1-jsnitsel@redhat.com>
References: <20230321061419.3139051-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Fixes: 970ac2bb70e7 ("scsi: mpt3sas: Force sense buffer allocations to be within same 4 GB region")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
changes from v1: Add missing Fixes tag, and missed Cc to James

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

