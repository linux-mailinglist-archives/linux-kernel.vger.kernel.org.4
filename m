Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D77396BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFVFPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVFPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:15:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B71BCB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:15:47 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-54fac329a71so3641422a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687410947; x=1690002947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9soCak5raKcjZvJvMtE+uNsH2FPMIxS+OErwqzv9v8=;
        b=Hc6c/JC6Js4sO/XgQOqhO+zupd9oBK1lS7N42qvtzAoPwy5z2C6gqP6sV0sgsLOole
         KUQ0YwS58O6QJE7p5+R69qSEgsSh0eTXij5BFmO963NHp+VZw30Kl4ByiMLI8DrCcvdY
         8isFvVhXZG6tFqTaaZIHZLj7PnfGQIaWeMK6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410947; x=1690002947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9soCak5raKcjZvJvMtE+uNsH2FPMIxS+OErwqzv9v8=;
        b=DYJ58c24cdr4ZG/A1Lq7elC0ZI8lo2B05KlG5NzxomUl5PjnY4QFW68M6liAPwI+Tt
         +rZJHNMMGyQAttyaTPr5/LcKd4coVWvh1IfTXIMt+7rdw9IUfcv+W59DxUjydPRd82Ql
         7xNmX2hcKlYz55qNIghjXNJgbg+xK0VJZ27PpAUiIXRBXN+Ep1+yDdN5YsvxWCDpo0pl
         baPCsikUj3PbsyUU6cpU3k99tFIn7bTCz3Qywnux0OTYJ8g4wqWQZ7Wg4lNFNKdeaP2/
         q16hr8I3ygwkN1D8nboR5K/crtvh/BUZDxEjLps1TU1zDQo0e/50iXswJG/rA7hOFYES
         Iwhg==
X-Gm-Message-State: AC+VfDzxCpYx74JQPwrSfeJs9HWcK8NE2CJ4a0B1p7L5QNmjCKQvyXW8
        wEyprjB2VCOBFumgHhR0N4tmiD/k/oSf3sL0cvM=
X-Google-Smtp-Source: ACHHUZ4kxeAPlCYHMJ4z3pJKW/cHTMxNWmyYnjBc+EHck+ckiyMvuhkwiIr3wXI65RbsSnDZYFW9Wg==
X-Received: by 2002:a05:6a20:a11f:b0:122:fa7e:85b5 with SMTP id q31-20020a056a20a11f00b00122fa7e85b5mr4717354pzk.42.1687410946941;
        Wed, 21 Jun 2023 22:15:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ba6-20020a170902720600b001a285269b70sm4319201plb.280.2023.06.21.22.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 22:15:46 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:15:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Stultz <jstultz@google.com>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated
 ramoops memory regions
Message-ID: <202306212212.5E53607@keescook>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:47:26PM -0700, John Stultz wrote:
> On Wed, Jun 21, 2023 at 5:52 PM 'Isaac J. Manjarres' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> >
> > The reserved memory region for ramoops is assumed to be at a fixed
> > and known location when read from the devicetree. This is not desirable
> > in environments where it is preferred for the region to be dynamically
> > allocated early during boot (i.e. the memory region is defined with
> > the "alloc-ranges" property instead of the "reg" property).
> >
> 
> Thanks for sending this out, Isaac!
> 
> Apologies, I've forgotten much of the details around dt bindings here,
> so forgive my questions:
> If the memory is dynamically allocated from a specific range, is it
> guaranteed to be consistently the same address boot to boot?
> 
> > Since ramoops regions are part of the reserved-memory devicetree
> > node, they exist in the reserved_mem array. This means that the
> > of_reserved_mem_lookup() function can be used to retrieve the
> > reserved_mem structure for the ramoops region, and that structure
> > contains the base and size of the region, even if it has been
> > dynamically allocated.
> 
> I think this is answering my question above, but it's a little opaque,
> so I'm not sure.

Yeah, I had exactly the same question: will this be the same
boot-to-boot?

> 
> > Thus invoke of_reserved_mem_lookup() in case the call to
> > platform_get_resource() fails in order to support dynamically
> > allocated ramoops memory regions.
> >
> > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> > Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> > Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

I think this should have "Co-developed-by:"s for each person, since this
isn't explicitly a S-o-B chain...

> > ---
> >  fs/pstore/ram.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > index ade66dbe5f39..e4bbba187011 100644
> > --- a/fs/pstore/ram.c
> > +++ b/fs/pstore/ram.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_reserved_mem.h>
> >
> >  #include "internal.h"
> >  #include "ram_internal.h"
> > @@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >  {
> >         struct device_node *of_node = pdev->dev.of_node;
> >         struct device_node *parent_node;
> > +       struct reserved_mem *rmem;
> >         struct resource *res;
> >         u32 value;
> >         int ret;
> > @@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >
> >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >         if (!res) {
> > -               dev_err(&pdev->dev,
> > -                       "failed to locate DT /reserved-memory resource\n");
> > -               return -EINVAL;
> > +               rmem = of_reserved_mem_lookup(of_node);
> 
> Nit: you could keep rmem scoped locally here.
> 
> Otherwise the code looks sane, I just suspect the commit message could
> be more clear in explaining the need/utility of the dts entry using
> alloc-ranges.

I haven't looked closely at the API here, but does this need a "put"
like the "get" stuff? (I assume not, given the "lookup" is on a node...)

-Kees

-- 
Kees Cook
