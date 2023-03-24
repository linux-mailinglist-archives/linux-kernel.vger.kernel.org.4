Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352926C816C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjCXPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCXPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4120544
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679672182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
        b=TLjxFI4Tkbt3AKgLy9sSXJaM7NSDmP3THQEkk8UB/wlLfkv5Ut2xns5T6KGp6m5ORgKTi8
        dGMZ/18W5Ys6OEIbHpDAoGp98QodtlmxOKkPKJsEPI6wWtUD5F0iL0iHU+GvoU+XxxNBs1
        n70GY/kw+/ZlQQAVCimQjbAfjN8mm5s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-HjuYM8ZsPBy0-lbEDR4-Ag-1; Fri, 24 Mar 2023 11:36:20 -0400
X-MC-Unique: HjuYM8ZsPBy0-lbEDR4-Ag-1
Received: by mail-ed1-f70.google.com with SMTP id ev6-20020a056402540600b004bc2358ac04so3751412edb.21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
        b=TBFXm+beAsFaMFrUUY1rBNK5uREZdC5QyQmnipJ9EXwgxEMELQig20ND6L472xOT2I
         IdecQU9u7EM+bZEUHC5WvUXx7nvoJUzroHA8e5UX25E2h48Ml55WE9GHQz8Sf9OFIcdZ
         Tuh+IbNcVgpTbb6bwjcgHEhHKmz28SQ3N1u+/Fh7wv5bP1OS1wW4BL5DDWXw5AWhJFos
         t1WhUCB/qCMemXCt884gEWHqE7Wd3hcNVCK6FAwWQdwNrl36vrGeZJ9Q/aLrz509o1AN
         tj/FlrDe8bmY+hVSaas8bhBWb7CAwcXcEqsE2vSRuiR76cz6VISxb0IL+YBVklydxseP
         RTjw==
X-Gm-Message-State: AAQBX9d4GCTmcfn1rU/CvNsjG04/PKQsZcDW2yj2aGmssC7sOgoVMQKk
        XfyJuW8HWOjIeeyLol5w2SOZvhmQdJW5pFjruzXR921MQuJt0Agj6P9tSETlsnz6Zgu+oZJA2jn
        O3GxF+MJjf5nKDi9IxRa7au/5
X-Received: by 2002:a17:906:fa0b:b0:8b8:c06e:52d8 with SMTP id lo11-20020a170906fa0b00b008b8c06e52d8mr2946642ejb.36.1679672179809;
        Fri, 24 Mar 2023 08:36:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZuirhl8xx4rByPSqoq6QKJPGj09MFOoO+Qf6ZIruLZfjDXz0VEK/mx0/0gVcgfYuVnqttLg==
X-Received: by 2002:a17:906:fa0b:b0:8b8:c06e:52d8 with SMTP id lo11-20020a170906fa0b00b008b8c06e52d8mr2946615ejb.36.1679672179513;
        Fri, 24 Mar 2023 08:36:19 -0700 (PDT)
Received: from localhost.localdomain (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id a27-20020a509b5b000000b00501dd53dbfbsm5468613edj.75.2023.03.24.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:36:18 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     stefanha@redhat.com, Jason Wang <jasowang@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org, eperezma@redhat.com,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 1/9] vdpa: add bind_mm/unbind_mm callbacks
Date:   Fri, 24 Mar 2023 16:35:59 +0100
Message-Id: <20230324153607.46836-2-sgarzare@redhat.com>
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

