Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B663B7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiK2CC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiK2CCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:02:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A8FE02
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:02:49 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLlvj3zZrz15MyB;
        Tue, 29 Nov 2022 10:02:09 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 10:02:47 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 10:02:47 +0800
Subject: Re: [PATCH v3 1/5] vfio/migration: Add debugfs to live migration
 driver
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <john.garry@huawei.com>,
        <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <20221128031200.11017-1-liulongfang@huawei.com>
 <20221128031200.11017-2-liulongfang@huawei.com> <Y4S59c2dWqdrdUlg@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <ca3059d7-c73c-e712-9924-94891229cefd@huawei.com>
Date:   Tue, 29 Nov 2022 10:02:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4S59c2dWqdrdUlg@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/28 21:39, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 11:11:56AM +0800, Longfang Liu wrote:
> 
>> @@ -119,6 +132,9 @@ struct vfio_migration_ops {
>>  				   enum vfio_device_mig_state *curr_state);
>>  	int (*migration_get_data_size)(struct vfio_device *device,
>>  				       unsigned long *stop_copy_length);
>> +	int (*migration_get_data)(struct vfio_device *device, char *buffer);
>> +	int (*migration_get_attr)(struct vfio_device *device, char *buffer);
>> +	int (*migration_debug_operate)(struct vfio_device *device,
>>  				   unsigned int cmd);
> 
> Please don't do wrappers like this, give the variant driver a chance
> to create its own files natively under the debugfs directory
> 

Using this public debugfs file does not need to deal with file
creation and destruction.
The driver only needs to define its debug operation command,
isn't it simpler?

Thanks,
Longfang.
> Jason
> .
> 
