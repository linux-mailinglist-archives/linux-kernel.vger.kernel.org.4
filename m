Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7268C64E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBFS6s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Feb 2023 13:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBFS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:58:45 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42083ED;
        Mon,  6 Feb 2023 10:58:43 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id gr7so37011907ejb.5;
        Mon, 06 Feb 2023 10:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZRKKRT4ZIDV3Cuy+Qfd+p1zTOEBSHwGJp1JZTzG5ok=;
        b=6CyGVfzdhvdwnORt3O7GXsIeOTpQ3H0ocQuvUqalA/qNjfXe4VZgSnWr7sKXZYxk9N
         Bs1RaV4QZd6X6B9Pt8tS4jsXWWVh/pyxPlTCDgLMyoDKajBzIrszL1bxjZv6eaZUoTiI
         jH8TL8GEECTeLrIEjQXZuAaEYo1SaMIkfRSzu2vk8ew3ZBybql4mK0LuZV2IeXmeHnuc
         qbiDu72rICnMkGr+rBKGLEPgzeV4T4VOIAEh+xT454w2Ddg9k0o/TaDJxsDQaLq+RJ1n
         4OUHVuVb8BGWsaNd3nVqAjsU9xEhRTUXTEh6ZgDAjlAwgwN6IUje5BpHcmtMPWZYk/0k
         D7mw==
X-Gm-Message-State: AO0yUKVXCggotYin+k4zK798GjIHJ2MN8UvY4EKnomtDwQsr/9iwomkz
        7QGcdexWFKNz13siKGHwGCzuyoZuKU87skyeg9I=
X-Google-Smtp-Source: AK7set/ak6MZnYdtQTxsAVE+xz5YVi/RCMv1r2gAopn+b4EYawjkQDtLUqkG7w3CwQvvjMKYVVhk4m9t4/2rSFuORBE=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr108593ejb.274.1675709922484; Mon, 06
 Feb 2023 10:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <20220707125329.378277-2-jaz@semihalf.com>
 <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
 <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com>
 <CAH76GKMw2rAnQOSFqReG1sEC=sdncWOJHNXn-Rp2Gx1oUZR3ZQ@mail.gmail.com>
 <CAH76GKMtMi-Bp9h_49t5TBwF1cT0AQE=4H+4E+a4SK+cJ4JJ6A@mail.gmail.com> <CAH76GKMpnCmrbUfo8oQ1C4ej_iNmSw=xBHb8UZYy5Z8vQwcCzQ@mail.gmail.com>
In-Reply-To: <CAH76GKMpnCmrbUfo8oQ1C4ej_iNmSw=xBHb8UZYy5Z8vQwcCzQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Feb 2023 19:58:31 +0100
Message-ID: <CAJZ5v0gov4cnWiF9RsbrEOgZZS=K2_tw5w_2ws2kgi66iXUufA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmytro Maluka <dmy@semihalf.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Dominik Behr <dbehr@google.com>, upstream@semihalf.com,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 1:25 PM Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
>
> Hi Rafael,
>
> Kindly reminder about this topic.

Well, it's been a bit outdated since Mario's changes have been integrated.

> BTW I've noticed that in the meantime v. similar patch was merged but
> aimed for debugging purposes [1] (it uses s/notify/check and invokes
> the callback a bit earlier just before s2idle_entry).
> Perhaps combining Mario's [1] with aligned to it patch #2 of this
> series [2] could be used and accepted as s2idle notifications method?

Maybe it could.

Please send a new series based on top of the current mainline kernel
(6.2-rc7 as of yesterday) and we'll see.

