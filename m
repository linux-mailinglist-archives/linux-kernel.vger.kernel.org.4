Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF96F4196
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjEBK2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjEBK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:27:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF5559B;
        Tue,  2 May 2023 03:26:20 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ptnD7-0004cs-4G; Tue, 02 May 2023 12:26:17 +0200
Message-ID: <0fd55257-5b26-1969-18b7-97b39c3f620b@leemhuis.info>
Date:   Tue, 2 May 2023 12:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217386 - intel_powerclamp null pointer dereference
 in Linux 6.3.x
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683023180;0714f1ef;
X-HE-SMSGID: 1ptnD7-0004cs-4G
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developers don't keep an eye on it, I decided to forward it by mail.

Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
not CCed them in mails like this.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217386 :

>  Risto A. Paju 2023-05-01 09:49:03 UTC
> 
> Created attachment 304199 [details]
> dmesg-6.3.1
> 
> I use intel_powerclamp on a Thinkpad X220i via a custom script for
> thermal management, and it triggers a kernel bug in Linux 6.3.0 and
> 6.3.1. The script has a part
> 
> awk something > /sys/class/thermal/cooling_device4/cur_state
> 
> and the awk process hangs, with the null pointer bug reported in dmesg.
> 
> The script has worked fine for years, and for now I've switched back to
> the 6.2 series for this laptop.
> 
> [tag] [reply] [−]
> Private
> Comment 1 Risto A. Paju 2023-05-01 12:23:15 UTC
> 
> The affected CPU is an i3-2310M. I tested the same on a newer Intel
> laptop with an i5-7300HQ, and there's no sign of the bug there.

From the dmesg:

> [   16.495596] Oops: 0002 [#1] PREEMPT SMP PTI
> [   16.496084] CPU: 0 PID: 2792 Comm: awk Not tainted 6.3.1 #2
> [   16.496589] Hardware name: LENOVO 428737G/428737G, BIOS 8DET76WW (1.46 ) 06/21/2018
> [   16.497095] RIP: 0010:idle_inject_set_duration+0x6/0x20
> [   16.497607] Code: 00 49 c7 c4 f4 ff ff ff eb 92 49 c7 c4 f4 ff ff ff eb 91 cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 89 f0 01 d0 74 06 <89> 77 44 89 57 40 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00
> [   16.498824] RSP: 0018:ffffc900005e7de8 EFLAGS: 00010206
> [   16.499461] RAX: 00000000000927c0 RBX: 0000000000000000 RCX: 0000000000001770
> [   16.500103] RDX: 0000000000001770 RSI: 0000000000091050 RDI: 0000000000000000
> [   16.500752] RBP: 0000000000000002 R08: 0000000000000001 R09: 000000000000000a
> [   16.501405] R10: 000000000000000a R11: f000000000000000 R12: 0000000000000000
> [   16.502071] R13: ffff8881064bd720 R14: ffffc900005e7ea0 R15: ffff8881022283e0
> [   16.502745] FS:  00007fe494782b80(0000) GS:ffff888216200000(0000) knlGS:0000000000000000
> [   16.503421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.504095] CR2: 0000000000000044 CR3: 000000010f94c006 CR4: 00000000000606f0
> [   16.504783] Call Trace:
> [   16.505456]  <TASK>
> [   16.506124]  powerclamp_set_cur_state+0x56/0x200 [intel_powerclamp]
> [   16.506810]  cur_state_store+0x74/0xd0
> [   16.507497]  kernfs_fop_write_iter+0x128/0x1c0
> [   16.508193]  vfs_write+0x2be/0x3f0
> [   16.508897]  ksys_write+0x5a/0xe0
> [   16.509794]  do_syscall_64+0x3b/0x90
> [   16.510607]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   16.511444] RIP: 0033:0x7fe4948c0be0
> [   16.512247] Code: 40 00 48 8b 15 49 c2 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 01 4a 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> [   16.514025] RSP: 002b:00007ffc045bd0d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [   16.515180] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe4948c0be0
> [   16.516346] RDX: 0000000000000002 RSI: 0000562bc4d50990 RDI: 0000000000000001
> [   16.517543] RBP: 00007fe49499e780 R08: 0000000000000007 R09: 0000562bc4d46da0
> [   16.518751] R10: 00007fe4947d5f50 R11: 0000000000000202 R12: 0000000000000002
> [   16.519977] R13: 0000562bc4d50990 R14: 0000000000000002 R15: 00007fe494999d60
> [   16.521234]  </TASK>
> [   16.522479] Modules linked in: 
> [...]
> [   16.534416] CR2: 0000000000000044
> [   16.536059] ---[ end trace 0000000000000000 ]---
> [   16.537819] RIP: 0010:idle_inject_set_duration+0x6/0x20
> [   16.537827] Code: 00 49 c7 c4 f4 ff ff ff eb 92 49 c7 c4 f4 ff ff ff eb 91 cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 89 f0 01 d0 74 06 <89> 77 44 89 57 40 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00
> [   16.543180] RSP: 0018:ffffc900005e7de8 EFLAGS: 00010206
> [   16.543189] RAX: 00000000000927c0 RBX: 0000000000000000 RCX: 0000000000001770
> [   16.543193] RDX: 0000000000001770 RSI: 0000000000091050 RDI: 0000000000000000
> [   16.549435] RBP: 0000000000000002 R08: 0000000000000001 R09: 000000000000000a
> [   16.551087] R10: 000000000000000a R11: f000000000000000 R12: 0000000000000000
> [   16.551091] R13: ffff8881064bd720 R14: ffffc900005e7ea0 R15: ffff8881022283e0
> [   16.554264] FS:  00007fe494782b80(0000) GS:ffff888216200000(0000) knlGS:0000000000000000
> [   16.554270] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.554281] CR2: 0000560363a98298 CR3: 000000010f94c006 CR4: 00000000000606f0
> [   17.635258] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=2842 'X'


See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.2..v6.3
https://bugzilla.kernel.org/show_bug.cgi?id=217386
#regzbot title: pm: thermal: intel_powerclamp null pointer dereference
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"
