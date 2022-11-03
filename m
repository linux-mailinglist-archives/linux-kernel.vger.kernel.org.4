Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C292617E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiKCNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKCNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:51:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA2A95B8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:51:50 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oqadI-00073V-Vf; Thu, 03 Nov 2022 14:51:49 +0100
Message-ID: <37cd0a8d-bbd1-baf3-9c37-0cb8325b4cb3@leemhuis.info>
Date:   Thu, 3 Nov 2022 14:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [REGRESSION] Bug 216646 - having TRANSPARENT_HUGEPAGE enabled hangs
 some applications
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikhail Pletnev <mmp.dux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667483511;66c8a863;
X-HE-SMSGID: 1oqadI-00073V-Vf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Matthew, I noticed a regression report in bugzilla.kernel.org. As many
(most?) kernel developer don't keep an eye on it, I decided to forward
it by mail. Quoting from
https://bugzilla.kernel.org/show_bug.cgi?id=216646 :

>  Mikhail Pletnev 2022-11-01 02:43:59 UTC
> 
> Created attachment 303112 [details]
> dmesg error
> 
> After updating kernel past 5.17 (checked in 5.19, 6.06), deluge torrent client began to hang after 1-4 hours of runtime, (when under heavy load - thousands of files mmapped and read at 20+MB/s) with following message in dmesg:
>   
> BUG: kernel NULL pointer dereference, address: 0000000000000096
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 15 PID: 8263 Comm: Disk Not tainted 5.17.0-rc4_ap-00165-g56a4d67c264e-dirty #36
> Hardware name: Micro-Star International Co., Ltd. MS-7C35/MEG X570 UNIFY (MS-7C35), BIOS A.C3 03/15/2022
> RIP: 0010:__filemap_get_folio+0x9e/0x350
> Code: 10 e8 46 06 68 00 48 89 c3 48 3d 02 04 00 00 74 e2 48 3d 06 04 00 00 74 da 48 85 c0 0f 84 3e 02 00 00 a8 01 0f 85 40 02 00 00 <8b> 40 34 85 c0 74 c2 8d 50 01 f0 0f b1 53 34 75 f2 48 8b 54 24 28
> RSP: 0000:ffffbe1044ad3cb0 EFLAGS: 00010246
> RAX: 0000000000000062 RBX: 0000000000000062 RCX: 0000000000000002
> RDX: 000000000000001c RSI: ffffbe1044ad3cc0 RDI: ffff9fca83239ff0
> RBP: 0000000000000000 R08: ffffbe1044ad3d40 R09: 0000000000000000
> R10: ffffffffffffffc0 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff9fcbee9efa78 R14: 000000000004285e R15: fff000003fffffff
> FS:  00007f0a763fc640(0000) GS:ffff9fd23edc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000096 CR3: 0000000122c60000 CR4: 0000000000750ee0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  filemap_fault+0x63/0x820
>  __do_fault+0x2f/0x80
>  __handle_mm_fault+0xe46/0x15c0
>  ? __hrtimer_init+0xd0/0xd0
>  handle_mm_fault+0xbc/0x280
>  do_user_addr_fault+0x1bc/0x640
>  exc_page_fault+0x60/0x140
>  ? asm_exc_page_fault+0x8/0x30
>  asm_exc_page_fault+0x1e/0x30
> RIP: 0033:0x7f0aae557789
> Code: 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 83 fa 20 72 27 <c5> fe 6f 06 48 83 fa 40 0f 87 a9 00 00 00 c5 fe 6f 4c 16 e0 c5 fe
> RSP: 002b:00007f0a763fb7e8 EFLAGS: 00010202
> RAX: 00007f0a5c070bc0 RBX: 0000000000000000 RCX: 00007f0a763fb990
> RDX: 0000000000004000 RSI: 00007ef87d85e4d7 RDI: 00007f0a5c070bc0
> RBP: 00007f0a763fb808 R08: 0000000000000006 R09: 0000000000000000
> R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f09dccf30f0 R14: 000000000000001d R15: 00007f0a5c001480
>  </TASK>
> Modules linked in: overlay xt_addrtype amdgpu drm_ttm_helper ttm gpu_sched drm_kms_helper backlight iwlmvm syscopyarea mac80211 libarc4 sysfillrect sysimgblt fb_sys_fops iwlwifi i2c_piix4 cfg80211 k10temp fuse configfs efivarfs
> CR2: 0000000000000096
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__filemap_get_folio+0x9e/0x350
> Code: 10 e8 46 06 68 00 48 89 c3 48 3d 02 04 00 00 74 e2 48 3d 06 04 00 00 74 da 48 85 c0 0f 84 3e 02 00 00 a8 01 0f 85 40 02 00 00 <8b> 40 34 85 c0 74 c2 8d 50 01 f0 0f b1 53 34 75 f2 48 8b 54 24 28
> RSP: 0000:ffffbe1044ad3cb0 EFLAGS: 00010246
> RAX: 0000000000000062 RBX: 0000000000000062 RCX: 0000000000000002
> RDX: 000000000000001c RSI: ffffbe1044ad3cc0 RDI: ffff9fca83239ff0
> RBP: 0000000000000000 R08: ffffbe1044ad3d40 R09: 0000000000000000
> R10: ffffffffffffffc0 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff9fcbee9efa78 R14: 000000000004285e R15: fff000003fffffff
> FS:  00007f0a763fc640(0000) GS:ffff9fd23edc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000096 CR3: 0000000122c60000 CR4: 0000000000750ee0
> PKRU: 55555554
> 
> i did a bisect:
> 
> git bisect start
> git bisect bad be1a63daffdd152ba4c7b71ab9fec2e39259b42b
> git bisect good 8bb7eca972ad531c9b149c0a51ab43a417385813
> git bisect good fee62ea772040a6b7d5d07d285dcf68f989fc81c
> git bisect bad dbe946287e0825f0e9cd4cbeacfcde9d9b2dd168
> git bisect bad 25fd2d41b505d0640bdfe67aa77c549de2d3c18a
> git bisect bad 182966e1cd74ec0e326cd376de241803ee79741b
> git bisect good b080cee72ef355669cbc52ff55dc513d37433600
> git bisect good 3fe2f7446f1e029b220f7f650df6d138f91651f2
> git bisect bad d51b1b33c51d147b757f042b4d336603b699f362
> git bisect good 3bf03b9a0839c9fb06927ae53ebd0f960b19d408
> git bisect bad 6b1f86f8e9c7f9de7ca1cb987b2cf25e99b1ae3a
> git bisect good 4aed23a2f8aaaafad0232d3392afcf493c3c3df3
> git bisect good ebf55c886eb7fc3c54d02ba1046f0ee38b81fc10
> git bisect good d68eccad370665830e16e5c77611fde78cd749b3
> git bisect good 3a3bae50af5d73fab5da20484029de77ca67bb2e
> git bisect good 1854bc6e2420472676c5c90d3d6b15f6cd640e40
> git bisect bad 72e725887413f031fa72d27fea5795450bab1940
> git bisect bad 4687fdbb805a92ce5a9f23042c436dc64fef8b77
> git bisect bad 56a4d67c264e37014b8392cba9869c7fe904ed1e
> 
> which identified commit 56a4d67 as the culprit
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3027,7 +3027,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>         ra->size = ra->ra_pages;
>         ra->async_size = ra->ra_pages / 4;
>         ractl._index = ra->start;
> -       do_page_cache_ra(&ractl, ra->size, ra->async_size);
> +       page_cache_ra_order(&ractl, ra, 0);
>         return fpin;
>  }
> 
> I took a look at page_cache_ra_order and saw that it's behavior depends on MAX_PAGECACHE_ORDER and, subsequently, CONFIG_TRANSPARENT_HUGEPAGE. Then i tried disabling CONFIG_TRANSPARENT_HUGEPAGE and found that it indeed works around the issue for now.
> 
> Hardware:
> https://linux-hardware.org/?probe=1a88842782

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 56a4d67c264
https://bugzilla.kernel.org/show_bug.cgi?id=216646
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
