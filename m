Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF363A9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiK1Nen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiK1Nej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:34:39 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB21464F4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:34:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id b2so7524989iof.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8EES1Kr9LZMONvZuXbjcGrF24ZUuZg3NAqZmV3+L2T0=;
        b=CaFwfvIWI9F4qeqT9h5Fkb4K4xPdfPNKooWjry4FWOiMYVB2qgFrzkwj/7Y/vgXYb2
         PVJOuCUzjt+1Uh43BNV8ACz3iI/BhF9fA0IprHaADWxfkt6DEuOOHtliN3vRki1aW0sa
         g0YT5OHhCJHR+Wn+GNJvlEcu3SaebNG+D0iPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EES1Kr9LZMONvZuXbjcGrF24ZUuZg3NAqZmV3+L2T0=;
        b=hLJsJytI4TnmmCUCMwMkyre+2t11eMuYKHmx346p00M1mxN3d2DHJJL0BQWhUt/mji
         oDB72DjefvyYmgUk+76JwFxQSFzLiNxQfBJZvpMVT8IxRMWt38pWy/lDDXI4XG6XZEdK
         4ED8ec15iDU9wmN+8gIVZpmJxQZqKGSIIH/0v70+zj/rk+2khzJcRhC86SCRXNw14c0s
         EAl4hRXcdYVI4vuEk5/4zilJiPpEOZOr2PV8jh9bgF/neLI4h19LsIb+eg+nFFFu3hgX
         WWDu3g1UlPzjCy+epl1NI9VBz+EoIY3Aen5XlN9tbxtYxJiaB+0OJlgCT7N2NuODYMi3
         UChw==
X-Gm-Message-State: ANoB5pnZMIF0IyPjajBy+McYNG9Nuz/an+/XUV1avM/3EDnB9PasR3sR
        s3ZrXuWI5QucHlmxkYFWcpQ4x/O5RDCmbcyo
X-Google-Smtp-Source: AA0mqf4/8Lms+k9DqkiCmVgDJLHuuvXaaku4rHJqDno8t5JBCIuLvMQ413+ekSWpFTshd3lLFueiew==
X-Received: by 2002:a02:a006:0:b0:370:f43c:c6a with SMTP id a6-20020a02a006000000b00370f43c0c6amr16447577jah.127.1669642477037;
        Mon, 28 Nov 2022 05:34:37 -0800 (PST)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id n207-20020a6b8bd8000000b006df19c8671fsm4455493iod.27.2022.11.28.05.34.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:34:34 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id 11so7580927iou.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:34:33 -0800 (PST)
X-Received: by 2002:a5e:c64a:0:b0:6cc:e295:7bde with SMTP id
 s10-20020a5ec64a000000b006cce2957bdemr14440342ioo.183.1669642472997; Mon, 28
 Nov 2022 05:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v3-0-a2eda731ca14@chromium.org>
 <87wn7fzb2g.wl-tiwai@suse.de> <CANiDSCtSAM3seszVWfjJPaYFO3v223P-tYEtdpW4+pQQ3bcf0g@mail.gmail.com>
 <87tu2jz9os.wl-tiwai@suse.de>
In-Reply-To: <87tu2jz9os.wl-tiwai@suse.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 14:34:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCvFzrEMwbpbA-gpUr2xSNU1J1q2nx6Mvpev-jtbvMPrcA@mail.gmail.com>
Message-ID: <CANiDSCvFzrEMwbpbA-gpUr2xSNU1J1q2nx6Mvpev-jtbvMPrcA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ALSA: core: Fix deadlock when shutdown a frozen userspace
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>, Len Brown <len.brown@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi

Thanks  for your response

