Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1EE6EA25E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjDUDdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjDUDcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:32:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005F2712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:32:49 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q2g3y4GmVz17WMn;
        Fri, 21 Apr 2023 11:29:02 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 11:32:47 +0800
Subject: Re: [PATCH v10 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
From:   liulongfang <liulongfang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-4-liulongfang@huawei.com> <ZDlGC8SUXqKNmfSe@nvidia.com>
 <ca592d60-9a5b-dec3-9565-76cd5c0740e0@huawei.com>
Message-ID: <81e11acf-0ede-d515-bb5a-3964c302f384@huawei.com>
Date:   Fri, 21 Apr 2023 11:32:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca592d60-9a5b-dec3-9565-76cd5c0740e0@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/21 11:27, liulongfang wrote:
> On 2023/4/14 20:24, Jason Gunthorpe wrote:
>> On Sat, Apr 08, 2023 at 03:42:22PM +0800, Longfang Liu wrote:
>>> +static int hisi_acc_vf_debug_restore(struct seq_file *seq, void *data)
>>> +{
>>> +	struct device *vf_dev = seq->private;
>>> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
>>> +	struct vfio_device	*vdev = &core_device->vdev;
>>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>>> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
>>> +	int ret;
>>> +
>>> +	ret = hisi_acc_vf_debug_check(seq, vdev);
>>> +	if (ret)
>>> +		goto restore_err;
>>> +
>>> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
>>> +	if (ret) {
>>> +		seq_printf(seq, "%s\n", "failed to save device data!");
>>> +		goto restore_err;
>>> +	}
>>> +
>>> +	ret = vf_qm_check_match(hisi_acc_vdev, migf);
>>> +	if (ret) {
>>> +		seq_printf(seq, "%s\n", "failed to match the VF!");
>>> +		goto restore_err;
>>> +	}
>>> +
>>> +	ret = vf_qm_load_data(hisi_acc_vdev, migf);
>>> +	if (ret) {
>>> +		seq_printf(seq, "%s\n", "failed to recover the VF!");
>>> +		goto restore_err;
>>> +	}
>>> +
>>> +	vf_qm_fun_reset(&hisi_acc_vdev->vf_qm);
>>> +	seq_printf(seq, "%s\n", "successful to resume device data!");
>>> +
>>> +restore_err:
>>> +	return 0;
>>> +}
>>
>> This is basically an in-kernel self test, it should be protected with
>> some kind of VFIO selftest kconfig.
>>
> As a debugfs function, its usage will be more flexible for users.
> 
>> Though, I wonder why we need it??? 
> After a live migration error occurs. Through this debugfs function,
> you can perform separate functional tests on the source and destination
> to locate the cause of the error.
> 
> Can't you write a trivial userspace
>> program under tools/testing to do this sequence with the ioctls?
>>
> Sorry, I still wish this feature was a simple debugfs feature.
> If you want the userspace testing tool you mentioned,
> you can try it on mlx5.
> 
> Thanks,
> Longfang.
>>> +static int hisi_acc_vf_debug_save(struct seq_file *seq, void *data)
>>> +{
>>> +	struct device *vf_dev = seq->private;
>>> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
>>> +	struct vfio_device	*vdev = &core_device->vdev;
>>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>>> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
>>> +	int ret;
>>> +
>>> +	ret = hisi_acc_vf_debug_check(seq, vdev);
>>> +	if (ret)
>>> +		goto save_err;
>>> +
>>> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
>>> +	if (ret) {
>>> +		seq_printf(seq, "%s\n", "failed to save device data!");
>>> +		goto save_err;
>>> +	}
>>> +	seq_printf(seq, "%s\n", "successful to save device data!");
>>> +
>>> +save_err:
>>> +	return 0;
>>> +}
>>
>> Same kind of commen there, this is a selftest, why does it need a
>> special kernel interface?
>>
>> .. and so on..
>>
>> I thought the non-selftesty bits were OK, maybe split the patch to
>> match progress
>>

Thank you for your suggestion, but the current debugfs method can already
meet the functional requirements of verification testing and
problem location.

Thanks,
Longfang.
>> Jason
>> .
>>
