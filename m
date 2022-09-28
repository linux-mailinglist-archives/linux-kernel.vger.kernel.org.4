Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791305EE25D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiI1Qzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiI1Qzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:55:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE0E2675
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEA03B82174
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183EFC433C1;
        Wed, 28 Sep 2022 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664384131;
        bh=tLOVuvqT/jso+IqBGmnpwLbxnw7RR/afyibgsZNw1Cs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=p1SotuJMaAN9KCbiFbJnvxEYBga0oMGnHoSGPOUbvXyHXuhNKbgKnHFhl6M6l8JV6
         xkaXEnjsUWs6ct0Je86Fhv1lxAOYyht+Hm/ZKK14tRloGKFqghjT7MuIcsqQk1FVht
         xjPrEQNSm6U5te7dj28iur9ZoZBOkx4bxLgQCQf200vDTk4cccflMUqCV/IRun28uF
         e0IWAJ92rXc+RoA+Qol3XNOG9CVkEXqtFy/E7jl75wzC7PEX9dNFebGoyT8NmKvAv0
         L1pkWWf+TWQ2qPZMmGKIP7HwPxTtWjaoIBznkbBceon+eu4pDE2Cz161kVTbenn1Ny
         TKCiQ/wZ/tw5g==
Date:   Wed, 28 Sep 2022 17:55:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [resend][bug] low-probability console lockups since 5.19
Message-ID: <YzR8fzyjhggO+/tT@spud>
References: <Yy3dsSgpDnovBdEn@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy3dsSgpDnovBdEn@spud>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:24:17PM +0100, Conor Dooley wrote:
> Hey all,
> 
> Been bisecting a bug that is causing a boot failure in my CI & have
> ended up here.. The bug in question is a low(ish) probability lock up
> of the serial console, I would estimate about 1-in-5 chance on the
> boards I could actually trigger it on which it has taken me so long
> to realise that this was an actual problem. Thinking back on it, there
> were other failures that I would retroactively attribute to this
> problem too, but I had earlycon disabled and I chalked the hangs at
> "Starting kernel" down to pre-release hardware since the other boots
> in a CI job would not fail (we boot the same config multiple times),
> Silly me I guess!
> 
> In a boot failure (with earlycon & keep_bootcon enabled) I see the
> likes of [0]:
> [    0.485063] NFS: Registering the id_resolver key type
> [    0.491051] Key type id_resolver registered
> [    0.495743] Key type id_legacy registered
> [    0.500528] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [    0.508010] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
> [    0.516857] 9p: Installing v9fs 9p2000 file system support
> [    0.524032] NET: Registered PF_ALG protocol family
> [    0.529562] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [    0.537817] io scheduler mq-deadline registered
> [    0.542889] io scheduler kyber registered
> [    0.559682] microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
> [    0.568431] microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
> [    0.635633] microchip-pcie 2000000000.pcie: axi read request error
> [    0.642602] microchip-pcie 2000000000.pcie: axi read timeout
> [    0.776630] microchip-pcie 2000000000.pcie: sec error in axi2pcie buffer
> [    0.784133] microchip-pcie 2000000000.pcie: axi write request error
> [    0.791100] microchip-pcie 2000000000.pcie: sec error in axi2pcie buffer
> [    0.798543] microchip-pcie 2000000000.pcie: sec error in axi2pcie buffer
> [    0.805981] microchip-pcie 2000000000.pcie: sec error in axi2pcie buffer
> [    0.813421] microchip-pcie 2000000000.pcie: sec error in axi2pcie buffer
> [    0.820859] microchip-pcie 2000000000.pcie: sec error in axi2pcie buffer
> [    0.828295] microchip-pcie 2000000000.pcie: sec error in axi2pcie buffer
> [    1.579668] Freeing initrd memory: 7316K
> 
> The sec error stuff is unrelated & happens on good boots too - although
> there are far fewer lines of "sec error" there [1] (excuse the message
> duplication from the bootcon).
> 
> I was able to bisect the behaviour to this set of reverts, but I have
> low confidence as to which commit specifically caused it - it's hard
> to know that doing 20+ reboots on every commmit I built is enough to
> make sure I did not make a mistake. I had initially started the
> bisection between v6.0-rc6 & v6.0-rc1, and that lead me down a sub-tree
> of net which is why the bisect log starts at a "random" commit as that
> merge commit was the one blamed by the inital bisection.
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [5e8379351dbde61ea383e514f0f9ecb2c047cf4e] Merge tag 'net-5.19-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect bad 5e8379351dbde61ea383e514f0f9ecb2c047cf4e
> # good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
> git bisect good 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> # good: [fbe86daca0ba878b04fa241b85e26e54d17d4229] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good fbe86daca0ba878b04fa241b85e26e54d17d4229
> # good: [2b8c612c6102f751e6e3e1bd425f64e9d3d3f638] kernel/reboot: Fix powering off using a non-syscall code paths
> git bisect good 2b8c612c6102f751e6e3e1bd425f64e9d3d3f638
> # good: [54c2cc79194c961a213c1d375fe3aa4165664cc4] Merge tag 'usb-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect good 54c2cc79194c961a213c1d375fe3aa4165664cc4
> # skip: [8f7ac50c97d30ae5ae48da3b516510d05a67b9e5] Merge tag 'sound-5.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect skip 8f7ac50c97d30ae5ae48da3b516510d05a67b9e5
> # good: [cdd85786f4b3b9273e4376e69aa95a2d71722764] x86/tdx: Clarify RIP adjustments in #VE handler
> git bisect good cdd85786f4b3b9273e4376e69aa95a2d71722764
> # good: [8cc683833726912498130a0130fc3bd0d169ef59] Merge branch 'net-dp83822-fix-interrupt-floods'
> git bisect good 8cc683833726912498130a0130fc3bd0d169ef59
> # bad: [0840a7914caa14315a3191178a9f72c742477860] Merge tag 'char-misc-5.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> git bisect bad 0840a7914caa14315a3191178a9f72c742477860
> # bad: [38bc4ac431684498126f9baa3a530e5a132f0173] Merge tag 'drm-fixes-2022-06-24' of git://anongit.freedesktop.org/drm/drm
> git bisect bad 38bc4ac431684498126f9baa3a530e5a132f0173
> # good: [399bd66e219e331976fe6fa6ab81a023c0c97870] Merge tag 'net-5.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect good 399bd66e219e331976fe6fa6ab81a023c0c97870
> # bad: [a237cfd6b7469d6f5eeaa45f30128ab78b5281a5] Merge tag 'block-5.19-2022-06-24' of git://git.kernel.dk/linux-block
> git bisect bad a237cfd6b7469d6f5eeaa45f30128ab78b5281a5
> # good: [92f20ff72066d8d7e2ffb655c2236259ac9d1c5d] Merge tag 'pm-5.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good 92f20ff72066d8d7e2ffb655c2236259ac9d1c5d
> # bad: [598f2404879336277a4320ac5000394b873e049a] Merge tag 'io_uring-5.19-2022-06-24' of git://git.kernel.dk/linux-block
> git bisect bad 598f2404879336277a4320ac5000394b873e049a
> # good: [386e4fb6962b9f248a80f8870aea0870ca603e89] io_uring: use original request task for inflight tracking
> git bisect good 386e4fb6962b9f248a80f8870aea0870ca603e89
> # good: [2d9ef940f89e0ab4fde7ba6f769d82f2a450c35a] Revert "printk: extend console_lock for per-console locking"
> git bisect good 2d9ef940f89e0ab4fde7ba6f769d82f2a450c35a
> # bad: [07a22b61946f0b80065b0ddcc703b715f84355f5] Revert "printk: add functions to prefer direct printing"
> git bisect bad 07a22b61946f0b80065b0ddcc703b715f84355f5
> # bad: [5831788afb17b89c5b531fb60cbd798613ccbb63] Revert "printk: add kthread console printers"
> git bisect bad 5831788afb17b89c5b531fb60cbd798613ccbb63
> # first bad commit: [5831788afb17b89c5b531fb60cbd798613ccbb63] Revert "printk: add kthread console printers"
> 
> On 5831788afb17 ("Revert "printk: add kthread console printers"") or on
> 07a22b61946f ("Revert "printk: add functions to prefer direct printing"")
> I was not able to reproduce the exact error conditions that I got on
> the current HEAD or any of the commits along my bisection, but instead I
> got something different [2]:
> 
> [    0.471992] 9p: Installing v9fs 9p2000 file system support
> [    0.479049] NET: Registered PF_ALG protocol family
> [    0.484585] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [    0.492813] io scheduler mq-deadline registered
> [    0.497871] io scheduler kyber registered
> [    0.513472] microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
> [    0.522194] microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
> [    0.588518] microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> [    0.596027] microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> [    0.603467] microchip-pcie 2000000000.pcie: axi read request error
> [    0.610322] microchip-pcie 2000000000.pcie: axi read timeout
> [    0.616603] microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> [    0.624025] microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> [    0.631450] microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> [    0.638877] microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> [    0.646300] microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> [    0.653725] microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> [    1.516378] Freeing initrd memory: 7336K
> [    5.591881] mc_event_handler: 667402 callbacks suppressed
> [    5.591909] microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> [    5.605290] microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> [    5.612704] microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 
> <truncated>
> 
> [   21.539878] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   21.546651] rcu: 	0-...0: (1 GPs behind) idle=19f/1/0x4000000000000002 softirq=34/36 fqs=2626 
> [   21.556177] 	(detected by 1, t=5256 jiffies, g=-1151, q=1143 ncpus=4)
> [   21.563293] Task dump for CPU 0:
> [   21.566860] task:swapper/0       state:R  running task     stack:    0 pid:    1 ppid:     0 flags:0x00000008
> [   21.577823] Call Trace:
> 
> Unfortunately I do not really have any more information than that for
> you, I am hoping that you (plural) could be of some help as to where
> I should start looking - although after spending every evening this
> week bisecting/setting up so that I could automate my bisection it'll
> be a few days before I could really focus on this again.
> 
> My system is an embedded RISC-V dev board (PolarFire SoC Icicle kit).
> 
> There is also a failing build in the ClangBuiltLinux CI [3] that is
> seeing similar symptoms, but I was unable to reproduce this problem
> doing 1000s of reboots of a known-bad commit in QEMU myself.
> 
> LMK if you need any more info,
> Conor.
> 
> [0] https://gist.githubusercontent.com/ConchuOD/575f4bfe3d68b9b32227740365b04401/raw/c69dfffd21183898edaeb223a9455ebc28edcf65/gistfile1.txt
> [1] https://gist.github.com/ConchuOD/575f4bfe3d68b9b32227740365b04401?permalink_comment_id=4313185#gistcomment-4313185
> [2] https://gist.github.com/ConchuOD/575f4bfe3d68b9b32227740365b04401?permalink_comment_id=4313202#gistcomment-4313202
> [3] https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/3090070308/jobs/4999131449#step:5:270
>

#regzbot introduced: 5831788afb17b89c5b531fb60cbd798613ccbb63 ^
Hopefully I did this correctly...

I picked that commit as that's where things start going haywire.

Thanks,
Conor.

