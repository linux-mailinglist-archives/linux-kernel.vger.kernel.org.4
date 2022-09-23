Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E3A5E7AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiIWMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiIWMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:36:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B912870D;
        Fri, 23 Sep 2022 05:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDB6DB8077F;
        Fri, 23 Sep 2022 12:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DEBC433C1;
        Fri, 23 Sep 2022 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663936601;
        bh=bCdNiChCRRBG0p1xeGOmzIh0cwkTWCkcGq3D+ihsJ0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUQa2JUkuN25zy1VO0Om8XqE4IzNMl5t2jtsJ6D9ynHvauBTDNAVOtsvPNr/0OEUf
         J98LjbWcQ+wEKpHr8bssIktB0DWo8Fs4BU6WNbsHaKs7sC3IAaZzosAbEplzbKM/i8
         XSEXqWB4+Z8MMrXiw0/ub1Ey9a1pi4+/mH92yqB5fPuJccjLObbtEiTj2IvKV/Gv0E
         f8VuHpYWCt/X9qPBUA+0QVH1q42R0d9IcYmP0aRacwIjXZRLu+ny1q2CjsJE4SzSiW
         9f5EC37h60EpQlvZHVPZXnOf1bG6hsz3YJonWxpGAslng48yB1ybfvkceaDQ4X47aS
         ISUGHaR1XygGg==
Date:   Fri, 23 Sep 2022 13:36:35 +0100
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com,
        Jonathan Corbet <corbet@lwn.net>, leo.yan@linaro.org,
        broonie@kernel.org, linux-doc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] perf: arm64: Kernel support for Dwarf unwinding
 through SVE functions
Message-ID: <20220923123633.GC13942@willie-the-truck>
References: <20220901132658.1024635-1-james.clark@arm.com>
 <166385556279.1475166.2989569100449667346.b4-ty@kernel.org>
 <1dabe308-21f7-aa2e-ee8f-48807878f91b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dabe308-21f7-aa2e-ee8f-48807878f91b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:32:15AM +0100, James Clark wrote:
> 
> 
> On 22/09/2022 21:33, Will Deacon wrote:
> > On Thu, 1 Sep 2022 14:26:56 +0100, James Clark wrote:
> >> I'm resubmitting this with a few of the changes suggested by Will on V2.
> >>
> >> I haven't made any changes regarding the open questions about the
> >> discoverability or saving the new reg and passing to output_sample()
> >> because I think it's best to be consistent with the implementations on
> >> other platforms first. I have explained in more detail on v2 [1].
> >>
> >> [...]
> > 
> > Applied to will (for-next/perf), thanks!
> > 
> > [1/2] perf: arm64: Add SVE vector granule register to user regs
> >       https://git.kernel.org/will/c/cbb0c02caf4b
> > [2/2] arm64/sve: Add Perf extensions documentation
> >       https://git.kernel.org/will/c/1f2906d1e10a
> > 
> > Cheers,
> 
> Thanks Will. Sorry about the build, I will fix my config for next time.

No problem. For some reason, I was unable to repro the failure locally.
Maybe it's a GCC thing?

Will
