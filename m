Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFC673A737
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFVR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFVR0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:26:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3605173F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:26:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b52875b8d9so13005ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687454800; x=1690046800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp0t+PLucuEtsm8QBIhhl2b8jQzEk9CK2+LuMCdHbHY=;
        b=2eo53V8GN6cveuVkUHlZRsCKdn6oG2YXGQjxCOTV4meYN/t4hLRLFk7Bw7ZJFu9YAS
         n9NLFKwgU9QALg7gsLsZz189l3E9fwfS/q6d+07n0QkgDcB7bw3NkGj7LTYmvlQ3ZvER
         OwLIYcB+zWsT/OUj+fFll72BBVeAbetIvVPeXgQduHl5wbk2uQdKUqxGTPwpklbupYKP
         0pvZnb0BWcPJozEVoM2tSFP2tebAZcMJnmPq0CoE3pileVicN/IgJwWAYaQAI2qwQ4tO
         r6ZG6p2mc6FeSpAYD9MYEXWs7ddb2KIxq0NI2XbPxDfYnKNT866iOo4AWiDGXCEeNAhx
         8f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454800; x=1690046800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp0t+PLucuEtsm8QBIhhl2b8jQzEk9CK2+LuMCdHbHY=;
        b=YlGPeEqxJF61HsA7/+e7x4S+8hsrokRpuDs6vYwY+5LymSXpy15dLLTL+3Mbhql2wF
         em6hXFvVoqjEfj+qPIoCKXmWsdCDZD31kCH7S1fI52BWww82Go1Bo/uQNrxbsfBYHaGD
         MQjXSa7P3LH4u2Ub10QmwZhsntQA2inIBSGDYh9LGk2WNCIQoWyT0yKnP9F4Jlb2TQ0K
         Y89itkSp+CP1bkjQWDXU34fSXVJNIoXP8tDx17k6bkN+TzE181Y3dLsbttvvahE04Egj
         Nacli9Q0uoWplCqyQkQ8hUiGGtgEkM9MpWvx0/WSyQhiRylBWDTp9jA8cQlG3/8Sg6ui
         iQXQ==
X-Gm-Message-State: AC+VfDysfBFNIGl/e1kdC14VcBoy8g4782j4D8/uGbEgogNcARXQoz8p
        v9MJCI2qQpgangwOE7HU+TnyDw==
X-Google-Smtp-Source: ACHHUZ4+G/oeecut6TKOIjj0aeUUFs58jdW0biSd6uS6KQajdC89E1A7CiKsEZo6nWrRuaFm3UNoBA==
X-Received: by 2002:a17:902:d2c6:b0:19c:c5d4:afd2 with SMTP id n6-20020a170902d2c600b0019cc5d4afd2mr129416plc.11.1687454799910;
        Thu, 22 Jun 2023 10:26:39 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:44d3:c215:d3c3:9a46])
        by smtp.gmail.com with ESMTPSA id l18-20020a656812000000b00514256c05c2sm4711761pgt.7.2023.06.22.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 10:26:39 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:26:35 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     John Stultz <jstultz@google.com>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated
 ramoops memory regions
Message-ID: <ZJSES98P+zzrhBI5@google.com>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
 <202306212212.5E53607@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306212212.5E53607@keescook>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:15:45PM -0700, Kees Cook wrote:
> On Wed, Jun 21, 2023 at 09:47:26PM -0700, John Stultz wrote:
> > > The reserved memory region for ramoops is assumed to be at a fixed
> > > and known location when read from the devicetree. This is not desirable
> > > in environments where it is preferred for the region to be dynamically
> > > allocated early during boot (i.e. the memory region is defined with
> > > the "alloc-ranges" property instead of the "reg" property).
> > >
> > 
> > Thanks for sending this out, Isaac!
> > 
> > Apologies, I've forgotten much of the details around dt bindings here,
> > so forgive my questions:
> > If the memory is dynamically allocated from a specific range, is it
> > guaranteed to be consistently the same address boot to boot?
> > 
> > > Since ramoops regions are part of the reserved-memory devicetree
> > > node, they exist in the reserved_mem array. This means that the
> > > of_reserved_mem_lookup() function can be used to retrieve the
> > > reserved_mem structure for the ramoops region, and that structure
> > > contains the base and size of the region, even if it has been
> > > dynamically allocated.
> > 
> > I think this is answering my question above, but it's a little opaque,
> > so I'm not sure.
> 
> Yeah, I had exactly the same question: will this be the same
> boot-to-boot?

Hi Kees,

Thank you for taking a look at this patch and for your review! When the
alloc-ranges property is used to describe a memory region, the memory
region will always be allocated within that range, but it's not
guaranteed to be allocated at the same base address across reboots.

I had proposed re-wording the end of the commit message in my response
to John as follows:

"...and that structure contains the address of the base of the region
that was allocated at boot anywhere within the range specified by the
"alloc-ranges" devicetree property."

Does that clarify things better?

> > 
> > > Thus invoke of_reserved_mem_lookup() in case the call to
> > > platform_get_resource() fails in order to support dynamically
> > > allocated ramoops memory regions.
> > >
> > > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> > > Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> > > Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> > > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> 
> I think this should have "Co-developed-by:"s for each person, since this
> isn't explicitly a S-o-B chain...

Noted. I'll fix this up for v2 of the patch.

> > > @@ -643,6 +644,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> > >  {
> > >         struct device_node *of_node = pdev->dev.of_node;
> > >         struct device_node *parent_node;
> > > +       struct reserved_mem *rmem;
> > >         struct resource *res;
> > >         u32 value;
> > >         int ret;
> > > @@ -651,13 +653,20 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> > >
> > >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >         if (!res) {
> > > -               dev_err(&pdev->dev,
> > > -                       "failed to locate DT /reserved-memory resource\n");
> > > -               return -EINVAL;
> > > +               rmem = of_reserved_mem_lookup(of_node);
> > 
> > Nit: you could keep rmem scoped locally here.
> > 
> > Otherwise the code looks sane, I just suspect the commit message could
> > be more clear in explaining the need/utility of the dts entry using
> > alloc-ranges.
> 
> I haven't looked closely at the API here, but does this need a "put"
> like the "get" stuff? (I assume not, given the "lookup" is on a node...)

No, it doesn't need a put, since of_reserved_mem_lookup() doesn't
acquire a reference to anything.

Thanks,
Isaac
