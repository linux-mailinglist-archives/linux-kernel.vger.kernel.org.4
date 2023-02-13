Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647BA694E67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBMRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBMRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:50:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C561F933
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:50:09 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so1462004pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8NVw51hJujJ9w6ww4tXYpEn/8Vq7ox+Z1FASgY/bLU=;
        b=Bd5fqu4Y/EyTummo2fVWma8W7zSH94KPXwjC+My/qv4w4lRqc2bTM0aeCnwo6RxXqx
         Qr+kuCxm+ap5+tWeT8OpIKQQTipytFb7/VmEUWg7rfnNZKpqDqQEHV5nGn8XO1FGTIk+
         Nv4k3G3cJKiR3Q7ObE4YCnakTxt7A81IvBvGWk1/KSvFfHtxEp6CPMyvhBkOKyOuYFvK
         lTno7aCndNECZC+kSDNG8MR1VstW/BurZNGlpBM46+040Vmc0bbLtTufBBF0wZGWZc+x
         zD2cd1bgxeINi8EXEJNHjiAb5HnZPX/jb5phCXk8ACCb2hEiYZweiC4Kbi2OEhcQmVTc
         i1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8NVw51hJujJ9w6ww4tXYpEn/8Vq7ox+Z1FASgY/bLU=;
        b=PaURErGfWrDkpsEG6WIeHcB6RmYe6SLfK4WOcYUzIVNSl/uBxLHo+zg0molmgoHs4N
         kpYNomAwxxUrTgbEc31JHP/nibEMV7/fRrGzuJxs4WH2gr4R9eBwqCU/N+M7Tr3SX1pv
         jJYP5FfBuCsu/KSvYRGMlFTzqCVzg+l+WUDc4z5hL++96tVV28G5iEZk1RRjecNAcLin
         oUQURs4Hf7//6uZhJ+GRs0kirE+BsrQmWvLm9iO6sWcNSHmdzjxcsGeRfdN1vXqEbQVD
         mBnHrPtXVQ9/RDhn0B9zWw1X2braxQNjrkDX7HFdZjDxip7tkV7elkSIUZQe7OT4qKkd
         K5JA==
X-Gm-Message-State: AO0yUKVT4hWMgWBNK/6aCJRzlFzDnNyV4EzpdZjcu28phuqvWBaDoK9o
        rOm6dpbzgQayFOUAShUpUc2g+w==
X-Google-Smtp-Source: AK7set9lsbgjl5TgXfCPbU1vvfIDzkRjBJr9zNN0yZX/rOiaR87z3+Pi1tvaUwDAPm+VBgOq2lq3rA==
X-Received: by 2002:a17:90b:4a0b:b0:233:9fff:888e with SMTP id kk11-20020a17090b4a0b00b002339fff888emr13858074pjb.39.1676310609341;
        Mon, 13 Feb 2023 09:50:09 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:8b5:7925:cf2a:8bac])
        by smtp.gmail.com with ESMTPSA id i61-20020a17090a3dc300b00231224439c1sm4290656pjc.27.2023.02.13.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:50:08 -0800 (PST)
Date:   Mon, 13 Feb 2023 10:50:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Message-ID: <20230213175006.GA310433@p14s>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
 <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
> On 2/12/2023 9:43 AM, Peng Fan wrote:
> > Hi Iuliana,
> > 
> > > Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
> > > DDR
> > > 
> > > 
> > > On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > V3:
> > > > 
> > > >    Daniel, Iuliana
> > > > 
> > > >      Please help review this patchset per Mathieu's comments.
> > > > 
> > > >    Thanks,
> > > >    Peng.
> > > > 
> > > >    Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
> > > >    IMX_RPROC_ANY in patch 3 Per Mathieu
> > > >    Update comment and commit log in patch 5, 6.
> > > > 
> > > >    NXP SDK provides ".interrupts" section, but I am not sure how others
> > > >    build the firmware. So I still keep patch 6 as v2, return bootaddr
> > > >    if there is no ".interrupts" section.
> > > > 
> > > > V2:
> > > >    patch 4 is introduced for sparse check warning fix
> > > > 
> > > > This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
> > > > could be in DDR, not just the default TCM.
> > > > 
> > > > i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
> > > > initial value could be got from firmware first section ".interrupts".
> > > > i.MX93 is a bit different, it just needs the address of .interrupts
> > > > section. NXP SDK always has .interrupts section.
> > > > 
> > > > So first we need find the .interrupts section from firmware, so patch
> > > > 1 is to reuse the code of find_table to introduce a new API
> > > > rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
> > > > 
> > > > Patch 2 is introduce devtype for i.MX8M/93
> > > > 
> > > > Although patch 3 is correct the mapping, but this area was never used
> > > > by NXP SW team, we directly use the DDR region, not the alias region.
> > > > Since this patchset is first to support firmware in DDR, mark this
> > > > patch as a fix does not make much sense.
> > > > 
> > > > patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
> > > > .interrupts section. Detailed information in each patch commit message.
> > > > 
> > > > Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
> > > If one can build their firmware as they want, then the .interrupt section can
> > > also be called differently.
> > > I don't think is a good idea to base all your implementation on this
> > > assumption.
> > > 
> > > It's clear there's a limitation when linking firmware in DDR, so this should be
> > > well documented so one can compile their firmware and put the needed
> > > section (interrupt as we call it in NXP SDK) always in TCML - independently
> > > where the other section go.
> > Ok, so .interrupt section should be a must in elf file if I understand correctly.
> > 
> > I could add a check in V4 that if .interrupt section is not there, driver will report
> > failure.
> > 
> > How do you think?
> 
> Peng, I stand by my opinion that the limitation of linking firmware in DDR
> should be documented in an Application Note, or maybe there are other
> documents where how to use imx_rproc is explained.
> 
> The implementation based on the .interrupt section is not robust.
> Maybe a user linked his firmware correctly in TCML, but the section is not
> called .interrupt so the firmware loading will work.
> 
> So, instead of using the section name, you should use the address.

Can you be more specific on the above?

> 
> First, check whether there is a section linked to TCML.
> If there is none, check for section name - as you did.
> If there is no section called .interrupt, give an error message.

We have two ways of booting, one that puts the firmware image in the TCML and
another in RAM.  Based on the processor type, the first 8 bytes of the TCML need
to include the address for the stack and PC value.

I think the first thing to do is have two different firmware images, one for
i.MX8M and another one for i.MX93.  That should greatly simplify things.

Second, there should always be a segment that adds the right information to the
TMCL.  That segment doesn't need a name, it simply have to be part of the
segments that are copied to memory (any kind of memory) so that function
rproc_elf_load_segments() can do its job. 

That pushes the complexity to the tool that generates the firmware image,
exactly where it should be.

This is how I think we should solve this problem based on the very limited
information provided with this patchset.  Please let me know if I missed
something and we'll go from there.    

> 
> For all the above options please add comments in code, explaining each step.
> 
