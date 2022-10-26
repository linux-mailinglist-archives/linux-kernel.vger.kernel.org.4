Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0B60DCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiJZIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiJZIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:09:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4882FA4B8C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:09:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1onbTA-00046G-8P; Wed, 26 Oct 2022 10:09:00 +0200
Message-ID: <e75adcf8-68ce-e521-301c-177928d8aae9@leemhuis.info>
Date:   Wed, 26 Oct 2022 10:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit
 c7ff29763989bd09c433f73fae3c1e1c15d9cda4 #forregzbot
Content-Language: en-US, de-DE
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     regressions@lists.linux.dev
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666771742;5e91b5fa;
X-HE-SMSGID: 1onbTA-00046G-8P
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 24.10.22 15:13, Mirsad Goran Todorovac wrote:
> Dear all,
> 
> Around Sep 27th 2022 I've noticed in a mainline kernel built with
> CONFIG_DEBUG_KMEMLEAK=y
> that there actually is a leak:

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced c7ff29763989bd
#regzbot title thermald regression (MEMLEAK)
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


> |sudo cat /sys/kernel/debug/kmemleak unreferenced object
> 0xffff8881095f3ee0 (size 80): comm "thermald", pid 837, jiffies
> 4294896698 (age 9867.428s) hex dump (first 32 bytes): 00 00 00 00 00 00
> 00 00 0d 01 2d 00 00 00 00 00 ..........-..... af 07 01 00 00 c9 ff ff
> 00 00 00 00 00 00 00 00 ................ backtrace: [<00000000b50b9dd6>]
> kmem_cache_alloc+0x184/0x380 [<00000000fa8428c0>]
> acpi_os_acquire_object+0x2c/0x32 [<000000002cc0099f>]
> acpi_ps_alloc_op+0x65/0xe6 [<00000000335faf1b>]
> acpi_ps_get_next_arg+0x842/0x9ed [<000000007afa2dee>]
> acpi_ps_parse_loop+0x718/0xee1 [<0000000010ce490e>]
> acpi_ps_parse_aml+0x261/0x7b2 [<00000000278d4c5f>]
> acpi_ps_execute_method+0x360/0x459 [<00000000ff7ad4ba>]
> acpi_ns_evaluate+0x595/0x810 [<0000000037ce3488>]
> acpi_evaluate_object+0x28b/0x5b2 [<000000001a800bbf>]
> acpi_run_osc+0x209/0x3d0 [<00000000776fbd43>]
> int3400_thermal_run_osc+0xed/0x180 [int3400_thermal]
> [<00000000d6ec2302>] current_uuid_store+0x17c/0x1d0 [int3400_thermal]
> [<00000000486cf3e6>] dev_attr_store+0x3e/0x60 [<00000000bf193027>]
> sysfs_kf_write+0x88/0xa0 [<00000000820b5cce>]
> kernfs_fop_write_iter+0x1c9/0x270 [<0000000062f8d35e>]
> vfs_write+0x5a5/0x750 Mr. Pandruvada required a bug bisect from me, so I
> have eventually made one. # first bad commit:
> [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal: int340x: Update OS
> policy capability handshake Here is the git bisect log:
> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log git bisect
> start # good: [b6abb62daa5511c4a3eaa30cbdb02544d1f10fa2] Linux 5.15.1
> git bisect good b6abb62daa5511c4a3eaa30cbdb02544d1f10fa2 # bad:
> [e6f4ff3f91251f67b130c29f38673eb5702f88b9] Linux 6.0.3 git bisect bad
> e6f4ff3f91251f67b130c29f38673eb5702f88b9 # good:
> [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15 git bisect good
> 8bb7eca972ad531c9b149c0a51ab43a417385813 # bad:
> [1464677662943738741500a6f16b85d36bbde2be] Merge tag
> 'platform-drivers-x86-v5.18-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
> git bisect bad 1464677662943738741500a6f16b85d36bbde2be # good:
> [8efd0d9c316af470377894a6a0f9ff63ce18c177] Merge tag '5.17-net-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next git bisect
> good 8efd0d9c316af470377894a6a0f9ff63ce18c177 # good:
> [aaa25a2fa7964d94690f6de5edd7164ca7d76555] Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net git bisect good
> aaa25a2fa7964d94690f6de5edd7164ca7d76555 # bad:
> [b4bc93bd76d4da32600795cd323c971f00a2e788] Merge tag 'arm-drivers-5.18'
> of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc git bisect bad
> b4bc93bd76d4da32600795cd323c971f00a2e788 # bad:
> [ef510682af3dbe2f9cdae7126a1461c94e010967] Merge tag 'f2fs-for-5.18' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs git bisect
> bad ef510682af3dbe2f9cdae7126a1461c94e010967 # good:
> [a04b1bf574e1f4875ea91f5c62ca051666443200] Merge tag 'for-5.18/parisc-1'
> of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux git
> bisect good a04b1bf574e1f4875ea91f5c62ca051666443200 # bad:
> [b080cee72ef355669cbc52ff55dc513d37433600] Merge tag
> 'for-5.18/io_uring-statx-2022-03-18' of git://git.kernel.dk/linux-block
> git bisect bad b080cee72ef355669cbc52ff55dc513d37433600 # good:
> [02b82b02c34321dde10d003aafcd831a769b2a8a] Merge tag 'pm-5.18-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm git bisect
> good 02b82b02c34321dde10d003aafcd831a769b2a8a # good:
> [0e03b8fd29363f2df44e2a7a176d486de550757a] crypto: xilinx - Turn SHA
> into a tristate and allow COMPILE_TEST git bisect good
> 0e03b8fd29363f2df44e2a7a176d486de550757a # good:
> [3e504d2026eb6c8762cd6040ae57db166516824a] random: check for signal and
> try earlier when generating entropy git bisect good
> 3e504d2026eb6c8762cd6040ae57db166516824a # good:
> [5e929367468c8f97cd1ffb0417316cecfebef94b] io_uring: terminate manual
> loop iterator loop correctly for non-vecs git bisect good
> 5e929367468c8f97cd1ffb0417316cecfebef94b # bad:
> [2d6fc1455f3f383499e013ebc4b19ff49c53c15e] Merge branches
> 'thermal-powerclamp', 'thermal-int340x' and 'thermal-docs' git bisect
> bad 2d6fc1455f3f383499e013ebc4b19ff49c53c15e # good:
> [1d6aab36a26ba44b114d7f8a857c430c9e0c32c9]
> thermal/drivers/ti-soc-thermal: Remove unused function
> ti_thermal_get_temp() git bisect good
> 1d6aab36a26ba44b114d7f8a857c430c9e0c32c9 # bad:
> [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal: int340x: Update OS
> policy capability handshake git bisect bad
> c7ff29763989bd09c433f73fae3c1e1c15d9cda4 # good:
> [098c874e20be2a4cee3021aa9b3485ed5e1f4d5b] thermal: Replace
> acpi_bus_get_device() git bisect good
> 098c874e20be2a4cee3021aa9b3485ed5e1f4d5b # good:
> [668f69a5f863b877bc3ae129efe9a80b6f055141] thermal: int340x: Increase
> bitmap size git bisect good 668f69a5f863b877bc3ae129efe9a80b6f055141 #
> first bad commit: [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal:
> int340x: Update OS policy capability handshake You have new mail in
> /var/mail/mtodorov mtodorov@domac:~/linux/kernel/linux_stable$ I was
> unable to locate the culprit in the patch myself. Thank you very much
> for your attention. I am available for all further questions. Have a
> nice day :) Regards, |
> 
