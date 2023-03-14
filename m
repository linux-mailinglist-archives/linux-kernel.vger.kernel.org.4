Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80236B9025
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCNKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCNKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:35:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653A95E32
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:35:01 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PbVDS5SYRznWxL;
        Tue, 14 Mar 2023 18:31:04 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 18:34:00 +0800
Subject: Re: [PATCH v8 2/5] hisi_acc_vfio_pci: extract public functions for
 container_of
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-3-liulongfang@huawei.com>
 <20230310164010.3428141f.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <5d20b25f-4872-e033-9aa7-4526125a97a7@huawei.com>
Date:   Tue, 14 Mar 2023 18:34:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230310164010.3428141f.alex.williamson@redhat.com>
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

On 2023/3/11 7:40, Alex Williamson wrote:
> On Fri, 17 Feb 2023 16:48:28 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> In the current driver, vdev is obtained from struct
>> hisi_acc_vf_core_device through the container_of function.
>> This method is used in many places in the driver. In order to
>> reduce this repetitive operation, I extracted a public function
>> to replace it.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 21 ++++++++++---------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index a117eaf21c14..a1589947e721 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -630,6 +630,12 @@ static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vde
>>  	}
>>  }
>>  
>> +static struct hisi_acc_vf_core_device *hisi_acc_get_vf_dev(struct vfio_device *vdev)
>> +{
>> +	return container_of(vdev, struct hisi_acc_vf_core_device,
>> +			    core_device.vdev);
>> +}
> 
> This type of function is often named to_foo_bar(), ex. to_pci_dev(),
> and often macros.  Perhaps:
> 
> #define to_hisi_acc_dev(n) container_of(n, \
> 	struct hisi_acc_vf_core_device, core_device,vdev)
>

First of all, thanks for your suggestion, but I want to keep
the current way of complete function declaration.

Thanks,
Longfang.
> Thanks,
> Alex
> 
>> +
>>  /*
>>   * This function is called in all state_mutex unlock cases to
>>   * handle a 'deferred_reset' if exists.
>> @@ -1042,8 +1048,7 @@ static struct file *
>>  hisi_acc_vfio_pci_set_device_state(struct vfio_device *vdev,
>>  				   enum vfio_device_mig_state new_state)
>>  {
>> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
>> -			struct hisi_acc_vf_core_device, core_device.vdev);
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>>  	enum vfio_device_mig_state next_state;
>>  	struct file *res = NULL;
>>  	int ret;
>> @@ -1084,8 +1089,7 @@ static int
>>  hisi_acc_vfio_pci_get_device_state(struct vfio_device *vdev,
>>  				   enum vfio_device_mig_state *curr_state)
>>  {
>> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
>> -			struct hisi_acc_vf_core_device, core_device.vdev);
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>>  
>>  	mutex_lock(&hisi_acc_vdev->state_mutex);
>>  	*curr_state = hisi_acc_vdev->mig_state;
>> @@ -1301,8 +1305,7 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>>  
>>  static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>>  {
>> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
>> -			struct hisi_acc_vf_core_device, core_device.vdev);
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>>  	struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
>>  	int ret;
>>  
>> @@ -1325,8 +1328,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
>>  
>>  static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
>>  {
>> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
>> -			struct hisi_acc_vf_core_device, core_device.vdev);
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>>  
>>  	iounmap(vf_qm->io_base);
>> @@ -1341,8 +1343,7 @@ static const struct vfio_migration_ops hisi_acc_vfio_pci_migrn_state_ops = {
>>  
>>  static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>>  {
>> -	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
>> -			struct hisi_acc_vf_core_device, core_device.vdev);
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>>  	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
>>  	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
>>  
> 
> .
> 
