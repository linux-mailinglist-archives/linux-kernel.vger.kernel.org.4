Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31C6C9418
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCZMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA3472B7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679832605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HbnW/Rgnvg5ujAUjgAGlY8Mc7i1z035Taln23xgjKTM=;
        b=DjndetiM9BoSHOt603QbZZvHvhk2E0hiKbNOvQzYTIYiyjTbnDIcRrVhcv89cl/VBMEbQs
        AWo61fcYFH+1zHTaGTKc8DzEQGJn5kg9esxcjSk/DdGBYr3SN/CgWqWjr7BpDWFWG0j20i
        Kylez25NYrnA1x1UKqrKhAnvnTZGVpk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ZnUFB6umOsaHKYfSmR2HEA-1; Sun, 26 Mar 2023 08:10:03 -0400
X-MC-Unique: ZnUFB6umOsaHKYfSmR2HEA-1
Received: by mail-qt1-f199.google.com with SMTP id l13-20020a05622a174d00b003e4df699997so2002997qtk.20
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679832603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbnW/Rgnvg5ujAUjgAGlY8Mc7i1z035Taln23xgjKTM=;
        b=PzlnjRuQ0AHbjxG5QVMSeL6x9Osu+VVKCtg37VWVMSBfX7rL3YouAj/Y9FGm1vOkI+
         FTJ/9a7RMTbbbbeL4AuWQwmEI8yrxcpMPcfXzuHZUj3AvxdGY+wKaau9MngBtiJqLbwG
         nr7/iLvvzimyf/donO52FvqaEEaHz30+7A4GZXhAiB/+fYDz89nsE2aOrgL4B7lC+UO0
         h/NPA0ysUdzrTS1cb8WmbxhvK8RNvXxWWFnDyH/l7uI9RxNHH+e6n3MFDgAYc4VC5+pJ
         6RxEbtxtW0xo/f7vNE7tY3gvIOhIPGi01DAsH24GEn1xhTRur6BzhWe/0o59N0J9k6Ft
         s4ww==
X-Gm-Message-State: AO0yUKWjcwjMW23Ihhp0nuRv9h60w3DF66UtOtuDPspULEqUURfsWMZH
        QHacnJBbFkmF5FnsmWDvWoaGcWFOw1tpr/ZdwlCq4BbpFeC0WVy+6csgbz6VXHmo1Q46cvsVt64
        wylVS8Lqu/5RprVc5jC81F3oO
X-Received: by 2002:a05:6214:2484:b0:56f:768a:9bb8 with SMTP id gi4-20020a056214248400b0056f768a9bb8mr24767185qvb.26.1679832603157;
        Sun, 26 Mar 2023 05:10:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set+f0s1CKPEqIVVuYB6YrTJvY7M+h/pytIksz3Z008dcgKHhPNGRujHw3Gc1sAqT01/Ut/23dQ==
X-Received: by 2002:a05:6214:2484:b0:56f:768a:9bb8 with SMTP id gi4-20020a056214248400b0056f768a9bb8mr24767159qvb.26.1679832602910;
        Sun, 26 Mar 2023 05:10:02 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id mx16-20020a0562142e1000b005dd8b934588sm2158942qvb.32.2023.03.26.05.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 05:10:02 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, mgurtovoy@nvidia.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/ocrdma: remove unused discard_cnt variable
Date:   Sun, 26 Mar 2023 08:09:59 -0400
Message-Id: <20230326120959.1351948-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/infiniband/hw/ocrdma/ocrdma_verbs.c:1592:6: error: variable
  'discard_cnt' set but not used [-Werror,-Wunused-but-set-variable]
        int discard_cnt = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index dd4021b11963..58f994341e9a 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1589,7 +1589,6 @@ static void ocrdma_discard_cqes(struct ocrdma_qp *qp, struct ocrdma_cq *cq)
 {
 	unsigned long cq_flags;
 	unsigned long flags;
-	int discard_cnt = 0;
 	u32 cur_getp, stop_getp;
 	struct ocrdma_cqe *cqe;
 	u32 qpn = 0, wqe_idx = 0;
@@ -1641,7 +1640,6 @@ static void ocrdma_discard_cqes(struct ocrdma_qp *qp, struct ocrdma_cq *cq)
 		/* mark cqe discarded so that it is not picked up later
 		 * in the poll_cq().
 		 */
-		discard_cnt += 1;
 		cqe->cmn.qpn = 0;
 skip_cqe:
 		cur_getp = (cur_getp + 1) % cq->max_hw_cqe;
-- 
2.27.0

