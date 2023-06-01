Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACDD71F6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjFAXzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAXzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:55:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57E136;
        Thu,  1 Jun 2023 16:55:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b034ca1195so8201085ad.2;
        Thu, 01 Jun 2023 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685663714; x=1688255714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihl8v58xxI+k8/qBpzTYZAfUmx+fnzwWgMHjRzgdYbE=;
        b=kdR5H2X7d12BcILtHvrj70bvW2DgiE0sSf7f2e81MSKM4kNEklP4ZLPEKSqx8t2NvC
         jI93bcl7vbjpdu/IBcQVCB0n/F5b8HzGpfYmAJ1DJyYvApuJ2WQVT61pckYGE2Q9yOXZ
         Cr0BH1XstkTP6Q9izTuWDC8CM5cOb9l/DEFyTyPiPaUOrT1fgk+6OL4/svb1S9ADGqHF
         4+VQBH63V95XUfYJb0fBLJd33YEyL/2NfydYTbjvCxVw95vhrX2RxjO5x9g8Sc/4Kcm2
         RPVAKBUmkGy01BbcCV/V/2UeWrJrHC66XtB/amLVUc40f0uacj5LIj4/nm9rFLIZabGj
         6P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685663714; x=1688255714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihl8v58xxI+k8/qBpzTYZAfUmx+fnzwWgMHjRzgdYbE=;
        b=l66nTgJzVgOn8bLe8XRbXl007HgrWSWCw3ld2q4+0/HUDuDnSFQCyVA4dDpgsgB2Uk
         35u4SzyZYQ7ydZONKoVTVUofOYxe4n+PCGiZFF1tGkpKqARC8C5fbSMxpk7tVBG7gtmU
         3/ZHdrLpkLB3VVPrlV2BpFSDV1SBzk5Rrp0ObTlXzajhJPoM6oE2NQ3V6167abxgtCcZ
         YBppeiz/2hZDRGLpz6p8WZQAaXWcULtlyZQINGtBDDxWguEkZ6AMHan86uFScveS2+5w
         V/K7CKBtIMrF2X+CCOqlgEjU4/qeXP0WsbEfG9+8e6DYZHkAViuLMvzuIpaIecNgbmPc
         z0MA==
X-Gm-Message-State: AC+VfDympoH7D8ViIGNnqUcjpQBCFplbc8DZWCcbd4UFqqSvYifybgs+
        sO08YrfG1Qe9CEg5wBAVp0I=
X-Google-Smtp-Source: ACHHUZ6BrFhevm2B2jVnR9Sgoop6ktChkiYMnQv1G5hcbie6gxrt0IOjXJFz2O9mbYiIqyfEgfrCmw==
X-Received: by 2002:a17:902:ecc1:b0:1ac:3605:97ec with SMTP id a1-20020a170902ecc100b001ac360597ecmr615508plh.62.1685663713896;
        Thu, 01 Jun 2023 16:55:13 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:c494:2aca:bc01:6f7b])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001a6d4ffc760sm4054136plh.244.2023.06.01.16.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:55:13 -0700 (PDT)
Date:   Fri, 2 Jun 2023 08:55:11 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        kherbst@redhat.com, Salvatore Bonaccorso <carnil@debian.org>,
        1036530@bugs.debian.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZHkv32h2F/AYmIqk@xps>
References: <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com>
 <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
 <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps>
 <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <ZHWfMBeAONerAJmd@xps>
 <ZHfa/wQlaVCeUC22@xps>
 <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Limonciello, Mario <mario.limonciello@amd.com> [230602 01:18]:
> +Lyude, Lukas, Karol
> 
> On 5/31/2023 6:40 PM, Nick Hastings wrote:
> > 
> > * Nick Hastings <nicholaschastings@gmail.com> [230530 16:01]:
> > > * Mario Limonciello <mario.limonciello@amd.com> [230530 13:00]:
> > <snip>
> > > > As you're actually loading nouveau, can you please try nouveau.runpm=0 on
> > > > the kernel command line?
> > > I'm not intentionally loading it. This machine also has intel graphics
> > > which is what I prefer. Checking my
> > > /etc/modprobe.d/blacklist-nvidia-nouveau.conf
> > > I see:
> > > 
> > > blacklist nvidia
> > > blacklist nvidia-drm
> > > blacklist nvidia-modeset
> > > blacklist nvidia-uvm
> > > blacklist ipmi_msghandler
> > > blacklist ipmi_devintf
> > > 
> > > So I thought I had blacklisted it but it seems I did not. Since I do not
> > > want to use it maybe it is better to check if the lock up occurs with
> > > nouveau blacklisted. I will try that now.
> > I blacklisted nouveau and booted into a 6.1 kernel:
> > % uname -a
> > Linux xps 6.1.0-9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.27-1 (2023-05-08) x86_64 GNU/Linux
> > 
> > It has been running without problems for nearly two days now:
> > % uptime
> >   08:34:48 up 1 day, 16:22,  2 users,  load average: 1.33, 1.26, 1.27
> > 
> > Regards,
> > 
> > Nick.
> 
> Thanks, that makes a lot more sense now.
> 
> Nick, Can you please test if nouveau works with runtime PM in the
> latest 6.4-rc?

I reported this twice already. I guess it was lost since for some
reason emails in this thread are not being trimmed. I'll repeat here:

I did eventually see a lockup of this kernel. On the console I saw:

[  151.035036] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible

I did not see the other two lines that were present in earlier lock ups.

Regards,

Nick.

