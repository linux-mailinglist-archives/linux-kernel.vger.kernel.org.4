Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6612A696728
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjBNOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjBNOlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:41:52 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B2B21945;
        Tue, 14 Feb 2023 06:41:51 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id u21so17742400edv.3;
        Tue, 14 Feb 2023 06:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaFJsZLG1yaHAOaVj94M7dknjPMkfjabuH7GLPdGLtw=;
        b=PiPtjrsWhBpJC66XxDNpvGlHGIaRNjKlV1YUQ74GGkvC4v2xC62dxAsxJKw6TgG+Ye
         QPxZZfwRKc4E/lzo/xWWe5QNZsTgsFMmdF6HMF4Fy5inUk8Pk//EKgD6Cz3kK14cF795
         wFGyyShCwbLQlCaJg2w4q9wwxwYBEROcCIriYhfSylJfGYm4hW+rd5c+L8OrRdZ1/550
         /HTUBwUyEowuyI9AIvHGjKmlwmL+cqzBtj0ezddcwH+HH/nOw9OrJvuzeqyPtu6Luhvf
         oKx3diUSzZoESipMkynd3EM0bo+Sp03nVlsZ8SBb3rbe87BwPo0ZE71LQQHoBFgUDprl
         mWlw==
X-Gm-Message-State: AO0yUKU1DyNNnk0OCcIJ2IcSAkSy0f9trpZyfvEcw9TcFVWhTHyGM2kC
        WNeqa+lFrIGitweGsJRETySaO+dfCEiCNCqDQ47vFj5V
X-Google-Smtp-Source: AK7set+liXYYxCabxOryUIc0a0OhOY7VfNtiGWaBEsWMbD2EsukiQxyVWjNBt4a4RunDes+A4nJpYgoYb27/Y8sn7Nk=
X-Received: by 2002:a50:f691:0:b0:4ac:50e4:1eee with SMTP id
 d17-20020a50f691000000b004ac50e41eeemr1291725edn.3.1676385710090; Tue, 14 Feb
 2023 06:41:50 -0800 (PST)
MIME-Version: 1.0
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher>
 <mafs0sfgybc3q.fsf_-_@amazon.de> <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>
 <mafs0zga0ds30.fsf_-_@amazon.de> <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>
 <0f74e16d2a1c5005c342d800445c046b8fe248cb.camel@linux.intel.com>
 <CAJZ5v0g1PiMDFUeVKy3YL4pni6oDDaEVTw-LLYnYMMsF+5uuMQ@mail.gmail.com> <dc9f52c96be1be761177e4d52eae1cd4306abeb4.camel@linux.intel.com>
In-Reply-To: <dc9f52c96be1be761177e4d52eae1cd4306abeb4.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:41:38 +0100
Message-ID: <CAJZ5v0gVHOw-2oyW-x53Ud6vwNKNQyepBptGunb8SXJL1U_ziw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 3:25 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2023-02-14 at 14:57 +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 14, 2023 at 2:40 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Mon, 2023-01-30 at 15:58 +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Jan 30, 2023 at 3:18 PM Pratyush Yadav
> > > > <ptyadav@amazon.de>
> > > > wrote:
> > > > >
> > > > >
> > >
> > > [...]
> > >
> > > > > [0]
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
> > > >
> > > > It's already in the mainline:
> > > >
> > > > e8a0e30b742f cpufreq: intel_pstate: Drop ACPI _PSS states table
> > > > patching
> > > > 99387b016022 ACPI: processor: perflib: Avoid updating frequency
> > > > QoS
> > > > unnecessarily
> > > > c02d5feb6e2f ACPI: processor: perflib: Use the "no limit"
> > > > frequency
> > > > QoS
> > >
> > > I am checking 6.2-rc8.
> > > I don't see these commits.
> >
> > You are right, they are in linux-next only, sorry for the confusion.
> >
> > I'm going to push them for 6.3-rc1 this week, though.
> I don't think they are marked for stable. Can we add that?

I'd rather not rebase them for that.

It is still possible to send an inclusion request to -stable when then
get into the mainline.
