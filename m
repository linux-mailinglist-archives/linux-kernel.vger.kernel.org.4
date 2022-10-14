Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B65FE962
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJNHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJNHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57422AC4E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665731993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vvc9nSeTOx+R9O1KRdNsOErR2cLTeHQp0FKXCgftjxs=;
        b=HNrdpU2xwIN8G6BM60njqsV+5qsMbZ1kdPNmM1RsLTY/CyWCFmW7ECJ26Gg0uHFbiGpYGX
        EOAnpEm5bJlg43tPN4w+kSVn+skz96UUI5GPHumphbS2WaiJe4UN/qAOBUiiBJaqvDq8ul
        cyIjYoH5PAe9Cp1mnFzL7UlI4rUrebU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-Ig3lh1acMgil5WThUrAQyw-1; Fri, 14 Oct 2022 03:19:49 -0400
X-MC-Unique: Ig3lh1acMgil5WThUrAQyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C86A3C0F423;
        Fri, 14 Oct 2022 07:19:48 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-52.bne.redhat.com [10.64.54.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 642DFC3343C;
        Fri, 14 Oct 2022 07:19:43 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.linux.dev
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com,
        pbonzini@redhat.com, maz@kernel.org, shuah@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com, peterx@redhat.com,
        maciej.szmigiero@oracle.com, ricarkol@google.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: [PATCH 1/6] KVM: selftests: memslot_perf_test: Use data->nslots in prepare_vm()
Date:   Fri, 14 Oct 2022 15:19:09 +0800
Message-Id: <20221014071914.227134-2-gshan@redhat.com>
In-Reply-To: <20221014071914.227134-1-gshan@redhat.com>
References: <20221014071914.227134-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepare_vm(), 'data->nslots' is assigned with 'max_mem_slots - 1'
at the beginning, meaning they are interchangeable.

Use 'data->nslots' isntead of 'max_mem_slots - 1'. With this, it
becomes easier to move the logic of probing number of slots into
upper layer in subsequent patches.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/memslot_perf_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 44995446d942..231cc8449c2e 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -280,14 +280,14 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
 	ucall_init(data->vm, NULL);
 
 	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
-		max_mem_slots - 1, data->pages_per_slot, rempages);
+		data->nslots, data->pages_per_slot, rempages);
 
 	clock_gettime(CLOCK_MONOTONIC, &tstart);
-	for (slot = 1, guest_addr = MEM_GPA; slot < max_mem_slots; slot++) {
+	for (slot = 1, guest_addr = MEM_GPA; slot <= data->nslots; slot++) {
 		uint64_t npages;
 
 		npages = data->pages_per_slot;
-		if (slot == max_mem_slots - 1)
+		if (slot == data->nslots)
 			npages += rempages;
 
 		vm_userspace_mem_region_add(data->vm, VM_MEM_SRC_ANONYMOUS,
@@ -297,12 +297,12 @@ static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
 	}
 	*slot_runtime = timespec_elapsed(tstart);
 
-	for (slot = 0, guest_addr = MEM_GPA; slot < max_mem_slots - 1; slot++) {
+	for (slot = 0, guest_addr = MEM_GPA; slot < data->nslots; slot++) {
 		uint64_t npages;
 		uint64_t gpa;
 
 		npages = data->pages_per_slot;
-		if (slot == max_mem_slots - 2)
+		if (slot == data->nslots - 1)
 			npages += rempages;
 
 		gpa = vm_phy_pages_alloc(data->vm, npages, guest_addr,
-- 
2.23.0