On Mon, 28 Nov 2022 at 10:53, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 28 Nov 2022 10:26:36 +0100,
> Ricardo Ribalda wrote:
> >
> > Hi Takashi
> >
> > Thanks for your prompt reply
> >
> > On Mon, 28 Nov 2022 at 10:24, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Mon, 28 Nov 2022 10:10:12 +0100,
> > > Ricardo Ribalda wrote:
> > > >
> > > > Since 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
> > > > we wait for userspace to close its fds.
> > >
> > > IMO, the fix above brought more problem.  If you'd need to want to
> > > avoid later accesses during shutdown, the driver should rather just
> > > disconnect devices without waiting for the user-space completion.
> > > And, for that, a simple call of snd_card_disconnect() should suffice.
> > >
> > > > But that will never occur with a frozen userspace (like during kexec()).
> > > >
> > > > Lets detect the frozen userpace and act accordingly.
> > >
> > > ... and skipping the user-space sync at snd_card_disconnect_sync() as
> > > of this patch set is a dangerous move, I'm afraid.  The user-space
> > > gets frozen also at the normal suspend/resume, and it implies that the
> > > sync will be lost even for the normal PM, too (although it must be a
> > > very corner case).
> > >
> >
> > And what about checking kexec_in_progress instead?
>
> I still think that the call of snd_card_disconnect_sync() itself at
> shutdown is somehow wrong.  If this only comes from the SOF code path
> above, we should address in that code path instead.
>
> OTOH, you showed two code paths: one is
>
> [   84.943749] Freezing user space processes ... (elapsed 0.111 seconds) done.
> [  246.784446] INFO: task kexec-lite:5123 blocked for more than 122 seconds.
> [  246.819035] Call Trace:
> [  246.821782]  <TASK>
> [  246.824186]  __schedule+0x5f9/0x1263
> [  246.828231]  schedule+0x87/0xc5
> [  246.831779]  snd_card_disconnect_sync+0xb5/0x127
> ...
> [  246.889249]  snd_sof_device_shutdown+0xb4/0x150
> [  246.899317]  pci_device_shutdown+0x37/0x61
> [  246.903990]  device_shutdown+0x14c/0x1d6
> [  246.908391]  kernel_kexec+0x45/0xb9
>
> and another is
>
> [  246.893222] INFO: task kexec-lite:4891 blocked for more than 122 seconds.
> [  246.927709] Call Trace:
> [  246.930461]  <TASK>
> [  246.932819]  __schedule+0x5f9/0x1263
> [  246.936855]  ? fsnotify_grab_connector+0x5c/0x70
> [  246.942045]  schedule+0x87/0xc5
> [  246.945567]  schedule_timeout+0x49/0xf3
> [  246.949877]  wait_for_completion+0x86/0xe8
> [  246.954463]  snd_card_free+0x68/0x89
> ...
> [  247.001080]  platform_device_unregister+0x12/0x35
>
> The former is likely the SOF code path by the commit you mentioned
> (but it's not 100% clear because you trimmed the stack trace), and
> this should be reconsidered.

Let me add both traces completely:


[  247.080494] INFO: task kexec-lite:5441 blocked for more than 122 seconds.
[  247.088100]       Tainted: G     U            5.15.79-14932-g6eecac25030c #5
[  247.095984] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  247.104745] task:kexec-lite      state:D stack:    0 pid: 5441
ppid:  5390 flags:0x00004002
[  247.114083] Call Trace:
[  247.116833]  <TASK>
[  247.119185]  __schedule+0x5f9/0x1263
[  247.123193]  schedule+0x8e/0xdb
[  247.126698]  snd_card_disconnect_sync+0xb5/0x127
[  247.131877]  ? init_wait_entry+0x31/0x31
[  247.136270]  soc_cleanup_card_resources+0x27/0x1d3
[  247.141636]  snd_soc_unbind_card+0xa6/0xfc
[  247.146218]  snd_soc_unregister_card+0x26/0x34
[  247.151192]  release_nodes+0x43/0x62
[  247.155200]  devres_release_all+0x8b/0xc4
[  247.159695]  device_release_driver_internal+0x11a/0x1be
[  247.165546]  bus_remove_device+0xd9/0x103
[  247.170038]  device_del+0x1f7/0x355
[  247.173946]  platform_device_del+0x28/0x8e
[  247.178539]  platform_device_unregister+0x12/0x35
[  247.183807]  snd_sof_device_shutdown+0x57/0x94 [snd_sof
7d15170beb0e48032711b3230201744d5e4e590d]
[  247.193742]  pci_device_shutdown+0x37/0x61
[  247.198335]  device_shutdown+0x14c/0x1d6
[  247.202735]  kernel_kexec+0x45/0xb9
[  247.206646]  __se_sys_reboot+0x173/0x1f6
[  247.211041]  ? syscall_enter_from_user_mode+0x1a6/0x1ab
[  247.216885]  do_syscall_64+0x55/0x9d
[  247.220879]  ? exit_to_user_mode_prepare+0x3c/0x8b
[  247.226245]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  247.231889] RIP: 0033:0x79b6a8563693
[  247.235897] RSP: 002b:00007fff9ab771b8 EFLAGS: 00000202 ORIG_RAX:
00000000000000a9
[  247.244375] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000079b6a8563693
[  247.252363] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee1dead
[  247.260337] RBP: 00007fff9ab77200 R08: 0000000000000004 R09: 00007fff9ab7930b
[  247.268323] R10: 00007fff9ab7936a R11: 0000000000000202 R12: 00000000ffffffff
[  247.276297] R13: 0000000000000004 R14: 00007fff9ab7936a R15: 0000000000000003
[  247.284272]  </TASK>
[  247.286729] task:init            state:D stack:    0 pid:    1
ppid:     0 flags:0x00004006
[  247.296079] Call Trace:
[  247.298810]  <TASK>
[  247.301155]  __schedule+0x5f9/0x1263
[  247.305163]  ? core_sys_select+0x278/0x343
[  247.309754]  schedule+0x8e/0xdb
[  247.313261]  __refrigerator+0x5e/0x97
[  247.317364]  get_signal+0x5e4/0x5e9
[  247.321280]  arch_do_signal_or_restart+0x4a/0x27a
[  247.326550]  exit_to_user_mode_loop+0x76/0xde
[  247.331433]  exit_to_user_mode_prepare+0x61/0x8b
[  247.336606]  syscall_exit_to_user_mode+0x26/0x168
[  247.341877]  do_syscall_64+0x63/0x9d
[  247.345871]  ? exit_to_user_mode_prepare+0x3c/0x8b
[  247.351227]  entry_SYSCALL_64_after_hwframe+0x61/0xcb



