Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617156D4F93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjDCRwg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 13:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjDCRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:52:16 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCD82724;
        Mon,  3 Apr 2023 10:51:44 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id ew6so120517696edb.7;
        Mon, 03 Apr 2023 10:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CznSD9bS8RyObCuFJmGTR5dWb8+MmRhHb9IiF6EKc+g=;
        b=zXhYBPK+u28xovUU0CfY+PyN0DRb73gN2xD0eSKQWFVCYrUE9tbH+9iiHrXiJK6mBg
         cdifNoyGikFNXEZQaOAKC5bn3CjwkSE4OWw9rtPoz7bSumtWURzlwkiKYRaErLh2MZ+a
         jVaYor+yQzCPnae4Dv8HhVp9VxsYwPGUVMWCbJD3eooAZ3cU8XpIGfaBV1uNJFIixXjr
         sLSdiAZ0G0nSF5uDk0Kse6Yx7pIy8cUzw2TAewSmQBXRu2q1/kGXQz1XT2/YDijtPVU9
         2/pEmisTf8Xl9kApSYrOk3ZY3svd0r5UIUL33MpZMEIa4mqeuA/FosdvvCaS8NYumm+S
         04EA==
X-Gm-Message-State: AAQBX9cfQGLmQBD08EyH3xR37MPVs6OR024GZlcN5ZBPfrorHgG1vmuX
        /i7uN1thGbuORJlEH9CH/sgowR4GtgWKt9fEGJU=
X-Google-Smtp-Source: AKy350ZdacuCAFk9OAUxlO3Usd+9JK8uI41jY0FBRaRA5QjURF92uSIJk3TxHMy/xxOajIj/4ixlWNjSWHxoWiB4liE=
X-Received: by 2002:a17:906:4a94:b0:947:c623:2c84 with SMTP id
 x20-20020a1709064a9400b00947c6232c84mr5366132eju.2.1680544302879; Mon, 03 Apr
 2023 10:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230316153841.3666-1-rui.zhang@intel.com> <20230316153841.3666-5-rui.zhang@intel.com>
 <CAJZ5v0hG9mC0DAWeGfgcrripi8dpANSwBgBQxjDSzzLGQcC0iQ@mail.gmail.com> <1299d6418c469d56cfe4c94af7342e9c9d26858e.camel@intel.com>
In-Reply-To: <1299d6418c469d56cfe4c94af7342e9c9d26858e.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 19:51:31 +0200
Message-ID: <CAJZ5v0iwN-3TyX6A4VuX4EXwD9o04hHxm4T3=XaBg2hXPXev4g@mail.gmail.com>
Subject: Re: [PATCH 04/15] powercap/intel_rapl: Support per Interface
 primitive information
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 2, 2023 at 9:43 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2023-03-30 at 19:56 +0200, Rafael J. Wysocki wrote:
> > On Thu, Mar 16, 2023 at 4:42 PM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > > RAPL primitive information is Interface specific.
> > >
> > > Although current MSR and MMIO Interface share the same RAPL
> > > primitives,
> > > new Interface like TPMI has its own RAPL primitive information.
> > >
> > > Save the primitive information in the Interface private structure.
> > >
> > > Plus, using variant name "rp" for struct rapl_primitive_info is
> > > confusing because "rp" is also used for struct rapl_package.
> > > Use "rpi" as the variant name for struct rapl_primitive_info, and
> > > rename
> > > the previous rpi[] array to avoid conflict.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/powercap/intel_rapl_common.c | 50 ++++++++++++++++++----
> > > ------
> > >  include/linux/intel_rapl.h           |  2 ++
> > >  2 files changed, 35 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > b/drivers/powercap/intel_rapl_common.c
> > > index 56e8af2a1e6f..898238285188 100644
> > > --- a/drivers/powercap/intel_rapl_common.c
> > > +++ b/drivers/powercap/intel_rapl_common.c
> > > @@ -654,7 +654,7 @@ static u64 rapl_unit_xlate(struct rapl_domain
> > > *rd, enum unit_type type,
> > >  }
> > >
> > >  /* in the order of enum rapl_primitives */
> > > -static struct rapl_primitive_info rpi[] = {
> > > +static struct rapl_primitive_info rpis_default[] = {
> >
> > What does the 's' in the name stand for?
>
> 'rpi' stands for rapl_primitive_info, so I use 'rpis' for a series of
> rapl_primitive_info.

I would call it rpi_default[] (without the 's'), because the "array"
part is implied by its definition, so the plural is not really
necessary.
