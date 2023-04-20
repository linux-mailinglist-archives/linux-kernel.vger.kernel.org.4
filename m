Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA67F6E9D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjDTUhD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 16:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjDTUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:37:01 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8BF1FFB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:36:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 29B8F63CC190;
        Thu, 20 Apr 2023 22:36:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NbvsokkF7ZlM; Thu, 20 Apr 2023 22:36:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B8976418F2B;
        Thu, 20 Apr 2023 22:36:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DRD9jo1tEAsD; Thu, 20 Apr 2023 22:36:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E189363CC190;
        Thu, 20 Apr 2023 22:36:55 +0200 (CEST)
Date:   Thu, 20 Apr 2023 22:36:55 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <412779912.228444.1682023015809.JavaMail.zimbra@nod.at>
In-Reply-To: <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com> <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com> <687864524.118195.1681799447034.JavaMail.zimbra@nod.at> <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com> <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com> <977347543.226888.1682011999468.JavaMail.zimbra@nod.at> <CA+UBctA4fSbSdooQ9q9fwNuaHb_PnkfFuqJ7Q5vii-3-uCiUjw@mail.gmail.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: divide error in ubi_attach_mtd_dev
Thread-Index: f8YvMDTSYLQx33FOZb2oMatq86v3fQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> Can you please share the qemu command line?
> qemu-system-x86_64 -m 2G -smp 2 -kernel
> /home/test/Workspace/SyzGen/linux-distro/linux-6.2-debug/arch/x86/boot/bzImage
> -append “console=ttyS0 root=/dev/sda net.ifnames=0” -hda
> /home/test/Workspace/SyzGen/linux-distro/image/stretch.img -chardev
> socket,id=SOCKSYZ,server=on,nowait,host=localhost,port=54640 -mon
> chardev=SOCKSYZ,mode=control -device virtio-rng-pci -device
> e1000,netdev=net0 -netdev
> user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:11760-:22 -display none
> -serial stdio -cpu host,migratable=off -no-reboot -name VM -snapshot
> -enable-kvm
> 
>> Within Linux you can query /proc/mtd or /sys/class/mtd/
>> to get infos about the MTD in question.
>>
> 
> Thanks for the hints. We find that this is a “mtdram test device”.
> 
> root@syzkaller:~# cat /proc/mtd
> dev:    size   erasesize  name
> mtd0: 00020000 00001000 “mtdram test device”

Hmm, mtdram should be fine, erasesize is not zero.

Thanks,
//richard
