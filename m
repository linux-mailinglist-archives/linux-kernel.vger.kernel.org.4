Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2531C6520EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLTMqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiLTMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB913D23
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671540120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=a9dphcXJKbDgaDzxRRBiVFA9p7kE9yji17UDhT5ug+8=;
        b=jDlbCVx5ASW9WXd/pM0qM3JKtx5JDLczj05mZ/T2tx3j0JEJLNlBevQSTFkX69JY6oVB/1
        b4dITTT2oSk8ueGT+FDcKRgoHHg+EdroInniqMs45LSF6jleOztdCILOUBTeG3O3WVGOx8
        UD/5q+Kq63GELU0sYr2RDhIJh1veFRs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-QPCcPzcRNLy3P7IjJkXiwg-1; Tue, 20 Dec 2022 07:41:59 -0500
X-MC-Unique: QPCcPzcRNLy3P7IjJkXiwg-1
Received: by mail-qt1-f198.google.com with SMTP id bt4-20020ac86904000000b003a96b35e7a8so5417343qtb.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9dphcXJKbDgaDzxRRBiVFA9p7kE9yji17UDhT5ug+8=;
        b=AojLgKbjrw8xOw+luvIwJDIu1NqJp5rCR738Yjz0/emluJUsXJqbrIDG2JGNAtkjtQ
         J017ucEFZcbeQ0WMaKYQ/MXMB4g8CRfh4E/huiTxZkuzGk6HO9FxMM1E0bi0WpgvhAhF
         AEnragPuP3Uzjks+glfDtoxUyB+Nb7stfnytakEv69o3i9ejvzAhpQ8mE+CuJOM7K3qg
         OifyYFj8fuf7TcNhg9pHF7Xd21LaxlbRLXNyhyR818Aw80mgS+ZNXoI7QV4dwZSAdgj6
         Q3a0tyCBPGkDJD0zwXF7OWApTsVVWmCwOKvVikUDFYinw3TYvATTaoCoBgNZqb26C8sB
         1Rkw==
X-Gm-Message-State: AFqh2kqqrKromN57WzZ4lUGcSSOB34vxps89PXAxV7FUt8nawbabqx/1
        qKUZQ69W3cgde+V1/kt3XiOnWKwPlreC++4jDtZ9LMAVBfZEktdBslvtwtlrD7PJ0Eg5i7nGEhj
        XPNiZnBPZn9J9gQCgYVjHQZUVabiwg5KYSh1XbJeKeNmILo2uttfEoNfiSyFk59i65bJnDg==
X-Received: by 2002:ac8:6904:0:b0:3a9:6b48:a130 with SMTP id bt4-20020ac86904000000b003a96b48a130mr25323887qtb.34.1671540119087;
        Tue, 20 Dec 2022 04:41:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSZ+R1ipZB7Pp5jlH4N4rO4W1kiXyv4dXazNe/fcZv+aCknM6mHWYUdqpnkHeBoyJ3nTFEpA==
X-Received: by 2002:ac8:6904:0:b0:3a9:6b48:a130 with SMTP id bt4-20020ac86904000000b003a96b48a130mr25323850qtb.34.1671540118802;
        Tue, 20 Dec 2022 04:41:58 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006fbaf9c1b70sm8781028qko.133.2022.12.20.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:41:58 -0800 (PST)
Date:   Tue, 20 Dec 2022 07:41:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: temporary variable type tweak
Message-ID: <20221220124152.523531-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtblk_result returns blk_status_t which is a bitwise restricted type,
so we are not supposed to stuff it in a plain int temporary variable.
All we do with it is pass it on to a function expecting blk_status_t so
the generated code is ok, but we get warnings from sparse:

drivers/block/virtio_blk.c:326:36: sparse: sparse: incorrect type in initializer (different base types) @@     expected int status @@
+got restricted blk_status_t @@
drivers/block/virtio_blk.c:334:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted
+blk_status_t [usertype] error @@     got int status @@

Make sparse happy by using the correct type.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 88d8410ecc5e..73cd5db0d7d5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -336,7 +336,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	int status = virtblk_result(vbr->status);
+	blk_status_t status = virtblk_result(vbr->status);
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
-- 
MST

