Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A975C6CD2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjC2HSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjC2HSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:18:02 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0082BA;
        Wed, 29 Mar 2023 00:17:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PmdDf5JHbz4f3lwX;
        Wed, 29 Mar 2023 15:17:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyEi5iNklZgMFw--.48573S4;
        Wed, 29 Mar 2023 15:17:56 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     lduncan@suse.com, cleech@redhat.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huawei.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, houtao1@huawei.com
Subject: [PATCH] scsi: iscsi_tcp: Check the sock is correct before iscsi_set_param
Date:   Wed, 29 Mar 2023 15:17:39 +0800
Message-Id: <20230329071739.2175268-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyEi5iNklZgMFw--.48573S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tryUGrW5Ar4xAw1ruryfWFg_yoW8Gw4kpa
        1UK34UJws8G3909Fn0gF45uFWYq398GrWIyFWjg343Z3WSkF9IkFWkJ347CFW5Krn7Xrn3
        trWqqFy5uF1qk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

The correctness of sock should be checked before assignment to avoid
assigning wrong values.

Commit
"scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling getpeername()"
introduced this change. This change may lead to inconsistent values of
tcp_sw_conn->sendpage and conn->datadgst_en.

Fix it by moving the position of the assignment.

Fixes: 57569c37f0ad ("scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling getpeername()")
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 drivers/scsi/iscsi_tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 882e8b81b490..b32f3ca3e7d0 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -726,13 +726,12 @@ static int iscsi_sw_tcp_conn_set_param(struct iscsi_cls_conn *cls_conn,
 		iscsi_set_param(cls_conn, param, buf, buflen);
 		break;
 	case ISCSI_PARAM_DATADGST_EN:
-		iscsi_set_param(cls_conn, param, buf, buflen);
-
 		mutex_lock(&tcp_sw_conn->sock_lock);
 		if (!tcp_sw_conn->sock) {
 			mutex_unlock(&tcp_sw_conn->sock_lock);
 			return -ENOTCONN;
 		}
+		iscsi_set_param(cls_conn, param, buf, buflen);
 		tcp_sw_conn->sendpage = conn->datadgst_en ?
 			sock_no_sendpage : tcp_sw_conn->sock->ops->sendpage;
 		mutex_unlock(&tcp_sw_conn->sock_lock);
-- 
2.31.1

