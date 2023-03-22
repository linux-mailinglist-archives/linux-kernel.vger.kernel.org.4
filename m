Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D266C4F20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCVPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCVPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:13:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E71E1C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:13:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so19483566pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679498032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9ZTp7ZZm4J7TRIYDhiFVRzOC61nUJhSd8nfAEWPRzg=;
        b=W44GNUYI9bL7w9zg1EGFmSrVNq2zwlsVHXMuWzpOr88CtaRzO8/PScZ+qKQzs2Ci/M
         5p+1N4uCAUCgfk00bQ9MKO/LkBxJplRuMisPePd4xfR4B4eqn9EcwNS8p8FAH/hHw6UC
         alIMBfQvwzxQiN5+8+a5Ze6g9H7rxHHzqVc15MyoeJvzlRW8f/UEyjDwk09Tq2nHHoFS
         hfxIpMtVO/oBB5OMIiKGVkZ7u8Rt+Ki22OGYPAjDSHrV4oupbqK7bKBAMSXf5zB4L+Do
         Xj0LR2FC8mO3xRlBhDfOuNwd96ZyfqShl4O7MzpsfMPiPZZHYl01k7qmJ9qfptsV6NW7
         EYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679498032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9ZTp7ZZm4J7TRIYDhiFVRzOC61nUJhSd8nfAEWPRzg=;
        b=SlSHpLNdQRlDtkSmEJwnzKu1GJH0Ag5ul6go/Q3maOYG/K5BFzS/cxDdxB2aF5uOSP
         aZ8jDvFX1R9fUMRALWReQbdleMrFtcU9Y78vtQyRIYixedyOTWZsjnxK19yITeSy5kUI
         qIH5q8A8/C0HxV34WjMy3aCTFygLxPrew2kuxDxXzMZ9UHbk832Njw3IgYJUebTkO2mv
         WrgVvxqjGNHPNlEJRyDYP2Twd7Eg8EaoOB/I5wz3WClbiEIJ/vvyB6j29T/GSc8DfRwR
         AF02unloYRWE1FwrKm8VqHX9/PUqFVe1pLddAz/ecoDnIUnTyYJtx8y2ZimDrydfHNbb
         OaxQ==
X-Gm-Message-State: AO0yUKW6MLV2Js+JKqKiupqerRviIbKl3IN1kNwCe7v+WKir8fm+McsE
        Wb58sMXsZIpgk3iBRL46DrLleg==
X-Google-Smtp-Source: AK7set9zstRexLFTBKYTDeSdKyZ1uelByjZNJYf0PfMiNC9558pcmsd+EU3UiuFsb6BEV7H1OwdqjA==
X-Received: by 2002:a17:902:f681:b0:1a1:c9f7:cec5 with SMTP id l1-20020a170902f68100b001a1c9f7cec5mr4621071plg.2.1679498032277;
        Wed, 22 Mar 2023 08:13:52 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2eb7:bf6c:83a2:9d2f])
        by smtp.gmail.com with ESMTPSA id p7-20020a1709028a8700b001a1860da968sm10668805plo.178.2023.03.22.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:13:51 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:13:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Peng Fan <peng.fan@oss.nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
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
Message-ID: <20230322151349.GA2821487@p14s>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
 <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com>
 <20230213175006.GA310433@p14s>
 <343571ba-faed-35d7-2859-2668391dadb2@oss.nxp.com>
 <20230307202629.GA1693781@p14s>
 <021fd1cc-0ac6-c7fc-2523-48c1debf96ae@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021fd1cc-0ac6-c7fc-2523-48c1debf96ae@kontron.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:59:02AM +0100, Frieder Schrempf wrote:
