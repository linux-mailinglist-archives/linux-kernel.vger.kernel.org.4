Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE177636F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKXAlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXAlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D3A6A1E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669250417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1+apOxZ+xixitjARNjgGXWFt9CpSHyedQWwoyLE6NpY=;
        b=LQ95RvcovRscDH1XgZeeCDrrhX9xCIdZyzGKcgM8I10RV1s9HhpSZtOySGICoTj+0xti92
        Wm8Cho8x7FaacTULbgdDyZ0pygVpfC8xz5O0OADqC+LL/IqjiaAtBxPUKc/9OpZRvbCm6X
        KjPuqyumI2TTtGG2H2Q8g+vSnOFG7Pk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-F3XcF4wCPQCBqz6-kDfQ9g-1; Wed, 23 Nov 2022 19:40:16 -0500
X-MC-Unique: F3XcF4wCPQCBqz6-kDfQ9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C04B338041C5;
        Thu, 24 Nov 2022 00:40:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 677BF1415114;
        Thu, 24 Nov 2022 00:40:15 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] KVM: always declare prototype for kvm_arch_irqchip_in_kernel
Date:   Wed, 23 Nov 2022 19:40:15 -0500
Message-Id: <20221124004015.138822-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
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

Architecture code might want to use it even if CONFIG_HAVE_KVM_IRQ_ROUTING
is false; for example PPC XICS has KVM_IRQ_LINE and wants to use
kvm_arch_irqchip_in_kernel from there, but it does not have
KVM_SET_GSI_ROUTING so the prototype was not provided.

Fixes: d663b8a28598 ("KVM: replace direct irq.h inclusion")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9dcb9e79c010..8f874a964313 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -663,9 +663,9 @@ struct kvm_irq_routing_table {
 	 */
 	struct hlist_head map[];
 };
+#endif
 
 bool kvm_arch_irqchip_in_kernel(struct kvm *kvm);
-#endif
 
 #ifndef KVM_INTERNAL_MEM_SLOTS
 #define KVM_INTERNAL_MEM_SLOTS 0
-- 
2.31.1

