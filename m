Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC87204E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjFBOvc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjFBOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:51:30 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA023E49;
        Fri,  2 Jun 2023 07:51:27 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so512354a12.1;
        Fri, 02 Jun 2023 07:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717486; x=1688309486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXHfdMrgpozX1VOcBn1dgVWQVi3s3HG1/X81+A5jHZo=;
        b=TCH68Eg01gaFre+ljvdcoNPQIntwKCxFANPIf5v0v6S4xrx+q7O/N88wO8d4mrw6h0
         7dpJOrBa+P/mBVEJX/Wp2nwx4+t+FFLZNF17w7LvTgTKboWyjaBEncgi4IxHA2XBjnJm
         yeOJ9a+mKUgISQ7/adlPfE3s5SYTFfL4wI83L5m/GuUe4fGUGFvNdrxbIcvkQ7z/sOsT
         FOx8gpr7z/gCBtlu8+SGNb2Trg1CEul6Qmw1RSghiYiVVnb/J1gReoF+E/B7EUtT8LHr
         7N60nxm8e1VNczFdCL3+q8CLAh4a/S9bcFXLsydXFKxuLXdBUMEANVV98J5/9zsUmJdr
         ujRw==
X-Gm-Message-State: AC+VfDwKK1zngNkJgAAQIUvzoOH5Pd9Ghj1ZNZFrW7hIYWLLKDvTKumA
        SSu3+M/VBgOrCiKVw6Mxy8G+aEkRurplfQwM+tK6Y8mS
X-Google-Smtp-Source: ACHHUZ40ia8U3bhmMtJZKW83lKmq8I3pg3C5oT7SvB79yrvkP1+pKAZzyzJNV2VAYGQnq/2KV8MQdP61loiTbPyHfPw=
X-Received: by 2002:a17:906:5199:b0:975:bb7:5dc3 with SMTP id
 y25-20020a170906519900b009750bb75dc3mr958357ejk.7.1685717486156; Fri, 02 Jun
 2023 07:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230601233953.1332-1-mario.limonciello@amd.com>
 <d1e0d5fc837753c292f78a5357fd9ba4531f06d2.camel@linux.intel.com>
 <b0e0abc0-26ba-d104-ff73-b89745510be8@amd.com> <05162d36a009a1669870a2c82bd0b2b65458b244.camel@linux.intel.com>
In-Reply-To: <05162d36a009a1669870a2c82bd0b2b65458b244.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jun 2023 16:51:13 +0200
Message-ID: <CAJZ5v0j8-1Kg5v04yBNMEvPJpJ5KdFX8opu+EXFRw_e6jvEAAw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Adjust Microsoft LPS0 _DSM handling sequence
To:     david.e.box@linux.intel.com
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

On Fri, Jun 2, 2023 at 5:06 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> On Thu, 2023-06-01 at 20:46 -0500, Limonciello, Mario wrote:
> >
> > On 6/1/2023 8:31 PM, David E. Box wrote:
> > > On Thu, 2023-06-01 at 18:39 -0500, Mario Limonciello wrote:
> > > > In Windows the Microsoft _DSM doesn't call functions 3->5->7 for suspend
> > > > and 8->6->4 for resume like Linux currently does.
> > > >
> > > > Rather it calls 3->7->5 for suspend and 6->8->4 for resume.
> > > > Align this calling order for Linux as well.
> > > >
> > > > Link:
> > > > https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states
> > > I didn't catch the ordering in the link.
> >
> > Yeah it's tough to interpret from the link, because the picture at the
> > bottom
> > is missing annotations.
> >
> > Basically if you look at the picture the blue part is the screen on/off.
> >
> > The green part is "modern standby" and then the little "humps" are LPS0
> > enter/exit.
> >
> > > Was there any issue that prompted this
> > > change?
> >
> >
> > We were debugging an unrelated problem and noticed the difference
> > comparing the
> >
> > BIOS debugging log from Windows and Linux.
> >
> > If an OEM depends on this call order in that code used in LPS0 phase
> > requires
> > changes from MS phase I could hypothesize this fixes it.
> >
> >
> > > David
> >
> > BTW - is there interest in supporting the Microsoft _DSM GUID for Intel
> > side too?
> >
> > It's an incongruity today that we run both AMD GUID and Microsoft GUID
> > for AMD systems
> > but only run Intel GUID for Intel systems.
>
> There hasn't been a need yet. Rafael have you look at it?

Nothing official ATM AFAICS.

But I guess it'll need to be used on Intel at one point too.
