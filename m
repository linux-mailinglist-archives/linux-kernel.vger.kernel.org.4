Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56636D9BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbjDFPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbjDFPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10FA26D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73236618D3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C1CC433D2;
        Thu,  6 Apr 2023 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793502;
        bh=h2XNKsgNLlyUosnIu8qD+xUiAgExiAf5Oo0xMP3JFbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FafLEZc0IC4Z8PaMKdij/9VMxXMGxtZFqKOZ5JdeyZ8iPFz6lZiOJ2Lcd/awV4sV+
         U97nU6CZtjYCZjZmypX3T1F7cXjuYtlKQMyIi7WxVx46SND6lpZjjPSmgbdfpEywc8
         +boOLMHCkcOIrnt9qdGEo0EFsoxcmE/+ZHeg/q0eJ3VRPapABec2oZVIW/JIb64As5
         Gpjs1Hj/shqshqeW0hsDoj8aQXXNzw8WKi8SPxomQghAcPCSYHw+wO7rEl8wNssewB
         EDCyUt5/iRjKmoMe2fHedgJxkJ1z10PZkXOVAMTaxtAaaG6aKWmiNJACdrxZco2mNx
         Y9xMv4WrZrLAA==
Date:   Thu, 6 Apr 2023 16:04:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64/sysreg: Convert HFGITR_EL2 to automatic
 generation
Message-ID: <20230406150456.GA11802@willie-the-truck>
References: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
 <20230306-arm64-fgt-reg-gen-v3-2-decba93cbaab@kernel.org>
 <20230406144653.GB11479@willie-the-truck>
 <8474042a-d0e3-4316-9740-733c524f2e27@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8474042a-d0e3-4316-9740-733c524f2e27@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 04:02:18PM +0100, Mark Brown wrote:
> On Thu, Apr 06, 2023 at 03:46:54PM +0100, Will Deacon wrote:
> > On Thu, Mar 23, 2023 at 08:44:54PM +0000, Mark Brown wrote:
> 
> > > Automatically generate the Hypervisor Fine-Grained Instruction Trap
> > > Register as per DDI0601 2022-12, currently we only have a definition for
> > > the register name not any of the contents.  No functional change.
> 
> > > +Res0	63:61
> > > +Field	60	COSPRCTX
> > > +Field	59	nGCSEPP
> > > +Field	58	nGCSSTR_EL1
> > > +Field	57	nGCSPUSHM_EL1
> 
> > These aren't in the Arm ARM afaict ^^^
> 
> Yes, as mentioned in the cover letter these are as per DDI0601 2022-12,
> the current at time of posting the patch latest release of the
> architecture XML.  They should appear in the next release of the ARM,
> the XML is updated more frequently.  The XML can be seen on the web
> here:
> 
>     https://developer.arm.com/documentation/ddi0601/2022-12/AArch64-Registers/HFGITR-EL2--Hypervisor-Fine-Grained-Instruction-Trap-Register?lang=en

Thanks -- I just wanted to check that they were final. Happy to trust that
xml.

> > Can't we generate this file from the architecture xml? That would hopefully
> > avoid typos like this and make review less tedious.
> 
> I agree that this seems like a sensible idea however there has
> previously been pushback on the idea of providing tooling to do that,
> and we would want to manually integrate the output of any such tool
> since there are a number of cases where for legacy or usability reasons
> we rename or combine fields.  The cases where we use a Fields block to
> cover identical ELx versions are another issue.
> 
> I also note that while the XML is viewable on the web AFAICT the only
> directly downloadable version of the architecture XML available
> externally is in PDF format which is not entirely helpful for this
> purpose.

Sorry, I didn't mean to automate this in the tree, just that you could
do it locally when you generate the patch (as I suspect this must be
tedious for you to write out by hand too!). We've had a string of typos
in the definitions so far, and it would be nice to take steps to avoid
that for future changes.

Will
