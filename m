Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33528640BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiLBRGv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 12:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiLBRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:06:40 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C351934D4;
        Fri,  2 Dec 2022 09:06:39 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id jr1so6007638qtb.7;
        Fri, 02 Dec 2022 09:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh9kgJLINYmxV8g3qTi7szoV+9siNmymyIdCpJv+cBQ=;
        b=6vI2rMG1ROoB06Hf8KsxEZfXgrYNKGnZCqppEg40H+4nQO9/S9pmOGmi6yPurt/GRa
         8cKsg4fgakuR6v7+EIZYCcgnhlLGuqj4Aa3afbsSCkG4hQS9hLMyNVTVQYFCb4gp5W/1
         Es2BqX0rDY5JYjqHJUdwy50NI3zhZbD8n44mULw2W+J7N3jeXXVx5Mf64xkMZL3pQYWR
         qj1zWWGGolA9v8b8cGmqq4X8PXGTcSpB2QGRKL9es4z6cuCztwN2N5I5EsGmr4YhjPfT
         gXSLEA1Z6G0Yqu0exmOOCBUivBdsbTNX8ExA+ptfKNvtmJ5Kgf5ZbgnHUFV7n01A1Ueu
         Y6zA==
X-Gm-Message-State: ANoB5pnQ1+Iz0IIi6hTFNeFDDB94mE157XszYhOfaSXAPnmwhlFkHcSY
        o8i31BdvbFKyZtb3IvoU9bHpf0u0959EMr/DXNI=
X-Google-Smtp-Source: AA0mqf7fLL+ryfJc9gdlygwZFMKAW1X4WWvlOUNEoVLLyu7iJ7lEwsoaHA2t1RhbtGz9hRYHOwN5y8/jp/Ex9zi8Yls=
X-Received: by 2002:ac8:4818:0:b0:3a6:a0d7:e1f7 with SMTP id
 g24-20020ac84818000000b003a6a0d7e1f7mr1208911qtq.153.1670000798144; Fri, 02
 Dec 2022 09:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20221121102113.41893-1-roger.pau@citrix.com> <20221121102113.41893-2-roger.pau@citrix.com>
 <6b212148-4e3f-3ef6-7922-901175746d44@intel.com> <Y4d8cm97hn5zuRQ1@Air-de-Roger>
 <4a0e9f91-8d8b-84bc-c9db-7265f5b65b63@intel.com> <Y4nugxKV1J/BqhBt@Air-de-Roger>
 <93fd7ed0-5311-d6db-4d8b-b992a8f78ada@intel.com> <Y4opuLnLIT3v9Aa7@Air-de-Roger>
In-Reply-To: <Y4opuLnLIT3v9Aa7@Air-de-Roger>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 18:06:26 +0100
Message-ID: <CAJZ5v0hrdwUNOELXM5zxtTeavp+_o7TbkCRBjZVqvQVxt4QBnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 5:37 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
>
> On Fri, Dec 02, 2022 at 08:17:56AM -0800, Dave Hansen wrote:
> > On 12/2/22 04:24, Roger Pau Monné wrote:
> > > On the implementation side, is the proposed approach acceptable?
> > > Mostly asking because it adds Xen conditionals to otherwise generic
> > > ACPI code.
> >
> > That's a good Rafael question.

Sorry for joining late, but first off _PDC has been deprecated since
ACPI 3.0 (2004) and it is not even present in ACPI 6.5 any more.

It follows from your description that _PDC is still used in the field,
though, after 18 years of deprecation.  Who uses it, if I may know?

> > But, how do other places in the ACPI code handle things like this?
>
> Hm, I don't know of other places in the Xen case, the only resource
> in ACPI AML tables managed by Xen are Processor objects/devices AFAIK.
> The rest of devices are fully managed by the dom0 guest.
>
> I think such special handling is very specific to Xen, but maybe I'm
> wrong and there are similar existing cases in ACPI code already.
>
> We could add some kind of hook (iow: a function pointer in some struct
> that could be filled on a implementation basis?) but I didn't want
> overengineering this if adding a conditional was deemed OK.

What _PDC capabilities specifically do you need to pass to the
firmware for things to work correctly?

What platforms are affected?
