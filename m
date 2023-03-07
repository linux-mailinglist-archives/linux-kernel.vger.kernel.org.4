Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCE6AD35E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCGAbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCGAbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:31:35 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E46C1A3;
        Mon,  6 Mar 2023 16:31:35 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id l18so12808550qtp.1;
        Mon, 06 Mar 2023 16:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678149094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OcxBWi+fVPcj6LdXeac5WEwf/t01OSULuob77wgPfk=;
        b=YR0KwaaBJA1hGXLSZTGyWJ533Jw/LtfGeqKUCa6BkRF42fBEKLBNZHEAZ+U68FzxTh
         cJAJUHB7mxZiwFewO/gPTHhUz7X2rfcC1w38up2x+SCgam+5cBYfcFeC9U+2qJ6EAiSa
         EjUCd02FnxMpTgM3diqQbLL0jlW9tf/24lOdpRHaY6aBaz9pQtuT+QHCfafw1ASoe61l
         wzlpfc0GbxEy1OiNnKagcUf0KYwVw0f/yDjIx7PjnWVMzmCDCiOU6MxQEQ+yVgvmz1OJ
         eAeKCNUS0+IpDgwjCDrykg2ts1zNDucwKf6qB3mhNPWyPzjzpx8e6SQLMYoE1LTdLJ2c
         g7Aw==
X-Gm-Message-State: AO0yUKXBG1IhnBzi63KJMiCsfDoymBbzOCqqe+krUKL94Y0anT5vxzNq
        8krHWf9gjPmWS/ukOy/97g==
X-Google-Smtp-Source: AK7set8fUnjreVZQ0144g6g2i5wEN0n+GrJKJ96YTx91SjVQkoi4tSAg2pTObyRW7ccAlKfX+Zxpdw==
X-Received: by 2002:ac8:5c08:0:b0:3b9:bc8c:c1f9 with SMTP id i8-20020ac85c08000000b003b9bc8cc1f9mr29744892qti.4.1678149094187;
        Mon, 06 Mar 2023 16:31:34 -0800 (PST)
Received: from robh_at_kernel.org (adsl-72-50-3-187.prtc.net. [72.50.3.187])
        by smtp.gmail.com with ESMTPSA id a4-20020a379804000000b007417affecdcsm8643332qke.69.2023.03.06.16.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:31:33 -0800 (PST)
Received: (nullmailer pid 6585 invoked by uid 1000);
        Tue, 07 Mar 2023 00:31:32 -0000
Date:   Mon, 6 Mar 2023 18:31:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        devicetree@vger.kernel.org,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH] virt-pci: add platform bus support
Message-ID: <20230307003132.GA6366-robh@kernel.org>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
 <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
 <Y+t6qXBxLqf/+eQM@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+t6qXBxLqf/+eQM@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:12:25PM +0100, Vincent Whitchurch wrote:
> On Mon, Feb 13, 2023 at 06:54:49PM +0100, Johannes Berg wrote:
> > On Fri, 2023-01-27 at 15:30 +0100, Vincent Whitchurch wrote:
> > > My first approach to getting platform drivers working on UML was by
> > > adding a minimal PCI-to-platform bridge driver, which worked without
> > > modifications to virt-pci, but that got shot down:
> > > 
> > >  https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/
> > 
> > Reading through that ... OK that isn't fun either :-)
> > 
> > Sounds like there's a use case for something else though, but the PCI
> > IDs issue also makes that thorny.
> 
> Yes, Greg was initially totally opposed to the idea of putting platform
> devices under PCI devices, but in his latest email he seemed to
> allow it in some cases.  It's still unclear if he'd be OK with a
> "virtual PCI-to-platform bridge" though.  And yes, adding platform
> devices support like in this patch removes one layer and also eliminates
> the disadvantage of having to wait for user space to specify a PCI ID
> for the bridge device.

Like I said in that thread, we have multiple usecases needing something 
similar for non-discoverable MMIO devices behind a PCI device. And I 
convinced Greg a platform device was okay, so please continue that path.

I'm adding you to the thread of other usecases.

Rob
