Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1E36D193F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCaIDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCaIDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E15E072
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680249733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z1bhGoNJZMSwcpQc6yTvdcUKf3R+huOZ4zfMlXF6R1k=;
        b=d8AwJGOUik9kjaeOIUlbAPgQkqOn66lhqtSuu/cHA6qjsGy6s9lbAlNbApXmcqHos0Q+t9
        TOvn3IRr1BsYvoRUD/yeB4JZ2kvP+6B+js6oDYDT2Qg2wdAm8g6Ij0feLuRdxYRsRMVgFd
        vZbD3gJ1kRcKssEV196Z/lzBCUkHgKQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-LG1BsQxxNMCaaCXW17edvQ-1; Fri, 31 Mar 2023 04:02:11 -0400
X-MC-Unique: LG1BsQxxNMCaaCXW17edvQ-1
Received: by mail-ed1-f71.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so30214927edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680249730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1bhGoNJZMSwcpQc6yTvdcUKf3R+huOZ4zfMlXF6R1k=;
        b=n5Bwy4lWimkK63WIGwJl7404iq0upRzBdhrxKpAvqAi8v4t2wLIAfw3scWcyiWNs4h
         Hkfck3h7iJkhByjyrdP+QCaexQ4DVSIZtfva+pQ4Oen/FgzEkp/Dw2vB5bQQMyZiftxL
         U3oBZa03aDdUWCWWpgiEr7P2H4EaVjgKdA95tD2pJSO+/o1F534a6e1SfOCkwL84QBFX
         +/wsP43vdb3DVUN7S5g1Ko8IM738lAxx9Um6tqKtkx24XJN/lWxfs4SDJYUPj1jtM+xb
         UTUabqQ8UVF0fZsxV/9pI8VKifJGku4mONqrURjkoDeXMuyJ77wJnWdqYuZ0qfPCYQ1J
         AmqQ==
X-Gm-Message-State: AAQBX9djVlbWOmaQVRytQOArMmA/RnNrD6zZOGlyhpcw7+CDOiIMEwu6
        Rt8SsDzvZDbn1OZS/JQJ8jV/Uyt+hGXtG1PiCW9PPJs8HA1HvbrfMhe60EQurJUysLXxmpLmQQ7
        8p/wrpVyFr0HYpaqvyBADmBEp
X-Received: by 2002:a17:906:3a83:b0:932:9502:4fd1 with SMTP id y3-20020a1709063a8300b0093295024fd1mr25804896ejd.43.1680249730763;
        Fri, 31 Mar 2023 01:02:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350YmxPDA5UW4cP8XQymOxzi1zIV1vQp/Pm9MW2epeKgfsHTsDIGjBuy3IHnIuIOwTawke5i8Zg==
X-Received: by 2002:a17:906:3a83:b0:932:9502:4fd1 with SMTP id y3-20020a1709063a8300b0093295024fd1mr25804873ejd.43.1680249730456;
        Fri, 31 Mar 2023 01:02:10 -0700 (PDT)
Received: from step1.home (host-82-57-51-130.retail.telecomitalia.it. [82.57.51.130])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906498600b009321cd80fdfsm689029eju.158.2023.03.31.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:02:09 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH] vringh: fix typos in the vringh_init_* documentation
Date:   Fri, 31 Mar 2023 10:02:08 +0200
Message-Id: <20230331080208.17002-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
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

Replace `userpace` with `userspace`.

Cc: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index a1e27da54481..694462ba3242 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -636,9 +636,9 @@ static inline int xfer_to_user(const struct vringh *vrh,
  * @features: the feature bits for this ring.
  * @num: the number of elements.
  * @weak_barriers: true if we only need memory barriers, not I/O.
- * @desc: the userpace descriptor pointer.
- * @avail: the userpace avail pointer.
- * @used: the userpace used pointer.
+ * @desc: the userspace descriptor pointer.
+ * @avail: the userspace avail pointer.
+ * @used: the userspace used pointer.
  *
  * Returns an error if num is invalid: you should check pointers
  * yourself!
@@ -911,9 +911,9 @@ static inline int kern_xfer(const struct vringh *vrh, void *dst,
  * @features: the feature bits for this ring.
  * @num: the number of elements.
  * @weak_barriers: true if we only need memory barriers, not I/O.
- * @desc: the userpace descriptor pointer.
- * @avail: the userpace avail pointer.
- * @used: the userpace used pointer.
+ * @desc: the userspace descriptor pointer.
+ * @avail: the userspace avail pointer.
+ * @used: the userspace used pointer.
  *
  * Returns an error if num is invalid.
  */
@@ -1306,9 +1306,9 @@ static inline int putused_iotlb(const struct vringh *vrh,
  * @features: the feature bits for this ring.
  * @num: the number of elements.
  * @weak_barriers: true if we only need memory barriers, not I/O.
- * @desc: the userpace descriptor pointer.
- * @avail: the userpace avail pointer.
- * @used: the userpace used pointer.
+ * @desc: the userspace descriptor pointer.
+ * @avail: the userspace avail pointer.
+ * @used: the userspace used pointer.
  *
  * Returns an error if num is invalid.
  */
-- 
2.39.2

