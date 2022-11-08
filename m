Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9162122B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiKHNTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiKHNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:19:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721B931F8D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:19:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D42DB81A9A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35EBC433C1;
        Tue,  8 Nov 2022 13:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667913547;
        bh=8YhLs6Xl5Z3PNK4uEBuLitnKdiZ0d1Z9zfNCnk9Xdjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwQxPA0g+qX1N5tSZyFG9gTNM+O2dXsM/OsmQp7/8BlYQkin6Hqvev5f32r1rcRgg
         rri6SeKVUU2Z8mwHLvGqTdS4gKFphw79zBWbF6r8dyKGtRJJoqdP2T1B5XATZBsyLc
         G4vMWm5GU2geUpECpMVKngqQfCeUpwIhLWpEE/khygQ3fXUwZwuJrcovy7KshIiz7e
         tulhpg7OTGzGlI2op7vmOZsitZxuJZyiFovRi9ikZLNvcYv5AtZbaggiL6kapa8xn9
         G2ypHhHgy2C193RH8wMfM1zQCPPxQ36WHjTf8XdruXWmC4Pi8qwayUTJxZgOG1Yi0n
         dMCV4eKMBcVCw==
Date:   Tue, 8 Nov 2022 13:19:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] mte: Initialize tag storage to KASAN_TAG_INVALID
Message-ID: <20221108131901.GA22816@willie-the-truck>
References: <20220907110015.11489-1-vincenzo.frascino@arm.com>
 <20221107151929.GB21002@willie-the-truck>
 <e1d857df-7b6b-113f-1bed-2b5274d887c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d857df-7b6b-113f-1bed-2b5274d887c1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:47:14PM +0000, Vincenzo Frascino wrote:
> Hi Will,
> 
> On 11/7/22 15:19, Will Deacon wrote:
> > On Wed, Sep 07, 2022 at 12:00:15PM +0100, Vincenzo Frascino wrote:
> >> When the kernel is entered on aarch64, the MTE allocation tags are in an
> >> UNKNOWN state.
> >>
> >> With MTE enabled, the tags are initialized:
> >>  - When a page is allocated and the user maps it with PROT_MTE.
> >>  - On allocation, with in-kernel MTE enabled (HW_TAGS KASAN).
> >>
> >> If the tag pool is zeroed by the hardware at reset, it makes it
> >> difficult to track potential places where the initialization of the
> >> tags was missed.
> >>
> >> This can be observed under QEMU for aarch64, which initializes the MTE
> >> allocation tags to zero.
> >>
> >> Initialize to tag storage to KASAN_TAG_INVALID to catch potential
> >> places where the initialization of the tags was missed.
> >>
> >> This is done introducing a new kernel command line parameter
> >> "mte.tags_init" that enables the debug option.
> >>
> >> Note: The proposed solution should be considered a debug option because
> >> it might have performance impact on large machines at boot.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >> ---
> >>  arch/arm64/kernel/mte.c | 47 +++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 47 insertions(+)
> > 
> > I don't really see the point in this change -- who is going to use this
> > option?
> > 
> 
> I think this option can be useful to someone who is trying to debug a problem
> that is related to a missed tag initialization and it is doing it on QEMU.
> 
> QEMU by default would mask this class of problems because it initializes to zero
> the tags at "reset" (which is a valid UNKNOWN STATE according to the architecture).
> 
> I noticed this behavior because I was trying to debug a similar issue which I
> was able to reproduce only on FVP.
> 
> Said that, I originally posted this patch as RFC back in April this year to find
> out if someone else would find it useful, in fact my idea was to keep it locally.
> 
> Please let me know what do you want to do.

I'd prefer to leave the code as-is until we have a concrete ask for this
feature.

Will
