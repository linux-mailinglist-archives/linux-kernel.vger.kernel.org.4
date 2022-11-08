Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1C62074C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiKHDIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiKHDIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:08:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD18611140;
        Mon,  7 Nov 2022 19:08:38 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5tMs5tsPzmVk6;
        Tue,  8 Nov 2022 11:08:25 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:08:37 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:08:36 +0800
Message-ID: <f6c5a664-e9f1-c50a-6735-12b543097336@huawei.com>
Date:   Tue, 8 Nov 2022 11:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/2] Fix scsi device's iodone_cnt mismatch with
 iorequest_cnt
Content-Language: en-US
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Steffen Maier <maier@linux.ibm.com>,
        Wenchao Hao <haowenchao@huawei.com>
References: <20221021235638.1968832-1-haowenchao@huawei.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <20221021235638.1968832-1-haowenchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500003.china.huawei.com (7.185.36.200) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/22 7:56, Wenchao Hao wrote:
> Following scenario would make scsi_device's iodone_cnt mismatch with
> iorequest_cnt even if there is no request on this device any more.
> 
> 1. request timeout happened. If we do not retry the timeouted command,
>    this command would be finished in scsi_finish_command() which would
>    not increase the iodone_cnt; if the timeouted command is retried,
>    another increasement for iorequest_cnt would be performed, the
>    command might add iorequest_cnt for multiple times but iodone_cnt
>    only once. Increase iodone_cnt in scsi_timeout() can handle this
>    scenario.
> 
> 2. scsi_dispatch_cmd() failed, while the iorequest_cnt has already been
>    increased. If scsi_dispatch_cmd() failed, the request would be
>    requeued, then another iorequest_cnt would be added. So we should not
>    increase iorequest_cnt if dispatch command failed
> 
> V2:
> - Add description about why we can add iodone_cnt in scsi_timeout()
> - Do not increase iorequest_cnt if dispatch command failed
> 
> Wenchao Hao (2):
>   scsi: increase scsi device's iodone_cnt in scsi_timeout()
>   scsi: donot increase scsi_device's iorequest_cnt if dispatch failed
> 
>  drivers/scsi/scsi_error.c | 1 +
>  drivers/scsi/scsi_lib.c   | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Friendly ping...
