Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68C86D6276
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjDDNOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjDDNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34826AD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680614012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=30ZisPh4IfYxBa26xRUyTniBO/vlBTDmjsdwsbCPJho=;
        b=SOxgMywvz9b5dg8bqfjjTE9clDpftzpqjlYuGttt3V9wRqgKUhwcxyRPtWPZetEd8JjIq1
        OOqJFZci2u/H2gFYNghjLul7Kb/KAqPCLOo4T7BaTqk+64hYDPQhDsHPS9NnpuS7nkokY/
        s78Xgepbv8HzbSSLnAVkEF/4KrcKEpM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-4haiZhpjOeWYePW0y_teTA-1; Tue, 04 Apr 2023 09:13:31 -0400
X-MC-Unique: 4haiZhpjOeWYePW0y_teTA-1
Received: by mail-qk1-f199.google.com with SMTP id s190-20020ae9dec7000000b00746b7fae197so3381698qkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30ZisPh4IfYxBa26xRUyTniBO/vlBTDmjsdwsbCPJho=;
        b=MrwyMUBscXUkiEcHT7HZ1FhID3p3qdfZrvSCrc9zlNlpGTt0BXMmz8j7tsJ3qZj8Qd
         s2xLkrTai0v1cMQH6/rjGfZK48P+IoR/tY/0+jo1u20cdeiXfllibyxLwhY7WG0L1Suq
         6i63daqsr9IEeT2cm71Ki4xXpjIUEl9deWKyJJWxpRlPJEpwRqcWcqzx499QdNZj0DOM
         xEEudf3fMjmtKw2akaAS4xojJGxCxVt2U55VRSPYvYGydwxgXqiFYFrjDDSLyfzB97yS
         YnMDY1ZrKfoqIb9gpS8ZcK/W0qeRFWo+Ch5SOjX+Q1WR7f6jf3Tnw7nrfR55fH+p/J0S
         VB9Q==
X-Gm-Message-State: AAQBX9corvRel6Tqe3HkcgB60jbkfqSDWHcQ5Wv1qMDFV+mPI6l5YQB4
        rgoMRiig5nKYQDps5A6j0sk6PkhU9QQhylXtodnQ7ZjdE0VIf0eJ94ywossNMYX2KpIBChz1nb8
        iv8YfPDAWoMhZ6S5AM5/Z5WVd
X-Received: by 2002:a05:6214:761:b0:5b7:f1cb:74b6 with SMTP id f1-20020a056214076100b005b7f1cb74b6mr2937065qvz.39.1680614010948;
        Tue, 04 Apr 2023 06:13:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZ2zTnbb4FJI/gZ6P1fNW7ktKk0SsSIVk8yGebzeOt4qcSLlZcWaLED4QcoPTHMx/dn8nf2g==
X-Received: by 2002:a05:6214:761:b0:5b7:f1cb:74b6 with SMTP id f1-20020a056214076100b005b7f1cb74b6mr2937024qvz.39.1680614010596;
        Tue, 04 Apr 2023 06:13:30 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it. [82.53.134.157])
        by smtp.gmail.com with ESMTPSA id mk14-20020a056214580e00b005dd8b9345e8sm3367788qvb.128.2023.04.04.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:13:29 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     eperezma@redhat.com, stefanha@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 0/9] vdpa_sim: add support for user VA
Date:   Tue,  4 Apr 2023 15:13:17 +0200
Message-Id: <20230404131326.44403-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

This series adds support for the use of user virtual addresses in the
vDPA simulator devices.

The main reason for this change is to lift the pinning of all guest memory.
Especially with virtio devices implemented in software.

The next step would be to generalize the code in vdpa-sim to allow the
implementation of in-kernel software devices. Similar to vhost, but using vDPA
so we can reuse the same software stack (e.g. in QEMU) for both HW and SW
devices.

For example, we have never merged vhost-blk, and lately there has been interest.
So it would be nice to do it directly with vDPA to reuse the same code in the
VMM for both HW and SW vDPA block devices.

The main problem (addressed by this series) was due to the pinning of all
guest memory, which thus prevented the overcommit of guest memory.

Thanks,
Stefano

Changelog listed in each patch.
v4: https://lore.kernel.org/lkml/20230324153607.46836-1-sgarzare@redhat.com/
v3: https://lore.kernel.org/lkml/20230321154228.182769-1-sgarzare@redhat.com/
v2: https://lore.kernel.org/lkml/20230302113421.174582-1-sgarzare@redhat.com/
RFC v1: https://lore.kernel.org/lkml/20221214163025.103075-1-sgarzare@redhat.com/

Stefano Garzarella (9):
  vdpa: add bind_mm/unbind_mm callbacks
  vhost-vdpa: use bind_mm/unbind_mm device callbacks
  vringh: replace kmap_atomic() with kmap_local_page()
  vringh: define the stride used for translation
  vringh: support VA with iotlb
  vdpa_sim: make devices agnostic for work management
  vdpa_sim: use kthread worker
  vdpa_sim: replace the spinlock with a mutex to protect the state
  vdpa_sim: add support for user VA

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  11 +-
 include/linux/vdpa.h                 |  10 ++
 include/linux/vringh.h               |   9 ++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 161 ++++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  10 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  10 +-
 drivers/vhost/vdpa.c                 |  34 ++++++
 drivers/vhost/vringh.c               | 173 ++++++++++++++++++++++-----
 8 files changed, 340 insertions(+), 78 deletions(-)

-- 
2.39.2

