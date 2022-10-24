Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6560B761
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiJXTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiJXTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:21:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B411D1F632;
        Mon, 24 Oct 2022 10:57:14 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mx0cp01G6z6HJTD;
        Tue, 25 Oct 2022 00:18:50 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 18:20:08 +0200
Received: from [10.48.145.243] (10.48.145.243) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:20:08 +0100
Message-ID: <7345fb7f-f713-2fdf-5fce-8a0549ff3b7e@huawei.com>
Date:   Mon, 24 Oct 2022 17:20:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
References: <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
 <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
 <Yz7qD+gpmI1bdw16@x1-carbon>
 <bc7d74dc-5aaa-1ad3-626f-df89955b1380@huawei.com>
 <Y1aEGW2BtdIRJy7s@x1-carbon>
 <dc61408d-8fc7-ca29-d284-0c92c2e1828c@huawei.com>
 <Y1aOrlmp3IDMDLS1@x1-carbon>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Y1aOrlmp3IDMDLS1@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.243]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 14:10, Niklas Cassel wrote:
> At least on the HoneyComb LX2,
> running with "arm-smmu.disable_bypass=0 iommu.passthrough=1" gives a working
> system (and working pm80xx).
> 
> The ACPI IOMMU code that parses the ACPI IORT RMR revision E.d node
> was first included in kernel v6.0:
> https://lore.kernel.org/linux-iommu/20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com/
> 
> However, the HoneyComb edk2-platforms code has not yet been updated to add
> a ACPI IORT RMR revision E.d node.
> 
> Considering that it works with "arm-smmu.disable_bypass=0 iommu.passthrough=1",
> I assume that the ACPI IORT RMR node basically just defines a number of
> memory regions which the IOMMU should treat as "bypass", while all other
> memory has to be re-mapped via the IOMMU as per usual.

Hi Niklas,

As I expected, unfortunately that did not help. Note that I actually 
can't use passthrough on my platform due to SMMUv3 implementation bug, 
so I just disable SMMUv3 entirely via kernel config.

I'm still betting on a memory ordering issue for me.

Thanks again,
John
