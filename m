Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D406A812C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjCBLfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCBLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D8199E1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677756873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zd9PLJS6vpKJ6CPmR9YHtESYhzkUvkwsWDxsXaqlwQ8=;
        b=KBPxhpEZ/FO1f2jdraRNtjAM4oXlKEWSC3qkaxMTzF7kXTUXp+a3WEs+v8R7BbU78Xd+iG
        xBzhuoAk3eU3W4ksdhs9KDiqIzekmxvaLOJpnZPF90MXrTwwB8aHC/OMa64QyhMlffI+xv
        s7JHfdWcK3NfP42WHzABqgl6tCT/bRA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-226-Mc2WA9EfO2em5QzhmsZCrg-1; Thu, 02 Mar 2023 06:34:32 -0500
X-MC-Unique: Mc2WA9EfO2em5QzhmsZCrg-1
Received: by mail-qk1-f200.google.com with SMTP id dm13-20020a05620a1d4d00b00742a22c4239so7998870qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677756871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd9PLJS6vpKJ6CPmR9YHtESYhzkUvkwsWDxsXaqlwQ8=;
        b=EX+/AYKnegEzkG2ezZMqO0wxExlTQw2Nj7m2bhDHSLsIXn36HUtJ6JhazEEh9ob3XZ
         9CmFjp31Je7nhVIH/GVyzvjp0y4XcVUuzcqeIojau3qzBLoeDVR4fOOAq9dVHkU2KZ5n
         DJp0tvW5EqWtIp8Wwnyk350qcszA9bNNkylXoqGnk+2qrBgyeZU4YXxenAxdchVwbET4
         TMt1ph+XcypoEj7a2jyWoUugUUfGcVOjYjXokH2KE8rpX1EzDSowUwg5SSh/iqz5OvNG
         jT262eR0UhWUxBQAHVmyduyKyj27QV/imSXEttOrjzdPtn28UZt+wG/IvubU/rgeO5oV
         notg==
X-Gm-Message-State: AO0yUKWK5km27SxqUu8IPVjSz9HytrmxwJNzRKBEqv1m92Hw5NLsQK3e
        rxa8ZdDigtMbLJ0hS8MHsUuLVK4r/+qru1I9gfQ2K/IObEexUtW9+Q0qb0mS41Zu2uwLJgFf2kc
        VZFU+IqZXaJ1ybT8wdq8TJY3w
X-Received: by 2002:a05:622a:14a:b0:3bf:d0b1:433d with SMTP id v10-20020a05622a014a00b003bfd0b1433dmr17172913qtw.60.1677756871625;
        Thu, 02 Mar 2023 03:34:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+LNHqJ8iSXkQnBxJNED/Dd+UhTVPKK7gC7ULHZoFWAiCyFuYmT1oYs5XX8i5qwnVYajblszQ==
X-Received: by 2002:a05:622a:14a:b0:3bf:d0b1:433d with SMTP id v10-20020a05622a014a00b003bfd0b1433dmr17172896qtw.60.1677756871371;
        Thu, 02 Mar 2023 03:34:31 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8698c000000b003ba19e53e43sm10084156qtq.25.2023.03.02.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 03:34:30 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        eperezma@redhat.com, netdev@vger.kernel.org, stefanha@redhat.com,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 1/8] vdpa: add bind_mm/unbind_mm callbacks
Date:   Thu,  2 Mar 2023 12:34:14 +0100
Message-Id: <20230302113421.174582-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302113421.174582-1-sgarzare@redhat.com>
References: <20230302113421.174582-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

