Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7146C360F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCUPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCUPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AFA19118
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679413359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/nQNcXvQOfjQfrlKnDNrxxtzxnlaUxAliAI/vatFyI=;
        b=XPycb34ZWqt3/WASZcAndvS/9O+4DuG7WiTwCFLGd9mob9ULQHXK3nHr7FkYJC7fZQzrIa
        cUkhazqa+g2XzmH2vwFL+cvP2AS7X7xRBNnrHo7pf+eAV4G4S7nDo70J4sK+G3X9XxQzLB
        kNf1bpeYyNUlIk5QjBMTXxD0hwnmPOw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-aPA0e0wMPomX-JRONVV3wQ-1; Tue, 21 Mar 2023 11:42:38 -0400
X-MC-Unique: aPA0e0wMPomX-JRONVV3wQ-1
Received: by mail-wm1-f71.google.com with SMTP id k18-20020a05600c1c9200b003ed2a3f101fso10177663wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/nQNcXvQOfjQfrlKnDNrxxtzxnlaUxAliAI/vatFyI=;
        b=g74zbJoYTL+jxe/l248c7vaa2H1QUsuQxoZmPDfPyqT7JDAIClXgqOnP96pYIZs4Cf
         RI+I+B5mVd6uXoSeFGhYA47tvo+ZiG72CNbV9gqTo70AgdpPAc8EptNvna/BCokHW+fd
         FLW23q2kpYxzn9pBSY0CH6tAbF+wRzWCTnz4Ka1fxgosPPqJgrY87eNyLA8RJUA7b18T
         Kq8hz4HiC90B9hsGddonpBKPP27Di32W2Op8GTkQqRM0AoTWzCX+wvuSH3di/shXM4s1
         PW4vSDNDBJyGxc+bDmkh0/IVGQuuLOAE5Oa7pGQVwQ86kRb2tSZVQ2wBP4KRZCtsNOjE
         flDw==
X-Gm-Message-State: AO0yUKXGtIzFcjCU86FzbQ7bDLvBi5MHNHngK9XgMc6O/4PoIdTlWQbK
        l0fm7dXqmIvKRipqApm3jZ9E7ZuDUyuO8uf4QnfhG8ZDwO5CYaNGwx9mnQFXONVmrbQIdm1A/5Z
        SKhDxs0F6TSSEWOlVAmji7es5
X-Received: by 2002:a05:6000:10c3:b0:2d2:6a31:b868 with SMTP id b3-20020a05600010c300b002d26a31b868mr2602309wrx.27.1679413357316;
        Tue, 21 Mar 2023 08:42:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set/e7guuybvidSucOQAc9fidioCV858cDkY1wJhAUIbIQvY6mOovHetJt1xqlgoBWZ+wGjbLUQ==
X-Received: by 2002:a05:6000:10c3:b0:2d2:6a31:b868 with SMTP id b3-20020a05600010c300b002d26a31b868mr2602288wrx.27.1679413357024;
        Tue, 21 Mar 2023 08:42:37 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id n2-20020adffe02000000b002cfeffb442bsm11582490wrr.57.2023.03.21.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:42:36 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        eperezma@redhat.com, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 3/8] vringh: replace kmap_atomic() with kmap_local_page()
Date:   Tue, 21 Mar 2023 16:42:23 +0100
Message-Id: <20230321154228.182769-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321154228.182769-1-sgarzare@redhat.com>
References: <20230321154228.182769-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() is deprecated in favor of kmap_local_page() since commit
f3ba3c710ac5 ("mm/highmem: Provide kmap_local*").

With kmap_local_page() the mappings are per thread, CPU local, can take
page-faults, and can be called from any context (including interrupts).
Furthermore, the tasks can be preempted and, when they are scheduled to
run again, the kernel virtual addresses are restored and still valid.

kmap_atomic() is implemented like a kmap_local_page() which also disables
page-faults and preemption (the latter only for !PREEMPT_RT kernels,
otherwise it only disables migration).

The code within the mappings/un-mappings in getu16_iotlb() and
putu16_iotlb() don't depend on the above-mentioned side effects of
kmap_atomic(), so that mere replacements of the old API with the new one
is all that is required (i.e., there is no need to explicitly add calls
to pagefault_disable() and/or preempt_disable()).

This commit reuses a "boiler plate" commit message from Fabio, who has
already did this change in several places.

Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v3:
    - credited Fabio for the commit message
    - added reference to the commit that deprecated kmap_atomic() [Jason]
    v2:
    - added this patch since checkpatch.pl complained about deprecation
      of kmap_atomic() touched by next patch

 drivers/vhost/vringh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index a1e27da54481..0ba3ef809e48 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1220,10 +1220,10 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_atomic(iov.bv_page);
+	kaddr = kmap_local_page(iov.bv_page);
 	from = kaddr + iov.bv_offset;
 	*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	return 0;
 }
@@ -1241,10 +1241,10 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_atomic(iov.bv_page);
+	kaddr = kmap_local_page(iov.bv_page);
 	to = kaddr + iov.bv_offset;
 	WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 
 	return 0;
 }
-- 
2.39.2

