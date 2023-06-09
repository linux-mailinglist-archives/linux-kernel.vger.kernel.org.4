Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A272729FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbjFIQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbjFIQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28F3A80
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686327463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4M45gRnQ1u7hqy31r1Lf6wTaxv13BKes8mPSZrcPv2Y=;
        b=XkpPaEVRio74K2Trcka19KqY3MO+QszVSmrvHvoVCzGmgQPnZllJWkqfI4oTe7bfEpI16M
        QGgC/8xTbUNagZKVlec1BJVSz/9Fa3CKvphA5owof5Ug5RJcJnbAVbupztDfJ/tnXZotpe
        Q85qXwmLvwxeXJ9np7xG8TiIKUtyGhY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-kKVMaN0WN7K7VCLOJVmnzw-1; Fri, 09 Jun 2023 12:17:41 -0400
X-MC-Unique: kKVMaN0WN7K7VCLOJVmnzw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30793c16c78so2550457f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327460; x=1688919460;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4M45gRnQ1u7hqy31r1Lf6wTaxv13BKes8mPSZrcPv2Y=;
        b=KdjVoNrxyIwniIjjzs0kF5oToIpw8cxrRgHZBwjk9uh/+tTNLmEt+qrnvntyCzx4mX
         pXQ/5J6tx/SuohPzGnAWxktzMjdT03Ez3UAjA745JRfWXoj0v8loyswi9byBvX6oBUGr
         vTXjw4f5Iblm5U+gVgJV+FSdbRavJNqqKoB/csskRD3ElYy1Fwc2ucTcpSL8xCLdNthk
         HkaYccyUWj0FbEoJVW4yt1KuIBB/SvRKDhVtAVUY03JdG6Hi4Fum2KxEGim6dPb+RF8d
         dR2QhQXzxQgteXWhgYhE9FhobEXLSZwpwMebMk0P2qeUm7XTzYpZwGazQPW+c30R/pX/
         4omg==
X-Gm-Message-State: AC+VfDzOKg3FZclUsWgvXPZl/OfgGnHVRuwjIPzbJ+COITCDA06ny3jU
        IU+7t8ZfkkiSFMyW/GILj23Gugu17fW36Z7t+YTrgYVD/Y5YFkqOKFkzXQFOqlBbm18maXmZ9TK
        hE/uNqnynkJRZOLQfLR5Z0bMO
X-Received: by 2002:adf:e110:0:b0:307:2d0c:4036 with SMTP id t16-20020adfe110000000b003072d0c4036mr1422047wrz.66.1686327460472;
        Fri, 09 Jun 2023 09:17:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MwccKZqMZmmQAMpaztP78KxQ/TadfL/ac1dUpnVsjT6zjT2OgsfcKy47axrXbgo+oojXt4w==
X-Received: by 2002:adf:e110:0:b0:307:2d0c:4036 with SMTP id t16-20020adfe110000000b003072d0c4036mr1422026wrz.66.1686327460126;
        Fri, 09 Jun 2023 09:17:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6acc000000b003062b6a522bsm4864763wrw.96.2023.06.09.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:17:39 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:17:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        asmetanin@yandex-team.ru, dtatulea@nvidia.com, jasowang@redhat.com,
        michael.christie@oracle.com, mst@redhat.com,
        prathubaronia2011@gmail.com, rongtao@cestc.cn,
        shannon.nelson@amd.com, sheng.zhao@bytedance.com,
        syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com,
        xieyongji@bytedance.com, zengxianjun@bytedance.com,
        zwisler@chromium.org, zwisler@google.com
Subject: [GIT PULL] virtio,vhost,vdpa: bugfixes
Message-ID: <20230609121737-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 07496eeab577eef1d4912b3e1b502a2b52002ac3:

  tools/virtio: use canonical ftrace path (2023-06-09 12:08:08 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: bugfixes

A bunch of fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrey Smetanin (1):
      vhost_net: revert upend_idx only on retriable error

Dragos Tatulea (1):
      vdpa/mlx5: Fix hang when cvq commands are triggered during device unregister

Mike Christie (2):
      vhost: Fix crash during early vhost_transport_send_pkt calls
      vhost: Fix worker hangs due to missed wake up calls

Prathu Baronia (1):
      vhost: use kzalloc() instead of kmalloc() followed by memset()

Rong Tao (2):
      tools/virtio: Fix arm64 ringtest compilation error
      tools/virtio: Add .gitignore for ringtest

Ross Zwisler (1):
      tools/virtio: use canonical ftrace path

Shannon Nelson (3):
      vhost_vdpa: tell vqs about the negotiated
      vhost: support PACKED when setting-getting vring_base
      vhost_vdpa: support PACKED when setting-getting vring_base

Sheng Zhao (1):
      vduse: avoid empty string for dev name

 drivers/vdpa/mlx5/net/mlx5_vnet.c       |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c      |  3 ++
 drivers/vhost/net.c                     | 11 +++--
 drivers/vhost/vdpa.c                    | 34 +++++++++++++--
 drivers/vhost/vhost.c                   | 75 +++++++++++++++------------------
 drivers/vhost/vhost.h                   | 10 +++--
 kernel/vhost_task.c                     | 18 ++++----
 tools/virtio/ringtest/.gitignore        |  7 +++
 tools/virtio/ringtest/main.h            | 11 +++++
 tools/virtio/virtio-trace/README        |  2 +-
 tools/virtio/virtio-trace/trace-agent.c | 12 ++++--
 11 files changed, 120 insertions(+), 65 deletions(-)
 create mode 100644 tools/virtio/ringtest/.gitignore

