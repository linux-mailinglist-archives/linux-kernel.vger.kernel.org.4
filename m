Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA76D6272
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjDDNO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjDDNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35BB2D43
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680614016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
        b=TZi5rZ2itZzC/gF8EBJ3sSWvRdWonCuX4D4d/MHPntsfMcFN0G4mHY1TfakEIvqVkjLJUj
        dgdWkzYHfH8NB9AN4C6w5NNCC/XYtSwrwKvbDBc63zzZIsW9nroCBh6ua2vrqY1ztJ0EZe
        T9Nr3hbot0nlaY98QhqnYu4VoH5pCsM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-FYxmjC3TPIaK4Ab44cV8fw-1; Tue, 04 Apr 2023 09:13:34 -0400
X-MC-Unique: FYxmjC3TPIaK4Ab44cV8fw-1
Received: by mail-qk1-f199.google.com with SMTP id d187-20020a3768c4000000b00746864b272cso14680352qkc.15
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
        b=SCuQGiWb8b1oZzMUXH3DjRguFacVbJ3p2ecu4pQT5wgrLTaR2VFygnN0AoXZqR5xbP
         ydKEWMWOH5DL8ZuZrc94eiY2v6QP168wh+Zq46fTOYuYC4npMGHxGI8tiXo/XuLWyD0s
         OfWJbDyYtopuo2s3tg482ML3kG5pRnG8iz7wS9b1Um9ZyZFQ1FIXUjxBjxIqOYllnmfZ
         /+hEEES6TDPWIf/tAM8bG0sFKcCc424lbm5/KVS+Ul4Zd3rXS+gqGaYFjDH64Tzx+DZP
         D0ebZq9URRpanuVaZQMzlxLH7G5koigxvNkNF9KnkaKoflPn7s8bSWiVWqYjZ7u6NVqE
         ZPqw==
X-Gm-Message-State: AAQBX9e8Oevuck52pCtbNYt1J9sE6NCQn5ezRXt3nieLNfQMXwybGUHX
        QsVvsUvC7JHWQ3m9LXK7ZyusTYD6VC/In8/5iKupEuCNgdi8WCTFIhh/9LKaWsexLUie2pmYeYM
        3ELj5Y+FGN+Smx1qDSINVGt9b
X-Received: by 2002:a05:6214:240d:b0:5e0:63ec:5d7a with SMTP id fv13-20020a056214240d00b005e063ec5d7amr3896837qvb.46.1680614013912;
        Tue, 04 Apr 2023 06:13:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350aKm0amVIapEM6Osx9+Rfg1SXxy+vCHEeGfHbCKzQgTZk0x83W/PRr71qSe/u0h5R9nDk3onw==
X-Received: by 2002:a05:6214:240d:b0:5e0:63ec:5d7a with SMTP id fv13-20020a056214240d00b005e063ec5d7amr3896807qvb.46.1680614013667;
        Tue, 04 Apr 2023 06:13:33 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it. [82.53.134.157])
        by smtp.gmail.com with ESMTPSA id mk14-20020a056214580e00b005dd8b9345e8sm3367788qvb.128.2023.04.04.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:13:32 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     eperezma@redhat.com, stefanha@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 1/9] vdpa: add bind_mm/unbind_mm callbacks
Date:   Tue,  4 Apr 2023 15:13:18 +0200
Message-Id: <20230404131326.44403-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404131326.44403-1-sgarzare@redhat.com>
References: <20230404131326.44403-1-sgarzare@redhat.com>
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

These new optional callbacks is used to bind/unbind the device to
a specific address space so the vDPA framework can use VA when
these callbacks are implemented.

Suggested-by: Jason Wang <jasowang@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v2:
    - removed `struct task_struct *owner` param (unused for now, maybe
      useful to support cgroups) [Jason]
    - add unbind_mm callback [Jason]

 include/linux/vdpa.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 43f59ef10cc9..369c21394284 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -290,6 +290,14 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns pointer to structure device or error (NULL)
+ * @bind_mm:			Bind the device to a specific address space
+ *				so the vDPA framework can use VA when this
+ *				callback is implemented. (optional)
+ *				@vdev: vdpa device
+ *				@mm: address space to bind
+ * @unbind_mm:			Unbind the device from the address space
+ *				bound using the bind_mm callback. (optional)
+ *				@vdev: vdpa device
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -351,6 +359,8 @@ struct vdpa_config_ops {
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
 	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
+	int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
+	void (*unbind_mm)(struct vdpa_device *vdev);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
-- 
2.39.2

