Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4615D6A3E31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB0JVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjB0JVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:21:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D34C03
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:19:33 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PQFL623g3zrSJT;
        Mon, 27 Feb 2023 17:18:54 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 17:18:59 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <stefanha@redhat.com>, <sgarzare@redhat.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <eperezma@redhat.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [PATCH v4 0/2] vdpasim: support doorbell mapping
Date:   Mon, 27 Feb 2023 17:18:55 +0800
Message-ID: <20230227091857.2406-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

This patchset supports doorbell mapping for vdpasim devices.

v3: https://lore.kernel.org/lkml/20230213070446-mutt-send-email-mst@kernel.org/T/
v2: https://lore.kernel.org/lkml/CACGkMEtdT5fG=ffbpQadkGmzHf6Ax-+L50LsriYqJaW++natMg@mail.gmail.com/T/

Changes v3->v4:
    - use WRITE_ONCE  [Jason]
    - start/stop periodic work when create/destroy vdpasim device  [Jason]

Changes v2->v3:
    - add a new callback named get_vq_notification_pgprot to vdpa_config_ops [Jason]
    - remove the new added module parameter 'parameter' [Jason]
    - opencode the schedule/cancel_delayed() [Jason]

Changes v1->v2:
    - support both kick mode and passthrough mode. [Jason]
    - poll the notify register first. [Jason, Michael]

Longpeng (2):
  vdpa: support specify the pgprot of vq notification area
  vdpasim: support doorbell mapping

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 67 ++++++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
 drivers/vhost/vdpa.c             |  4 +-
 include/linux/vdpa.h             |  9 +++++
 4 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.23.0

