Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99E96C89EC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjCYBS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjCYBSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:18:40 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68381A94A;
        Fri, 24 Mar 2023 18:18:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pk1Rt1cfDz4f3mLK;
        Sat, 25 Mar 2023 09:18:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUiDpSx5kmy0NFg--.49234S6;
        Sat, 25 Mar 2023 09:18:36 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH 2/5] scsi: introduce SHOST_BLOCKED state to support blocking IO
Date:   Sat, 25 Mar 2023 09:17:31 +0800
Message-Id: <20230325011734.507453-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230325011734.507453-1-yebin@huaweicloud.com>
References: <20230325011734.507453-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUiDpSx5kmy0NFg--.49234S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xGw47ur4DuF4xury7trb_yoW8KryfpF
        WDXw1xC3y8GayIkwnIg3Z8Gr95Ka97WrWqqFyUWa47Wa4jy34Y9w4DCFyUZay8GrW7Krnx
        WF4DWF1DCFWrJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzMKuUUUUU
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

SHOST_BLOCKED state to blocking io in block layer. This state use for
test, Only running state and blocked state can be switched to each
other.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/hosts.c      | 11 +++++++++++
 drivers/scsi/scsi_sysfs.c |  1 +
 include/scsi/scsi_host.h  |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 9b6fbbe15d92..3b497fd4d329 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -90,6 +90,7 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
 		switch (oldstate) {
 		case SHOST_CREATED:
 		case SHOST_RECOVERY:
+		case SHOST_BLOCKED:
 			break;
 		default:
 			goto illegal;
@@ -99,6 +100,7 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
 	case SHOST_RECOVERY:
 		switch (oldstate) {
 		case SHOST_RUNNING:
+		case SHOST_BLOCKED:
 			break;
 		default:
 			goto illegal;
@@ -109,6 +111,7 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
 		switch (oldstate) {
 		case SHOST_CREATED:
 		case SHOST_RUNNING:
+		case SHOST_BLOCKED:
 		case SHOST_CANCEL_RECOVERY:
 			break;
 		default:
@@ -144,6 +147,14 @@ int scsi_host_set_state(struct Scsi_Host *shost, enum scsi_host_state state)
 			goto illegal;
 		}
 		break;
+	case SHOST_BLOCKED:
+		switch (oldstate) {
+		case SHOST_RUNNING:
+			break;
+		default:
+			goto illegal;
+		}
+		break;
 	}
 	shost->shost_state = state;
 	return 0;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index cc0ae5e3def3..b14f95ac594e 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -69,6 +69,7 @@ static const struct {
 	{ SHOST_RECOVERY, "recovery" },
 	{ SHOST_CANCEL_RECOVERY, "cancel/recovery" },
 	{ SHOST_DEL_RECOVERY, "deleted/recovery", },
+	{ SHOST_BLOCKED, "blocked", },
 };
 const char *scsi_host_state_name(enum scsi_host_state state)
 {
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 587cc767bb67..9e99317b11fa 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -527,6 +527,7 @@ enum scsi_host_state {
 	SHOST_RECOVERY,
 	SHOST_CANCEL_RECOVERY,
 	SHOST_DEL_RECOVERY,
+	SHOST_BLOCKED,
 };
 
 struct Scsi_Host {
-- 
2.31.1

