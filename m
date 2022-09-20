Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A195BEB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiITRDq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Sep 2022 13:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiITRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:03:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C938501AF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:03:40 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MX79j1xwyzHnxQ;
        Wed, 21 Sep 2022 01:01:29 +0800 (CST)
Received: from kwepemm000006.china.huawei.com (7.193.23.237) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 01:03:37 +0800
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 kwepemm000006.china.huawei.com (7.193.23.237) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 01:03:36 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2375.031;
 Tue, 20 Sep 2022 18:03:34 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     liulongfang <liulongfang@huawei.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
Thread-Topic: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
Thread-Index: AQHYyKNl0n81Lxv0MUKz8I4GKo4bYq3oe7uAgAABAQCAABOTkA==
Date:   Tue, 20 Sep 2022 17:03:34 +0000
Message-ID: <04a17bfa71c440e8a38cba2337a8c6ac@huawei.com>
References: <20220915013157.60771-1-liulongfang@huawei.com>
 <20220915013157.60771-2-liulongfang@huawei.com>
 <20220920103443.72654dd7.alex.williamson@redhat.com>
 <YynsesGyvJl26jDI@nvidia.com>
In-Reply-To: <YynsesGyvJl26jDI@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: 20 September 2022 17:38
> To: Alex Williamson <alex.williamson@redhat.com>
> Cc: liulongfang <liulongfang@huawei.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; cohuck@redhat.com;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org
> Subject: Re: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
> 
> On Tue, Sep 20, 2022 at 10:34:43AM -0600, Alex Williamson wrote:
> > On Thu, 15 Sep 2022 09:31:53 +0800
> > Longfang Liu <liulongfang@huawei.com> wrote:
> >
> > > During the stop copy phase of live migration, the driver allocates a
> > > memory for the migrated data to save the data.
> > >
> > > When an exception occurs when the driver reads device data, the
> > > driver will report an error to qemu and exit the current migration state.
> > > But this memory is not released, which will lead to a memory leak
> > > problem.
> 
> Why isn't it released? The fput() releases it:
> 
> static int hisi_acc_vf_release_file(struct inode *inode, struct file *filp) {
> 	struct hisi_acc_vf_migration_file *migf = filp->private_data;
> 
> 	hisi_acc_vf_disable_fd(migf);
> 	mutex_destroy(&migf->lock);
> 	kfree(migf);
>         ^^^^^^^^^^
> 
> This patch looks wrong to me.

That's right. Missed that. Sorry of the oversight.

Thanks,
Shameer

