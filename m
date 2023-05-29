Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF9714266
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjE2Dvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2Dva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:51:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C06AF;
        Sun, 28 May 2023 20:51:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3578c25bso3404215b3a.3;
        Sun, 28 May 2023 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685332288; x=1687924288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWkO1L+ouf2ah8LI6jKTrWLnhiGc82nUY4Gt/CvuXVY=;
        b=HSD1FX44jrvtXqFvvXC6dUBttrRYsdgQkKbG8SUDF6oF9DdTJKY4M5M8yAOqFCeti2
         xnHYtz/5W3qForvRN+4Dk4V37+CiHhB6lrhyRW9dtAp2uKi5lLmLhHIOq/Tm2bEQDxCa
         oLgqkwj5a+opXAjjGfy0UwYPcAT3Pwj5bc6BZKFnEp9Q31azjHX5qijKpF+g1L/KRquu
         TBO+Wf7eYaZTyX7fzkHbfJZtj2i9UK7AiSZvN+dQ2kpDU5ecky3M/Wxhj1oloELfp6FW
         2tWG8FoGsKeH7cJ8rrmId+UpwDf1k9hb3x2qb7yRhxhOjSDsB1Jc5PDyJwV5hjKifHkl
         ezjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685332288; x=1687924288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWkO1L+ouf2ah8LI6jKTrWLnhiGc82nUY4Gt/CvuXVY=;
        b=M+nI5PgRNJ/mkuotb37bP7bTGqd51TJmJCTSL371zcoFffOFX5SgbS4OCv+qAsioQP
         cyx0EeCJIhLDuoTtzJr9XuuF9ZbugfAN6OF+cynh6VXsbsv7jy7Jqp17CtN6SuVh1dyt
         gSSFAl3Eq4EjGdHlfRhM8QyV/h+fbmbgtd5GM7EvyNhW4bo6IuYooaS+2+BQ+OqnOWTs
         yjrLFlYEV5C0KRq7TfyKQSURKv7BMhOgRwmVo7pApSvfLYv3NKAeT0pP9b/fIsUJw6fu
         LSj4S09I+5xQNFx3uvFvxMr8Y9IwzixhHwrIQCLpW/V4ZEuZitvbi1EJ/7r7M6QQvJo6
         h8yQ==
X-Gm-Message-State: AC+VfDzD1e9ML9Ng9V0q+4yWfR3FepBLzjCpbR5A2cC8i2f4Ewkpk9SU
        Je4bG7l60N2Som6o11Yvprb6VJ3b2v0tjQ5P
X-Google-Smtp-Source: ACHHUZ5wL8TAQK0crfhurwCmme9flkSOyTBq+EFhHKLhu9rItwgzzI/Ai4IcRO11Q6hEgcJW8xFu0g==
X-Received: by 2002:a05:6a21:33a8:b0:100:b137:3563 with SMTP id yy40-20020a056a2133a800b00100b1373563mr8141116pzb.32.1685332288315;
        Sun, 28 May 2023 20:51:28 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:c494:2aca:bc01:6f7b])
        by smtp.gmail.com with ESMTPSA id w123-20020a636281000000b00528b78ddbcesm6121959pgb.70.2023.05.28.20.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 20:51:27 -0700 (PDT)
Date:   Mon, 29 May 2023 12:51:25 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1036530@bugs.debian.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZHQhPcKUF76Kplwm@xps>
References: <ZG98fQ+MD4O0nGGE@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZG/8cxxTJ9ZzrVPQ@xps>
 <ZHCYRmD7YeIWoy2W@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps>
 <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com>
 <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mario Limonciello <mario.limonciello@amd.com> [230529 10:14]:
