Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165E161F772
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiKGPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiKGPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE690289
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:19:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77CC4B812A1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17879C433C1;
        Mon,  7 Nov 2022 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667834375;
        bh=NwsEDPislMlr5qAw4s2tyK4jOd4n3+iAr26wewpmChY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2EcSwCDsuVTAF21jzZyyvSAOkaFo2MMZ5TLHFijd9fl6LuknY+iOwde6fi+KQ6pp
         30S9w2uKaRIw+IKbP73hlj1GN1G4O/zc5iUjRXD+uIGf63P3FrKXRxEoN/4S1Iudx0
         vE2xqStmHLj+C8661XlmeVcseCY/Ia7eCnDzH4i5rTylOLz4TJQb7Qaq6Jh7nu5V6u
         6ZITmd3fjMR71u/h9G47VPO/w/4taBfbgFLQyIuO55G+NqJ/N0FpBPk//BtesCl/IR
         pI4EtvQ8qdjVHjts74YenVuI7SdFFO34UYRH8qZodZdP7b8SMHzK02Z4Zm+FUjoyja
         +QhX/QOq3YxBg==
Date:   Mon, 7 Nov 2022 15:19:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] mte: Initialize tag storage to KASAN_TAG_INVALID
Message-ID: <20221107151929.GB21002@willie-the-truck>
References: <20220907110015.11489-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907110015.11489-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 12:00:15PM +0100, Vincenzo Frascino wrote:
> When the kernel is entered on aarch64, the MTE allocation tags are in an
> UNKNOWN state.
> 
> With MTE enabled, the tags are initialized:
>  - When a page is allocated and the user maps it with PROT_MTE.
>  - On allocation, with in-kernel MTE enabled (HW_TAGS KASAN).
> 
> If the tag pool is zeroed by the hardware at reset, it makes it
> difficult to track potential places where the initialization of the
> tags was missed.
> 
> This can be observed under QEMU for aarch64, which initializes the MTE
> allocation tags to zero.
> 
> Initialize to tag storage to KASAN_TAG_INVALID to catch potential
> places where the initialization of the tags was missed.
> 
> This is done introducing a new kernel command line parameter
> "mte.tags_init" that enables the debug option.
> 
> Note: The proposed solution should be considered a debug option because
> it might have performance impact on large machines at boot.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/mte.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

I don't really see the point in this change -- who is going to use this
option?

Will
