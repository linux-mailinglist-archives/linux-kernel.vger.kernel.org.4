Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE5B674CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjATF62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjATF6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7C43A581
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674194263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbP4W57AMZS9MBlxZ+FGeKuIJTpb3nSR8+y62zx7ev0=;
        b=i2yclwUYLUjVCZ0myUH8lJSAEyXTfVcMcqJjTLdVbjQ0vY/P8msimNE3V+AZvcDAaV0cMr
        Ies4zxB05z8FDA6ZWkKbvLfvMQUrY8muI35aWdBnvRj75yzhXVg11UCT+yYwAENDcQbi2I
        Y4rcg8Ji8553I2lqYqfQMlJzivEtzBg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-hsPSwQu1MzqPAF6P0cWtIQ-1; Fri, 20 Jan 2023 00:57:38 -0500
X-MC-Unique: hsPSwQu1MzqPAF6P0cWtIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C6B53C02556;
        Fri, 20 Jan 2023 05:57:38 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-98.bne.redhat.com [10.64.54.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61BF340C6EC4;
        Fri, 20 Jan 2023 05:57:35 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, shan.gavin@gmail.com
Subject: [PATCH 1/2] drivers/base/memory: Fix comments for phys_index_show()
Date:   Fri, 20 Jan 2023 13:57:26 +0800
Message-Id: <20230120055727.355483-2-gshan@redhat.com>
In-Reply-To: <20230120055727.355483-1-gshan@redhat.com>
References: <20230120055727.355483-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

According to 'admin-guide/mm/memory-hotplug.rst', the memory block ID,
instead of the section index, is shown by '/sys/devices/system/memory/
memoryX/phys_index'.

Fix the comments to match with 'admin-guide/mm/memory-hotplug.rst'.
Besides, use the existing helper memory_block_id() to convert the section
index to the memory block index.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/base/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fe98fb8d94e5..b456ac213610 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -115,18 +115,13 @@ unsigned long __weak memory_block_size_bytes(void)
 }
 EXPORT_SYMBOL_GPL(memory_block_size_bytes);
 
-/*
- * Show the first physical section index (number) of this memory block.
- */
+/* Show the memory block ID, relative to the memory block size */
 static ssize_t phys_index_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct memory_block *mem = to_memory_block(dev);
-	unsigned long phys_index;
-
-	phys_index = mem->start_section_nr / sections_per_block;
 
-	return sysfs_emit(buf, "%08lx\n", phys_index);
+	return sysfs_emit(buf, "%08lx\n", memory_block_id(mem->start_section_nr));
 }
 
 /*
-- 
2.23.0

