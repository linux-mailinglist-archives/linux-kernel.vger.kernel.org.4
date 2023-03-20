Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777066C08E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCTCQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTCQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4621ABCA;
        Sun, 19 Mar 2023 19:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B174B80D38;
        Mon, 20 Mar 2023 02:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FF3C433D2;
        Mon, 20 Mar 2023 02:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679278601;
        bh=cho+Cw6CT2KVRHUhfVes5dYNRH/VbgR1VeYtM1Fa6FU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6gDs3dXUREH+uZi9PrWvqJVB/FYv4XW8M6UcvMASqMsVIn6WPqKc90HubdJYdXJU
         jTAxDPdmeH5rd+RCFvZETZVFKT2Lb5DffuiHd680wkzvtlUHAvC8WiiFv12bFvqiHT
         LrGM2NkcIX1u632v4ZEUDmsnl+lpyvnEe4OGN7JSHXEgWf8Q7deru8OQPLzVzqOyz9
         76925jPQFfryP7hkFaDzlbCiesBhlQ2XOjxIrbvhMPWEJRGhQ6XCKHdT1L/5O0vbOh
         DGNoFeLF+3wJ1dyHlfcpY5CJOANEAgQpEZzA07vEdwZzVMUNHq0lhV5qRwnTdmIIAi
         YHiQHgcGEidvw==
Date:   Sun, 19 Mar 2023 19:19:57 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Split out SA8155P and use correct
 RPMh power domains
Message-ID: <20230320021957.yzg6zhrhjr36rcz4@ripper>
References: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
 <20230214095435.2192153-3-konrad.dybcio@linaro.org>
 <20230314001052.7qvgbwkl73x22oll@ripper>
 <eaf2ca0d-4d90-b68b-3b36-8bb0148cfb95@linaro.org>
 <ee1ebac4-bf18-019a-f770-5cb88703d06b@linaro.org>
 <20230315230024.wxuqthay74i5zgrq@ripper>
 <3d3117d2-b3eb-1174-7061-b899cdcdf6ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3117d2-b3eb-1174-7061-b899cdcdf6ce@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:50:49AM +0100, Konrad Dybcio wrote:
> On 16.03.2023 00:00, Bjorn Andersson wrote:
> > On Tue, Mar 14, 2023 at 12:41:45PM +0100, Konrad Dybcio wrote:
> >>
> >>
> >> On 14.03.2023 12:36, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 14.03.2023 01:10, Bjorn Andersson wrote:
> >>>> On Tue, Feb 14, 2023 at 10:54:35AM +0100, Konrad Dybcio wrote:
> >>>>> The RPMhPD setup on SA8155P is different compared to SM8150. Correct
> >>>>> it to ensure the platform will not try accessing forbidden/missing
> >>>>> RPMh entries at boot, as a bad vote will hang the machine.
> >>>>>
> >>>>
> >>>> I don't see that this will scale, as soon as someone adds a new device
> >>>> in sm8150.dtsi that has the need to scale a power rail this will be
> >>>> forgotten and we will have a mix of references to the SM8150 and SA8155P
> >>>> value space.
> >>>>
> >>>> That said, I think it's reasonable to avoid duplicating the entire
> >>>> sm8150.dtsi.
> >>> Yeah, this problem has no obvious good solutions and even though it's
> >>> not very elegant, this seems to be the less bad one..
> >>>
> >>>>
> >>>> How about making the SA8155P_* macros match the SM8150_* macros?
> >>>> That way things will fail gracefully if a device node references a
> >>>> resource not defined for either platform...
> >>> Okay, let's do that
> >> Re-thinking it, it's good that the indices don't match, as this way the
> >> board will (should) refuse to function properly if there's an oversight,
> >> which may have gone unnoticed if they were matching, so this only guards
> >> us against programmer error which is not great :/
> >>
> > 
> > Right, ensuring that the resource indices never collides would be a good
> > way to capture this issue, as well as copy-paste errors etc. My
> > pragmatic proposal is that we make SA8155P_x == SM8150_x where a match
> > exist, and for the ones that doesn't match we pick numbers that doesn't
> > collide between the platforms.
> > 
> > The alternative is to start SA8155P_x at 11, but it's different and
> > forces sa8155p.dtsi to redefine every single power-domains property...
> > 
> > 
> > This does bring back the feeling that it was a mistake to include the
> > platform name in these defines in the first place... Not sure if it's
> > worth mixing generic defines into the picture at this point, given that
> > we I don't see a way to use them on any existing platform.
> TBF we could, think:
> 
> sm1234_rpmpds[] = {
> 	[CX] = &foobar1,
> 	[CX_AO] = &foobar1_ao,
> 
> 	[...]
> 
> 	/* Legacy DT bindings */
> 	[SM1234_CX] = &foobar1,
> 	[SM1234_CX_AO] = &foobar1_ao,
> };
> 
> WDYT?

Given that every platform got these defines different we'd have to start
at the new generic list at 17 (which would throw away 136 bytes per
platform), if we're going to allow the scheme for existing platforms.
Which I don't fancy.

It's not super-pretty to mix and match, but I think I would be okay
switching to this scheme for new platforms.

PS. We'd better prefix the defines with something (perhaps RPM_?)

Regards,
Bjorn
