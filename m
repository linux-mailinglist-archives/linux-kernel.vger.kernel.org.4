Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7936AF6AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCGU1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjCGU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:26:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE25A729A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:26:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso17765633pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678220793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JG+8cn9a3MVqddPtGZw0HBF9LcZFV3ZvoAF8l2EgmNw=;
        b=IFttrmHhqcHbiZzWKa1r4VsPwlAVg3itHb22qloMoEmGSHkmmYUNDApiyo2dgFrOD/
         GDghFYH5Y+XSibazMSXaj0UlGQQ00LXjuCWKQXAvDvK8qddwWnj35ij1O1E7cjwN2ESw
         psNkn+l/g0x/K6mckHzQ9gB/vbPJTeU+tREZX/IpqldJMI890B5mfAyyjzzqqGLd4h7b
         aZmKRA6xoWpD5fYs+3RWeXO0msvA5wddK9JVm2mPxfDxHbz5WSMcetrSn+PBN27cWwqX
         Mvl/pDR8cFrYrGJ2QHEW4a+bnZ7eY1GefztpZCi6Jh/Qtel1NAuC5SxSIDFIfh3VkQ3K
         yqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678220793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG+8cn9a3MVqddPtGZw0HBF9LcZFV3ZvoAF8l2EgmNw=;
        b=GeVV5iinKKZqYhb1N49horxZGVsjyJgQQYuYEieu5D45rOPTrMXAoqTC2AwxF1GEiL
         7bLjo7AE1wt/gatke8r0aUMKBCBwNB+g3bETR1E+Upj3ZXUbBtumadG+LXJSepgrVsK+
         ydFz4lfjyZSOEwwcng7aDDmVkXNOdH83Rcs9cFvE7rwBelksDS+Crl+toNSIEGzAPhHZ
         IuSxQh4Ad2Mu/2YoDceHDK7kMf7bDmtxLmnySF29FnDt08D9h3JptwHbFWC8SMKkqgWr
         SmSosixEkHHmNd+pGlCSvEVcLXggoZigMxhBMCVsoaCP/PCgYbezlK80xPro+4mX4wH9
         eWjQ==
X-Gm-Message-State: AO0yUKWfgM+CbDs4xx5ulc+REsq04MDEBAwMCUZUGGN2uWSmAOmeVZA0
        Wzu3MgZb3N/aBZztSZH8Hs+Scg==
X-Google-Smtp-Source: AK7set92PuRqEs3qZiTmMVNi/aZkDseorWZojXLR5il8j9jB5W6mV+++SVlsIgIFaVBdZh5WyvDf0g==
X-Received: by 2002:a17:902:b181:b0:19e:bc01:610e with SMTP id s1-20020a170902b18100b0019ebc01610emr8165414plr.33.1678220792962;
        Tue, 07 Mar 2023 12:26:32 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:e81a:aa4b:a2a8:6904])
        by smtp.gmail.com with ESMTPSA id lc4-20020a170902fa8400b0019625428cefsm8721568plb.281.2023.03.07.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 12:26:32 -0800 (PST)
Date:   Tue, 7 Mar 2023 13:26:29 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
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
Message-ID: <20230307202629.GA1693781@p14s>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
 <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com>
 <20230213175006.GA310433@p14s>
 <343571ba-faed-35d7-2859-2668391dadb2@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343571ba-faed-35d7-2859-2668391dadb2@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 03:59:38PM +0800, Peng Fan wrote:
