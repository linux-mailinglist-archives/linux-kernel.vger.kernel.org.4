Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3353265F0A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjAEP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjAEP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:59:16 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00340F66
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:59:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VYwMxZY_1672934349;
Received: from 30.27.95.191(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYwMxZY_1672934349)
          by smtp.aliyun-inc.com;
          Thu, 05 Jan 2023 23:59:11 +0800
Message-ID: <03ada837-2504-9e69-5fec-0b7a7f186d90@linux.alibaba.com>
Date:   Thu, 5 Jan 2023 23:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [syzbot] [erofs?] WARNING: CPU: NUM PID: NUM at
 mm/page_alloc.c:LINE get_page_from_freeli
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <000000000000c0a08805f07291a0@google.com>
 <f126fc95-fdbe-cc2e-5efb-ab704d13bd41@linux.alibaba.com>
 <CANp29Y63rCdepVtantxdJEcvbRv0D61gfY_oGV7dgrmEGgPdLw@mail.gmail.com>
From:   Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <CANp29Y63rCdepVtantxdJEcvbRv0D61gfY_oGV7dgrmEGgPdLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Aleksandr,

On 2023/1/5 19:14, Aleksandr Nogikh wrote:
> Hi,
> 
> On Thu, Jan 5, 2023 at 11:54 AM Xiang Gao <hsiangkao@linux.alibaba.com> wrote:
> 
>> I wasn't able to build the kernel with this kernel config, it shows:
>> "...
>> FATAL: modpost: vmlinux.o is truncated. sechdrs[i].sh_offset=1399394064 > sizeof(*hrd)=64
>> make[2]: *** [Module.symvers] Error 1
>> make[1]: *** [modpost] Error 2
>> make: *** [__sub-make] Error 2
>> "
> 
> Could you please tell, what exact compiler/linker version did you use?

Thanks for your help.

GCC 9.2.1 on my developping server.

> 
> 
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/0c8a5f06ceb3/disk-f9ff5644.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/be222e852ae2/vmlinux-f9ff5644.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/d9f42a53b05e/bzImage-f9ff5644.xz
>>
>> Finally I tried the original kernel image, and it printed some other
>> random bug when booting system and then reboot, like:
>>
>> [   36.991123][    T1] ==================================================================
>> [   36.991800][    T1] BUG: KASAN: slab-out-of-bounds in copy_array+0x96/0x100
>> [   36.992438][    T1] Write of size 32 at addr ffff888018c34640 by task systemd/1
> < .. >
> 
> Interesting!
> I've just tried to boot it with qemu and it was fine.
> 
> qemu-system-x86_64 -smp 2,sockets=2,cores=1 -m 4G -drive
> file=disk-f9ff5644.raw,format=raw -snapshot -nographic -enable-kvm
> 
> So it looks like it's some difference between these VMMs that causes
> that bug to fire.

I think the problem is that the rootfs which I used has more complicated
workload than the given one.

> 
>>
>> May I ask it can be reproducable on the latest -rc kernel?
> 
> We can ask syzbot about v6.2-rc2:
> 
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> 88603b6dc419445847923fcb7fe5080067a30f98

I think I know the root cause: It seems that kvcalloc doesn't support
GFP_NOFAIL, I will use kcalloc directly instead.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
>>
> 
> --
> Aleksandr
