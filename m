Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD5689441
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjBCJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjBCJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AAD14EA6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675417372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4HoMBB9b+GYCrS+oYQ3jjJ7MAxGR9J+rSDLb84UwlM=;
        b=alnP43QJIuUwAKz4Qe+RUo6S7aUofTyXkSBWpNw3baPMxvXj6Ib7NlFZVWB2K8c+tgahTm
        paNIA9YCHYyEOAw+GVd3oy6LaXI5RRYvpjcCULYGXbOOl2lV20LJKWXk+edRjOUbNQogcz
        G6qHQ0nuwt73vtYg75fPN25wBAnk4G4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-Ceqhc3xGNYGk_k8HJWjvcw-1; Fri, 03 Feb 2023 04:42:50 -0500
X-MC-Unique: Ceqhc3xGNYGk_k8HJWjvcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5880857A93;
        Fri,  3 Feb 2023 09:42:49 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD9D9410B1AD;
        Fri,  3 Feb 2023 09:42:46 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/7] KVM: Move KVM_GET_NR_MMU_PAGES into the deprecation section
Date:   Fri,  3 Feb 2023 10:42:26 +0100
Message-Id: <20230203094230.266952-4-thuth@redhat.com>
In-Reply-To: <20230203094230.266952-1-thuth@redhat.com>
References: <20230203094230.266952-1-thuth@redhat.com>
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

The KVM_GET_NR_MMU_PAGES ioctl is quite questionable on 64-bit hosts
since it fails to return the full 64 bits of the value that can be
set with the corresponding KVM_SET_NR_MMU_PAGES call. This ioctl
likely has also never really been used by userspace applications
(at least not by QEMU and kvmtool which I checked), so it's better
to move it to the deprecation section in kvm.h to make it clear for
developers that this also should not be used in new code in the
future anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/uapi/linux/kvm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 55155e262646..f55965a4cec7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -83,6 +83,8 @@ struct kvm_debug_guest {
 
 #define __KVM_DEPRECATED_VCPU_W_0x87 _IOW(KVMIO, 0x87, struct kvm_debug_guest)
 
+#define KVM_GET_NR_MMU_PAGES _IO(KVMIO, 0x45)
+
 /* *** End of deprecated interfaces *** */
 
 
@@ -1442,7 +1444,6 @@ struct kvm_vfio_spapr_tce {
 #define KVM_CREATE_VCPU           _IO(KVMIO,   0x41)
 #define KVM_GET_DIRTY_LOG         _IOW(KVMIO,  0x42, struct kvm_dirty_log)
 #define KVM_SET_NR_MMU_PAGES      _IO(KVMIO,   0x44)
-#define KVM_GET_NR_MMU_PAGES      _IO(KVMIO,   0x45)
 #define KVM_SET_USER_MEMORY_REGION _IOW(KVMIO, 0x46, \
 					struct kvm_userspace_memory_region)
 #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
-- 
2.31.1

