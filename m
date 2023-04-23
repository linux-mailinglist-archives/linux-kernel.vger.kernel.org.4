Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B36EBC9A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjDWDVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWDVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:21:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E9210E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 20:20:59 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q3tjK19XRz17VZT;
        Sun, 23 Apr 2023 11:17:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 11:20:56 +0800
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
To:     Richard Weinberger <richard@nod.at>, Yu Hao <yhao016@ucr.edu>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
 <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com>
 <687864524.118195.1681799447034.JavaMail.zimbra@nod.at>
 <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com>
 <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com>
 <977347543.226888.1682011999468.JavaMail.zimbra@nod.at>
 <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com>
 <412779912.228444.1682023015809.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com>
Date:   Sun, 23 Apr 2023 11:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <412779912.228444.1682023015809.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/4/21 4:36, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>>> Can you please share the qemu command line?
>> qemu-system-x86_64 -m 2G -smp 2 -kernel
>> /home/test/Workspace/SyzGen/linux-distro/linux-6.2-debug/arch/x86/boot/bzImage
>> -append “console=ttyS0 root=/dev/sda net.ifnames=0” -hda
>> /home/test/Workspace/SyzGen/linux-distro/image/stretch.img -chardev
>> socket,id=SOCKSYZ,server=on,nowait,host=localhost,port=54640 -mon
>> chardev=SOCKSYZ,mode=control -device virtio-rng-pci -device
>> e1000,netdev=net0 -netdev
>> user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:11760-:22 -display none
>> -serial stdio -cpu host,migratable=off -no-reboot -name VM -snapshot
>> -enable-kvm
>>
>>> Within Linux you can query /proc/mtd or /sys/class/mtd/
>>> to get infos about the MTD in question.
>>>
>>
>> Thanks for the hints. We find that this is a “mtdram test device”.
>>
>> root@syzkaller:~# cat /proc/mtd
>> dev:    size   erasesize  name
>> mtd0: 00020000 00001000 “mtdram test device”
> 
> Hmm, mtdram should be fine, erasesize is not zero.
> 

I guess the zero-erasesize mtd device is dynamically generated in 
runtime, after looking through the code, I find erasesize is 
initiallized in specific flash driver and it won't be updated later(eg. 
ioctl\sysctl). And some mtd devices may have zero erasesize, eg. 
drivers/mtd/devices/mchp23k256.c[1]. Unfortunately, I don't know how to 
load/simulate this mtd, maybe it requires a real device? If we load this 
mtd device as ubi, it will trigger the problem?


[1] https://cloud.tencent.com/developer/ask/sof/114616431
