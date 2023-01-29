Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD567FC72
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjA2Cuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjA2Cul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:50:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FCE1B571
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:50:40 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P4G3j2mxBzJrJm;
        Sun, 29 Jan 2023 10:49:05 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 10:50:37 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <stefanha@redhat.com>, <sgarzare@redhat.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <eperezma@redhat.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [PATCH v3 0/2] vdpasim: support doorbell mapping
Date:   Sun, 29 Jan 2023 10:50:32 +0800
Message-ID: <20230129025034.2000-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
v2: https://lore.kernel.org/lkml/CACGkMEtdT5fG=ffbpQadkGmzHf6Ax-+L50LsriYqJaW++natMg@mail.gmail.com/T/

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

 drivers/vdpa/vdpa_sim/vdpa_sim.c | 65 ++++++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
 drivers/vhost/vdpa.c             |  4 +-
 include/linux/vdpa.h             |  9 +++++
 4 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.23.0