> On 5/28/23 19:56, Nick Hastings wrote:
> > Hi,
> > 
> > * Mario Limonciello <mario.limonciello@amd.com> [230528 21:44]:
> > > On 5/28/23 01:49, Salvatore Bonaccorso wrote:
> > > > Hi Mario
> > > > 
> > > > Nick Hastings reported in Debian in https://bugs.debian.org/1036530
> > > > lockups from his system after updating from a 6.0 based version to
> > > > 6.1.y. >
> > > > #regzbot ^introduced 24867516f06d
> > > > 
> > > > he bisected the issue and tracked it down to:
> > > > 
> > > > On Sun, May 28, 2023 at 10:14:51AM +0900, Nick Hastings wrote:
> > > > > Control: tags -1 - moreinfo
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > I repeated the git bisect, and the bad commit seems to be:
> > > > > 
> > > > > (git)-[v6.1-rc1~206^2~4^5~3|bisect] % git bisect bad
> > > > > 24867516f06dabedef3be7eea0ef0846b91538bc is the first bad commit
> > > > > commit 24867516f06dabedef3be7eea0ef0846b91538bc
> > > > > Author: Mario Limonciello <mario.limonciello@amd.com>
> > > > > Date:   Tue Aug 23 13:51:31 2022 -0500
> > > > > 
> > > > >       ACPI: OSI: Remove Linux-Dell-Video _OSI string
> > > > >       This string was introduced because drivers for NVIDIA hardware
> > > > >       had bugs supporting RTD3 in the past.
> > > > >       Before proprietary NVIDIA driver started to support RTD3, Ubuntu had
> > > > >       had a mechanism for switching PRIME on and off, though it had required
> > > > >       to logout/login to make the library switch happen.
> > > > >       When the PRIME had been off, the mechanism had unloaded the NVIDIA
> > > > >       driver and put the device into D3cold, but the GPU had never come back
> > > > >       to D0 again which is why ODMs used the _OSI to expose an old _DSM
> > > > >       method to switch the power on/off.
> > > > >       That has been fixed by commit 5775b843a619 ("PCI: Restore config space
> > > > >       on runtime resume despite being unbound"). so vendors shouldn't be
> > > > >       using this string to modify ASL any more.
> > > > >       Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > >       Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > >       Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > 
> > > > >    drivers/acpi/osi.c | 9 ---------
> > > > >    1 file changed, 9 deletions(-)
> > > > > 
> > > > > This machine is a Dell with an nvidia chip so it looks like this really
> > > > > could be the commit that that is causing the problems. The description
> > > > > of the commit also seems (to my untrained eye) to be consistent with the
> > > > > error reported on the console when the lockup occurs:
> > > > > 
> > > > > [   58.729863] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> > > > > [   58.729904] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> > > > > [   60.083261] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
> > > > > 
> > > > > Hopefully this is enough information for experts to resolve this.
> > > > 
> > > > Does this ring some bell for you? Do you need any further information
> > > > from Nick?
> > > > 
> > > > Regards,
> > > > Salvatore
> > > 
> > 
> > > Have Nick try using "pcie_port_pm=off" and see if it helps the issue.
> > 
> > I booted into a 6.1 kernel with this option. It has been running without
> > problems for 1.5 hours. Usually I would expect the lockup to have
> > occurred by now.

I let this run for 3 hours without issue.

> > > Does this happen in the latest 6.4 RC as well?
> > 
> > I have compiled that kernel and will boot into it after running this one
> > with the pcie_port_pm=off for another hour or so.

I'm now running 6.4.0-rc4 without seeing the problem after 1 hour.

I did however see two unrelated problems that I include here for
completeness:
1. iwlwifi module did not automatically load
2. Xwayland used huge amount of CPU even though was not running any X
programs. Recompiling my wayland compositor without XWayland support
"fixed" this.

> > > I think we need to see a full dmesg and acpidump to better
> > > characterize it.
> > 
> > Please find attached. Let me know if there is anything else I can provide.
> > 
> > Regards,
> > 
> > Nick.
> 
> I don't see nouveau loading, are you explicitly preventing it from
> loading?

Yes nouveau is blacklisted.

> Can I see the journal from a boot when it reproduced?

Hmm not sure which n for "journalctl -b n" maps to which kernel (is that
what you are requesting?). The commit hash doesn't not seem to be
listed. I may have to boot into a bad kernel again.

Regards,

Ncik.