Then, after adding the (pm_freezing hack) in card_disconnect_sync


[  247.081334] INFO: task kexec-lite:5568 blocked for more than 122 seconds.
[  247.088940]       Tainted: G     U
5.15.79-14932-g6eecac25030c-dirty #6
[  247.097428] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  247.106198] task:kexec-lite      state:D stack:    0 pid: 5568
ppid:  5389 flags:0x00004002
[  247.115552] Call Trace:
[  247.118297]  <TASK>
[  247.120651]  __schedule+0x5f9/0x1263
[  247.124655]  ? fsnotify_grab_connector+0x5c/0x70
[  247.129829]  schedule+0x8e/0xdb
[  247.133354]  schedule_timeout+0x49/0xf3
[  247.137655]  wait_for_completion+0x86/0xe8
[  247.142249]  snd_card_free+0x68/0x89
[  247.146258]  soc_cleanup_card_resources+0x1b5/0x1d3
[  247.151725]  snd_soc_unbind_card+0xa6/0xfc
[  247.156314]  snd_soc_unregister_card+0x26/0x34
[  247.161293]  release_nodes+0x43/0x62
[  247.165303]  devres_release_all+0x8b/0xc4
[  247.169797]  device_release_driver_internal+0x11a/0x1be
[  247.175654]  bus_remove_device+0xd9/0x103
[  247.180147]  device_del+0x1f7/0x355
[  247.184058]  platform_device_del+0x28/0x8e
[  247.188649]  platform_device_unregister+0x12/0x35
[  247.193923]  snd_sof_device_shutdown+0x57/0x94 [snd_sof
e88f872f6695f09a149f1a182cec1fe8e07d5eea]
[  247.203858]  pci_device_shutdown+0x37/0x61
[  247.208455]  device_shutdown+0x14c/0x1d6
[  247.212858]  kernel_kexec+0x45/0xb9
[  247.216759]  __se_sys_reboot+0x173/0x1f6
[  247.221157]  ? syscall_enter_from_user_mode+0x1a6/0x1ab
[  247.227016]  do_syscall_64+0x55/0x9d
[  247.231020]  ? exit_to_user_mode_prepare+0x3c/0x8b
[  247.236386]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  247.242048] RIP: 0033:0x7d2d2634a693
[  247.246056] RSP: 002b:00007ffdceeb6338 EFLAGS: 00000202 ORIG_RAX:
00000000000000a9
[  247.254532] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007d2d2634a693
[  247.262520] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee1dead
[  247.270500] RBP: 00007ffdceeb6380 R08: 0000000000000004 R09: 00007ffdceeb8305
[  247.278489] R10: 00007ffdceeb836a R11: 0000000000000202 R12: 00000000ffffffff
[  247.286468] R13: 0000000000000004 R14: 00007ffdceeb836a R15: 0000000000000003
[  247.294458]  </TASK>
[  247.296909] task:init            state:D stack:    0 pid:    1
ppid:     0 flags:0x00004006
[  247.306253] Call Trace:
[  247.308994]  <TASK>
[  247.311337]  __schedule+0x5f9/0x1263
[  247.315330]  ? core_sys_select+0x278/0x343
[  247.319924]  schedule+0x8e/0xdb
[  247.323445]  __refrigerator+0x5e/0x97
[  247.327537]  get_signal+0x5e4/0x5e9
[  247.331449]  arch_do_signal_or_restart+0x4a/0x27a
[  247.336721]  exit_to_user_mode_loop+0x76/0xde
[  247.341602]  exit_to_user_mode_prepare+0x61/0x8b
[  247.346763]  syscall_exit_to_user_mode+0x26/0x168
[  247.352035]  do_syscall_64+0x63/0x9d
[  247.356043]  ? exit_to_user_mode_prepare+0x3c/0x8b
[  247.361410]  entry_SYSCALL_64_after_hwframe+0x61/0xcb


