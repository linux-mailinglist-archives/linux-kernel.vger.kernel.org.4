Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA126C1F09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCTSHc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCTSHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:07:07 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B42F044;
        Mon, 20 Mar 2023 11:01:12 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id eh3so50096372edb.11;
        Mon, 20 Mar 2023 11:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7sGwAEHU4rAw3qBsGFuv5yZFvS6onzoI7msIxY22vg=;
        b=5EyXNmI6Mt+mHO8Vz37RI/q3PqqAnRwzTPeDxSRdkQsQ4tN+XKs9rJvhsRjkdTNCXU
         egQpWSPDFkth18UiD/PjoQc5bjFk+z9oHlYEBco7y0jEWQn9a4foOO24rm2xEm12JP5U
         W4Zm493nmKWUMLZZJFkHTcJ81fwjvcExI5s5VfzLYNAkvE8fN6Xo+0izARHYaI1vTt2B
         xcBEd/ZHt+YfLxTZU8siCoerEKHBp5RFDt5qpRmzNARuxQQJk65DnmJyqeCTQViO2STW
         LdPPmvz8Imz51GvOmpVkZucuRyQ2rfz9RsbWA7P7LqD1ODOJ+EDLonY1b7jwwR6Op2Vk
         DMzA==
X-Gm-Message-State: AO0yUKUOMuTEDGC1r7V+zFsQlQ0iUvS3G0E9p5zli7+asZxC9iGyVQj1
        tiaCTJhMInbCM/y/ORMUSdVYLTJ9ruDtasbb99c=
X-Google-Smtp-Source: AK7set/in7G2WHAmc6rnFdSqsx1ce37uXlEGwdE3zMTPqOaxqAVJfdLtNMLdGm8j32jUt5evhqvSJZnucvSipaxI6fw=
X-Received: by 2002:a50:8d04:0:b0:4fc:ebe2:2fc9 with SMTP id
 s4-20020a508d04000000b004fcebe22fc9mr223808eds.3.1679335181185; Mon, 20 Mar
 2023 10:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230316164257.42590-1-roger.pau@citrix.com> <17ffe417-8ea0-df98-a8b7-8c370839134f@suse.com>
In-Reply-To: <17ffe417-8ea0-df98-a8b7-8c370839134f@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:59:30 +0100
Message-ID: <CAJZ5v0i-RGRQbkVFu0RUyhPrsbiJ1DpAM0rKU-xM4U3Yddvufg@mail.gmail.com>
Subject: Re: [PATCH v4] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
To:     Juergen Gross <jgross@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        josef@oderland.se, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 1:42 PM Juergen Gross <jgross@suse.com> wrote:
>
> On 16.03.23 17:42, Roger Pau Monne wrote:
> > In ACPI systems, the OS can direct power management, as opposed to the
> > firmware.  This OS-directed Power Management is called OSPM.  Part of
> > telling the firmware that the OS going to direct power management is
> > making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
> > methods must be evaluated for every processor object.  If these _PDC
> > calls are not completed for every processor it can lead to
> > inconsistency and later failures in things like the CPU frequency
> > driver.
> >
> > In a Xen system, the dom0 kernel is responsible for system-wide power
> > management.  The dom0 kernel is in charge of OSPM.  However, the
> > number of CPUs available to dom0 can be different than the number of
> > CPUs physically present on the system.
> >
> > This leads to a problem: the dom0 kernel needs to evaluate _PDC for
> > all the processors, but it can't always see them.
> >
> > In dom0 kernels, ignore the existing ACPI method for determining if a
> > processor is physically present because it might not be accurate.
> > Instead, ask the hypervisor for this information.
> >
> > Fix this by introducing a custom function to use when running as Xen
> > dom0 in order to check whether a processor object matches a CPU that's
> > online.  Such checking is done using the existing information fetched
> > by the Xen pCPU subsystem, extending it to also store the ACPI ID.
> >
> > This ensures that _PDC method gets evaluated for all physically online
> > CPUs, regardless of the number of CPUs made available to dom0.
> >
> > Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Applied as 6.4 material under a slightly edited subject, thanks!
