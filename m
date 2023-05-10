Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AD6FDDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjEJMVh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjEJMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:21:32 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C737AB7;
        Wed, 10 May 2023 05:21:31 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5068638856dso1664776a12.1;
        Wed, 10 May 2023 05:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683721290; x=1686313290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5pFNRwvf284sJgrDKRHuerqevx/y4may+eaccK7H28=;
        b=Q2I7W+z9Yk3M0KpqxyKPFaIQ+PbQ6cOOnSpyTmkD8QQbJrh4+HUEmLUVRp+8VJ90Yz
         O4hEQYUAlwhvXNANKw8PCmwaSD2zFgFSiCUO1x935jOTo0Bl4fQSmSV7umE0gHlDyRci
         NkoHHFj6ZhsIN+Ak3lJHU6WAysAN2f6DrCOnzvpnvrT94lbMibDoddKdixGjNGzJQ/bz
         TitxYlhAoAEMUXHYDAVZ1SV0hzT3TtEWt4V1gumeoEPpXb0ZYDClPndXxotPV5qxyHyD
         uslHEd72QIptgItwPsuiLS7wpD15ujRus6D1ieNYi/nv9WU0vB6mgs1kG/ZZxJVr4mFp
         8Aog==
X-Gm-Message-State: AC+VfDwGPXQK5cyp5QduUvwx6ACoWvsz9mKaL2Dg41PlzeIGU1hJ9zxp
        cQeQnox/8vB2TNvMhzlb9/SWbzeHcYUU/bEvZ/U=
X-Google-Smtp-Source: ACHHUZ41wfVi8X4DwK1ieMwDRElM5/87L8s9/uueP7Vkui3iBwYAYZDD7pRoNFCbOsbvPe+mikiSR/fSovB6yhrLgSc=
X-Received: by 2002:a17:906:14e:b0:965:9602:3ee1 with SMTP id
 14-20020a170906014e00b0096596023ee1mr13806894ejh.2.1683721289996; Wed, 10 May
 2023 05:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230316151036.10181-1-petr.pavlu@suse.com> <ZFreh8SDMX67EaB6@kevinlocke.name>
 <d63c25f5-0b10-b153-023f-4b2d4a42f9a5@suse.com>
In-Reply-To: <d63c25f5-0b10-b153-023f-4b2d4a42f9a5@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 May 2023 14:21:17 +0200
Message-ID: <CAJZ5v0jjVKxp-FC2yCbUcwDgBci-CAMvwc6Pp-bCR_PNrpBybw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Kevin Locke <kevin@kevinlocke.name>, rafael@kernel.org,
        lenb@kernel.org, viresh.kumar@linaro.org, pmladek@suse.com,
        mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, May 10, 2023 at 10:48 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> On 5/10/23 02:00, Kevin Locke wrote:
> > On Thu, 2023-03-16 at 16:10 +0100, Petr Pavlu wrote:
> >> The patch extends the ACPI parsing logic to check the ACPI namespace if
> >> the PPC or PCC interface is present and creates a virtual platform
> >> device for each if it is available. The acpi-cpufreq and pcc-cpufreq
> >> drivers are then updated to map to these devices.
> >>
> >> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
> >> boot and only if a given interface is available in the firmware.
> >
> > As a result of this patch (691a637123470bfe63bccf5836ead40fac4c7fab)
> > my ThinkPad T430 with an i5-3320M CPU configured with
> > CONFIG_X86_INTEL_PSTATE=y and CONFIG_X86_ACPI_CPUFREQ=m (Debian's
> > amd64 kernel config) now logs
> >
> > kernel: acpi-cpufreq: probe of acpi-cpufreq failed with error -17
> >
> > during boot.  Presumably this occurs because loading acpi-cpufreq
> > returns -EEXIST when intel-pstate is already loaded (or built-in, as
> > in this case).  I'm unsure why the message was not printed before;
> > perhaps a difference between driver probing for platform and cpu bus
> > types?  Although the error message is not wrong, it may lead to
> > unnecessary investigation by sysadmins, as it did for me.  I thought
> > it was worth reporting so you can consider whether the change is
> > desirable.
>
> Thanks for reporting this issue. The patch moved the setup of
> acpi-cpufreq from being done directly in its module init function to
> going through the probe logic. The reported warning newly comes from
> call_driver_probe() when the probe fails.
>
> One immediate option that I can see to silence this warning would be to
> change the return code for this case in acpi_cpufreq_probe() from
> -EEXIST to -ENODEV/ENXIO. Function call_driver_probe() then prints only
> a debug message about the probe rejecting the device.

-ENODEV, pretty please.  Or I can send a patch, whichever you prefer.

It would be a better error code for this condition anyway IMV.
