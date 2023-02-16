Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CE698FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBPJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjBPJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:29:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5616BBDE3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:29:01 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSaZU-0000eh-1H; Thu, 16 Feb 2023 10:28:56 +0100
Message-ID: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
Date:   Thu, 16 Feb 2023 10:28:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        michallinuxstuff@gmail.com
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217037 - cmb attributes missing from the nvme class
 under sysfs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676539741;0120c9ad;
X-HE-SMSGID: 1pSaZU-0000eh-1H
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217037 :

>  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> 
> For the CMB-capable nvme ctrls, kernel was exposing couple of related attributes under the sysfs. E.g.
> 
> 
> # grep . /sys/class/nvme/nvme0/cmb*
> /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> /sys/class/nvme/nvme0/cmbloc:98
> /sys/class/nvme/nvme0/cmbsz:524829
> #
> 

> The above was taken from fedora37 running under 6.1.8 kernel build.
> In 6.1.{9,10} all these attributes are gone.
> 
> I am running fedora37 under QEMU 7.{0,2}.0, all nvmes are emulated.
> 
> I've tried to understand what change in 6.1.9 might have caused it
> (suspected that maybe fedora's src is applying some weird patches on
> top but that's not it), but I could not pinpoint anything specific.
> 
> The latest commit that indirectly touches these attributes is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86adbf0cdb9ec
> but my C-fu is to weak to understand if this really could somehow
> hide|remove these attrs.
> 
> Also from the look of nvme_pci_attrs_are_visible() nothing has
> recently changed. I use same QEMU params for setting up the nvmes
> across all the VMs - is it possible that the way QEMU exposes CMB is
> not valid anymore?
> 
> If I check proper BARs with setpci + /proc/iomem it seems like CMB is
> there. SPDK also tells me that given nvme comes with CMB.
> 
> Any hints would be appreciated. I have couple of scripts which depend
> on these so I am a bit biased if it comes to prio on this. :)>
> [...]
>
> So I did install the latest available build,
> 6.2.0-0.rc8.20230215gte1c04510.258.vanilla.fc37.x86_64 to be exact,
> but there's no change - /cmb* stuff is still missing (remaining
> parts, lspci output, etc. look exactly the same as in the case of
> previously mentioned versions).

See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.1..v6.2-rc8
https://bugzilla.kernel.org/show_bug.cgi?id=217037
#regzbot title: nvme: cmb attributes vanished after v6.1.8
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
