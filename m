Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF1C6561E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiLZKdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:33:22 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595E2615F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:33:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NgYyz6349z4f3nV8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:33:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rFreKlj6SMxAg--.54373S4;
        Mon, 26 Dec 2022 18:33:17 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     linux-cachefs@redhat.com
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>, houtao1@huawei.com
Subject: [PATCH v2 0/2] Fixes for fscache volume operations
Date:   Mon, 26 Dec 2022 18:33:07 +0800
Message-Id: <20221226103309.953112-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rFreKlj6SMxAg--.54373S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry7Zr1fWF1DKFW7GF17Jrb_yoWDWwc_W3
        4xGas8ur40qa4DKa15KFnIgrZ3uw4jga18JFyUtF17GryY9rn09r1ktr9avF12g34UZF15
        Ar1kAFWrJr129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset includes two fixes for fscache volume operations: patch 1
fixes the hang problem during volume acquisition when the volume
acquisition process waits for the freeing of relinquished volume, patch
2 adds the missing memory barrier in fscache_create_volume_work() and it
is spotted through code review when checking whether or not these is
missing smp_mb() before invoking wake_up_bit().

Comments are always welcome.

Chang Log:
v2:
 * rebased on v6.1-rc1
 * Patch 1: use wait_on_bit() instead (Suggested by David)
 * Patch 2: add the missing smp_mb() in fscache_create_volume_work()

v1: https://listman.redhat.com/archives/linux-cachefs/2022-December/007384.html

Hou Tao (2):
  fscache: Use wait_on_bit() to wait for the freeing of relinquished
    volume
  fscache: Add the missing smp_mb__after_atomic() before wake_up_bit()

 fs/fscache/volume.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.29.2

