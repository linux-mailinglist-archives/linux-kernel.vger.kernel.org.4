Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996E0696143
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjBNKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjBNKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:45:50 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24C42684E;
        Tue, 14 Feb 2023 02:45:22 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pRsnN-0006ug-Nm; Tue, 14 Feb 2023 11:44:21 +0100
Message-ID: <197e2991-9d0a-4cb3-e2d3-f0f58fb28a2e@leemhuis.info>
Date:   Tue, 14 Feb 2023 11:44:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, albimarini4283@gmail.com
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [Regression] Bug 217026 - Backlight control broken on kernels 6.1.4+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676371523;6dfd7647;
X-HE-SMSGID: 1pRsnN-0006ug-Nm
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
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217026 :

>  albimarini4283@gmail.com 2023-02-12 20:57:03 UTC
> 
> Brightness control does not work with AMD Ryzen 5800H when using hybrid
> graphics on kernel updates 6.1.4+. I am using a Lenovo Legion Slim 7
> (2021, 15ACH6) currently running Arch Linux with the mainline kernel
> 6.1.11, however, I have been testing my experience with this issue on
> every point revision from 6.1.3 to 6.1.11.
> 
>       CPU: AMD Ryzen 5 5800H with Radeon Graphics
>       GPU: NVIDIA RTX 3060 Mobile / Max-Q (Proprietary NVIDIA driver,
> tested with 525.78.01-1 (version prior to 6.1.4 being released) and
> 525.89.02-1 (latest driver at time of writing))
>       System Memory: 40 GB
>       Display: Laptop (Laptop Screen)
> 
> The only parameters applied at boot on my system are: nvidia-drm.modeset=1
> 
> How to reproduce the issue:
> Enable hybrid graphics/Optimus in BIOS setup.
> 
> Prior to kernel version 6.1.4, /sys/class/backlight contained two entries:
> amdgpu_bl0 and nvidia_wmi_ec_backlight
> 
> With these two entries in /sys/class/backlight , I was able to write to
> their respective brightness files directly or use a program like light
> to change the values. Those values would change the brightness of the
> screen depending on if I was using the AMD GPU or NVIDIA GPU to display
> the current application. I could set these values to roughly the same
> thing to achieve an overall complete brightness experience regardless of
> whether or not I was currently running an application on my integrated
> (AMD) GPU or dedicated (NVIDIA) GPU.
> 
> Then, upon updating to kernel versions 6.1.4+, there is no longer an
> amdgpu_bl0 entry in /sys/class/backlight , just a
> nvidia_wmi_ec_backlight entry, making it impossible for me to change the
> brightness on my display when using the iGPU. Interestingly, on kernels
> 6.1.4+, running "journalctl -b -0 | grep backlight" returns an output
> "amdgpu: [drm] Skipping amdgpu DM backlight registration", which was not
> present in prior kernel versions.
> 
> However, if I instead prepend the option "acpi_backlight=native" to my
> kernel command line options at boot, "amdgpu_bl0" is once again present
> in /sys/class/backlight but "nvidia_wmi_ec_backlight" has now
> disappeared and is nowhere to be seen making it so I can change the
> brightness when using the iGPU, but the brightness is stuck at max when
> using the dedicated GPU. Running the above journalctl command at this
> point returns no errors relating to my AMD GPU and does not mention
> anything about the NVIDIA GPU. Trying different acpi_backlight options
> on 6.1.4+ does not fix the issue and instead removes functionality.
> acpi_backlight=vendor makes an entry called "ideapad" pop up in
> /sys/class/backlight with nothing else. Changing the brightness values
> in ideapad does nothing.
> acpi_backlight=video makes only two entries appear in
> /sys/class/backlight, acpi_video0 and acpi_video1. Changing the
> brightness values in either of these directories does nothing.
> acpi_backlight=none causes nothing to appear under /sys/class/backlight.
> 
> If hybrid graphics is disabled, the display is connected to the NVIDIA
> GPU and /sys/class/backlight/nvidia_0 is present, the NVIDIA driver can
> change the display brightness without a problem.p
> 
> Below is my lscpi -nn and dmidecode outputs on kernel 6.1.3 and 6.1.11.
> [...]

See the ticket for more details.

[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.1.3..v6.1.4
https://bugzilla.kernel.org/show_bug.cgi?id=217026
#regzbot title: backlight: brightness control stopped working on a Ryzen
system with hybrid graphics
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
