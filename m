Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471A6692BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBJXzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBJXzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:55:03 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CB65DC12;
        Fri, 10 Feb 2023 15:55:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id r17so4574704pff.9;
        Fri, 10 Feb 2023 15:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sac/fX0wt9v0DHBtkfOe72qxgSq2ZxL7sJ1RWk0mQzQ=;
        b=Oh6mXmII+Z7iHd6314WW1IkZYatL53ousxgQOW7+m/EyoqbBUNzdiADjeTgbLBh4MM
         r6WJWYin1EetsFpHoW2v/rrFOwVTFqYi97k7uzhc4gSRvCjsxPbOKxKPpNQkuplwxMYj
         iJwCrNrYgb7Q4kVc9EykNh6RO4shGUuPYn7oB59kkng+UMxT94IJ2E+7NoB6UI0oVts0
         FCPkDXToksMdz/CKXYy7M2Daa6U4j7HT90WhTUHMbghRVOdfyqFpkjfMKOor2poztRAF
         qszAjfqrMzBPVc4sCRbSolXncQ4LD4B3G2ruzxF0kEglUfAL/afRdWpGGqLPYj16bMnc
         NvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sac/fX0wt9v0DHBtkfOe72qxgSq2ZxL7sJ1RWk0mQzQ=;
        b=hf0V/+bthMXjsazuVXy4t9paz2CIWyqDowrlVQCIWA8IKsuMbOTi0MU9oE+XH/bE48
         kBVB0DTVm8AdPsIOvCYs80WN43x+L05F6dwLvkujz9KY/9b1T87/CS2I0SSs341gYHNd
         9Hw5NwMGGNNY2FjYGPfR8NtNJHlMULVzJk7LRuTmahsv3oIiTnz9btObXqrCxN6jmfrB
         WF3J5jypLodVGvo9Ljqyzm8meRWZfWcFqGRxap0mQa0a0KUACsAqsPMuV2DWkSkCbuS2
         IF2P3n3CZbvlNrEuyBWLes9ki8yHkgHwPEDYbKQywfqz6MDv7AjAiPDng7/aom9gVa2G
         r4hQ==
X-Gm-Message-State: AO0yUKUAs4JG6Mf4OkC8MTi8wlSm1JjQCngUdmBXE2tzdw6KAUF5V9Kh
        /lNRjZkNvvEy/rQdpuZ/64o=
X-Google-Smtp-Source: AK7set9nPEtV76VsB+ysNcWvcdA/XjTiAQwDc+XnZPZ2oGeO6JBsSezTX4grz36H63ofrjyYlHusKg==
X-Received: by 2002:a62:1b8a:0:b0:592:fc9f:8ae5 with SMTP id b132-20020a621b8a000000b00592fc9f8ae5mr14453938pfb.23.1676073301644;
        Fri, 10 Feb 2023 15:55:01 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0056be1581126sm3888031pfi.143.2023.02.10.15.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:55:01 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:54:47 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Airlie <airlied@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Evan Quan <evan.quan@amd.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Mark Gross <markgross@kernel.org>,
        Kerem Karabay <kekrby@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Aditya Garg <gargaditya08@live.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [RFC PATCH 9/9] drm/amdgpu: register a vga_switcheroo client
 for all GPUs that are not thunderbolt attached
