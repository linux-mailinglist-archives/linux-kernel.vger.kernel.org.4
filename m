Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071E65FFEFA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJPLhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJPLhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 07:37:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773B439BA1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 04:37:19 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ok1xD-0003Xb-7L; Sun, 16 Oct 2022 13:37:15 +0200
Message-ID: <a7c43527-1634-ff02-985e-4a6ad21b237c@leemhuis.info>
Date:   Sun, 16 Oct 2022 13:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [6.0.0] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0
 [polyval_clmulni]
Content-Language: en-US, de-DE
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     CKI Project <cki-project@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CA+QYu4oK8D-89QZnBC8eYS9TxOU48hY5JazTvF=4N2qdeRepbw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CA+QYu4oK8D-89QZnBC8eYS9TxOU48hY5JazTvF=4N2qdeRepbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665920239;11f4b1fd;
X-HE-SMSGID: 1ok1xD-0003Xb-7L
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 03.10.22 09:16, Bruno Goncalves wrote:
> 
> recently we are hitting the following issue when booting using kernel
> with debug options enabled:

Bruno, FYI, reports sent just to LKML without CCing any actual people
(or at least subsystem specific mailing list, but that often is not
enough either) are most likely to be ignored, because nearly nobody
reads LKML fully these days. That's why I added the crypto maintainers
and the crypto list.

> [  126.821761] CPU: 1 PID: 296 Comm: cryptomgr_test Not tainted 6.0.0 #1
> [  126.824021] Hardware name: Red Hat KVM, BIOS 1.15.0-1.el9 04/01/2014
> [  126.825721] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]

FWIW, I noticed a report that looked someone similar:
https://bugzilla.kernel.org/show_bug.cgi?id=216587
Then I searched lore, which brought me to this mail and made me send
this reply to get the people that should deal with this into the loop,
which hopefully should get things rolling now.

For the rest of this mail:
[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

> [  126.827045] Code: df 11 c4 41 31 ef fb 48 83 c2 08 0f 84 eb 01 00
> 00 48 89 d0 48 c1 e0 04 48 81 c7 80 00 00 00 48 29 c7 0f 10 06 66 41
> 0f ef c7 <0f> 28 0f c4 63 71 44 f0 01 c4 e3 71 44 d0 10 c4 63 71 44 e0
> 00 c4
> [  126.831535] RSP: 0018:ffff88810ed779d8 EFLAGS: 00010282
> [  126.832957] RAX: 0000000000000030 RBX: 0000000000000030 RCX: ffff88810ede19e8
> [  126.834907] RDX: 0000000000000003 RSI: ffff8881094b8000 RDI: ffff88811483c408
> [  126.836554] RBP: ffff8881094b8000 R08: ffffffffc0300835 R09: ffff88810ede19e8
> [  126.838529] R10: ffffed1021dbc33f R11: 0000000000000000 R12: 0000000000000030
> [  126.840526] R13: 0000000000000003 R14: ffff88810ede19e8 R15: ffff88810ede19e0
> [  126.842702] FS:  0000000000000000(0000) GS:ffff888193d00000(0000)
> knlGS:0000000000000000
> [  126.844574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  126.846796] CR2: 0000564f48e04178 CR3: 000000010be88002 CR4: 0000000000370ee0
> [  126.848934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  126.850913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  126.852879] Call Trace:
> [  126.853703]  <TASK>
> [  126.854436]  polyval_x86_update+0x102/0x1e0 [polyval_clmulni]
> [  126.856092]  test_shash_vec_cfg+0x523/0x9d0
> [  126.857360]  ? alg_test_aead+0x170/0x170
> [  126.858682]  ? pointer+0x6a0/0x6a0
> [  126.859752]  ? ___slab_alloc+0x910/0xf70
> [  126.860950]  ? __alg_test_hash.constprop.0+0x200/0x430
> [  126.862140]  ? __kmalloc+0x64/0x380
> [  126.863233]  ? sprintf+0xb3/0xe0
> [  126.864159]  ? rcu_read_lock_sched_held+0x3f/0x80
> [  126.865560]  ? trace_kmalloc+0x33/0xf0
> [  126.866716]  __alg_test_hash.constprop.0+0x2e7/0x430
> [  126.867995]  ? test_ahash_vec_cfg+0xca0/0xca0
> [  126.869389]  ? lockdep_hardirqs_on_prepare+0x230/0x230
> [  126.870906]  ? lockdep_hardirqs_on+0x7d/0x100
> [  126.872221]  ? alg_test_hash+0x8e/0x130
> [  126.873398]  alg_test+0x60d/0x7d0
> [  126.874463]  ? alloc_cipher_test_sglists+0xb0/0xb0
> [  126.875867]  ? lock_release+0x233/0x470
> [  126.876726]  ? __kthread_parkme+0x65/0xf0
> [  126.877654]  ? reacquire_held_locks+0x270/0x270
> [  126.878984]  ? mark_held_locks+0x24/0x90
> [  126.879985]  ? preempt_count_sub+0xb7/0x100
> [  126.881260]  ? crypto_acomp_scomp_free_ctx+0x70/0x70
> [  126.882649]  cryptomgr_test+0x36/0x60
> [  126.883786]  kthread+0x17e/0x1b0
> [  126.884564]  ? kthread_complete_and_exit+0x20/0x20
> [  126.885975]  ret_from_fork+0x22/0x30
> [  126.887086]  </TASK>
> [  126.887858] Modules linked in: polyval_clmulni(+) polyval_generic
> virtio_blk(+) ghash_clmulni_intel floppy virtio_console serio_raw
> ata_generic pata_acpi qemu_fw_cfg
> 
> 
> full console log:
> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/10/02/redhat:656405029/build_x86_64_redhat:656405029_x86_64_debug/tests/4/results_0001/console.log/console.log
> 
> test logs: https://datawarehouse.cki-project.org/kcidb/tests/5344697
> cki issue tracker: https://datawarehouse.cki-project.org/issue/1626
> 
> kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/build%20x86_64%20debug/3116060967/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.config
> kernel tarball:
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/publish%20x86_64%20debug/3116060972/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.tar.gz
> 
> We didn't bisect, but the first commit we tested that we hit the
> problem is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46452d3786a82bd732ba73fb308ae5cbe4e1e591
> 
> The last commit we tested and didn't hit the problem is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1375562c0a87f0fa2eaf3e8ce15824696d4170a

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot introduced a1375562c0a87..46452d3786a82 ^
https://bugzilla.kernel.org/show_bug.cgi?id=216587
#regzbot title crypto: kernel panic after "RIP:
0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]"
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