> Hi,
> 
> On 07.03.23 21:26, Mathieu Poirier wrote:
> > On Sat, Mar 04, 2023 at 03:59:38PM +0800, Peng Fan wrote:
> >>
> >>
> >> On 2/14/2023 1:50 AM, Mathieu Poirier wrote:
> >>> On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
> >>>> On 2/12/2023 9:43 AM, Peng Fan wrote:
> >>>>> Hi Iuliana,
> >>>>>
> >>>>>> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
> >>>>>> DDR
> >>>>>>
> >>>>>>
> >>>>>> On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
> >>>>>>> From: Peng Fan <peng.fan@nxp.com>
> >>>>>>>
> >>>>>>> V3:
> >>>>>>>
> >>>>>>>     Daniel, Iuliana
> >>>>>>>
> >>>>>>>       Please help review this patchset per Mathieu's comments.
> >>>>>>>
> >>>>>>>     Thanks,
> >>>>>>>     Peng.
> >>>>>>>
> >>>>>>>     Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
> >>>>>>>     IMX_RPROC_ANY in patch 3 Per Mathieu
> >>>>>>>     Update comment and commit log in patch 5, 6.
> >>>>>>>
> >>>>>>>     NXP SDK provides ".interrupts" section, but I am not sure how others
> >>>>>>>     build the firmware. So I still keep patch 6 as v2, return bootaddr
> >>>>>>>     if there is no ".interrupts" section.
> >>>>>>>
> >>>>>>> V2:
> >>>>>>>     patch 4 is introduced for sparse check warning fix
> >>>>>>>
> >>>>>>> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
> >>>>>>> could be in DDR, not just the default TCM.
> >>>>>>>
> >>>>>>> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
> >>>>>>> initial value could be got from firmware first section ".interrupts".
> >>>>>>> i.MX93 is a bit different, it just needs the address of .interrupts
> >>>>>>> section. NXP SDK always has .interrupts section.
> >>>>>>>
> >>>>>>> So first we need find the .interrupts section from firmware, so patch
> >>>>>>> 1 is to reuse the code of find_table to introduce a new API
> >>>>>>> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
> >>>>>>>
> >>>>>>> Patch 2 is introduce devtype for i.MX8M/93
> >>>>>>>
> >>>>>>> Although patch 3 is correct the mapping, but this area was never used
> >>>>>>> by NXP SW team, we directly use the DDR region, not the alias region.
> >>>>>>> Since this patchset is first to support firmware in DDR, mark this
> >>>>>>> patch as a fix does not make much sense.
> >>>>>>>
> >>>>>>> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
> >>>>>>> .interrupts section. Detailed information in each patch commit message.
> >>>>>>>
> >>>>>>> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
> >>>>>> If one can build their firmware as they want, then the .interrupt section can
> >>>>>> also be called differently.
> >>>>>> I don't think is a good idea to base all your implementation on this
> >>>>>> assumption.
> >>>>>>
> >>>>>> It's clear there's a limitation when linking firmware in DDR, so this should be
> >>>>>> well documented so one can compile their firmware and put the needed
> >>>>>> section (interrupt as we call it in NXP SDK) always in TCML - independently
> >>>>>> where the other section go.
> >>>>> Ok, so .interrupt section should be a must in elf file if I understand correctly.
> >>>>>
> >>>>> I could add a check in V4 that if .interrupt section is not there, driver will report
> >>>>> failure.
> >>>>>
> >>>>> How do you think?
> >>>>
> >>>> Peng, I stand by my opinion that the limitation of linking firmware in DDR
> >>>> should be documented in an Application Note, or maybe there are other
> >>>> documents where how to use imx_rproc is explained.
> >>>>
> >>>> The implementation based on the .interrupt section is not robust.
> >>>> Maybe a user linked his firmware correctly in TCML, but the section is not
> >>>> called .interrupt so the firmware loading will work.
> >>>>
> >>>> So, instead of using the section name, you should use the address.
> >>>
> >>> Can you be more specific on the above?
> >>>
> >>>>
> >>>> First, check whether there is a section linked to TCML.
> >>>> If there is none, check for section name - as you did.
> >>>> If there is no section called .interrupt, give an error message.
> >>>
> >>> We have two ways of booting, one that puts the firmware image in the TCML and
> >>> another in RAM.  Based on the processor type, the first 8 bytes of the TCML need
> >>> to include the address for the stack and PC value.
> >>>
> >>> I think the first thing to do is have two different firmware images, one for
> >>> i.MX8M and another one for i.MX93.  That should greatly simplify things.
> >>
> >> sorry, I not got your points. i.MX8M and i.MX93 are not sharing firmware
> > 
> > Perfect.
> > 
> >> images. i.MX93 M33 has ROM, kicking M33 firmware just requires the
> >> address of the .interrupt address which holds stack/pc value.
> >> i.MX8M not has ROM, kick M33 firmware requires driver to copy
> >> stack/pc into the TCML beginning address.
> > 
> > It's been more than a month since I have looked at this patchset so the details are
> > vague in my memory.  That said, there should be one image for the TCML and
> > another one for the RAM.  And the image that runs in RAM should have a program
> > segment that write the correct information in the first 8 bytes.
> > 
> >>
> >> Whether i.MX8M/i.MX93, the NXP released MCU SDK use the section
> >> ".interrupt" to hold stack/pc initialization value in the beginning
> >> 8 bytes of the section.
> >>
> > 
> > And that is fine.  Simply release another version of the SDK that does the right
> > thing.
> > 
> > I suggest to work with Daniel and Iuliana if some details are still unclear.
> > Unlike me, they have access to the reference manual and the boot requirements.
> > 
> > 
> >>>
> >>> Second, there should always be a segment that adds the right information to the
> >>> TMCL.  That segment doesn't need a name, it simply have to be part of the
> >>> segments that are copied to memory (any kind of memory) so that function
> >>> rproc_elf_load_segments() can do its job.
> >>>
> >>> That pushes the complexity to the tool that generates the firmware image,
> >>> exactly where it should be.
> >>
> >> For i.MX8M, yes. For i.MX93, the M33 ROM needs address of storing stack/pc.
> >>>
> >>> This is how I think we should solve this problem based on the very limited
> >>> information provided with this patchset.  Please let me know if I missed
> >>> something and we'll go from there.
> >>
> >> I am not sure how to proceed on supporting the current firmware. what should
> >> I continue with current patchset?
> 
> I've successfully tested this on i.MX8MM with an elf file generated by
> the NXP SDK.
> 
> I would really like to see this upstreamed. If this requires changes
> that are not compatible with binaries compiled with the current SDK as
> discussed above, that would be fine for me as long as the kernel is able
> to detect the malformed binary and warns the user about it.
>

I agree.

> The user can then manually adjust the linker script, etc. in the SDK to
> match the requirements of the kernel.
> 

That is exactly what I suggested.

> Thanks
> Frieder
