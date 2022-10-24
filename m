Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068CF60BD21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiJXWJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiJXWI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:08:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F62FF684;
        Mon, 24 Oct 2022 13:22:51 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MwvrX1QKbz6HJRR;
        Mon, 24 Oct 2022 20:43:40 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:44:58 +0200
Received: from [10.48.145.243] (10.48.145.243) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 13:44:58 +0100
Message-ID: <dc61408d-8fc7-ca29-d284-0c92c2e1828c@huawei.com>
Date:   Mon, 24 Oct 2022 13:44:56 +0100
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
References: <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
 <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
 <Yz7qD+gpmI1bdw16@x1-carbon>
 <bc7d74dc-5aaa-1ad3-626f-df89955b1380@huawei.com>
 <Y1aEGW2BtdIRJy7s@x1-carbon>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <Y1aEGW2BtdIRJy7s@x1-carbon>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.243]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

Hi Niklas,

> 
> For the record, I tested the pm80xx driver on a HoneyComb LX2 board
> (an arm64 board using ACPI).
> 
> I tried v6.1-rc1 both with and without your series in $subject.
> 
> I couldn't see any issues.

ok, thanks for the effort.

> 
> 
> What I tried:
> -Running fio:
> fio --name=test --filename=/dev/sdc --ioengine=io_uring --rw=randrw --direct=1 --iodepth=32 --bs=1M
> on three different HDDs simultaneously for 15+ minutes,
> without any errors in fio or dmesg.
> 
> -Creating and mounting a btrfs volume, doing a huge dd to the filesystem
> without issues.
> 
> -sg_sat_read_gplog -d --log=0x10 /dev/sda
> which successfully returned the log.
> 
> 
> It is worth mentioning that this arm64 board has reserved memory regions,
> but does not yet have a firmware that supplies a IORT RMR (reserved memory
> regions) revision E.d node, which means that in order to get this board to
> boot successfully, we need to supply:
> "arm-smmu.disable_bypass=0 iommu.passthrough=1"
> on the kernel command line.

hmmm... that's interesting. I can try again with the IOMMU turned off, 
but, as I recall, it did not make a difference before. I think that 
requiring reserved memory regions would totally bust the driver (if not 
present) with IOMMU enabled. As I recall, sas 3008 card would not work 
without RMR for us.

It's also interesting that this LX2 board has A72 cores. For my system, 
we have newer custom arm v8 cores with quite weak memory ordering 
implementation. With that same system, I have detected a couple of other 
driver memory ordering bugs which we did not see on our A72-based platforms.

I always suspected that this issue was a memory ordering issue, but 
since the hang so reliably occurs I ruled it out. Maybe it is...

thanks,
John
