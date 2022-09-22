Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01B25E6D70
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIVU5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIVU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D812C67A;
        Thu, 22 Sep 2022 13:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA255610A1;
        Thu, 22 Sep 2022 20:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EF7C433D6;
        Thu, 22 Sep 2022 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663880234;
        bh=JB3NDJEV/v85Ow5DEPOCDDWd8yYDXhteqm8hggXtLjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ip9U3VRghsga/8UYTkwEoAVDxTnoiqrGLKjXLviuuQdWr6amJkSJ3Dy4pPlTtyK4n
         G0ST06gN3wXWlp4tweScZbxgAbWC1168z0cTLPlBTowYMNTgmgXGs4vkBIB+4OYPJD
         LCaztbwWkdv6V770fSPwsVAtgdBBMRkF6JhJcWhbiaGmvepzKWfMelp5oxSJtTsNhk
         poXdiRO/rmwFc3mWJjTXqMzwooKo5N1dwqInrPPHnpABu2t3s9vl1VWeXcVdNpcPlh
         And0lwmev0+nvtK5HJamjSRsMzlyuI4TAvnM0TPnO25VGgJBKcpLDmgsafbGa7yvlj
         33a75XLO85+0w==
Date:   Thu, 22 Sep 2022 21:57:08 +0100
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org, leo.yan@linaro.org, john.garry@huawei.com,
        catalin.marinas@arm.com, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf: arm64: Kernel support for Dwarf unwinding
 through SVE functions
Message-ID: <20220922205707.GB12945@willie-the-truck>
References: <20220901132658.1024635-1-james.clark@arm.com>
 <20220922140406.GG12095@willie-the-truck>
 <d6eaa797-380b-e8ae-f928-54843dd596f2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6eaa797-380b-e8ae-f928-54843dd596f2@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:31:20PM +0100, James Clark wrote:
> 
> 
> On 22/09/2022 15:04, Will Deacon wrote:
> > On Thu, Sep 01, 2022 at 02:26:56PM +0100, James Clark wrote:
> >> I'm resubmitting this with a few of the changes suggested by Will on V2.
> >>
> >> I haven't made any changes regarding the open questions about the
> >> discoverability or saving the new reg and passing to output_sample()
> >> because I think it's best to be consistent with the implementations on
> >> other platforms first. I have explained in more detail on v2 [1].
> >>
> >> [1]: https://lore.kernel.org/lkml/5fcf1a6f-c8fb-c296-992e-18aae8874095@arm.com/
> > 
> > Fair enough, I can't argue against being consistent.
> > 
> > Given that this exposes subtle new user ABI, do we have any coverage in
> > the selftests? If not, please could you add something?
> > 
> 
> Thanks, I will do that. I assume you mean the self tests in
> tools/perf/tests and not some non Perf tests?

I hadn't thought much about it, so wherever is best. It would just be nice
to have something we can run to make sure that this continues to work as
intended.

Will
