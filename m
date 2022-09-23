Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752915E746D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiIWGzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIWGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B61310BB28
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663916145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TyI3/pitfwr7G0vT4ywoa+PCxkCwg5DwusKh6v7dH8I=;
        b=AsHm5q3SriG0G+3Xpu1uK4CdhdFR8qTqv4MWF7hEjpkL1sZ6rewLy8T6aDywsKDDnoysdr
        heqWO0FbHCUu3HWzaBqTkRrm7j3nF8uFNws9vkAceKK9tXLd4LYO9Nn7rZiMSvbpooAEnF
        7J1NV0Q/Eor2WmXw+AYE8Df+7g1VN88=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-ZcEpPXmLM_6_z8LyNu0njg-1; Fri, 23 Sep 2022 02:55:44 -0400
X-MC-Unique: ZcEpPXmLM_6_z8LyNu0njg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9B1038041C5;
        Fri, 23 Sep 2022 06:55:43 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-126.bne.redhat.com [10.64.54.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 254AAC15BA5;
        Fri, 23 Sep 2022 06:55:39 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        eric.auger@redhat.com, yuzhe@nfschina.com, oliver.upton@linux.dev,
        shan.gavin@gmail.com
Subject: [PATCH] KVM: arm64: vgic: Remove duplicate check in update_affinity_collection()
Date:   Fri, 23 Sep 2022 14:54:47 +0800
Message-Id: <20220923065447.323445-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ITS collection is guranteed to be !NULL when update_affinity_collection()
is called. So we needn't check ITE's collection with NULL because the
check has been included to the later one.

Remove the duplicate check in update_affinity_collection().

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/vgic/vgic-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 9d3299a70242..24d7778d1ce6 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -406,7 +406,7 @@ static void update_affinity_collection(struct kvm *kvm, struct vgic_its *its,
 	struct its_ite *ite;
 
 	for_each_lpi_its(device, ite, its) {
-		if (!ite->collection || coll != ite->collection)
+		if (ite->collection != coll)
 			continue;
 
 		update_affinity_ite(kvm, ite);
-- 
2.23.0

