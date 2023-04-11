Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B209F6DDB95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjDKNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDKNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6246A8;
        Tue, 11 Apr 2023 06:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D04162567;
        Tue, 11 Apr 2023 13:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53ACC433EF;
        Tue, 11 Apr 2023 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681218215;
        bh=w233m1At44CuD4oKEJ9ouw0Upf9V5ee3kLtIQj5vlrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5/0JgdS+Qr2qZ7XdcZPhRHpMfesXfjmLBCm3XoA8RgzWD/4lV1oW3sdU23SBX4Qe
         vPWinCQ3+2feUoPSfyqb85oOWr/ew3ofucTzQ01Qyh5bks8pLd6uAnAwDWmSFDm24E
         bYRNs2aOZpOlaxUDk6BtX7sE4VWxP43x34DIifWTjHdq8s32eo1HMcmpJjHNKO2YBt
         Y4/CdQE2bBNHLNXfm4BIlrqXUcUnBDWQdcxe7p/MXSh7NObLj9TdBNnwJOq4z/q1Cm
         PAqaiMYdfh+2oVEl75aynMukmDf08EQxkfMCB1sRY++LL+EqaVyL8UJQYaS2lmaB0S
         xbZBHqMe1T33A==
Date:   Tue, 11 Apr 2023 14:03:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 00/10] arm64/perf: Enable branch stack sampling
Message-ID: <20230411130326.GA22736@willie-the-truck>
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.1683170-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman

On Wed, Mar 15, 2023 at 10:44:34AM +0530, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on 6.3-rc1 after applying the following patch from Mark
> which allows enums in SysregFields blocks in sysreg tools.
> 
> https://lore.kernel.org/all/20230306114836.2575432-1-mark.rutland@arm.com/

As mentioned by Mark at:

https://lore.kernel.org/r/ZB2sGrsbr58ttoWI@FVFF77S0Q05N

this conflicts with supporting PMUv3 on AArch32. Please can you rebase onto
for-next/perf, which will mean moving this driver back into drivers/perf/
now?

Thanks,

Will
