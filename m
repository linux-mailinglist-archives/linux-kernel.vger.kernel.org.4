Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27496C8173
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjCXPiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjCXPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8481E9E3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679672209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reoAM7f+Ql0t7teTIED97nCtpsbVHLsQxA9mgF0KDac=;
        b=bFYuR7hF1KJNT3DhgJkC8CQMwaMD8LkztP4INrcOpyTXyPiTG1cfr75DfJCpRhjHLIt3h8
        2MVsV9aYJJ0WftNfqs6nUWEvfTdRLqlWgR8iLlMokfeGV95vuGpVgj9IXNzTOAIQd6XupQ
        JViWEHp4KwlAVahOh1MHlsLG3RthFKo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-lo5G6hGrPCCJEZMeDvjQqA-1; Fri, 24 Mar 2023 11:36:48 -0400
X-MC-Unique: lo5G6hGrPCCJEZMeDvjQqA-1
Received: by mail-ed1-f69.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so3744808edh.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reoAM7f+Ql0t7teTIED97nCtpsbVHLsQxA9mgF0KDac=;
        b=f27QGOZHL0hJmJQbitVX1HJp9Ajv+KOVvFoPDmOO81dpX9i+j3FOFDlQPhH6cBqXq8
         LxLeY7+fhLllAoI3IBYFJG8gTSTAuoL0fjCoq7Y230iQKEzB/NwNgcJK0jXJjg3Ddn6c
         as6Jgb7BM9AMksQI55G/Xf0HMRvJmnRG1jayrwUiZLd7z7wL899yQ5/UBAl4v3C8AKIR
         wvaTCVs3tnqZKZPmvZX6mCE8o6TFMhITr6zWYBtOHJ5IHCBnGQGp8FaXMx34NxUJ745F
         wKwAf9R8bICoEYPmYLfmgI373O+hwisCvAbdze82tbyJ1m9Ur9J9mvzSyWZhafH53zt7
         NE3g==
X-Gm-Message-State: AAQBX9c4lvIbnUici6kfVcULCYpZc20yHvq+/C5SNl2QOhDfBE9XX759
        Ev/A8MY1jJfKeYaxxpcdXKz3rvIPwxUceVLeSL5vwkyHxYXwdE6+F1Ur/+msiQ8wtSY7e0znjVA
        Up97ENYVTLHXKEhTjludBSxyw
X-Received: by 2002:a05:6402:1002:b0:501:c547:2135 with SMTP id c2-20020a056402100200b00501c5472135mr3055023edu.36.1679672206666;
        Fri, 24 Mar 2023 08:36:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350b+KdvTwnSlwUHcwfB5Dr3iyF2TswJnUvHzIhq2f2NvqKi7QHj4nw34d7o5dhOk+zWrmvdj3w==
X-Received: by 2002:a05:6402:1002:b0:501:c547:2135 with SMTP id c2-20020a056402100200b00501c5472135mr3055009edu.36.1679672206395;
        Fri, 24 Mar 2023 08:36:46 -0700 (PDT)
Received: from localhost.localdomain (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id g25-20020a50d0d9000000b00501c2a9e16dsm7987307edf.74.2023.03.24.08.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:36:45 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     stefanha@redhat.com, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org, eperezma@redhat.com,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 4/9] vringh: define the stride used for translation
Date:   Fri, 24 Mar 2023 16:36:02 +0100
Message-Id: <20230324153607.46836-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

Define a macro to be reused in the different parts of the code.

Useful for the next patches where we add more arrays to manage also
translations with user VA.

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v4:
    - added this patch with the changes extracted from the next patch [Eugenio]
    - used _STRIDE instead of _SIZE [Eugenio]

 drivers/vhost/vringh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0ba3ef809e48..4aee230f7622 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1141,13 +1141,15 @@ static int iotlb_translate(const struct vringh *vrh,
 	return ret;
 }
 
+#define IOTLB_IOV_STRIDE 16
+
 static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				  void *src, size_t len)
 {
 	u64 total_translated = 0;
 
 	while (total_translated < len) {
-		struct bio_vec iov[16];
+		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
@@ -1180,7 +1182,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 	u64 total_translated = 0;
 
 	while (total_translated < len) {
-		struct bio_vec iov[16];
+		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
-- 
2.39.2

