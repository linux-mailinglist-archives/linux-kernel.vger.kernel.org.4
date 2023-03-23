Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B36C6750
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCWL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCWL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:57:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D8735261;
        Thu, 23 Mar 2023 04:56:56 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pj3dj110tzbcPB;
        Thu, 23 Mar 2023 19:53:45 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:56:52 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        <haowenchao2@huawei.com>
Subject: [PATCH 0/5]scsi:scsi_debug: Add error injection for single device 
Date:   Thu, 23 Mar 2023 19:55:56 +0800
Message-ID: <20230323115601.178494-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original error injection mechanism was based on scsi_host which
could not inject fault for a single SCSI device.

This patchset provides the ability to inject errors for a single
SCSI device. Now we supports inject timeout errors, queuecommand
errors, and hostbyte, driverbyte, statusbyte, and sense data for
specific SCSI Command.

The first patch add an sysfs interface to add and inquiry single
device's error injection info; the second patch defined how to remove
an injection which has been added. The following 3 patches use the
injection info and generate the related error type.

Wenchao Hao (5):
  scsi:scsi_debug: Add sysfs interface to manage scsi devices' error
    injection
  scsi:scsi_debug: Define grammar to remove added error injection
  scsi:scsi_debug: timeout command if the error is injected
  scsi:scsi_debug: Return failed value if the error is injected
  scsi:scsi_debug: set command's result and sense data if the error is
    injected

 drivers/scsi/scsi_debug.c | 296 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 296 insertions(+)

-- 
2.35.3

