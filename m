Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D06B91A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCNLbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCNLbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:31:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3FA24735
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:31:44 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PbWZ925RRzKmRV;
        Tue, 14 Mar 2023 19:31:29 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 19:31:42 +0800
Subject: Re: [PATCH v8 1/5] vfio/migration: Add debugfs to live migration
 driver
From:   liulongfang <liulongfang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-2-liulongfang@huawei.com> <ZAtlGDGZvBMMvE9R@nvidia.com>
 <b3f69fa5-b31e-f625-fc75-b655edb5f0c3@huawei.com>
Message-ID: <b721f417-55aa-2bb0-a223-2118ae4cbc30@huawei.com>
Date:   Tue, 14 Mar 2023 19:31:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b3f69fa5-b31e-f625-fc75-b655edb5f0c3@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/3/14 17:32, liulongfang wrote:
> On 2023/3/11 1:12, Jason Gunthorpe wrote:
>> On Fri, Feb 17, 2023 at 04:48:27PM +0800, Longfang Liu wrote:
>>> +void vfio_vf_debugfs_init(struct vfio_device *vdev)
>>> +{
>>> +	struct device *dev = &vdev->device;
>>> +
>>> +	vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
>>> +
>>> +	debugfs_create_devm_seqfile(dev, "migration_state", vdev->debug_root,
>>> +				  vfio_vf_state_read);
>>> +}
>>> +EXPORT_SYMBOL_GPL(vfio_vf_debugfs_init);
>>> +
>>> +void vfio_vf_debugfs_exit(struct vfio_device *vdev)
>>> +{
>>> +	debugfs_remove_recursive(vdev->debug_root);
>>> +}
>>> +EXPORT_SYMBOL_GPL(vfio_vf_debugfs_exit);
>>> +
>>> +void  vfio_debugfs_create_root(void)
>>> +{
>>> +	vfio_debugfs_root = debugfs_create_dir("vfio", NULL);
>>> +}
>>> +EXPORT_SYMBOL_GPL(vfio_debugfs_create_root);
>>> +
>>> +void  vfio_debugfs_remove_root(void)
>>> +{
>>> +	debugfs_remove_recursive(vfio_debugfs_root);
>>> +	vfio_debugfs_root = NULL;
>>> +}
>>> +EXPORT_SYMBOL_GPL(vfio_debugfs_remove_root);
>>
>> Why are these symbols exported?
>>
> 
> If the export statement is not added, a compilation error will occur:
> 
> ERROR: modpost: "vfio_vf_debugfs_init" [drivers/vfio/pci/hisilicon/hisi-acc-vfio-pci.ko] undefined!
> ERROR: modpost: "vfio_vf_debugfs_exit" [drivers/vfio/pci/hisilicon/hisi-acc-vfio-pci.ko] undefined!
> scripts/Makefile.modpost:126: recipe for target 'Module.symvers' failed
> make[1]: *** [Module.symvers] Error 1
> 

The first two functions cannot remove the export statement,
but the latter two can be removed.

Thanks,
Longfang.
> 
>> Jason
>>
>> .
> Thanks,
> Longfang
> 
>>
