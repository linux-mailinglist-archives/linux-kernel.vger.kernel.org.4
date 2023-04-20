Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785A6E8946
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjDTEt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjDTEtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:49:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BEF4225
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:49:23 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q24t53Py4z8xD1;
        Thu, 20 Apr 2023 12:48:29 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 12:49:21 +0800
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
To:     Richard Weinberger <richard@nod.at>, Yu Hao <yhao016@ucr.edu>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
 <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com>
 <687864524.118195.1681799447034.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com>
Date:   Thu, 20 Apr 2023 12:49:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <687864524.118195.1681799447034.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
> Yu Hao,
> 
> ----- Ursprüngliche Mail -----
>> Von: "Yu Hao" <yhao016@ucr.edu>
>>> ubi: mtd0 is already attached to ubi0
>>> ubi7: attaching mtd147
>>> divide error: 0000 [#1] PREEMPT SMP KASAN
>>> CPU: 0 PID: 20023 Comm: syz-executor.0 Not tainted 6.2.0 #6
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>> 1.13.0-1ubuntu1.1 04/01/2014
>>> RIP: 0010:mtd_div_by_eb include/linux/mtd/mtd.h:580 [inline]
>>> RIP: 0010:io_init drivers/mtd/ubi/build.c:620 [inline]
>>> RIP: 0010:ubi_attach_mtd_dev+0x77f/0x2fe0 drivers/mtd/ubi/build.c:955
>>> Code: fc ff df 48 c1 ea 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38
>>> d0 7c 08 84 d2 0f 85 1f 25 00 00 41 8b 4c 24 10 48 89 d8 31 d2 <48> f7
>>> f1 48 89 c3 e8 b6 f3 1b fc 48 8d 85 40 17 00 00 48 89 c2 48
>>> RSP: 0018:ffffc9000be0fd30 EFLAGS: 00010246
>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>> RDX: 0000000000000000 RSI: ffff888047a49d40 RDI: 0000000000000002
>>> RBP: ffff888024e1c000 R08: 0000000000000016 R09: fffff520017c1f47
>>> R10: ffffc9000be0fa37 R11: fffff520017c1f46 R12: ffff88806545a000
>>> R13: 0000000000000000 R14: ffff88806545a010 R15: 0000000000000007
>>> FS:  00007fd45e85c700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f64aeef53a4 CR3: 000000004f39a000 CR4: 0000000000350ef0
>>> Call Trace:
>>>   <TASK>
>>>   ctrl_cdev_ioctl+0x303/0x3a0 drivers/mtd/ubi/cdev.c:1043
> 
> What kind of MTD you attaching?
> Has it erasesize 0?
> 

Yes, I agree with Richard's point, I guess UBI got an mtd device with 
zero erasesize.


  568 static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info 
*mtd)
  569 {
  570         if (mtd->erasesize_shift)       // erasesize_shift is 0
  571                 return sz >> mtd->erasesize_shift;
  572         do_div(sz, mtd->erasesize);    // erasesize is 0 too
  573         return sz;
  574 }

Yu Hao, how do you find the problem, by syzkaller? Can you provide the 
reproducing program or reproducing log?
