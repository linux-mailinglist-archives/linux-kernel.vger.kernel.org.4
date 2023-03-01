Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573C76A6611
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCADAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCADAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:00:09 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580B18A88;
        Tue, 28 Feb 2023 19:00:05 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id bm20so9737577oib.7;
        Tue, 28 Feb 2023 19:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+hlk9qIUuM3fLnkVidAMNeHVHDdRcnOrwsq/H80HYc=;
        b=eTEp+ip+z+YjVDjaxcREGkrd5wbt5+EN7MSxL0LgsHJ5TcP7blAsQeLZRi5LxwujYT
         bk0UDGIhamob2WzWwukuaHQwc0I/ArVxGKZBTTBlGF5vDyGhZAbsSUUmeT8WwhP4HWsH
         +dT/ynla2CK3cGzZPXZFuonyYGzdwIsZ4QQNKk3NGAP9/T6WLqBXFSEhtkmk17AWpmar
         zUjpNGQoXPRs4bJAhXT0mQU5sgBlbdszUTagvM5r2Ijd9h5htoT0NZXnf63cOFDmSh+u
         dsDaTLu6WOmE9vZ35Dc0+wlNIXYTanP/HWqQFiZndpVjP+b8TjWrY6CHunjNMO3Kq9zB
         C0yA==
X-Gm-Message-State: AO0yUKXM4m5oy+dbLUrENGuQQ3tY2F2SrVNbqpJIFmOjog2FIUpNT1dP
        v601F+D8tkzJwJ7LPAk6ow==
X-Google-Smtp-Source: AK7set+HpWmzeYd1lGPiy8QJl4l7LAmnwcnfvUHV8gqxvp3LQQbCgck/qlm0hfpMFBXzIZ8Apr3ehA==
X-Received: by 2002:aca:1016:0:b0:383:e383:f265 with SMTP id 22-20020aca1016000000b00383e383f265mr2460854oiq.19.1677639604117;
        Tue, 28 Feb 2023 19:00:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id az2-20020a056808164200b0037d74a4b8fasm5279782oib.56.2023.02.28.19.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:00:03 -0800 (PST)
Received: (nullmailer pid 281189 invoked by uid 1000);
        Wed, 01 Mar 2023 03:00:03 -0000
Date:   Tue, 28 Feb 2023 21:00:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] of: create of_root if no dtb provided
Message-ID: <20230301030003.GA263873-robh@kernel.org>
References: <20230223213418.891942-1-frowand.list@gmail.com>
 <20230223213418.891942-2-frowand.list@gmail.com>
 <CAL_JsqLR9sm+GRU8EP4eO_Ln2UhD=ztdAU834CzP8RSv2s2jQg@mail.gmail.com>
 <cbf76155-4355-5241-d7a5-816e6721ce1b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbf76155-4355-5241-d7a5-816e6721ce1b@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 08:05:58PM -0600, Frank Rowand wrote:
> On 2/27/23 11:17, Rob Herring wrote:
> > On Thu, Feb 23, 2023 at 3:34 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> When enabling CONFIG_OF on a platform where of_root is not populated by
> >> firmware, we end up without a root node. In order to apply overlays and
> >> create subnodes of the root node, we need one. Create this root node
> >> by unflattening an empty builtin dtb.
> >>
> >> If firmware provides a flattened device tree (FDT) then the FDT is
> >> unflattened via setup_arch().  Otherwise, setup_of() which is called
> >> immediately after setup_arch(), and will create the default root node
> >> if it does not exist.
> > 
> > Why do we need a hook after setup_arch() rather than an initcall?
> > 
> > Rob
> 
> It might work as an initcall today.  Maybe not in the future as other
> initcalls are added.

That's an argument for never using initcalls (not a bad one either). But 
we have them and we have little reason not to use them. Also, it's 
better to do things as late as possible I've found. The earlier you do 
things, the more architecture specific stuff you hit. That's a big 
reason for the remaining differences in FDT init across architectures. 
Maybe after setup_arch is late enough. IDK.

> But my main stream of thinking is that before the patch "we know" that
> the device tree data structure exists when setup_arch() returns.
> Adding setup_of() immediately after setup_arch() retains that
> guarantee, but one line later in start_kernel().

I get the logic. I'd just rather not add another hook between the DT 
code and the core/arch code. Especially for this niche usecase.

We already have the secondary init when sysfs is up. Can't we just do 
this there?

> I could have instead put the call to setup_of() into each architectures'
> setup_arch(), but that would just be duplicating the same code for each
> architecture, which did not seem like a good choice.

Uhh, no!

Rob