> 
> 
> On 2/14/2023 1:50 AM, Mathieu Poirier wrote:
> > On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
> > > On 2/12/2023 9:43 AM, Peng Fan wrote:
> > > > Hi Iuliana,
> > > > 
> > > > > Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
> > > > > DDR
> > > > > 
> > > > > 
> > > > > On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > 
> > > > > > V3:
> > > > > > 
> > > > > >     Daniel, Iuliana
> > > > > > 
> > > > > >       Please help review this patchset per Mathieu's comments.
> > > > > > 
> > > > > >     Thanks,
> > > > > >     Peng.
> > > > > > 
> > > > > >     Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
> > > > > >     IMX_RPROC_ANY in patch 3 Per Mathieu
> > > > > >     Update comment and commit log in patch 5, 6.
> > > > > > 
> > > > > >     NXP SDK provides ".interrupts" section, but I am not sure how others
> > > > > >     build the firmware. So I still keep patch 6 as v2, return bootaddr
> > > > > >     if there is no ".interrupts" section.
> > > > > > 
> > > > > > V2:
> > > > > >     patch 4 is introduced for sparse check warning fix
> > > > > > 
> > > > > > This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
> > > > > > could be in DDR, not just the default TCM.
> > > > > > 
> > > > > > i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
> > > > > > initial value could be got from firmware first section ".interrupts".
> > > > > > i.MX93 is a bit different, it just needs the address of .interrupts
> > > > > > section. NXP SDK always has .interrupts section.
> > > > > > 
> > > > > > So first we need find the .interrupts section from firmware, so patch
> > > > > > 1 is to reuse the code of find_table to introduce a new API
> > > > > > rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
> > > > > > 
> > > > > > Patch 2 is introduce devtype for i.MX8M/93
> > > > > > 
> > > > > > Although patch 3 is correct the mapping, but this area was never used
> > > > > > by NXP SW team, we directly use the DDR region, not the alias region.
> > > > > > Since this patchset is first to support firmware in DDR, mark this
> > > > > > patch as a fix does not make much sense.
> > > > > > 
> > > > > > patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
> > > > > > .interrupts section. Detailed information in each patch commit message.
> > > > > > 
> > > > > > Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
> > > > > If one can build their firmware as they want, then the .interrupt section can
> > > > > also be called differently.
> > > > > I don't think is a good idea to base all your implementation on this
> > > > > assumption.
> > > > > 
> > > > > It's clear there's a limitation when linking firmware in DDR, so this should be
> > > > > well documented so one can compile their firmware and put the needed
> > > > > section (interrupt as we call it in NXP SDK) always in TCML - independently
> > > > > where the other section go.
> > > > Ok, so .interrupt section should be a must in elf file if I understand correctly.
> > > > 
> > > > I could add a check in V4 that if .interrupt section is not there, driver will report
> > > > failure.
> > > > 
> > > > How do you think?
> > > 
> > > Peng, I stand by my opinion that the limitation of linking firmware in DDR
> > > should be documented in an Application Note, or maybe there are other
> > > documents where how to use imx_rproc is explained.
> > > 
> > > The implementation based on the .interrupt section is not robust.
> > > Maybe a user linked his firmware correctly in TCML, but the section is not
> > > called .interrupt so the firmware loading will work.
> > > 
> > > So, instead of using the section name, you should use the address.
> > 
> > Can you be more specific on the above?
> > 
> > > 
> > > First, check whether there is a section linked to TCML.
> > > If there is none, check for section name - as you did.
> > > If there is no section called .interrupt, give an error message.
> > 
> > We have two ways of booting, one that puts the firmware image in the TCML and
> > another in RAM.  Based on the processor type, the first 8 bytes of the TCML need
> > to include the address for the stack and PC value.
> > 
> > I think the first thing to do is have two different firmware images, one for
> > i.MX8M and another one for i.MX93.  That should greatly simplify things.
> 
> sorry, I not got your points. i.MX8M and i.MX93 are not sharing firmware

Perfect.

> images. i.MX93 M33 has ROM, kicking M33 firmware just requires the
> address of the .interrupt address which holds stack/pc value.
> i.MX8M not has ROM, kick M33 firmware requires driver to copy
> stack/pc into the TCML beginning address.

It's been more than a month since I have looked at this patchset so the details are
vague in my memory.  That said, there should be one image for the TCML and
another one for the RAM.  And the image that runs in RAM should have a program
segment that write the correct information in the first 8 bytes.

> 
> Whether i.MX8M/i.MX93, the NXP released MCU SDK use the section
> ".interrupt" to hold stack/pc initialization value in the beginning
> 8 bytes of the section.
> 

And that is fine.  Simply release another version of the SDK that does the right
thing.

I suggest to work with Daniel and Iuliana if some details are still unclear.
Unlike me, they have access to the reference manual and the boot requirements.


> > 
> > Second, there should always be a segment that adds the right information to the
> > TMCL.  That segment doesn't need a name, it simply have to be part of the
> > segments that are copied to memory (any kind of memory) so that function
> > rproc_elf_load_segments() can do its job.
> > 
> > That pushes the complexity to the tool that generates the firmware image,
> > exactly where it should be.
> 
> For i.MX8M, yes. For i.MX93, the M33 ROM needs address of storing stack/pc.
> > 
> > This is how I think we should solve this problem based on the very limited
> > information provided with this patchset.  Please let me know if I missed
> > something and we'll go from there.
> 
> I am not sure how to proceed on supporting the current firmware. what should
> I continue with current patchset?
> 
> Thanks,
> Peng.
> 
> > 
> > > 
> > > For all the above options please add comments in code, explaining each step.
> > > 
