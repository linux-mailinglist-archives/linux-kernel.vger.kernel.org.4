Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABB6EBDD8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDWIC1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 23 Apr 2023 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDWICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:02:25 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563E5CC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 01:02:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CEB0463CC166;
        Sun, 23 Apr 2023 10:02:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SGYmLo3VK3p2; Sun, 23 Apr 2023 10:02:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5CBEA63CC174;
        Sun, 23 Apr 2023 10:02:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zUKjAkq3QXJ7; Sun, 23 Apr 2023 10:02:20 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 42A9563CC166;
        Sun, 23 Apr 2023 10:02:20 +0200 (CEST)
Date:   Sun, 23 Apr 2023 10:02:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Yu Hao <yhao016@ucr.edu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1366603418.245114.1682236940160.JavaMail.zimbra@nod.at>
In-Reply-To: <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com> <687864524.118195.1681799447034.JavaMail.zimbra@nod.at> <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com> <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com> <977347543.226888.1682011999468.JavaMail.zimbra@nod.at> <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com> <412779912.228444.1682023015809.JavaMail.zimbra@nod.at> <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: divide error in ubi_attach_mtd_dev
Thread-Index: P5jqm95hRKoxVO9TZkSQrtm6hLkHZQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>> root@syzkaller:~# cat /proc/mtd
>>> dev:    size   erasesize  name
>>> mtd0: 00020000 00001000 “mtdram test device”
>> 
>> Hmm, mtdram should be fine, erasesize is not zero.
>> 
> 
> I guess the zero-erasesize mtd device is dynamically generated in
> runtime, after looking through the code, I find erasesize is
> initiallized in specific flash driver and it won't be updated later(eg.
> ioctl\sysctl). And some mtd devices may have zero erasesize, eg.
> drivers/mtd/devices/mchp23k256.c[1]. Unfortunately, I don't know how to
> load/simulate this mtd, maybe it requires a real device? If we load this
> mtd device as ubi, it will trigger the problem?

Indeed. I guess qemu can emulate such chips.
So better fix UBI to reject attaching of mtd's with erasesize being 0.
(Please note, we cannot test for MTD_NO_ERASE, this one means there is no
erase method).

Thanks,
//richard