> [1] https://patchwork.kernel.org/project/linux-pm/patch/20220829162953.5947-2-mario.limonciello@amd.com
> [2] https://patchwork.kernel.org/project/linux-pm/patch/20220707125329.378277-3-jaz@semihalf.com/
>
> pon., 12 wrz 2022 o 16:44 Grzegorz Jaszczyk <jaz@semihalf.com> napisał(a):
> >
> > Hi Rafael,
> >
> > Gentle ping
> >
> > Best regards,
> > Grzegorz
> >
> > pon., 22 sie 2022 o 11:26 Grzegorz Jaszczyk <jaz@semihalf.com> napisał(a):
> > >
> > > Hi Rafael,
> > >
> > > Could you please kindly comment on the above?
> > >
> > > Thank you in advance,
> > > Grzegorz
> > >
> > > śr., 20 lip 2022 o 15:15 Grzegorz Jaszczyk <jaz@semihalf.com> napisał(a):
> > > >
> > > > wt., 19 lip 2022 o 20:09 Rafael J. Wysocki <rafael@kernel.org> napisał(a):
> > > > >
> > > > > On Thu, Jul 7, 2022 at 2:56 PM Grzegorz Jaszczyk <jaz@semihalf.com> wrote:
> > > > > >
> > > > > > Currently the LPS0 prepare_late callback is aimed to run as the very
> > > > > > last thing before entering the S2Idle state from LPS0 perspective,
> > > > > > nevertheless between this call and the system actually entering the
> > > > > > S2Idle state there are several places where the suspension process could
> > > > > > be canceled.
> > > > >
> > > > > And why is this a problem?
> > > > >
> > > > > The cancellation will occur only if there is a wakeup signal that
> > > > > would otherwise cause one of the CPUs to exit the idle state.  Such a
> > > > > wakeup signal can appear after calling the new notifier as well, so
> > > > > why does it make a difference?
> > > >
> > > > It could also occur due to suspend_test. Additionally with new
> > > > notifier we could get notification when the system wakes up from
> > > > s2idle_loop and immediately goes to sleep again (due to e.g.
> > > > acpi_s2idle_wake condition not being met) - in this case relying on
> > > > prepare_late callback is not possible since it is not called in this
> > > > path.
> > > >
> > > > >
> > > > > > In order to notify VMM about guest entering suspend, extend the S2Idle
> > > > > > ops by new notify callback, which will be really invoked as a very last
> > > > > > thing before guest actually enters S2Idle state.
> > > > >
> > > > > It is not guaranteed that "suspend" (defined as all CPUs entering idle
> > > > > states) will be actually entered even after this "last step".
> > > >
> > > > Since this whole patchset is aimed at notifying the host about a guest
> > > > entering s2idle state, reaching this step can be considered as a
> > > > suspend "entry point" for VM IMO. It is because we are talking about
> > > > the vCPU not the real CPU. Therefore it seems to me, that even if some
> > > > other vCPUs could still get some wakeup signal they will not be able
> > > > to kick (through s2idle_wake->swake_up_one(&s2idle_wait_head);) the
> > > > original vCPU which entered s2idle_loop, triggered the new notifier
> > > > and is halted due to handling vCPU exit (and was about to trigger
> > > > swait_event_exclusive). So it will prevent the VM's resume process
> > > > from being started.
> > > >
> > > > >
> > > > > > Additionally extend the acpi_s2idle_dev_ops by notify() callback so
> > > > > > any driver can hook into it and allow to implement its own notification.
> > > > > >
> > > > > > Taking advantage of e.g. existing acpi_s2idle_dev_ops's prepare/restore
> > > > > > hooks is not an option since it will not allow to prevent race
> > > > > > conditions:
> > > > > > - VM0 enters s2idle
> > > > > > - host notes about VM0 is in s2idle
> > > > > > - host continues with system suspension but in the meantime VM0 exits
> > > > > > s2idle and sends notification but it is already too late (VM could not
> > > > > > even send notification on time).
> > > > >
> > > > > Too late for what?
> > > >
> > > > Too late to cancel the host suspend process, which thinks that the VM
> > > > is in s2idle state while it isn't.
> > > >
> > > > >
> > > > > > Introducing notify() as a very last step before the system enters S2Idle
> > > > > > together with an assumption that the VMM has control over guest
> > > > > > resumption allows preventing mentioned races.
> > > > >
> > > > > How does it do that?
> > > >
> > > > At the moment when VM triggers this new notifier we trap on MMIO
> > > > access and the VMM handles vCPU exit (so the vCPU is "halted").
> > > > Therefore the VMM could control when it finishes such handling and
> > > > releases the vCPU again.
> > > >
> > > > Maybe adding some more context will be helpful. This patchset was
> > > > aimed for two different scenarios actually:
> > > > 1) Host is about to enter the suspend state and needs first to suspend
> > > > VM with all pass-through devices. In this case the host waits for
> > > > s2idle notification from the guest and when it receives it, it
> > > > continues with its own suspend process.
> > > > 2) Guest could be a "privileged" one (in terms of VMM) and when the
> > > > guest enters s2idle state it notifies the host, which in turn triggers
> > > > the suspend process of the host.
> > > >
> > > > >
> > > > > It looks like you want suspend-to-idle to behave like S3 and it won't.
> > > >
> > > > In a way, yes, we compensate for the lack of something like PM1_CNT to
> > > > trap on for detecting that the guest is suspending.
> > > > We could instead force the guest to use S3 but IMO it is undesirable,
> > > > since it generally does make a difference which suspend mode is used
> > > > in the guest, s2idle or S3, e.g some drivers check which suspend type
> > > > is used and based on that behaves differently during suspend. One of
> > > > the example is:
> > > > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L2323
> > > > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L1069
> > > > https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c#L583
> > > >
> > > > Thank you,
> > > > Grzegorz
