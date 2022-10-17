Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703D5600A59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJQJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJQJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:21:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F40252B8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:20:50 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrWZ23v40z1P7Vh;
        Mon, 17 Oct 2022 17:15:54 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:20:35 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:20:34 +0800
Subject: Re: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
To:     John Garry <john.garry@huawei.com>, <alex.williamson@redhat.com>,
        <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <20221014025757.39415-1-liulongfang@huawei.com>
 <20221014025757.39415-2-liulongfang@huawei.com>
 <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
Date:   Mon, 17 Oct 2022 17:20:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/14 17:20, John Garry wrote:
> On 14/10/2022 03:57, Longfang Liu wrote:
>> +static void hisi_acc_vf_debugfs_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>> +{
>> +    struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
>> +    struct device *dev = &vf_pdev->dev;
>> +    int ret;
>> +
>> +    if (!atomic_read(&hisi_acc_root_ref))
>> +        hisi_acc_debugfs_root = debugfs_create_dir("hisi_vfio_acc", NULL);
>> +    atomic_inc(&hisi_acc_root_ref);
>> +
> 
> This looks totally racy, such that I wonder why even bother using an atomic for hisi_acc_root_ref.


When enabling VF, it is possible for multiple VMs to enable VF at the same time. The atomic variable
is used to ensure that only one "hisi_vfio_acc" is created. When other VFs are enabled,
it will not be created again, but will be used directly.

 Indeed, why is hisi_acc_debugfs_root not created in the driver module init?
>
Because the normal function of VF is to perform encryption and decryption services, the live migration
function is an auxiliary function, which no need to be used in scenarios where only encryption and
decryption services are performed.

During module init, it can register ops(hisi_acc_vfio_pci_ops) that only perform encryption and
decryption services, and can also register with live migration function ops(hisi_acc_vfio_pci_migrn_ops),
and this debugfs only needs to register it when the the ops is hisi_acc_vfio_pci_migrn_ops.

> Thanks,
> John
> .
> 
