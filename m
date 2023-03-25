Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C936C89E4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjCYBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjCYBSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:18:39 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643017CE6;
        Fri, 24 Mar 2023 18:18:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pk1Rs4kxFz4f3mL8;
        Sat, 25 Mar 2023 09:18:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUiDpSx5kmy0NFg--.49234S4;
        Sat, 25 Mar 2023 09:18:35 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH 0/5] limit set the host state by sysfs
Date:   Sat, 25 Mar 2023 09:17:29 +0800
Message-Id: <20230325011734.507453-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUiDpSx5kmy0NFg--.49234S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtrykJFW8XF1xurW7WF1rZwb_yoWfArcE9r
        WFv3yxtr10kFWvya4rGr1jqryvkr47Xr18ZF1jvry3urWUZF1DGw4kZ345Cr48ZF43Jws8
        Ar15Xry8Cr17GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s
        1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
        WIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Now, we can set the host state by sysfs with any value. Actually, it
doesn't make sense. May cause some functional issues.
This patchset introduce 'blocked' state to blocking IO, we can use this
state for testing. Perhaps we can use this to do some fault recovery or
firmware upgrades, as long as the driver support is good, it may be
insensitive to the upper layer.

Ye Bin (5):
  scsi: fix switch host state race between by sysfs and others
  scsi: introduce SHOST_BLOCKED state to support blocking IO
  scsi: limit to set the host state
  scsi: blocking IO when host is blocked
  scsi: run queue after set host state from blocked to running

 drivers/scsi/hosts.c      | 11 +++++++++++
 drivers/scsi/scsi_lib.c   |  4 ++++
 drivers/scsi/scsi_sysfs.c | 18 +++++++++++++++++-
 include/scsi/scsi_host.h  |  6 ++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.31.1

