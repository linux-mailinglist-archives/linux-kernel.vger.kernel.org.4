Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50745FEB73
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJNJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJNJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:20:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741C3D5BF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:20:08 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpgnJ16Y4z67lcR;
        Fri, 14 Oct 2022 17:19:16 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:20:05 +0200
Received: from [10.195.32.90] (10.195.32.90) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 10:20:05 +0100
Message-ID: <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
Date:   Fri, 14 Oct 2022 10:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
To:     Longfang Liu <liulongfang@huawei.com>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <20221014025757.39415-1-liulongfang@huawei.com>
 <20221014025757.39415-2-liulongfang@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221014025757.39415-2-liulongfang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.90]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 03:57, Longfang Liu wrote:
> +static void hisi_acc_vf_debugfs_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> +{
> +	struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
> +	struct device *dev = &vf_pdev->dev;
> +	int ret;
> +
> +	if (!atomic_read(&hisi_acc_root_ref))
> +		hisi_acc_debugfs_root = debugfs_create_dir("hisi_vfio_acc", NULL);
> +	atomic_inc(&hisi_acc_root_ref);
> +

This looks totally racy, such that I wonder why even bother using an 
atomic for hisi_acc_root_ref. Indeed, why is hisi_acc_debugfs_root not 
created in the driver module init?

Thanks,
John
