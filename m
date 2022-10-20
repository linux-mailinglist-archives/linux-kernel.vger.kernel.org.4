Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA1E606079
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJTMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJTMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:43:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14DF180AC2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:43:30 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1olUtV-00068d-7Q; Thu, 20 Oct 2022 14:43:29 +0200
Message-ID: <2ec00aa0-ccd0-d7f2-261a-3457745545a8@leemhuis.info>
Date:   Thu, 20 Oct 2022 14:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: v6.1-rc1: Regression in notification of sethostname changes
Content-Language: en-US, de-DE
To:     Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666269810;12d2d788;
X-HE-SMSGID: 1olUtV-00068d-7Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html



On 19.10.22 10:29, Torsten Hilbrich wrote:
> Hello Petr,
> 
> your commit
> 
> commit bfca3dd3d0680fc2fc7f659a152234afbac26e4d
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   Thu Sep 1 21:44:03 2022 +0200
> 
>     kernel/utsname_sysctl.c: print kernel arch
>     
>     Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
>     
>     This helps people who debug kernel with initramfs with minimal environment
>     (i.e.  without coreutils or even busybox) or allow to open sysfs file
>     instead of run 'uname -m' in high level languages.
> 
> broke the notification mechanism between the sethostname syscall and the pollers of /proc/sys/kernel/hostname.
> 
> The table uts_kern_table is addressed within uts_proc_notify by the enum value, however no new enum value was added in "enum uts_proc".
> 
> I noticed the problem when journald-systemd failed to detect hostname changes made with the sethostname syscall (as used by the hostname tool).
> When setting the hostname through /proc/sys/kernel/hostname the poll notification was working.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced bfca3dd3d0
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