Message-ID: <20230211105447.0d8dda6b@redecorated-mbp>
In-Reply-To: <CADnq5_PXa=d8ie8jj7sGxvxfn+ZNwed-eSyNg89PfWCvpo8LCw@mail.gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
        <20230210044826.9834-10-orlandoch.dev@gmail.com>
        <CADnq5_PVsrk4+K45kVgU=r98B9GgC2CxbC8AvGUXRtv2sZAHPg@mail.gmail.com>
        <b3a2d525-b30c-164c-705c-97fcb0016540@redhat.com>
        <CADnq5_PXa=d8ie8jj7sGxvxfn+ZNwed-eSyNg89PfWCvpo8LCw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 11:37:08 -0500
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Fri, Feb 10, 2023 at 11:07 AM Hans de Goede <hdegoede@redhat.com>
> wrote:
> >
> > Hi,
> >
> > On 2/10/23 16:53, Alex Deucher wrote:  
> > > On Fri, Feb 10, 2023 at 3:04 AM Orlando Chamberlain
> > > <orlandoch.dev@gmail.com> wrote:  
> > >>
> > >> From: Kerem Karabay <kekrby@gmail.com>
> > >>
> > >> Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
> > >> vga_switcheroo") made amdgpu only register a vga_switcheroo
> > >> client for GPU's with PX, however AMD GPUs in dual gpu Apple
> > >> Macbooks do need to register, but don't have PX. Instead of
> > >> AMD's PX, they use apple-gmux.  
> > >
> > > Is there a way to detect apple-gmux instead?  Otherwise, we
> > > register vga_switcheroo on any system with multiple GPUs which is
> > > not what we want.  
> >
> > Yes since 6.1.y (either stable series or just take 6.2.0) the
> > apple-gmux detect code has been factored out into a stand-alone
> > apple_gmux_detect() helper inside:
> >
> > include/linux/apple-gmux.h
> >
> > For usage outside of the actual apple-gmux driver you can simply
> > pass NULL for both arguments.
> >
> > This was necessary to reliably check if the apple-gmux should be
> > used for backlight control.
> >
> > Note there also is the older apple_gmux_present() helper, which is
> > already used in some drm code. That function is not reliable though
> > it detects if the ACPI tables contain an ACPI device describing
> > the presence of a gmux, but it turns out even Apple has buggy ACPI
> > tables and the mere presence of that ACPI device is not a reliable
> > indicator the gmux is actually there.
> >
> > I have not changed over any of the existing apple_gmux_present()
> > users for fear of unwanted side effects...  
> 
> Looks like we could maybe use the PWRD ACPI check like patch 8 does
> as well.

I wasn't using apple_gmux_detect as I mistakenly thought
pnp_get_resource would fail if apple-gmux had bound to the resource but
it looks like I was wrong about that so we can use that to determine if
the system has a gmux. I think I'll do that in v2.

As far as I know there's only one internal (non
thunderbolt) amd gpu inside all Macbooks with gmux so we probably
wouldn't need to check for PWRD to ensure it's  the right gpu.

With PWRD, I don't know if its present on all Dual GPU Macbooks, I've
only found the acpi tables for Macbookpro14,x to Macbookpro16,x, so I
don't know if it will work on older Macs (I'm also not sure if those
macs are using radeon or amdgpu).

> Alex
> 
> >
> > Regards,
> >
> > Hans
> >
> >
> >
> >  
> > >> Revert to the old logic of registering for all non-thunderbolt
> > >> gpus, like radeon and nouveau.
> > >>
> > >> Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
> > >> vga_switcheroo") Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> > >> [Orlando Chamberlain <orlandoch.dev@gmail.com>: add commit
> > >> description] Signed-off-by: Orlando Chamberlain
> > >> <orlandoch.dev@gmail.com> ---
> > >>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18
> > >> +++++++++++------- 1 file changed, 11 insertions(+), 7
> > >> deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c index
> > >> 2f28a8c02f64..0bb553a61552 100644 ---
> > >> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c +++
> > >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c @@ -3919,12
> > >> +3919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> > >> if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> > >> vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
> > >>
> > >> -       if (amdgpu_device_supports_px(ddev)) {
> > >> -               px = true;
> > >> -               vga_switcheroo_register_client(adev->pdev,
> > >> -
> > >> &amdgpu_switcheroo_ops, px);
> > >> +       px = amdgpu_device_supports_px(ddev);
> > >> +
> > >> +       if (!pci_is_thunderbolt_attached(adev->pdev))
> > >> +               vga_switcheroo_register_client(adev->pdev,
> > >> &amdgpu_switcheroo_ops, px); +
> > >> +       if (px)
> > >>                 vga_switcheroo_init_domain_pm_ops(adev->dev,
> > >> &adev->vga_pm_domain);
> > >> -       }
> > >>
> > >>         if (adev->gmc.xgmi.pending_reset)
> > >>                 queue_delayed_work(system_wq,
> > >> &mgpu_info.delayed_reset_work, @@ -4048,10 +4049,13 @@ void
> > >> amdgpu_device_fini_sw(struct amdgpu_device *adev)
> > >>
> > >>         kfree(adev->bios);
> > >>         adev->bios = NULL;
> > >> -       if (amdgpu_device_supports_px(adev_to_drm(adev))) {
> > >> +
> > >> +       if (!pci_is_thunderbolt_attached(adev->pdev))
> > >>                 vga_switcheroo_unregister_client(adev->pdev);
> > >> +
> > >> +       if (amdgpu_device_supports_px(adev_to_drm(adev)))
> > >>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
> > >> -       }
> > >> +
> > >>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> > >>                 vga_client_unregister(adev->pdev);
> > >>
> > >> --
> > >> 2.39.1
> > >>  
> > >  
> >  

