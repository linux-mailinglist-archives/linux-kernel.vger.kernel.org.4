Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201361FCB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiKGSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiKGSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:04:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A226C25C46;
        Mon,  7 Nov 2022 10:01:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DB5FB81613;
        Mon,  7 Nov 2022 18:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B600C433C1;
        Mon,  7 Nov 2022 18:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667844072;
        bh=fMF3eh8wQpUiDewc7X6iYICV9of+TWDBelitXegKc8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFeQFdVKH2weZ7ljs3rEQW0RnZ7qdLHBctEVN7zSZjP+VIiQzCEL0wuJfS6Rh8h9H
         lR0deR4YlImR4Mszu/a8PzF1slqw0+DB4xMQ3URGtoTPKA12X1hZecNtViX8EGuSxI
         aJRJGlVsAKHD7UqDJXy/Ce8vzgpq2uasG2K5qvQfFVDcQ7dKtKMTahKnuIYn6jLRcN
         d2rtV5NmUezWIzUgtCydyVzSLiV9lOnYYY8fwc21cTxgpa0K9GRnmAlgeqJj3tVLLS
         z6a1FgjThrK+gxZNW+h0Me4Fo6n6lwQqdUn8exRplArfwZChmwlN7RsCAjEsfrCZIn
         HwNnIjjzp3hGQ==
Date:   Mon, 7 Nov 2022 18:01:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: Re: [PATCH v6 0/2] perf: ARM CoreSight PMU support
Message-ID: <20221107180104.GA21769@willie-the-truck>
References: <20220930023443.9463-1-bwicaksono@nvidia.com>
 <20221107155311.GD21157@willie-the-truck>
 <SJ0PR12MB567614CC049F93584631DFBAA03C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB567614CC049F93584631DFBAA03C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 05:11:07PM +0000, Besar Wicaksono wrote:
> Hi Will,
> 
> > -----Original Message-----
> > From: Will Deacon <will@kernel.org>
> > Sent: Monday, November 7, 2022 9:53 AM
> > To: Besar Wicaksono <bwicaksono@nvidia.com>
> > Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> > catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > tegra@vger.kernel.org; sudeep.holla@arm.com;
> > thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> > <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> > Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> > mike.leach@linaro.org; leo.yan@linaro.org
> > Subject: Re: [PATCH v6 0/2] perf: ARM CoreSight PMU support
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Sep 29, 2022 at 09:34:41PM -0500, Besar Wicaksono wrote:
> > > Add driver support for ARM CoreSight PMU device and event attributes for
> > NVIDIA
> > > implementation. The code is based on ARM Coresight PMU architecture
> > and ACPI ARM
> > > Performance Monitoring Unit table (APMT) specification below:
> > >  * ARM Coresight PMU:
> > >         https://developer.arm.com/documentation/ihi0091/latest
> > >  * APMT: https://developer.arm.com/documentation/den0117/latest
> > >
> > > The patchset applies on top of
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >   master next-20220524
> > >
> > > For APMT support, please see patchset:
> > https://lkml.org/lkml/2022/4/19/1395
> > >
> > > Changes from v5:
> > >  * Default get_event/format_attrs callback now returns copy of default
> > array.
> > > Thanks to suzuki.poulose@arm.com for the review comments.
> > > v5: https://lore.kernel.org/linux-arm-kernel/20220928201830.45637-1-
> > bwicaksono@nvidia.com/
> > 
> > These patches no longer apply. Please can you rebase onto -rc4 and drop the
> > defconfig change from the first patch?
> 
> Why does the defconfig change need to be dropped ?

Oh, just because that file is a big source of conflicts so I'd prefer to
keep defconfig changes separate from patches which add new functionality.

Will
