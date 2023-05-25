Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A59710BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbjEYMHE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 08:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjEYMHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:07:02 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4720E7;
        Thu, 25 May 2023 05:07:00 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9739440b60bso29999766b.0;
        Thu, 25 May 2023 05:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016419; x=1687608419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKW6nh3Stu7+N3Kp7mLlmvutOp3dc9cSfF1cRxfu1tI=;
        b=dbJi4YeDCBVWMp0fZp5TjHNoAK96oqYvbW5U7hLpWC7p/7P5IfxcUlOjRK6/W7uP2G
         +gWBDfIFoGN5KaxM4+UyaI92yaPUOztuXwuU0xAhZZP/49ttsRebSZ91LObmCb+HKwjO
         VehSSQVJl/MeL4uLx2K97h/CF4TUvSUT5/kbLX02bbAzAOkyCxWD8SGblLquIVdY4Vah
         oejrCvIyAvvs0ehjSYJlICjQVIKNzbLsam0I2VYiU+MQtZf2TjDunAOKSBYm4OSpldyv
         JStpHhZc4u3vbsyahLJQh5lW+0lHCD5lPY48/KQZDfQcaNw+2B+EAajhiZ+Y4i8Ns6hw
         7Xyw==
X-Gm-Message-State: AC+VfDwvExtrFkiqSjXDU014hkUNscncI5UNDfkph3gPjltLHyagARm+
        VyeAtclv7ljagQ+pHHw5X2YHPPP5Vi9NVwQlWFs=
X-Google-Smtp-Source: ACHHUZ6IRQ/SnBgyfpCgayrSbirvIindZHWRMc+FngvXIzH25Iu+YuHgvlryIKQiaIxUsbTuhF1Hvdfb9QDAWtg1VY4=
X-Received: by 2002:a17:906:72d4:b0:96f:da08:d451 with SMTP id
 m20-20020a17090672d400b0096fda08d451mr11519029ejl.6.1685016418720; Thu, 25
 May 2023 05:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-4-mario.limonciello@amd.com> <e9eb526d-84fe-b814-67a3-6f7977aa0078@redhat.com>
 <MN0PR12MB6101AF7606A3547EC5AA42A7E2409@MN0PR12MB6101.namprd12.prod.outlook.com>
 <dcdb3d12-e0af-5e4d-119e-d4fbe9a9495b@redhat.com>
In-Reply-To: <dcdb3d12-e0af-5e4d-119e-d4fbe9a9495b@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 May 2023 14:06:46 +0200
Message-ID: <CAJZ5v0h=tSKjZxQJECZCQqzWDMAwY8cKf7F_xyLQSBG8TPyzrg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend
 related messages
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 12:13 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Mario,
>
> On 5/23/23 18:21, Limonciello, Mario wrote:
> > [AMD Official Use Only - General]
> >
> >> -----Original Message-----
> >> From: Hans de Goede <hdegoede@redhat.com>
> >> Sent: Tuesday, May 23, 2023 6:08 AM
> >> To: Limonciello, Mario <Mario.Limonciello@amd.com>; rafael@kernel.org;
> >> linus.walleij@linaro.org
> >> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> >> gpio@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-
> >> pm@vger.kernel.org; S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
> >> Natikar, Basavaraj <Basavaraj.Natikar@amd.com>
> >> Subject: Re: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for
> >> suspend related messages
> >>
> >> Hi Mario,
> >>
> >> On 5/22/23 22:00, Mario Limonciello wrote:
> >>> Using pm_pr_dbg() allows users to toggle
> >> `/sys/power/pm_debug_messages`
> >>> as a single knob to turn on messages that amd-pmc can emit to aid in
> >>> any s2idle debugging.
> >>>
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> ---
> >>>  drivers/platform/x86/amd/pmc.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/platform/x86/amd/pmc.c
> >> b/drivers/platform/x86/amd/pmc.c
> >>> index 427905714f79..1304cd6f13f6 100644
> >>> --- a/drivers/platform/x86/amd/pmc.c
> >>> +++ b/drivers/platform/x86/amd/pmc.c
> >>> @@ -543,7 +543,7 @@ static int amd_pmc_idlemask_read(struct
> >> amd_pmc_dev *pdev, struct device *dev,
> >>>     }
> >>>
> >>>     if (dev)
> >>> -           dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
> >>> +           pm_pr_dbg("SMU idlemask s0i3: 0x%x\n", val);
> >>>
> >>>     if (s)
> >>>             seq_printf(s, "SMU idlemask : 0x%x\n", val);
> >>
> >> This does not compile, amd/pmc.c may be build as an amd-pmc.ko module
> >> and currently the pm_debug_messages_on flag used by pm_pr_dbg()
> >> is not exported to modules:
> >>
> >>   CC [M]  drivers/platform/x86/amd/pmc.o
> >>   LD [M]  drivers/platform/x86/amd/amd-pmc.o
> >>   MODPOST Module.symvers
> >> ERROR: modpost: "pm_debug_messages_on"
> >> [drivers/platform/x86/amd/amd-pmc.ko] undefined!
> >> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> >> make: *** [Makefile:1978: modpost] Error 2
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >
> > My apologies, yes I was compiling in when testing.  Let me ask if this
> > series makes sense and is "generally" agreeable though.
>
> I have no objections against this series, otherwise I don't really
> have a strong opinion on this series.
>
> If this makes sense and if exporting pm_debug_messages_on is ok
> is Rafael's call to make IMHO.
>
> Rafael ?

I have no strong opinion.

I would do it slightly differently as mentioned in my reply to patch
[1/4] (and then the new function could be used in patch [2/4] I
think).

Otherwise this is fine with me if it helps to debug failures in the field.
