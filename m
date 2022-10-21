Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C186607521
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJUKkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUKkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:40:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59225EF5A0;
        Fri, 21 Oct 2022 03:40:12 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mv17w5Chrz15Lxl;
        Fri, 21 Oct 2022 18:35:24 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:40:11 +0800
Received: from build.huawei.com (10.175.101.6) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 18:40:10 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Steffen Maier <maier@linux.ibm.com>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH v2 0/2] Fix scsi device's iodone_cnt mismatch with iorequest_cnt
Date:   Fri, 21 Oct 2022 19:56:36 -0400
Message-ID: <20221021235638.1968832-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following scenario would make scsi_device's iodone_cnt mismatch with
iorequest_cnt even if there is no request on this device any more.

1. request timeout happened. If we do not retry the timeouted command,
   this command would be finished in scsi_finish_command() which would
   not increase the iodone_cnt; if the timeouted command is retried,
   another increasement for iorequest_cnt would be performed, the
   command might add iorequest_cnt for multiple times but iodone_cnt
   only once. Increase iodone_cnt in scsi_timeout() can handle this
   scenario.

2. scsi_dispatch_cmd() failed, while the iorequest_cnt has already been
   increased. If scsi_dispatch_cmd() failed, the request would be
   requeued, then another iorequest_cnt would be added. So we should not
   increase iorequest_cnt if dispatch command failed

V2:
- Add description about why we can add iodone_cnt in scsi_timeout()
- Do not increase iorequest_cnt if dispatch command failed

Wenchao Hao (2):
  scsi: increase scsi device's iodone_cnt in scsi_timeout()
  scsi: donot increase scsi_device's iorequest_cnt if dispatch failed

 drivers/scsi/scsi_error.c | 1 +
 drivers/scsi/scsi_lib.c   | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.35.3