Simply commenting out snd_sof_machine_unregister(sdev, pdata); does
the trick though... will send a new version with just that.



>
> But, the latter seems to be independent from that.  If that's the code
> path where the unbind is triggered before kexec, your fix might not
> work, either; it could be already at the wait_event*() when kexec
> starts.
>
> Maybe a simpler workaround would be to replace it with
> wait_event_killable*() stuff.  But whether we can discontinue the sync
> there is still another thing to consider...
>
>
> Takashi
>
> >
> > Thanks!
> >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > >
> > > > To: Jaroslav Kysela <perex@perex.cz>
> > > > To: Takashi Iwai <tiwai@suse.com>
> > > > To: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > To: Pavel Machek <pavel@ucw.cz>
> > > > To: Len Brown <len.brown@intel.com>
> > > > To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > > To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > > > To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > To: Mark Brown <broonie@kernel.org>
> > > > Cc: alsa-devel@alsa-project.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > > Cc: linux-pm@vger.kernel.org
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > Changes in v3:
> > > > - Wrap pm_freezing in a function
> > > > - Link to v2: https://lore.kernel.org/r/20221127-snd-freeze-v2-0-d8a425ea9663@chromium.org
> > > >
> > > > Changes in v2:
> > > > - Only use pm_freezing if CONFIG_FREEZER
> > > > - Link to v1: https://lore.kernel.org/r/20221127-snd-freeze-v1-0-57461a366ec2@chromium.org
> > > >
> > > > ---
> > > > Ricardo Ribalda (2):
> > > >       freezer: Add processes_frozen()
> > > >       ALSA: core: Fix deadlock when shutdown a frozen userspace
> > > >
> > > >  include/linux/freezer.h |  2 ++
> > > >  kernel/freezer.c        | 11 +++++++++++
> > > >  sound/core/init.c       | 13 +++++++++++++
> > > >  3 files changed, 26 insertions(+)
> > > > ---
> > > > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > > > change-id: 20221127-snd-freeze-1ee143228326
> > > >
> > > > Best regards,
> > > > --
> > > > Ricardo Ribalda <ribalda@chromium.org>
> > > >
> >
> >
> >
> > --
> > Ricardo Ribalda
> >



-- 
Ricardo Ribalda
